CREATE TABLE "user" (
    "admin" boolean NOT NULL DEFAULT false,
    "username" varchar(20) NOT NULL,
    "password" varchar(32) NOT NULL, -- 32 character MD5 hash
    PRIMARY KEY ("username")
);
