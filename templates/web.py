#!/usr/bin/python3
import subprocess
import cgi


print("content-type: text/html")
print()

output = subprocess.getoutput("/usr/games/fortune")
print(output)
print("<a href='http://google.com'>google</a>")