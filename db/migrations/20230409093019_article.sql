-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE IF NOT EXISTS "articles"
(
    "id"         BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    "title"      TEXT                                NOT NULL,
    "body"       TEXT                                NOT NULL,
    "created_at" TIMESTAMPTZ                         NOT NULL,
    "updated_at" TIMESTAMPTZ                         NOT NULL,
    "deleted_at" TIMESTAMPTZ                         NULL
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE IF EXISTS "articles";
