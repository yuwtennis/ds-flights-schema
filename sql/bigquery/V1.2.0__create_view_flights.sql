CREATE OR REPLACE VIEW dsongcp.flights AS
       SELECT
           FlightDate AS FL_DATE,
           Reporting_Airline AS UNIQUE_CARRIER,
           OriginAirportSeqID AS ORIGIN_AIRPORT_SEQ_ID,
           Origin AS ORIGIN,
           DestAirportSeqID AS DEST_AIRPORT_SEQ_ID,
           Dest AS DEST,
           CRSDepTime AS CRS_DEP_TIME,
           DepTime AS DEP_TIME,
           CAST(DepDelay AS FLOAT64) AS DEP_DELAY,
           CAST(TaxiOut AS FLOAT64) AS TAXI_OUT,
           WheelsOff AS WHEELS_OFF,
           WheelsOn AS WHEELS_ON,
           CAST(TaxiIn AS FLOAT64) AS TAXI_IN,
           CRSArrTime AS CRS_ARR_TIME,
           ArrTime AS ARR_TIME,
           CAST(ArrDelay AS FLOAT64) AS ARR_DELAY,
           IF(Cancelled = '1.00', True, False) AS CANCELLED,
           IF(Diverted = '1.00', True, False) AS DIVERTED,
           DISTANCE
       FROM dsongcp.flights_raw;