create database if not exists airline_ontime;
use airline_ontime;

drop table if exists flights_raw;
drop table if exists airports_raw;
drop table if exists airlines_raw;
drop table if exists planes_raw;

create external table flights_raw (
  Year int,
  Month int,
  DayofMonth int,
  DayOfWeek int,
  DepTime  int,
  CRSDepTime int,
  ArrTime int,
  CRSArrTime int,
  UniqueCarrier varchar(6),
  FlightNum int,
  TailNum varchar(8),
  ActualElapsedTime int,
  CRSElapsedTime int,
  AirTime int,
  ArrDelay int,
  DepDelay int,
  Origin varchar(3),
  Dest varchar(3),
  Distance int,
  TaxiIn int,
  TaxiOut int,
  Cancelled int,
  CancellationCode varchar(1),
  Diverted varchar(1),
  CarrierDelay int,
  WeatherDelay int,
  NASDelay int,
  SecurityDelay int,
  LateAircraftDelay int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' lines terminated by '\n'
stored as textfile
location "${hivevar:location}/data/airlines/flights_raw"
tblproperties ("skip.header.line.count"="1")
;

create external table airports_raw (
	iata string,
	airport string,
	city string,
	state double,
	country string,
	lat double,
	lon double
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' lines terminated by '\n'
stored as textfile
location "${hivevar:location}/data/airlines/airports_raw"
tblproperties ("skip.header.line.count"="1")
;

create external table airlines_raw (
	code string,
	description string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' lines terminated by '\n'
stored as textfile
location "${hivevar:location}/data/airlines/airlines_raw"
tblproperties ("skip.header.line.count"="1")
;

create external table planes_raw (
	tailnum string,
	owner_type string,
	manufacturer string,
	issue_date string,
	model string,
	status string,
	aircraft_type string,
	engine_type string,
	year int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' lines terminated by '\n'
stored as textfile
location "${hivevar:location}/data/airlines/planes_raw"
tblproperties ("skip.header.line.count"="1")
;

-- data has to located on HS2 server
LOAD DATA LOCAL INPATH '/tmp/data/1987.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1990.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1993.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1996.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1999.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2002.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2005.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2008.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1988.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1991.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1994.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1997.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2000.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2003.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2006.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1989.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1992.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1995.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/1998.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2001.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2004.csv.bz2' INTO TABLE flights_raw;
LOAD DATA LOCAL INPATH '/tmp/data/2007.csv.bz2' INTO TABLE flights_raw;

LOAD DATA LOCAL INPATH '/tmp/data/carriers.csv.gz' INTO TABLE airlines_raw;
LOAD DATA LOCAL INPATH '/tmp/data/airports.csv.gz' INTO TABLE airports_raw;
LOAD DATA LOCAL INPATH '/tmp/data/plane-data.csv.gz' INTO TABLE planes_raw;

set hive.cli.print.header=true;

select * from flights_raw limit 1;
select * from airports_raw limit 1;
select * from airlines_raw limit 1;
select * from planes_raw limit 1;
