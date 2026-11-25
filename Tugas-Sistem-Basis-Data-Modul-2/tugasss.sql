use its_sport_competition;
## no 1
select *
from its_sport_competition;


## no 2
select c.id, c.name, c.division
from committee as c
where c.competition_schedule_id in (select c.id
                                 from competition_schedule as c
                                 where c.location = 'Stadion ITS Sukolilo');

## no 3
SELECT t.name
FROM team AS t
WHERE t.id IN (
    SELECT r.team_id
    FROM registration AS r
    WHERE r.its_sport_competition_id IN (
        SELECT i.id
        FROM its_sport_competition AS i
        WHERE i.name = 'Futsal'
    )
);


## no 4

select i.name, sum(s.sponsor_nominal) as total
from its_sport_competition as i
join its_sponsor as s on i.id = s.its_sport_competition_id
group by s.its_sport_competition_id
order by total DESC;


## no 5

select r.id, t.name, r.registration_time
    from registration as r
join team as t on r.team_id = t.id
where r.registration_time >= '2026-10-10' and r.registration_time < '2026-10-17';

## no 6

select c.location, count(distinct c.id) as count
    from competition_schedule as c
join committee as com on c.id = com.competition_schedule_id
where com.division = 'Acara'
group by c.location having count > 1
order by count desc;

## no 7
select i.name, i.team_slot, t.name, r.registration_time
    from registration as r
join its_sport_competition as i on r.its_sport_competition_id = i.id
join team as t on r.team_id = t.id
join committee as c on r.committee_id = c.id
where c.division = 'Data Center' and r.registration_time >= '2026-10-10' and i.team_slot <= 20
order by registration_time asc;

## no 8
-- a
select i.name as nama_kompetisi,
    round(count(r.id) / i.team_slot * 100, 2) as fulfillment,
    i.team_slot - count(r.id) as sisa_slot
from its_sport_competition as i
left join registration as r on r.its_sport_competition_id = i.id
    and r.registration_time between '2026-10-10 00:00:00' and '2026-10-20 23:59:59'
group by i.id, i.name, i.team_slot;

## no 8
select d.waktu, round(avg(d.fulfillment), 2) as average_fulfillment
from (
    select date(r.registration_time) as waktu,
        count(r.id) / i.team_slot * 100 as fulfillment
    from registration as r
    join its_sport_competition as i on r.its_sport_competition_id = i.id
    where r.registration_time between '2026-10-10 00:00:00' and '2026-10-20 23:59:59'
    group by date(r.registration_time), i.id, i.team_slot
) as d
group by d.waktu
order by d.waktu;

## no 9
select cs.id, cs.start_time as waktu_mulai, cs.end_time as waktu_akhir,
    cs.team_name_1 as nama_tim_1, cs.team_name_2 as nama_tim_2, cs.location as lokasi
from competition_schedule as cs
where cs.location like 'Lapangan%'
    and (
        cs.team_name_1 in (
            select t.name
            from team as t
            join participants as p on p.team_id = t.id
            where p.study_program like 'Teknik%'
        )
        or cs.team_name_2 in (
            select t.name
            from team as t
            join participants as p on p.team_id = t.id
            where p.study_program like 'Teknik%'
        )
    );

## no 10
select sp.id as id_sponsor, sp.pic_name as nama_pic_sponsor,
    case
        when sp.id in (select s.sponsor_id from its_sponsor as s) then (
            select i.name
            from its_sport_competition as i
            join its_sponsor as s on s.its_sport_competition_id = i.id
            group by i.id, i.name
            order by sum(s.sponsor_nominal) asc, i.name asc
            limit 1
        )
        else coalesce((
            select i.name
            from its_sport_competition as i
            where i.id not in (select s.its_sport_competition_id from its_sponsor as s)
            order by i.start_date asc, i.name asc
            limit 1
        ), 'Tidak ada kompetisi')
    end as rekomendasi_kompetisi
from sponsor as sp;