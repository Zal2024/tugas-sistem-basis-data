## no 1
create database if not exists laboratory;

use laboratory;

create table student (
   student_id char(6) primary key,
   student_name varchar(100) not null,
   email varchar(100) not null UNIQUE,
   active_status BOOLEAN not null
);

create table staff (
   staff_id char(6) primary key,
   staff_name varchar(100) not null,
   staff_email varchar(100) not null UNIQUE
);

create table borrowing (
   borrowing_id char(6) primary key,
   borrow_date date not null,
   due_date date not null,
   return_date date null,
   student_student_id char(6) not null,
   staff_staff_id char(6) not null,
   FOREIGN KEY (student_student_id) REFERENCES student(student_id) on update cascade on delete restrict,
   FOREIGN KEY (staff_staff_id) REFERENCES staff(staff_id) on update cascade on delete RESTRICT
);

create table supplier (
   supplier_id char(6) primary key,
   supplier_name varchar(100) not null,
   phone varchar(20) not null,
   supplier_email varchar(100) NULL
);


create table equipment_category (
   category_id char(6) primary key,
   category_name varchar(50) not null UNIQUE
);


create table laboratory_room (
   room_id char(6) primary key,
   room_name varchar(100) not null,
   building varchar(50) not null,
   floor INT not null
);

create table equipment (
   equipment_id char(6) primary key,
   equipment_name varchar(100) not null,
   equipment_condition varchar(20) not null,
   equipment_status varchar(20) not null,
   procurement_date date NULL,
   equipment_category_category_id char(6) not null,
   laboratory_room_room_id char(6) not null,
   supplier_supplier_id char(6) not null,
   FOREIGN KEY (equipment_category_category_id) REFERENCES equipment_category(category_id) on update cascade on delete restrict,
   FOREIGN KEY (laboratory_room_room_id) REFERENCES laboratory_room(room_id) on update cascade on delete restrict,
   FOREIGN KEY (supplier_supplier_id) REFERENCES supplier(supplier_id) on update cascade on delete restrict 
);

create table borrowing_detail (
   borrowing_borrowing_id char(6),
   equipment_equipment_id char(6),
   primary key(borrowing_borrowing_id, equipment_equipment_id),
   foreign key (borrowing_borrowing_id) REFERENCES borrowing(borrowing_id) on UPDATE CASCADE on delete restrict,
   foreign key (equipment_equipment_id) REFERENCES equipment(equipment_id) on UPDATE CASCADE on delete RESTRICT
);

## no 2
alter table equipment add storage_location varchar(50) not null DEFAULT 'Not yet assigned';

## no 3
create table maintenance (
   maintenance_id char(6) primary key,
   equipment_id char(6) not null,
   maintenance_date date not null,
   descriptioner varchar(255) not null, ## reserverd word description --> descriptioner
   cost int not null,
   FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id) on update cascade on delete restrict
);

## no 4
insert into student (student_id, student_name, email, active_status) values
   ('MHS001', 'Alya Putri', 'alya@example.com', 1),
   ('MHS002', 'Farhan Maulana', 'farhan@example.com', 1),
   ('MHS003', 'Intan Dewi', 'intan@example.com', 0);

insert into staff (staff_id, staff_name, staff_email) VALUES
   ('PTG001', 'Budi Santoso', 'budi@example.com');

insert into equipment_category (category_id, category_name) values
   ('KTG001', 'Electronics'),
   ('KTG002', 'Mechanical'),
   ('KTG004', 'Audio');
 
insert into laboratory_room (room_id, room_name, building, floor) VALUES
   ('RNG001', 'Instrumentation Room', 'Laboratory Building A', 1),
   ('RNG002', 'Mechanical Room', 'Laboratory Building A', 1);
  

insert into supplier (supplier_id, supplier_name, phone, supplier_email) values
   ('PMS001', 'Instrumentation Supplier', '0215550101', 'pemasok1@example.com'),
   ('PMS002', 'Practicum Equipment Supplier', '0215550102', NULL);

insert into equipment (equipment_id, equipment_name, equipment_condition, equipment_status, procurement_date, equipment_category_category_id, laboratory_room_room_id, supplier_supplier_id) VALUES
   ('ALT001', 'Digital Multimeter', 'Good', 'Borrowed', '2025-08-01', 'KTG001', 'RNG001', 'PMS001'),
   ('ALT002', 'Oscilloscope', 'Good', 'Available', '2025-08-02', 'KTG001', 'RNG001', 'PMS001'),
   ('ALT004', 'Vernier Caliper', 'Good', 'Available', '2025-09-10', 'KTG002', 'RNG002', 'PMS002'),
   ('ALT005', 'Digital Scale', 'Minor Damage', 'Maintenance', '2024-11-30', 'KTG001', 'RNG001', 'PMS001');

insert into borrowing (borrowing_id, borrow_date, due_date, return_date, student_student_id, staff_staff_id) VALUES
   ('PJM001', '2026-10-01', '2026-10-08', NULL, 'MHS001', 'PTG001'),
   ('PJM002', '2026-09-20', '2026-09-27', '2026-09-26', 'MHS002', 'PTG001');


insert into borrowing_detail (borrowing_borrowing_id, equipment_equipment_id) values
   ('PJM001', 'ALT001'),
   ('PJM002', 'ALT004');
## no 5
insert into equipment (equipment_id, equipment_name, equipment_condition, equipment_status, procurement_date, equipment_category_category_id, laboratory_room_room_id, supplier_supplier_id, storage_location) VALUES
   ('ALT007', 'Digital Temperature Sensor', 'Good', 'Available', '2026-10-13', 'KTG001', 'RNG001', 'PMS001', 'Electronics Cabinet B');

##no 6
update equipment set equipment_status = 'Borrowed'
where equipment_id = 'ALT002';
update equipment set equipment_status = 'Borrowed'
where equipment_id = 'ALT007';
insert into borrowing (borrowing_id, borrow_date, due_date, return_date, student_student_id, staff_staff_id) VALUES
   ('PJM004', '2026-10-13', '2026-10-20', NULL, 'MHS002', 'PTG001');
insert into borrowing_detail (borrowing_borrowing_id, equipment_equipment_id) values
   ('PJM004', 'ALT002'),
   ('PJM004', 'ALT007');


##no 7

insert into maintenance (maintenance_id, equipment_id, maintenance_date, descriptioner, cost) VALUES
   ('PRW001', 'ALT005', '2026-10-13', 'Sensor repair and recalibration', 75000);
update equipment set equipment_status = 'Available'
where equipment_id = 'ALT005';
update equipment set equipment_condition = 'Good'
where equipment_id = 'ALT005';

##no 8
update borrowing set due_date = DATE_ADD(due_date, interval 7 day) where borrowing_id = 'PJM001';


##no 9
delete from equipment_category where category_id = 'KTG004';


##no 10
alter table student modify column student_name varchar(150) not null;

##no 11
alter table equipment add column temporary_note varchar(100) null;

##no 12
alter table equipment drop column temporary_note;