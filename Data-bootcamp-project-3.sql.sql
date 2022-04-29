 -- For the purpose of this project, we will be using healthcare data that covers 193 countires 
 -- from 2000-2015. The data contains variables like life expectancy (dependent ) as well as other 
 -- variables which impact life expectancy like alcohol intake, government expenditure on health, education level, body mass index etc.
 -- Before trying to analyse the data, we must first have a look at the data,
 -- this enables us to get more accustomed to it and  have a general feel of the data
 
 Select * from project.data;
 
 -- We can  filter our data based on certain criteria such as if there are developing countries or not.
 -- we could also segment the data over a certain time period as seen below.
 
 Select country, year, status, life_expectancy, income_composition_of_resources, total_expenditure, BMI, alcohol
 from project.data
 Where year Between 2000 And 2007
 And status = "developing";
  
 Select country, year, status, life_expectancy, income_composition_of_resources, total_expenditure, BMI, alcohol
 from project.data
 Where year Between 2000 And 2007
 And status = "developing";
 
 Select country, year, status, life_expectancy, income_composition_of_resources, total_expenditure, BMI, alcohol
 from project.data
 Where year Between 2000 And 2007
 And status = "developed";
 
 Select country, year, status, life_expectancy, income_composition_of_resources, total_expenditure, BMI, alcohol
 from project.data
 Where year Between 2007 And 2015
 And status = "developed";
 
 -- the code above filters the data based on thier development status and over a specified number of years.
 -- while it is useful to be able to filter our data in this way, this code does not allow us to spot and interpret patterns in our data very quickly
 -- we can resolve this problem by introducing the use of aggregators.
 
 -- 1. What is the trend of life expectancy, expenditure on health, income composition ,
 -- Schooling, national Alcohol, BMI in developed and developing countries over the years? 
 
Select Avg(life_expectancy) as "Avg_LE",  Avg(total_expenditure) as "Avg_tot_exp", Avg(income_composition_of_resources) as "Avg_inc_comp", 
Avg(alcohol) as "Avg_alcohol", aVG(Schooling) as "avg_sch", Avg(BMI) as "Avg_BMI"
from project.data
where year BETWEEN 2000 AND 2007
AND status = "developing";

Select Avg(life_expectancy) as "Avg_LE",  Avg(total_expenditure) as "Avg_tot_exp", Avg(income_composition_of_resources) as "Avg_inc_comp", 
Avg(alcohol) as "Avg_alcohol", aVG(Schooling) as "avg_sch", Avg(BMI) as "Avg_BMI"
from project.data
where year BETWEEN 2008 AND 2015
AND status = "developing";
 
 -- The results for developing countries show that the average life expectancy increased by over two years from 2008-2015 in comparison to
 -- (2000-2007), what is more interesting to see is that in the latter years (2008-2015), there is also an increase in the
 -- average income come composition (HDI), years of schooling and a reduction in the national alcohol intake. 
 -- income composition and schooling appear  to have a positive correlation with life expectancy while alcohol correlates negatively.
 
Select Avg(life_expectancy) as "Avg_LE",  Avg(total_expenditure) as "Avg_tot_exp", Avg(income_composition_of_resources) as "Avg_inc_comp", 
Avg(alcohol) as "Avg_alcohol", aVG(Schooling) as "avg_sch", Avg(BMI) as "Avg_BMI"
from project.data
where year BETWEEN 2000 AND 2007
AND status = "developed";

Select Avg(life_expectancy) as "Avg_LE",  Avg(total_expenditure) as "Avg_tot_exp", Avg(income_composition_of_resources) as "Avg_inc_comp", 
Avg(alcohol) as "Avg_alcohol", aVG(Schooling) as "avg_sch", Avg(BMI) as "Avg_BMI"
from project.data
where year BETWEEN 2008 AND 2015
AND status = "developed";

-- Just as we see in the case of developing nations, we can see an inrease in average life expectancy in more recent years in developed counterparts
-- we can also see an increase in income composition, scholing years and a fall in alcohol intake. we can also see a fall in health expenditure and a rise in BMI
-- However, this does not seem to impact overall life expectancty negatively. lastly, despite developingcountries
-- having a generally lower avg life expectancy, scholing, income composition etc, we can see that the rate of increase in the aforementioned surpasses developed countries
-- for example, income composition in developed countires increases by less than 0.03% while in developing countires, we see over 0.08% change.

-- 2. What is the prevelance of factors and life threatning disease that theoriticaly tend to impact Life expectacy negatively. 
-- what is the prevelance in both developed and developing groups?

Select Sum(adult_mortality) as "sum_adul_mort", sum(infant_deaths) as "sum_infant_mort", Sum(measles) as "sum_measles",
sum(hiv_aids) as "sum_aids", Sum(thinness_1_to_19_years) as "sum_adol_thinness"
from project.data
 where status = "developing";

Select Sum(adult_mortality) as "sum_adul_mort", sum(infant_deaths) as "sum_infant_mort", Sum(measles) as "sum_measles",
sum(hiv_aids) as "sum_aids", Sum(thinness_1_to_19_years) as "sum_adol_thinness"
from project.data
 where status = "developed";
 
