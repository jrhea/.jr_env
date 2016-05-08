#!/bin/bash
watch -e -n $1 'if ps cax | grep -w '$2'; then exit 0; else exit 1; fi'
