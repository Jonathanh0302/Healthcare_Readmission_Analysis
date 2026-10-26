-- 1. Readmission outcome distribution
-- count encounters and calculate percentages
SELECT
    readmitted,
    COUNT(*) AS encounter_count,
     ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_encounters
FROM public.diabetic_data
GROUP BY readmitted
ORDER BY readmitted;


--2. Readmission by length of stay
--compare 30 days readmission rates by stay length

select time_in_hospital, count(*) as total_encounters, count(case when readmitted ='<30' then 1 end) as readmitted_within_30_days, round(count(case when readmitted ='<30' then 1 end) * 100.0 / count(*), 2 ) as readmission_rate_pct 
from public.diabetic_data 
group by time_in_hospital 
order by time_in_hospital ;

--3 Readmission by number of diagnoses
-- compare 30 days readmission rates by the number of diagnoses

select number_diagnoses , count(*) as total_encounters, count(case when readmitted ='<30' then 1 end) as readmitted_within_30_days, round(count(case when readmitted ='<30' then 1 end) * 100.0 / count(*), 2 ) as readmission_rate_pct 
from public.diabetic_data 
group by number_diagnoses  
order by number_diagnoses ;

--4 Readmission by age

select age  , count(*) as total_encounters, count(case when readmitted ='<30' then 1 end) as readmitted_within_30_days, round(count(case when readmitted ='<30' then 1 end) * 100.0 / count(*), 2 ) as readmission_rate_pct 
from public.diabetic_data 
group by age  
order by age ;

--5 readmission by admission type

select atm.description , count(*) as total_encounters, count(case when readmitted ='<30' then 1 end) as readmitted_within_30_days, round(count(case when readmitted ='<30' then 1 end) * 100.0 / count(*), 2 ) as readmission_rate_pct 
from diabetic_data dd 
left  join admission_type_map atm 
on dd.admission_type_id = atm.admission_type_id 
group by atm.description 
order by total_encounters desc;

--6 Readmission by discharge disposition 

select ddm.description  , count(*) as total_encounters, count(case when readmitted ='<30' then 1 end) as readmitted_within_30_days, round(count(case when readmitted ='<30' then 1 end) * 100.0 / count(*), 2 ) as readmission_rate_pct 
from public.diabetic_data dd
left  join discharge_disposition_map ddm 
on dd.discharge_disposition_id = ddm.discharge_disposition_id 
group by ddm.description 
order by total_encounters  desc;

--7 readmission by admission_source 
select asm.description  , count(*) as total_encounters, count(case when readmitted ='<30' then 1 end) as readmitted_within_30_days, round(count(case when readmitted ='<30' then 1 end) * 100.0 / count(*), 2 ) as readmission_rate_pct 
from public.diabetic_data dd
left join admission_source_map asm 
on dd.admission_source_id  = asm.admission_source_id  
group by asm.description 
order by total_encounters  desc;


