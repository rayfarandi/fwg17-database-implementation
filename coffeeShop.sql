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

insert into "tags" ("name") values ('Flash sale'),('Buy 1 get 1'),('Birthday Package'),('Cheap');

insert into"productTags" ("productid", "tagid")
values(1, 1),(2, 2),(1,4);

insert into "productRatings" ("productid", "rate", "reviewMessage", "userid")
values(1, 4.0, 'mantap coffee!', 1),(2, 5.0, 'cappuccino nya enak!', 1);

insert into "categories" ("name")
values('Favorite Product'),('Coffee'),('Non Coffee'),('Foods'),('Add-On');

insert into "productCategories" ("productid", "categoryid")
values(1, 2),(2, 2);

insert into "promo" ("name", "code", "description", "percentage", "isExpired", "maximumPromo", "minimumAmount")
values ('HAPPY MOTHER’S DAY!', 'MOTHERDAY', '50% off on selected items', 0.50, false, 10000, 50000);

insert into "orders" ("userid", "orderNumber", "promoid", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
values(1, '001-11112023-0023', 1, 30000, null, 'on-progress', '123 Elm St', '99 bali, sanur', 'rahman@gmail.com'),
    	(1, '001-11112023-0024', 1, 45000, null, 'delivered', '456 Oak St', '99 bali, sanur', 'rahman@gmail.com');

insert into "orderDetails" ("productid", "productSizeid", "productVariantid", "quantity", "orderId")
values(1, 1, 1, 2, 1),(2, 2, 1, 1, 2);

insert into "message" ("recipientid", "senderid", "text")
values(1, 2, 'Hello, admin!'),(2, 1, 'Hi, Rahman! ada yg bisa saya bantu?');

--melihat semua data di product dan productCategory
select "p".*, "c".*
FROM "products" "p"
JOIN "productCategories" "pc" ON "p"."id" = "pc"."productid";

--melihat data produk nama,harga,deskripsi dan tags dari produk
select "p"."name","price","description","t"."name" from "products" "p"
join "productTags" "pt" on "pt"."id" = "p"."id"
join "tags" "t" on "t"."id" = "pt"."id";









