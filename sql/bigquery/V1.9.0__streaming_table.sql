CREATE TABLE IF NOT EXISTS dsongcp.streaming_events
(
    fl_date DATE,
    unique_carrier STRING,
    origin_airport_seq_id INT,
    origin STRING,
    dep_airport_tzoffset FLOAT64,
    dest_airport_seq_id FLOAT64,
    dest STRING,
    arr_airport_tzoffset FLOAT64,
    crs_dep_time TIMESTAMP,
    dep_time TIMESTAMP,
    dep_delay INT,
    taxi_out INT,
    wheels_off TIMESTAMP,
    wheels_on TIMESTAMP,
    taxi_in INT,
    crs_arr_time TIMESTAMP,
    arr_time TIMESTAMP,
    arr_delay INT,
    cancelled BOOL,
    diverted BOOL,
    distance FLOAT64
)
PARTITION BY
    DATE_TRUNC(fl_date, MONTH);