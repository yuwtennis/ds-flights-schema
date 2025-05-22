ALTER TABLE dsongcp.streaming_events
    ADD COLUMN notify_time STRING,
    ADD COLUMN event_type STRING,
    ADD COLUMN event_time TIMESTAMP;