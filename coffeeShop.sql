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
alter table "productVariant" rename "adittionalPrice" to "additionalPrice";

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
alter table "orderDetails" add column "subtotal" int;

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

insert into "productSize" ("size","productid", "additionalPrice")
values ('small',1,0),('medium',1,3000),('large',1,5000),('small',2,0),('medium',2,3000),('large',2,5000),('small',3,0),('medium',3,3000),('large',3,5000),
('small',4,0),('medium',4,3000),('large',4,5000),('small',5,0),('medium',5,3000),('large',5,5000),('small',6,0),('medium',6,3000),('large',6,5000),
('small',7,0),('medium',7,3000),('large',7,5000),('small',8,0),('medium',8,3000),('large',8,5000),('small',9,0),('medium',9,3000),('large',9,5000),('small',10,0),('medium',10,3000),('large',10,5000);

insert into "productVariant" ("name","productid","additionalPrice")
values ('hot',1,0),('ice',1,3000),('hot',2,0),('ice',2,3000),('hot',3,0),('ice',3,3000),
('hot',4,0),('ice',4,3000),('hot',5,0),('ice',5,3000),('hot',6,0),('ice',6,3000),
('hot',7,0),('ice',7,3000),('hot',8,0),('ice',8,3000),('hot',9,0),('ice',9,3000),('hot',10,0),('ice',10,3000);

insert into "promo"("name","code","description","percentage","expireadAt","maximumPromo","minimumAmount")
values ('Fazz food 11-11','FAZZFOOD50',null,0.5,now()+interval '10 day',50000,20000),
('Diteraktir Fazztrack','DITRAKTIR60',null,0.6,now()+interval '10day',35000,10000);

-- Menambahkan transaksi untuk customer Rahman Sofyan , (basePrce+lareg+ice)
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(2, 'ORD-001-12112023', (25000+5000+3000), 'delivered', '99 bali, sanur', 'Rahman Sofyan', 'rahman@gmail.com');

