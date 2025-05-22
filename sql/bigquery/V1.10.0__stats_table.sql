CREATE TABLE IF NOT EXISTS dsongcp.streaming_delays
(
    airport STRING,
    avg_arr_delay FLOAT64,
    avg_dep_delay FLOAT64,
    num_flights INT,
    start_time TIMESTAMP,
    end_time TIMESTAMP
)