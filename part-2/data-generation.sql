-- Assume you already did part-1/data-generation.sql

-- Create table for the extra challenge
drop table if exists measurements_extra_1trc;
create table measurements_extra_1trc(station string, ts timestamp, sensor_type int, measure decimal(5,2))
stored as iceberg;

insert into measurements_extra_1trc
select a.station,
      seconds_add('2024-01-01 00:00:00', cast(rand(unix_timestamp()) * 31622400 as int)),
      cast(rand(unix_timestamp() div 2) * 100 as int),
      a.measure
from measurements_1trc as a;

-- Create partitioned table for the extra challenge
drop table if exists measurements_extra_1trc_partitioned;
create table measurements_extra_1trc_partitioned (station string, ts timestamp, sensor_type int,
  measure decimal(5,2))
partitioned by spec (bucket(11, station), day(ts), truncate(10, sensor_type))
stored by iceberg
tblproperties ('format-version'='2');

insert into measurements_extra_1trc_partitioned
/* +noclustered */
select * from measurements_extra_1trc;

-- DML 1
delete from measurements_extra_1trc_partitioned
where sensor_type = 13;

-- DML 2
update measurements_extra_1trc_partitioned set measure = cast(measure - 2 as decimal(5,2))
  where station in ('Budapest', 'Paris', 'Zurich', 'Kuala Lumpur')
  and sensor_type in (7, 17, 77);

-- DML 3
delete from measurements_extra_1trc_partitioned
where ts between '2024-01-15 11:30:00' and '2024-09-10 11:30:00'
  and sensor_type between 45 and 51
  and station regexp '[ATZ].*';

-- DML 4
update measurements_extra_1trc_partitioned set measure = cast(measure + 5 as decimal(5,2))
where station in ('Accra', 'Addis Ababa', 'Entebbe', 'Helsinki', 'Hong Kong', 'Nairobi', 'Ottawa', 'Tauranga', 'Yaounde', 'Zagreb', 'Zurich')
  and ts > '2024-11-05 22:30:00'
  and sensor_type > 90;

-- DML 5
delete from measurements_extra_1trc_partitioned
where
  sensor_type between 65 and 77
  and ts > '2024-08-11 12:00:00';

-- DML 6
update measurements_extra_1trc_partitioned set measure = cast(measure + 3.5 as decimal(5,2))
where
  sensor_type in (56, 66, 76, 86, 96)
  and ts < '2024-03-17 01:00:00'
  and (station like 'Z%' or station like 'Y%');

