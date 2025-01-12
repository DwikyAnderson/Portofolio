 Select * from  raw_ramen_rate;
 
 #Create Duplicate From Raw Data
 
 create table ramen_rate_staging
 like raw_ramen_rate;
 
insert ramen_rate_staging
select *
from raw_ramen_rate; 

#Create Duplicate From Raw Data


# Check For Duplicate Data
with duplicate_CTE as
(
	select *,
	row_number() over(Partition by 
	`Review #`,
    Brand,
    Variety,
    Style,
    Country,
    Stars,
    `Top Ten`
    ) as row_num
	from raw_ramen_rate
)
select *
from duplicate_CTE
where row_num > 1;
# Check For Duplicate Data

select * from ramen_rate_staging;

select * from ramen_rate_staging
where `Top Ten` is not null;

with rank_CTE as
(
select *, Replace(substring(`Top Ten`,locate("#", `Top Ten`),3),"#","") as Ranks, substring(`Top Ten`,1,4) as Ranks_Year
from ramen_rate_staging
Where `Top Ten` is not null
order by `Review #`
)
select * from rank_CTE;

Select * from ramen_rate_staging
where Brand != Trim(Brand);

update ramen_rate_staging
set Brand = trim(Brand);

insert into ranking_ramen_rate_staging
select *, Replace(substring(`Top Ten`,locate("#", `Top Ten`),3),"#","") as Ranks, substring(`Top Ten`,1,4) as Ranks_Year
from ramen_rate_staging;

Select * from ranking_ramen_rate_staging
order by Ranks_Year desc, Country desc, Ranks desc, Stars desc ;