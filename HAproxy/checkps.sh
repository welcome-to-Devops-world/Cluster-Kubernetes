#!/bin/bash
if expr `ps -ef | grep haproxy | wc -l` - 1 == 0
then
        exit 1
else
        exit 0
fi