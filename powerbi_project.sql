create Database if not exists Mental_Health_Care;
use Mental_Health_Care;

-- Raw Data --
SELECT * FROM healthcare.anxiety_depression_data;

-- 1.Analysis and Cleaning Data Dataset

select distinct * from anxiety_depression_data; 

-- Check Null Values 
SELECT *
FROM anxiety_depression_data
WHERE 
    Age IS NULL OR
    Gender IS NULL OR
    Education_Level IS NULL OR
    Employment_Status IS NULL OR
    Sleep_Hours IS NULL OR
    Physical_Activity_Hrs IS NULL OR
    Social_Support_Score IS NULL OR
    Anxiety_Score IS NULL OR
    Depression_Score IS NULL OR
    Stress_Level IS NULL OR
    Family_History_Mental_Illness IS NULL OR
    Chronic_Illnesses IS NULL OR
    Medication_Use IS NULL OR
    Therapy IS NULL OR
    Meditation IS NULL OR
    Substance_Use IS NULL OR
    Financial_Stress IS NULL OR
    Work_Stress IS NULL OR
    Self_Esteem_Score IS NULL OR
    Life_Satisfaction_Score IS NULL OR
    Loneliness_Score IS NULL;
    
-- Not null values in Whole Entire Dataset.. 

-- Check duplicat values

select distinct * from anxiety_depression_data;

-- No such duplicate data

-- Check Data Type  
DESCRIBE anxiety_depression_data;

-- -- Data type check completed
-- All columns have the correct data types.  
-- No modifications needed. Proceeding to the next data cleaning step. 

-- Check outliers in a datsets

select min(Age),max(Age),min(Sleep_Hours),max(Sleep_Hours),min(Physical_Activity_Hrs),max(Physical_Activity_Hrs),min(Social_Support_Score),max(Social_Support_Score),
min(Anxiety_Score),max(Anxiety_Score),min(Depression_Score),max(Depression_Score),min(Stress_Level),max(Stress_Level),min(Family_History_Mental_Illness),max(Family_History_Mental_Illness),min(Chronic_Illnesses),max(Chronic_Illnesses),
min(Therapy),max(Therapy),min(Meditation),max(Meditation),min(Financial_Stress),max(Financial_Stress),min(Work_Stress),max(Work_Stress),
min(Self_Esteem_Score),max(Self_Esteem_Score),min(Life_Satisfaction_Score),max(Life_Satisfaction_Score),min(Loneliness_Score),max(Lonel_iness_Score) from anxiety_depression_data;

-- Distincit value of non numarical column 

select distinct gender from anxiety_depression_data;
-- here we have foue gender catogries Male, Felamle,  Non-Binary, and other
select distinct Education_Level from anxiety_depression_data;
-- Some Education_Level are Bachelor,Master ,High School,Other,PhD
select distinct Employment_Status from anxiety_depression_data;
-- here we have foue Employment_Status Unemployed,Retired,Employed,Student
select distinct Medication_Use from anxiety_depression_data;
-- here we have three Medication_Use None,Occasional,Regular
select distinct Substance_Use from anxiety_depression_data;
-- here we have three Medication_Use None,frequent,Occasional

select * FROM anxiety_depression_data;

-- Average Number of Age.
select round(Avg(Age)) Average_Age from  anxiety_depression_data;
-- Average age is '46.32'

-- Average Number of Sleeping Hour.
select round(Avg(sleep_Hours)) Avg_sleep_Hours from  anxiety_depression_data;

-- Average Number of stress level.
select round(Avg(stress_level)) as Avg_stress_level from  anxiety_depression_data;

--  Average Number of Financial_Stress
select round(Avg(Financial_Stress)) as Avg_Financial_Stress from  anxiety_depression_data;

-- Average Number of work stress level.
select round(Avg(work_stress)) as Avg_work_stress from  anxiety_depression_data;

-- Average Number of Anxity Score level.
select round(Avg(Anxiety_Score)) as Avg_Anxiety_Score from  anxiety_depression_data;

--  Average Number of depression Score level.
select round(Avg(Depression_Score)) as Avg_Depression_Score from  anxiety_depression_data;


-- get the age gender or Employment_Status number Anxiety_Score grater then average number of Anxiety_Score. 
select Age,gender,Employment_Status from anxiety_depression_data
where Anxiety_Score > (Select avg(Anxiety_Score) from anxiety_depression_data);		

-- 1. Average Anxity and depressin score by age group.

SELECT 
    Age_Group,
    round(AVG(Anxiety_Score),2) AS Average_Anxiety_Score,
    round(AVG(Depression_Score),2) AS Average_Depression_Score
FROM (
    SELECT 
        CASE 
            WHEN Age BETWEEN 18 AND 29 THEN '18-29'
            WHEN Age BETWEEN 26 AND 44 THEN '30-44'
            WHEN Age BETWEEN 36 AND 65 THEN '45-65'
            ELSE '65 years and older'
        END AS Age_Group,
        Anxiety_Score,
        Depression_Score
    FROM anxiety_depression_data
) AS grouped_data
GROUP BY Age_Group
order by Age_Group;
	
-- 2.Compare anxiety and depression scores between genders.

select gender,
round(Avg(Anxiety_Score),2) as Average_Anxiety_Score,
round(Avg(Depression_Score),2) as Average_Depression_Score
from anxiety_depression_data
group by gender;

-- 3.Compare anxiety and depression scores between Education_level.

select Education_level,
round(avg(Anxiety_Score),2) as Average_Anxiety_Score,
round(avg(Depression_Score),2)  as Average_Depression_Score
from anxiety_depression_data
group by Education_level;

-- 4.Compare anxiety and depression scores between Education_level.

select Employment_Status,
round(Avg(Anxiety_Score),2) as Average_Anxiety_Score,
round(Avg(Depression_Score),2) as Average_Depression_Score
from anxiety_depression_data
group by Employment_Status;


-- 5.Analyze how sleep hours,Physical_Activity_Hrs correlate with anxiety and depression scores.

select Sleep_Hours,Physical_Activity_Hrs,
round(Avg(Anxiety_Score),2) as Average_Anxiety_Score,
round(Avg(Depression_Score),2) as Average_Depression_Score
from anxiety_depression_data
group by Sleep_Hours,Physical_Activity_Hrs
order by Sleep_Hours,Physical_Activity_Hrs;


-- 6.Analyze the impact of financial and work stress on mental health.
 
SELECT 
    Financial_Stress,
    Work_Stress,
    round(AVG(Anxiety_Score),2) AS Average_Anxiety_Score,
    round(AVG(Depression_Score),2) AS Average_Depression_Score
FROM anxiety_depression_data 
GROUP BY Financial_Stress, Work_Stress;

-- 7.Compare mental health scores for those who use therapy or medication versus those who do not.

select therapy,medication_use,Substance_Use,
  AVG(Anxiety_Score) AS Average_Anxiety_Score,
    AVG(Depression_Score) AS Average_Depression_Score
FROM anxiety_depression_data 
group by therapy,medication_use,Substance_Use;

-- 8. This would show which employment status (employed, unemployed, student, etc.)
--  correlates with highest mental health challenges.
 
SELECT 
    Employment_Status,
    AVG(Anxiety_Score) AS Avg_Anxiety,	
    AVG(Depression_Score) AS Avg_Depression,
    AVG(Stress_Level) AS Avg_Stress,
    AVG(Life_Satisfaction_Score) AS Avg_Life_Satisfaction
FROM anxiety_depression_data
GROUP BY Employment_Status
ORDER BY Avg_Stress DESC;


