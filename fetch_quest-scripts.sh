#!/bin/bash

rsync -avz --max-size=10m qaddr:~/scripts_dft/ quest/
