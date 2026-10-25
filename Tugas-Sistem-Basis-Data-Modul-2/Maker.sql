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











