#!/usr/bin/env bash

pgloader --with "batch rows=500" --with "batch size=2048MB" --with "prefetch rows=10000" $1 postgresql://postgres:changeme@localhost/$2
