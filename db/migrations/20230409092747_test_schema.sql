-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE SCHEMA IF NOT EXISTS "test" AUTHORIZATION "blog_user";

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP SCHEMA IF EXISTS "test";
