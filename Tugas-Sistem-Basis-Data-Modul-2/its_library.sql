create database if not exists its_library;

use its_library;

create table publisher (
    id int primary key not null,
    name varchar(100) not null,
    city varchar(100) not null,
    phone_number varchar(13) not null
);

create table book (
    id char(6) primary key not null,
    isbn char(13) not null,
    title varchar(100) not null,
    publication_year char(4) not null,
    page_count int not null,
    stock int not null,
    publisher_id int not null,
    foreign key (publisher_id) references publisher(id) on update cascade on delete cascade
);

create table author (
    id int primary key not null,
    name varchar(100) not null,
    country_of_origin varchar(100) not null
);

create table book_author (
    book_id char(6) not null,
    author_id int not null,
    primary key (book_id, author_id),
    foreign key (book_id) references book(id) on update cascade on delete cascade,
    foreign key (author_id) references author(id) on update cascade on delete cascade
);

create table staff (
    id int primary key not null,
    name varchar(100) not null,
    job_title varchar(100) not null,
    phone_number varchar(13) not null
);

create table member (
    member_no char(10) primary key not null,
    name varchar(100) not null,
    birth_date date not null,
    address varchar(100) not null,
    phone_number varchar(13) not null,
    gender char(1) not null,
    member_status varchar(50) not null
);

create table loan (
    id char(6) primary key not null,
    loan_time timestamp not null,
    due_date date not null,
    return_date date null,
    loan_status varchar(50) not null,
    member_no char(10) not null,
    book_id char(6) not null,
    staff_id int not null,
    foreign key (member_no) references member(member_no) on update cascade on delete cascade,
    foreign key (book_id) references book(id) on update cascade on delete cascade,
    foreign key (staff_id) references staff(id) on update cascade on delete cascade
);

create table fine (
    id char(6) primary key unique not null,
    amount int not null,
    fine_type varchar(50) not null,
    payment_status varchar(50) not null,
    loan_id char(6) not null,
    foreign key (loan_id) references loan(id) on update cascade on delete cascade
);

insert into publisher values (1, 'Gramedia Pustaka Utama', 'Jakarta', '0215551001');
insert into publisher values (2, 'Bentang Pustaka', 'Yogyakarta', '0274555002');
insert into publisher values (3, 'Informatika Bandung', 'Bandung', '0225555003');
insert into publisher values (4, 'Lentera Dipanta', 'Jakarta', '0215555004');

insert into author values (1, 'Andrea Hirata', 'Indonesial');
insert into author values (2, 'Pramoedya Ananta Toer', 'Indonesia');
insert into author values (3, 'Tere Liye', 'Indonesial');
insert into author values (4, 'Rinaldi Munir', 'Indonesial');
insert into author values (5, 'Leoni Lidya', 'Indonesial');

insert into book values ('BK0001', '9786021000014', 'Laskar Pelangi', '2005', 529, 5, 2);
insert into book values ('BK0002', '9786021000021', 'Bumi Manusia', '2005', 535, 3, 4);
insert into book values ('BK0003', '9786021000038', 'Bumi', '2014', 440, 4, 1);
insert into book values ('BK0004', '9786021000045', 'Algoritma dan pemrograman', '2016', 458, 6, 3);
insert into book values ('BK0005', '9786021000052', 'Sang Pemimpin', '2006', 292, 2, 2);

insert into book_author values 
    ('BK0001', 1),
    ('BK0002', 2),
    ('BK0003', 3),
    ('BK0004', 4),
    ('BK0005', 5);

insert into member values 
    ('5026231001', 'Rani Putri', '2004-03-15', 'Jl. Keputih Tegal No.12, Surabaya', '081234567801', 'F', 'Active'),
    ('5026231002', 'Budi Santoso', '2003-11-02', 'Jl. Gubeng Pojok No. 5, Surabaya', '081234567802', 'M', 'Active'),
    ('5026231003', 'Dewi Anggraini', '2004-07-21', 'Jl. Dharmahusada No.20, Surabaya', '081234567803', 'F', 'Active'),
    ('5026231004', 'Ahmad Fauzi', '2002-12-09', 'Jl. Mulyorejo No.3, Surabaya', '081234567804', 'M', 'Inactive'),
    ('5026231005', 'Siti Rahmawati', '2003-05-28', 'Jl. Ngagel Jaya No.8, Surabaya', '081234567805', 'F', 'Active');

insert into staff values 
    (1, 'Hendra Wijaya', 'Librarian', '081345678901'),
    (2, 'Lestari Wilandari', 'Circulating Staff', '081345678902'),
    (3, 'Bambang Pratama', 'Cataloging Staff', '081345678903');

insert into loan values
    ('LN0001', '2026-09-14 09:00:00', '2026-09-21', '2026-09-20', 'Returned', '5026231001', 'BK0001', 1),
    ('LN0002', '2026-09-15 10:30:00', '2026-09-22', NULL, 'Overdue', '5026231002', 'BK0002', 2),
    ('LN0003', '2026-09-20 13:15:00', '2026-09-27', '2026-09-29', 'Returned', '5026231003', 'BK0003', 1),
    ('LN0004', '2026-10-08 09:00:00', '2026-10-15', NULL, 'Borrowed', '5026231001', 'BK0005', 3),
    ('LN0005', '2026-10-10 11:00:00', '2026-10-17', NULL, 'Borrowed', '5026231005', 'BK0004', 1),
    ('LN0006', '2026-09-25 14:20:00', '2026-10-02', NULL, 'Overdue', '5026231003', 'BK0004', 2);

alter table member 
add ( 
    email varchar(50), 
    activity_points int default 0
);

alter table publisher
modify phone_number varchar(20) not null;

alter table author
drop column country_of_origin;

alter table book
add constraint uq_book_isbn unique (isbn);

insert into fine values 
    ('FN0001', 5000, 'Late', 'Unpaid', 'LN0002'),
    ('FN0002', 2000, 'Late', 'Unpaid', 'LN0003'),
    ('FN0003', 3000, 'Late', 'Unpaid', 'LN0006');

update loan
set return_date = '2026-10-12',
    loan_status = 'Returned'
where id = 'LN0002';

update member
set phone_number = '0812233445566'
where member_no = '5026231001';

update fine 
set payment_status = 'Paid'
where id = 'FN0003';

delete from book
where id = 'BK0005' and title = 'Sang Pemimpin' and isbn = '9786021000052';

delete from loan 
where loan_status = 'Returned';
