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

create table if not exists "productVariant"(
	"id" serial primary key,
	"name" varchar (50),
	"adittionalPrice" numeric(6),
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);

create table if not exists "tags"(
	"id" serial primary key,
	"name" varchar,
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);

create table if not exists "productTags"(
	"id" serial primary key,
	"productid" int references "products"("id"),
	"tagid" int references "tags"("id"),
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);

create table if not exists "productRatings"(
	"id" serial primary key,
	"productid" int references "products"("id"),
	"rate" numeric (1),
	"reviewMessage" text,
	"userid" int references "users"("id"),
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);
create table if not exists "categories"(
	"id" serial primary key,
	"name" varchar,
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);
create table if not exists "productCategories"(
	"id" serial primary key,
	"productid" int references "products"("id"),
	"categoryid" int references "categories"("id"),
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);
create table if not exists "promo"(
	"id" serial primary key,
	"name" varchar(20) not null,
	"code" varchar(20) not null,
	"description" varchar,
	"percentage" float,
	"isExpired" boolean,
	"maximumPromo"int,
	"minimumAmount"int,
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);
create table if not exists "orders"(
	"id" serial primary key,
	"userid" int references "users"("id"),
	"orderNumber" varchar,
	"promoid" int references "promo"("id"),
	"total" numeric (15,2),
	"taxAmount" numeric (12,2),
	"status" varchar(15) check (status in ('on-progress','delivered','canceled','ready-to-pick')) not null,
	"deliveryAddress" text ,
	"fullName" varchar,
	"email" varchar,
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);
create table if not exists "orderDetails"(
	"id" serial primary key,
	"productid" int references "products"("id"),
	"productSizeid" int references "productSize"("id"),
	"productVariantid" int references "productVariant"("id"),
	"quantity" numeric(10,2),
	"orderId" int references "orders"("id"),
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);
create table if not exists "message"(
	"id" serial primary key,
	"recipientid" int references "users"("id"),
	"senderid" int references "users"("id"),
	"text" text,
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);

insert into "users" ("fullName", "email", "password", "address", "picture", "phoneNumber", "role")
values('Rahman Sofyan', 'rahman@gmail.com', 'password123', '99 bali, sanur', null, '08796876', 'customer'),
	('Ran', 'ran@gmail.com', 'pass', 'jl.taman jaya', null, '0876543210', 'admin');
insert into "products" ("name", "description", "price", "image", "discount", "isRecommended")
values('Espresso', 'Single shot of espresso', 25000, null, 0.10,null),
    ('Cappuccino', 'Espresso steamed milk and foam', 30000, null, null, true);

insert into "productSize" ("size", "additionalPrice")
values ('small', 0),('medium', 3000),('large',5000);

insert into "productVariant" ("name", "adittionalPrice")
values('Original', 0),('Spicy', 2000);




