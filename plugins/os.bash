#!/bin/bash

#{os_mountpoint_free [arg]}: 
#{os_mountpoint_size [arg] }: 
#{os_mount}: Output of "mount"
#{os_uname [arg]}:  
#{os_exec_cmd [arg]}:

replace cmd "{os_uname\s*\([^}]*\)}" "uname \1"
replace cmd "{os_mount}" "mount"

