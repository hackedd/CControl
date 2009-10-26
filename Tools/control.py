#!/usr/bin/python
import sys
from serial import Serial
from optparse import OptionParser
#from time import sleep

ACTIONS = "store", "retrieve"

def sleep(delay):
	pass

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
		return Serial(device)
	except Exception, ex:
		print >>sys.stderr, "Unable to open device '%s': %s" % (device, ex)
		return None

def checkVersion(port, verbose):
	try:
		port.write("\x01")
	except Exception, ex:
		print >>sys.stderr, "Unable to write to device: %s" % ex
		return 1
	
	version = ""
	while "\r" not in version:
		version += port.read(1)
		sleep(0.02)
		
	if verbose:
		print >>sys.stderr, "Version: '%s'" % version.strip()
		
	if version != "CCTRL-BASIC Version 1.1 (20.12.96)\r":
		print >>sys.stderr, "Received invalid version string"
		return False
		
	return True

def retrieve(output, options):
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
	
	length = ""
	while "\r" not in length:
		length += port.read(1)
		sleep(0.02)
	length = int(length.strip())
	
	data = ""
	while len(data) < length:
		data += port.read(1)
		sleep(0.02)

	if options.format == "bin":		
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

if __name__ == "__main__":
	parser = OptionParser(usage = "Usage: %prog [Options] Action", version = "%prog 0.1")
	parser.add_option("-d", "--device", dest = "device", default = "0", help = "C-Control unit is at this device")
	parser.add_option("-o", "--output", dest = "output", default = "-", help = "write output to this file")
	parser.add_option("-f", "--format", dest = "format", default = "dat", help = "input/output format")
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
			output = open(options.output, "w")
		except Exception, ex:
			print >>sys.stderr, "Error: Unable to open %s for writing" % options.output
			sys.exit(1)
	
	ret = eval(args[0] + "(output, options)")
	output.close()
	sys.exit(ret)
	
