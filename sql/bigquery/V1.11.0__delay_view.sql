-- Aggregate results by airport, lat, lon
CREATE OR REPLACE VIEW dsongcp.airport_delays AS
    WITH delays AS (
        SELECT
            d.*,
            a.LATITUDE,
            a.LONGITUDE
        FROM `dsongcp.streaming_delays` d
                 JOIN `dsongcp.airports_gcs` a USING (AIRPORT)
        WHERE a.AIRPORT_IS_LATEST = 1
    )

    SELECT
        airport,
        CONCAT(latitude, ',', longitude) AS location,
        ARRAY_AGG(
                STRUCT(avg_dep_delay, avg_arr_delay, num_flights, end_time)
                    ORDER BY end_time DESC LIMIT 1) AS a
    FROM delays
    GROUP BY airport, longitude, latitude;