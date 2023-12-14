-- SQL version
SELECT
    gp.*
FROM
    group_post gp
    JOIN user_follow uf ON gp.user_id = uf.following_id
WHERE
    uf.user_id = 10
UNION
SELECT
    gp.*
FROM
    group_post gp
    JOIN social_group_member sgm on gp.social_group_id = sgm.group_id
WHERE
    sgm.user_id = 10;

-- JPQL version
SELECT
    post
FROM
    GroupPost post
WHERE
    EXISTS (
        SELECT
            1
        FROM
            post.user.followers f
        WHERE
            f.id = :userId
            AND post = post
    )
    OR EXISTS (
        SELECT
            1
        FROM
            post.group.members member
        WHERE
            member.id = :userId
            AND post = post
    )