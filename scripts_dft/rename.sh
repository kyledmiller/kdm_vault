#!/bin/bash

for x in *"foo"*; do
  mv -- "$x" "${x//foo/bar}"
done
