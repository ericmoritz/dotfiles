#!/usr/bin/env python3
from subprocess import check_output
import json
import sys

def formatTime(duration, effort):
    duration=int(duration)
    effort=int(effort)
    style = " | color=red" if duration > effort else ""
    return "[{duration}/{effort}]{style}".format(**locals())

# Get the current task as JSON
data = check_output(["emacsclient",  "--eval", "(princ (json-encode (list :effort (org-duration-to-minutes org-clock-effort) :duration (org-duration-to-minutes (org-clock-get-clocked-time)) :task (if org-clock-current-task org-clock-heading))))"])
data = json.loads(json.loads(data))
# If there is no task, clock out
if data["task"] is None:
    print("[OUT]")
    sys.exit(0)

print(formatTime(data["duration"], data["effort"]))
print("---")
print('{task}'.format(**data))

