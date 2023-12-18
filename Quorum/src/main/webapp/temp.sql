SELECT
    p
FROM
    Professor p
WHERE
    (
        (firstName LIKE :query)
        OR (lastName LIKE :query)
    )
    AND enabled = true