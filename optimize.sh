#!/bin/bash

set -e -x;

hive -v -f ddl/analyze.sql;
