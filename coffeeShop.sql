create table if not exists "users" (
    "id" serial primary key,
    "fullName" varchar not null,
    "email"  varchar not null unique,
    "password" varchar not null,
    "address" text,
    "picture" varchar,
    "phoneNumber" varchar(15),
    "role" varchar(20) check (role in ('admin', 'staff', 'customer')),
    "created_at" timestamp default now() not null,
	"update_at" timestamp
);
create table if not exists "products" (
    "id" serial primary key,
    "name" varchar not null,
    "description" text,
    "price" numeric(10, 2),
    "image" varchar,
    "discount" numeric(5, 2),
    "isRecommended" boolean
);

create table if not exists "productSize" (
    "id" serial primary key,
    "size" varchar(15) check (size in ('small', 'medium', 'large')) not null,
    "additionalPrice" numeric(6) not null
);
alter table "products" add column "created_at" timestamp default now() not null;
alter table "products" add column"update_at" timestamp;
alter table "productSize" add column "created_at" timestamp default now() not null;
alter table "productSize" add column"update_at" timestamp;
alter table "products" alter column "discount" type float;








