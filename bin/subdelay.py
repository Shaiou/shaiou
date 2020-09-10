#!/usr/bin/env python

from datetime import datetime, timedelta
import re
import sys

inputname = sys.argv[1]
delay = int(sys.argv[2])

inputfile = open(inputname, encoding="ISO-8859-1")
outputname = "new-{}".format(inputname)
outputfile = open(outputname, "w")

regexp = re.compile("^(\d+:\d+:\d+),(\d+)(\s+-->\s+)(\d+:\d+:\d+),(\d+)")


def adddelta(string, mili):
    return datetime.strftime(
        datetime.strptime(string, "%H:%M:%S") + timedelta(seconds=delay),
        "%H:%M:%S,{}".format(mili),
    )


for linefeed in inputfile.readlines():
    line = linefeed.strip()
    result = regexp.match(line)
    if result:
        start = result.group(1)
        startmili = result.group(2)
        middle = result.group(3)
        end = result.group(4)
        endmili = result.group(5)
        newstart = adddelta(start, startmili)
        newend = adddelta(end, endmili)
        outputfile.write("{}{}{}\n".format(newstart, middle, newend))
    else:
        outputfile.write("{}\n".format(line))

inputfile.close()
outputfile.close()

print("New subtitle file generated {}".format(outputname))
