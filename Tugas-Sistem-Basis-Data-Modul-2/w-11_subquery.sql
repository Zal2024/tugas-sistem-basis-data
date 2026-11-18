use company;


## no 1
select PROJECT.PName
from company.PROJECT
where PNo in (
    select WORKS_ON.PNo
    from company.WORKS_ON
    where NationalID in (
        select NationalID
        from company.EMPLOYEE
        where FirstName = 'Franklin' and LastName = 'Wong'
        )
    );

## no 2
select EMPLOYEE.FirstName, EMPLOYEE.LastName
from EMPLOYEE
where salary >  all (select Salary
                 from EMPLOYEE
                 where DNo = (
                     select DNo
                     from company.DEPARTMENT
                     where DName = 'Administration'
                     )
                 );

## no 3
select PName
from PROJECT as p
where not exists (
    select PNo
    from WORKS_ON as w
    where p.PNo = w.pno
);


## no 4
select p.PName, count(w.Pno) as howmuchemployees
from PROJECT as p
left join WORKS_ON as w
    on p.PNo = w.PNo
group by p.PName, p.PNo;
## OR
select p.PName, (select count(*)
                 from WORKS_ON as w
                 where w.PNo = p.PNo) as mowmuch
from PROJECT as p;

## no 5
select e.FirstName, e.LastName
from EMPLOYEE as e
where exists(
    select *
    from DEPENDENT as d
    where d.NationalID = e.NationalID and d.Sex = e.Sex
);

## no 6
select  e.FirstName, LastName
from EMPLOYEE as e
where not (e.Firstname = 'John' and e.LastName = 'Smith')
    and not exists (
            select *
            from WORKS_ON as js
            where js.NationalID = (select  NationalID
                                   from EMPLOYEE
                                   where FirstName = 'John' and LastName = 'Smith')
            and not exists (
                select *
                from WORKS_ON as ew
                where ew.NationalID = e.NationalID
                and ew.PNo = js.PNo
            )
)
