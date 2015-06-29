#!/bin/bash

set -e -x;

hive -v -f ddl/text.sql;
hive -v -f ddl/orc.sql;
