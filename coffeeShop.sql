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
    "basePrice" int not null,
    "image" varchar,
    "discount" numeric(3,2),
    "isRecommended" boolean,
    "created_at" timestamp default now() not null,
	"update_at" timestamp
);

create table if not exists "productSize" (
    "id" serial primary key,
    "size" varchar(15) check (size in ('small', 'medium', 'large')) not null,
    "productid" int references "products"("id"),
    "additionalPrice" numeric(6) not null,
    "created_at" timestamp default now() not null,
	"update_at" timestamp
);


create table if not exists "productVariant"(
	"id" serial primary key,
	"name" varchar (50),
	"productid" int references "products"("id"),
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
	"tagid" int references "tags"("id"),
	"productid" int references "products"("id"),
	"created_at" timestamp default now() not null,
	"update_at" timestamp
);

create table if not exists "productRatings"(
	"id" serial primary key,
	"productid" int references "products"("id"),
	"rate" int,
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
	"name" varchar(30) not null,
	"code" varchar(20) not null,
	"description" text,
	"percentage" numeric(3,2),
	"expireadAt" timestamp not null ,
	"maximumPromo" int,
	"minimumAmount" int,
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
values('Ran', 'ran@gmail.com', 'pass', 'jl.taman jaya', null, '0876543210', 'admin'),
('Rahman Sofyan', 'rahman@gmail.com', 'password123', '99 bali, sanur', null, '08796876', 'customer'),
('Budi', 'budi@gmail.com', 'budi123', 'Jl. Pahlawan No. 123', null, '0812345678', 'customer'),
('Siti', 'siti@gmail.com', 'siti456', 'Jl. Merdeka No. 456', null, '0898765432', 'customer');

insert into "products" ("name", "description", "basePrice", "image", "discount", "isRecommended")
values('Espresso', 'Single shot of espresso', 25000, null, null,null),
    ('Cappuccino', 'Espresso steamed milk and foam', 30000, null, null, true),
  	('Latte', 'Espresso and steamed milk with a small amount of foam', 35000, null, null, null),
  	('Mocha', 'Espresso steamed milk chocolate and whipped cream', 38000, null, null, null),
  	('Americano', 'Diluted espresso with hot water', 22000, null, null, null),
  	('Macchiato', 'Espresso stained or marked with a small amount of foam', 28000, null, null, null),
  	('Iced Coffee', 'Chilled brewed coffee served over ice', 26000, null, null, null),
  	('Caramel Frappuccino', 'Blended coffee caramel milk ice topped whipped cream', 40000, null, null, null),
  	('Irish Coffee', 'Hot coffee Irish whiskey sugar topped cream', 32000, null, null, null),
  	('Chai Latte', 'Black tea spices steamed milk', 36000, null, null, null);








