CREATE USER "blog_test_user" WITH PASSWORD 'mYAw3s0meB!og';
CREATE SCHEMA "test" AUTHORIZATION "blog_test_user";

ALTER ROLE "blog_test_user" SET search_path TO "test";
ALTER ROLE "blog_user" SET search_path TO "public";
