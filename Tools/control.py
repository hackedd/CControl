#!/usr/bin/python
import sys
from serial import Serial
from optparse import OptionParser
from time import sleep

ACTIONS = "version", "store", "dump", "retrieve", "sysdump", "sysretrieve", "sysstore"

def getSerial(device):
	if device.upper().startswith("COM"):
		device = int(device[4:])
	elif device.startswith("/dev/"):
		pass
	else:
		try:
			device = int(device)
		except:
			print >>sys.stderr, "Please specify the device as 'COM?', '/dev/ttyS?' or an integer port number"
	
	try:
		return Serial(device, timeout = 10)
	except Exception, ex:
		print >>sys.stderr, "Unable to open device '%s': %s" % (device, ex)
		return None

def getString(port, terminator = "\r", length = -1):
	string = ""
	while terminator not in string and (length < 0 or len(string) < length):
		string += port.read(1)
	if string.endswith(terminator):
		string = string[0:-len(terminator)]
	return string

def checkVersion(port, verbose):
	try:
		port.write("\x01")
	except Exception, ex:
		print >>sys.stderr, "Unable to write to device: %s" % ex
		return 1
	
	version = getString(port, "\r")
	
	if verbose:
		print >>sys.stderr, "Version: '%s'" % version.strip()
		
	if version != "CCTRL-BASIC Version 1.1 (20.12.96)":
		print >>sys.stderr, "Received invalid version string"
		return False
		
	return True

def getWord(port):
	msb = ord(port.read(1))
	lsb = ord(port.read(1))
	return msb << 8 | lsb

def sendWord(port, word):
	port.write(chr((word & 0xFF00) >> 8))
	port.write(chr(word & 0x00FF))

def version(input, output, options):
	port = getSerial(options.device)
	if port == None:
		return 1

	try:
		port.write("\x01")
	except Exception, ex:
		print >>sys.stderr, "Unable to write to device: %s" % ex
		return 1
	
	version = getString(port, "\r")
	output.write(version + "\n")

def store(input, output, options):
	port = getSerial(options.device)
	if port == None:
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Checking C-Control version..."
	
	if not checkVersion(port, options.verbose):
		return 1

	if options.verbose:
		print >>sys.stderr, "Sending STORE command"

	try:
		port.write("\x02")
	except Exception, ex:
		print >>sys.stderr, "Unable to send STORE command: %s" % ex
		return 1
	
	if options.format == "bin":
		length = getWord(input)
		data = input.read(length)
	elif options.format == "dat":
		header = input.readline().strip()
		if header != "CCTRL-BASIC":
			print >>sys.stderr, "Input file is not a valid DAT file"
			return 1
		length = int(input.readline().strip())
	
		data = ""
		while len(data) < length:
			line = input.readline().strip()
			bytes = map(chr, map(int, line.split()))
			data += "".join(bytes)
		data = data[0:length]
	
	if options.verbose:
		print >>sys.stderr, "Sending data length..."

	try:	
		sendWord(port, length)
		port.read(2)
	except Exception, ex:
		print >>sys.stderr, "Unable to send data length: %s" % ex
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Sending CC-Basic Data..."

	for i in range(0, len(data)):
		byte = data[i]
		port.write(byte)
		byte2 = port.read(1)
		if byte != byte2:
			print >>sys.stderr, "Data mismatch at %5d: %3d %3d" % (i, ord(byte), ord(byte2))
			return 1
		if options.sleep:
			sleep(0.02)
	
	if options.verbose:
		print >>sys.stderr, "Done."

def dump(input, output, options):
	return retrieve(input, output, options)

def retrieve(input, output, options):
	port = getSerial(options.device)
	if port == None:
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Checking C-Control version..."
	
	if not checkVersion(port, options.verbose):
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Sending DUMP command"
	
	try:
		port.write("\x03")
	except Exception, ex:
		print >>sys.stderr, "Unable to send DUMP command: %s" % ex
		return 1
	
	length = int(getString(port, "\r"))
	
	data = ""
	while len(data) < length:
		data += port.read(1)

	if options.format == "bin":
		sendWord(output, len(data))
		output.write(data)
	elif options.format == "dat":
		output.write("CCTRL-BASIC\r\n")
		output.write("%d\r\n" % len(data))
		
		bytes = map(ord, data)
		for i in range(0, len(bytes), 32):
			output.write(" ".join(["%d" % b for b in bytes[i:i+32]]) + "\r\n")
	
	if options.verbose:
		print >>sys.stderr, "Dump complete. %d bytes dumped" % len(data)
	
	port.close()
	return 0

def sysdump(input, output, options):
	return sysretrieve(input, output, options)

