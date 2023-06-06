#!/bin/bash
for i in $(pgrep mcsqs | awk '{print $1}'); do pwdx $i; done
