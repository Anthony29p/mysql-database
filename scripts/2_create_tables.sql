USE auditdb

create table if not exists Entity
(
    id_    int auto_increment
        primary key,
    id     varchar(50) not null,
    name   varchar(50) not null,
    module varchar(50) not null,
    code   varchar(50) null,
    type   varchar(50) null,
    date   varchar(50) not null,
    status varchar(50) not null
)
    collate = utf8mb4_unicode_ci;

create table if not exists Organization
(
    id_  int auto_increment
        primary key,
    id   varchar(50) not null,
    name varchar(50) not null
)
    collate = utf8mb4_unicode_ci;

create table if not exists User
(
    id_      int auto_increment
        primary key,
    name     varchar(50) not null,
    email    varchar(50) not null,
    fullname varchar(50) not null
)
    collate = utf8mb4_unicode_ci;

create table if not exists Revision
(
    id              varchar(191)                             not null
        primary key,
    action          varchar(50)                              not null,
    data            json                                     not null,
    data_to_string  varchar(3000)                            not null,
    creation_date   datetime(3) default CURRENT_TIMESTAMP(3) not null,
    entityId_       int                                      not null,
    organizationId_ int                                      null,
    userId_         int                                      not null,
    constraint Revision_id_key
        unique (id),
    constraint Revision_entityId__fkey
        foreign key (entityId_) references Entity (id_)
            on update cascade,
    constraint Revision_organizationId__fkey
        foreign key (organizationId_) references Organization (id_)
            on update cascade on delete set null,
    constraint Revision_userId__fkey
        foreign key (userId_) references User (id_)
            on update cascade
)
    collate = utf8mb4_unicode_ci;

create table if not exists _prisma_migrations
(
    id                  varchar(36)                               not null
        primary key,
    checksum            varchar(64)                               not null,
    finished_at         datetime(3)                               null,
    migration_name      varchar(255)                              not null,
    logs                text                                      null,
    rolled_back_at      datetime(3)                               null,
    started_at          datetime(3)  default CURRENT_TIMESTAMP(3) not null,
    applied_steps_count int unsigned default '0'                  not null
)
    collate = utf8mb4_unicode_ci;

