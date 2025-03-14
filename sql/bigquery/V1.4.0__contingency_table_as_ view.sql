CREATE OR REPLACE VIEW dsongcp.contingency_table AS
    WITH contingency_table AS (
        SELECT
            THRESH,
            COUNTIF(DEP_DELAY < THRESH AND ARR_DELAY < 15) AS true_positives,
            COUNTIF(DEP_DELAY < THRESH AND ARR_DELAY >= 15) AS false_positives,
            COUNTIF(DEP_DELAY >= THRESH AND ARR_DELAY < 15) AS false_negatives,
            COUNTIF(DEP_DELAY >= THRESH AND ARR_DELAY >= 15) AS true_negatives,
            COUNT(*) AS total
        FROM `dsongcp-452504.dsongcp.flights` , UNNEST([5, 10, 11, 12, 13, 15, 20]) AS THRESH
        WHERE DEP_DELAY IS NOT NULL AND ARR_DELAY IS NOT NULL
        GROUP BY THRESH
    )

    SELECT
        ROUND((true_positives + true_negatives) / total, 2) AS accuracy,
        ROUND((false_positives/(true_positives + false_positives)), 2) AS fpr,
        ROUND((false_negatives/(false_negatives + true_negatives)), 2) AS fnr,
        *
    FROM contingency_table ORDER BY accuracy;