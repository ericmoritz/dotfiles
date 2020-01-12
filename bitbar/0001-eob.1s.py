#!/usr/local/bin/python3
import time
from datetime import datetime

EOB = "18:00"

now = datetime.now()
eob_time = datetime.strptime("{} {}".format(now.date().strftime("%m-%d-%y"), EOB), "%m-%d-%y %H:%M")

diff = eob_time - now
if diff.total_seconds() < 0:
    print("Go Home!")
else:
    diff = ":".join(str(diff).split(":")[:2])
    print(diff + "h")
