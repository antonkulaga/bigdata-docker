#!/usr/bin/env bash

pgloader --with "batch rows=10000" --with "batch size=10MB" --with "prefetch rows=50000" $1 postgresql://postgres:changeme@localhost/sra