-- detail transaksi untuk barang Espresso customer 1
insert into "orderDetails" ("productid","productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(1, 6, 2, 1,1,(25000+5000+3000) );

--Menambahkan 3 transaksi untuk customer Budi (capuchino+ice+large),(late+ice+large),(mocha+ice+large)
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(3, 'ORD-002-12112023', (30000+3000+5000), 'delivered', 'Jl. Pahlawan No. 123', 'Budi', 'budi@gmail.com');
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(3, 'ORD-003-12112023', (35000+3000+5000), 'delivered', 'Jl. Pahlawan No. 123', 'Budi', 'budi@gmail.com');
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(3, 'ORD-004-12112023', (38000+3000+5000), 'delivered', 'Jl. Pahlawan No. 123', 'Budi', 'budi@gmail.com');

-- Menambahkan detail transaksi untuk barang (cappuccino,late,mocha) pada masing-masing order
insert into "orderDetails" ("productid","productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(2, 9, 4, 1, 2, (30000+3000+5000));
insert into "orderDetails" ("productid","productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(3, 12, 6, 1, 3, (35000+3000+5000));
insert into "orderDetails" ("productid","productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(4, 15, 8, 1, 4,  (38000+3000+5000));

-- Menambahkan transaksi untuk customer Siti
-- Order 1 (americano+ice+large),(machiato+hot+small),(iceCoffee+ice+large),(caramelFrapechino+ice+large),(irisCoffe+hot+small)
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(4, 'ORD-005-12112023', ((22000+3000+5000)+(28000+0+0)+(26000+3000+5000)+(40000+3000+5000)+(32000+0+0)),
'delivered', 'Jl. Merdeka No. 456', 'Siti', 'siti@gmail.com');

-- Detail transaksi untuk (americano+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(5, 18, 10, 1, 5, (22000+3000+5000));
-- Detail transaksi untuk (machiato+hot+small) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(6, 19, 11, 1, 5, (28000+0+0));
-- Detail transaksi untuk (iceCoffee+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(7, 24, 14, 1, 5, (26000+3000+5000));
-- Detail transaksi untuk (caramelFrapechino+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(8, 27, 16, 1, 5, (40000+3000+5000));
-- Detail transaksi untuk (irisCoffe+hot+small) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(9, 28, 17, 1, 5, (32000+0+0));

-- Menambahkan transaksi untuk customer Siti
-- Order 2 (espreso+hot+small),(machiato+hot+small),(iceCoffee+ice+large),(caramelFrapechino+ice+large),(chaiLatte+ice+medium)
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(4, 'ORD-006-12112023', ((25000+0+0)+(28000+0+0)+(26000+3000+5000)+(40000+3000+5000)+(36000+3000+3000)),
'delivered', 'Jl. Merdeka No. 456', 'Siti', 'siti@gmail.com');

-- Detail transaksi untuk (espreso+hot+small) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(1, 4, 1, 1, 6, (25000+0+0));
-- Detail transaksi untuk (machiato+hot+small) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(6, 19, 11, 1, 6, (28000+0+0));
-- Detail transaksi untuk (iceCoffee+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(7, 24, 14, 1, 6, (26000+3000+5000));
-- Detail transaksi untuk (caramelFrapechino+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(8, 27, 16, 1, 6, (40000+3000+5000));
-- Detail transaksi untuk (chaiLatte+ice+medium) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(10, 32, 20, 1, 6, (32000+3000+3000));

-- Menambahkan transaksi untuk customer Siti
-- Order 3 (espreso+hot+small),(chappucino+ice+medium),(iceCoffee+ice+large),(caramelFrapechino+ice+large),(latte+ice+medium)
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(4, 'ORD-007-12112023', ((25000+0+0)+(30000+3000+3000)+(26000+3000+5000)+(40000+3000+5000)+(35000+3000+3000)),
'delivered', 'Jl. Merdeka No. 456', 'Siti', 'siti@gmail.com');

-- Detail transaksi untuk (espreso+hot+small) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(1, 4, 1, 1, 7, (25000+0+0));
-- Detail transaksi untuk (chappucino+ice+medium) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(2, 8, 4, 1, 7, (30000+3000+3000));
-- Detail transaksi untuk (iceCoffee+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(7, 24, 14, 1, 7, (26000+3000+5000));
-- Detail transaksi untuk (caramelFrapechino+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(8, 27, 16, 1, 7, (40000+3000+5000));
-- Detail transaksi untuk (latte+ice+medium) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(3, 11, 6, 1, 7, (35000+3000+3000));

-- Menambahkan transaksi untuk customer Siti
-- Order 4 (americano+ice+large),(chappucino+ice+medium),(iceCoffee+ice+large),(mocha+ice+large),(latte+ice+medium)
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(4, 'ORD-008-12112023', ((22000+3000+5000)+(30000+3000+3000)+(26000+3000+5000)+(38000+3000+5000)+(35000+3000+3000)),
'delivered', 'Jl. Merdeka No. 456', 'Siti', 'siti@gmail.com');

-- Detail transaksi untuk (americano+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(5, 18, 10, 1, 8, (22000+3000+5000));
-- Detail transaksi untuk (chappucino+ice+medium) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(2, 8, 4, 1, 8, (30000+3000+3000));
-- Detail transaksi untuk (iceCoffee+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(7, 24, 14, 1, 8, (26000+3000+5000));
-- Detail transaksi untuk (mocha+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(4, 15, 8, 1, 8, (38000+3000+5000));
-- Detail transaksi untuk (latte+ice+medium) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(3, 11, 6, 1, 8, (35000+3000+3000));

-- Menambahkan transaksi untuk customer Siti
-- Order 5 (americano+ice+large),(machiato+ice+medium),(iceCoffee+ice+large),(caramelFrapechino+ice+large),(irisCoffe+hot+small)
insert into "orders" ("userid", "orderNumber", "total", "status", "deliveryAddress", "fullName", "email")
values(4, 'ORD-009-12112023', ((22000+3000+5000)+(28000+3000+3000)+(26000+3000+5000)+(40000+3000+5000)+(32000+0+0)),
'delivered', 'Jl. Merdeka No. 456', 'Siti', 'siti@gmail.com');

-- Detail transaksi untuk (americano+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(5, 18, 10, 1, 9, (22000+3000+5000));
--agregasi (iceCoffee+ice+large)
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(5, 18, 10, 1, 9,
((select "basePrice" from "products" where "id" = 5 )+
(select "additionalPrice" from "productVariant"where "id" = 10)+
(select "additionalPrice" from "productSize"where "id"=18)));
-- Detail transaksi untuk (machiato+ice+medium) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(6, 20, 12, 1, 9, (28000+3000+3000));
--agregasi (machiato+ice+medium)
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(6, 20, 12, 1, 9,
((select "basePrice" from "products" where "id" = 7 )+
(select "additionalPrice" from "productVariant"where "id" = 12)+
(select "additionalPrice" from "productSize"where "id"=20)));
-- Detail transaksi untuk (iceCoffee+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(7, 24, 14, 1, 9, (26000+3000+5000));
--agregasi (iceCoffee+ice+large)
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(7, 24, 14, 1, 9,
((select "basePrice" from "products" where "id" = 7 )+
(select "additionalPrice" from "productVariant"where "id" = 14)+
(select "additionalPrice" from "productSize"where "id"=24)));
-- Detail transaksi untuk (caramelFrapechino+ice+large) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(8, 27, 16, 1, 9, (40000+3000+5000));
--agregasi (caramelFrapechino+ice+large)
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(8, 27, 16, 1, 9, 
((select "basePrice" from "products" where "id" = 8 )+
(select "additionalPrice" from "productVariant"where "id" = 16)+
(select "additionalPrice" from "productSize"where "id"=27)));
-- Detail transaksi untuk (irisCoffe+hot+small) customer Siti
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(9, 28, 17, 1, 9, (32000+0+0));
--agregasi (irisCoffe+hot+small)
insert into "orderDetails" ("productid", "productSizeid" ,"productVariantid" , "quantity", "orderId", "subtotal")
values(9, 28, 17, 1, 9, 
((select "basePrice" from "products" where "id" = 9 )+
(select "additionalPrice" from "productVariant"where "id" = 17)+
(select "additionalPrice" from "productSize"where "id"=28)));

--tes joint
select "o"."orderNumber" ,"p"."name", "od"."quantity" ,"od"."subtotal", "o"."total" from "orders" "o"
join "orderDetails" "od" on "od"."orderId" = "o"."id"
join "products" "p" on "od"."productid" = "p"."id";