-- the results from above show the summation of adult and child mortality, occurences of measles, aids and thinness per 1000 of the population
-- from 2000 - 2015 across developed and developing countires.
-- by comparisons we can immediately see that there is a higher prevelance of infant and adult mortality, measles, and aids in developing countries
-- than in developed countries.

-- 3. How many countires in the sample are classed as developing/developed?
-- and what is their avg GDP? Does this match their status?

Select Count(distinct country), Avg(GDP)
From project.data
where status = "developing";

Select Count(distinct country), Avg(GDP)
From project.data
where status = "developed";

-- here we are able to see the number of countries that are classed as developing(161)/(32)developed as well as
-- the average gdp per capita for each group. Based on world bank rankings we can deduce that the GDP per capita are aprropriate.
-- developed nations have an average per capita above 12,696 (usd) and for developing countries it falls between 1026 and 12475.

-- based on theoritical and emperical evidence found in litrature, population, lifestyle choice (like alcohol intake, BMI), expenditure on health, GDP per capita and schooling 
-- were reported to have significant impact on life expectancy. we will test the same and as contribution to existing evidence. we will study the impact of this variables 
-- across developing and developed nations in our sample.

-- 4. How does Population affect Life expectancy?
-- first, we will take the average population for the samlpe and use that as the benchmark

Select Avg(population) as "sample_avg" from project.data; -- ('9923150.2805')

 Select status, Avg(life_expectancy) as "avg_Le"
 From project.data
 Where population <= 9923150.2805
 group by status;
 
 Select status, Avg(life_expectancy) as "avg_Le"
 From project.data
 Where population > 9923150.2805
 group by status;

-- the results indicate that population density affects developed/developing countries differently.
-- in developing countries, when population is below or equal to the sample average, life is expectancy is up by approximately 2 years.
-- whereas in developed counries, when population is above sample average, life expectancy (avg) increases by 0.7 years approximately
-- population appears to affect developing nations negatively and affects developed nations positively.
-- The positive correlation we observe between population and life expectancy in developed nations could be explained by a theory that argues that
-- developed nations tend to have more rescources relative to its popultation size which could produce  adverse effects on an economy.
-- if this is the case in developed nations, then it is easy to see how population increase would have a positive correlation on life expectancy.

-- 5. What is the correlation between GDP per capita and life expectancy?

Select status, Avg(life_expectancy),
Case When GDP <= 1025 Then "low_income"
When GDP between 1026 and 12475 Then "Middle_income"
When GDP >=12476 Then "High_income"
ELSE "Unknown"
End as "Gdp_cat"
From project.data
Group by status, gdp_cat
Order by 1;

-- based on the results, it is clear that both in developed and developing worlds, countries with a high GDP per capita have a higher life expectancy
-- whereas, countries with low income per capita have a lower average life expectancy compared to middle and high per capita counterparts.

-- 6.What happens to life expectancy when the level of expenditure changes?
-- recommenations from various studies advice that expenditure on health should be at least 6- 7% of GDP

Select status, Avg(life_expectancy),
Case When total_expenditure < 6.0 Then "below standard"
when  total_expenditure between 6.0 and 7.0 Then "acceptable standard"
when total_expenditure  > 7.0 Then "above standard"
Else "Unknown2"
End as health_exp_cat
From project.data
Group by status, health_exp_cat
Order by 1

-- the results for developing nations indicate that average life expectancy is higher when percetage expenditure on health is 6% and above ( accceptable and above standard)
-- compared  to when it is at lower levels (below standard). in developed countries, a slightly different pattern emerges. life expectancy only improves when
-- percentage is expenditure above 7% (above standard).

-- 7. BMI and life expectancy?
-- ranknig is done based on CDC categorisation.

Select status, avg(life_expectancy),
Case When BMI < 18.5 Then "underweight"
When BMI between 18.5 and 24.9 Then 'Healthy'
When BMI between 25 and 29.9 Then "Overweight"
WHEN BMI >=30.0 Then "Obese"
ELSE 'UNKNOWN'
END AS 'BMI_CAT'
From project.data
Group by BMI_CAT, status
Order by 1;
 -- in developed countries, people with a BMI classed as healthy have a higher average life expectancy and obese people tend to have the lowest life expectancy.
 -- results indicates underweight people have a lesse average life expectancy than those who are overweight!
 -- whereas with developing nations, there is no clear pattern as healthy people tend to have the least average expectancy as oppsed to obese people! 
 -- a possible explanation is thaat BMI does not have a significant impact on life expectancy in developing nations.
 -- overall, GDP per capita appear to have a more significant impact on both groups compared to other variables that were analysed.
 
-- in summary, The trend of life expectancy, schooling, income composition, BMI has increased overtime, while alcohol intake has fallen in both groups.​
-- Increase in population affects life expectancy negatively in developing countries and has a positive correlation in developed countries.​
-- Higher GDP per capita correlates with a higher life expectancy in both groups.​
-- Expenditure on health that is deemed above or at required standard correlates with a higher average life expectancy in developing countries. 
-- But in developed nations, avg LE only improves when expenditure on health is above 7% of GDP​
