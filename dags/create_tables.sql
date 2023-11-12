drop table if exists staging_events;
drop table if exists staging_songs;
drop table if exists songplays;
drop table if exists users;
drop table if exists songs;
drop table if exists artists;
drop table if exists time;

create table if not exists staging_events (
        artist              varchar,
        auth                varchar,
        firstname           varchar,
        gender              char(1),
        iteminsession       int,
        lastname            varchar,
        length              float,
        level               varchar,
        location            text,
        method              varchar,
        page                varchar,
        registration        float,
        sessionid           int,
        song                varchar,
        status              int,
        ts                  bigint,
        useragent           text,
        userid              varchar
);

create table if not exists staging_songs (
        num_songs           int,
        artist_id           varchar,
        artist_latitude     float,
        artist_longitude    float,
        artist_location     text,
        artist_name         varchar,
        song_id             varchar,
        title               varchar,
        duration            float,
        year                int
);

create table if not exists songplays (
        songplay_id         varchar     primary key,
        start_time          timestamp   not null,
        userid              varchar,
        level               varchar,
        song_id             varchar,
        artist_id           varchar,
        sessionid           int,
        location            text,
        useragent           text
);

create table if not exists users(
        userid              varchar     primary key,
        first_name          varchar,
        last_name           varchar,
        gender              char(1),
        level               varchar
);

create table if not exists songs (
        song_id             varchar     primary key,
        title               varchar,
        artist_id           varchar,
        year                int,
        duration            float
);

create table if not exists artists (
        artist_id           varchar     primary key,
        name                varchar,
        location            text,
        latitude            float,
        longitude           float
);

create table if not exists time (
        start_time          timestamp   primary key,
        hour                int,
        day                 int,
        week                int,
        month               int,
        year                int,
        weekday             int
);
