-- 1. Get the forum post from April 2048 mentioning EmptyStack and dad
SELECT * FROM forum_posts
WHERE content ILIKE '%emptystack%' AND content ILIKE '%dad%'
  AND date >= '2048-04-01' AND date < '2048-05-01';

-- 2. Get the author's first and last name
SELECT first_name, last_name FROM forum_accounts
WHERE username = (
  SELECT author FROM forum_posts
  WHERE content ILIKE '%emptystack%' AND content ILIKE '%dad%'
    AND date >= '2048-04-01' AND date < '2048-05-01'
  LIMIT 1
);

-- 3. Find forum accounts sharing that last name
SELECT * FROM forum_accounts
WHERE last_name = (
  SELECT last_name FROM forum_accounts
  WHERE username = (
    SELECT author FROM forum_posts
    WHERE content ILIKE '%emptystack%' AND content ILIKE '%dad%'
      AND date >= '2048-04-01' AND date < '2048-05-01'
    LIMIT 1
  )
);

-- 4. Find employees with the same last name
SELECT * FROM emptystack_accounts
WHERE last_name = (
  SELECT last_name FROM forum_accounts
  WHERE username = (
    SELECT author FROM forum_posts
    WHERE content ILIKE '%emptystack%' AND content ILIKE '%dad%'
      AND date >= '2048-04-01' AND date < '2048-05-01'
    LIMIT 1
  )
);

-- 5. Find the employee’s post about the taxi project
SELECT content FROM forum_posts
WHERE author = (
  SELECT username FROM emptystack_accounts
  WHERE last_name = (
    SELECT last_name FROM forum_accounts
    WHERE username = (
      SELECT author FROM forum_posts
      WHERE content ILIKE '%emptystack%' AND content ILIKE '%dad%'
        AND date >= '2048-04-01' AND date < '2048-05-01'
      LIMIT 1
    )
  )
)
AND content ILIKE '%taxi project%';

-- 6. Get admin account credentials
SELECT username, password FROM emptystack_accounts
WHERE username = 'admin';

-- 7. Get the taxi project ID
SELECT id FROM forum_posts
WHERE content ILIKE '%taxi project%';
