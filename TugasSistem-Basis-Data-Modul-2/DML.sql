#i meant DML


insert into fine values 
    ('FN0001', 5000, 'Late', 'Unpaid', 'LN0002'),
    ('FN0002', 2000, 'Late', 'Unpaid', 'LN0003'),
    ('FN0003', 3000, 'Late', 'Unpaid', 'LN0006');


 #budi santoso
 update loan
 set return_date = '2026-10-12',
     loan_status = 'Returned'
 where id = 'LN0002';


#update phone number

update member
set phone_number = '0812233445566'
where member_no = '5026231001';


#update fine for dewi
update fine 
set payment_status = 'Paid'
where id = 'FN0003';

#update book
delete from book
where id = 'BK0005' and title = 'Sang Pemimpin' and isbn = '9786021000052';
#cleans the book table
delete from loan 
where loan_status = 'Returned';