def sysretrieve(input, output, options):
	port = getSerial(options.device)
	if port == None:
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Checking C-Control version..."
	
	if not checkVersion(port, options.verbose):
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Sending SYS-DUMP command"
	
	try:
		port.write("\x09")
	except Exception, ex:
		print >>sys.stderr, "Unable to send SYS-DUMP command: %s" % ex
		return 1
	
	data = ""
	while len(data) < 0xFE:
		data += port.read(1)

	if options.format == "bin":
		sendWord(output, len(data))
		output.write(data)
	elif options.format == "dat":
		output.write("CCTRL-BASIC-SYS\r\n")
		output.write("%d\r\n" % len(data))
		
		bytes = map(ord, data)
		for i in range(0, len(bytes), 32):
			output.write(" ".join(["%d" % b for b in bytes[i:i+32]]) + "\r\n")
	
	if options.verbose:
		print >>sys.stderr, "Dump complete. %d bytes dumped" % len(data)
	
	port.close()
	return 0

def sysstore(input, output, options):
	port = getSerial(options.device)
	if port == None:
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Checking C-Control version..."
	
	if not checkVersion(port, options.verbose):
		return 1

	if options.verbose:
		print >>sys.stderr, "Sending SYS-STORE command"

	try:
		port.write("\x08")
	except Exception, ex:
		print >>sys.stderr, "Unable to send SYS-STORE command: %s" % ex
		return 1
	
	if options.format == "bin":
		length = getWord(input)
		data = input.read(length)
	elif options.format == "dat":
		header = input.readline().strip()
		if header != "CCTRL-BASIC-SYS":
			print >>sys.stderr, "Input file is not a valid DAT file"
			return 1
		length = int(input.readline().strip())
		if length > 0xFE:
			print >>sys.stderr, "Input length > 0xFE bytes. Not a vaild SYS file"
			
		data = ""
		while len(data) < length:
			line = input.readline().strip()
			bytes = map(chr, map(int, line.split()))
			data += "".join(bytes)
		data = data[0:length]
	
	if options.verbose:
		print >>sys.stderr, "Sending data length..."

	try:	
		port.write(chr(length))
	except Exception, ex:
		print >>sys.stderr, "Unable to send data length: %s" % ex
		return 1
	
	if options.verbose:
		print >>sys.stderr, "Sending CC-Basic Data..."

	if options.sleep:
		for i in range(0, len(data)):
			byte = data[i]
			port.write(byte)
			byte2 = port.read(1)
			if byte != byte2:
				print >>sys.stderr, "Data mismatch at %5d: %3d %3d" % (i, ord(byte), ord(byte2))
				return 1
			sleep(0.02)
	else:
		try:
			port.write(data)
			data2 = port.read(length)
			
			if data != data2:
				raise Exception("Data mismatch. Retry with -s / --sleep")
		except Exception, ex:
			print >>sys.stderr, "Unable to send CC-Basic Data: %s" % ex
			return 1
	
	if options.verbose:
		print >>sys.stderr, "Done."

if __name__ == "__main__":
	parser = OptionParser(usage = "Usage: %prog [Options] Action", version = "%prog 0.1")
	parser.add_option("-d", "--device", dest = "device", default = "0", help = "C-Control unit is at this device")
	parser.add_option("-o", "--output", dest = "output", default = "-", help = "write output to this file (retrieve)")
	parser.add_option("-i", "--input", dest = "input", default = "-", help = "read input from this file (store)")
	parser.add_option("-f", "--format", dest = "format", default = "dat", help = "input/output format")
	parser.add_option("-s", "--sleep", dest = "sleep", action = "store_true", help = "limit send speed")
	parser.add_option("-v", dest = "verbose", action = "store_true", help = "be verbose")
	
	(options, args) = parser.parse_args()
	if len(args) != 1 or args[0].lower() not in ACTIONS:
		print >>sys.stderr, "Please specify excactly one action"
		print >>sys.stderr, "  Available actions are: " + ", ".join(ACTIONS)
		sys.exit()
	
	if options.output == "-":
		output = sys.stdout
	else:
		try:
			output = open(options.output, "wb")
		except Exception, ex:
			print >>sys.stderr, "Error: Unable to open %s for writing" % options.output
			sys.exit(1)
	
	if options.input == "-":
		input = sys.stdin
	else:
		try:
			input = open(options.input, "rb")
		except Exception, ex:
			print >>sys.stderr, "Error: Unable to open %s for reading" % options.input
			sys.exit(1)

	ret = eval(args[0] + "(input, output, options)")
	input.close()
	output.close()
	sys.exit(ret)
	
