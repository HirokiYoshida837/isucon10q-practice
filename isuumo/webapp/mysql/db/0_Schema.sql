DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    popularity_desc INTEGER AS (-popularity) NOT NULL,
    `point`     POINT AS (POINT(latitude, longitude)) STORED NOT NULL
);

-- invisible column使いたいが、mysql8からでないとつかえない。json側でResponseに含めないようにする。
-- reverseId INTEGER GENERATED ALWAYS AS (id*-1) でgenerated columnつくるのと何が違うんだろう

create index estate_rent_index
	on isuumo.estate (rent);

create index estate_popularity_index
	on isuumo.estate (popularity);

create index estate_popularity_desc_index
	on isuumo.estate (popularity_desc);

alter table isuumo.estate add spatial index (point);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL,
    popularity_desc INTEGER AS (-popularity) NOT NULL
);

create index chair_price_index
	on isuumo.chair (price);

-- create index chair_popularity_index
-- 	on isuumo.chair (popularity);

create index chair_popularity_desc_index
	on isuumo.chair (popularity_desc);


