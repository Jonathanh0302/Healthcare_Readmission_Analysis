Business scenario: A healthcare organization wants to understand which factors are associated with longer hospital stays, readmissions, and differences in resource utilization. 

Main Question:
What patterns in hospital utilization and patient encounters are associated with readmission, and what should hospital operations teams investigate further?

I'll investigate:
Readmission rates across patient groups.
Whether readmission patterns differ with length of stay.
How previous inpatient, outpatient, and emergency visits relate to readmission.
Differences associated with medication changes and other recorded encounter characteristics.
Data quality issues and limitations that affect interpretation.


Healthcare Readmission Analysis
1. Project Overview
Objective: Analyze hospital encounters and readmission patterns using the UCI Diabetes 130-US Hospitals dataset.
Dataset: Diabetes 130-US Hospitals for Years 1999–2008.

2. Initial Data Exploration
Dataset Size
Total rows, including header: 101,767
Total hospital encounters: 101,766
Each row represents a hospital encounter.
Key Columns
encounter_id
Unique identifier for a hospital encounter; candidate primary key.
patient_nbr
Patient identifier; may repeat across multiple encounters.
readmitted
Readmission outcome, with values <30, >30, and NO.

Readmission Values
<30: Readmitted within 30 days.
>30: Readmitted after more than 30 days.
NO: No readmission recorded within the dataset's defined follow-up period.

Initial Observations
Multiple encounters may belong to the same patient.
The dataset contains ? values in some fields, representing missing or unknown information.
No data cleaning or transformations have been performed yet.

3. Data Quality Checks
Reviewed column headers and row structure.
Identified key identifier and outcome columns.
Recorded total number of encounters.
Verify whether encounter_id is unique.
 -Result: All encounter IDs returned a count of 1 using Excel's COUNTIF function.
 -Conclusion: No duplicate encounter IDs were found. This supports using encounter_id as the unique identifier for each hospital encounter.
Check for duplicate rows.
Assess missing values.

Patient Encounter Patterns

-The patient_nbr field is not unique; some patients appear in multiple rows.
-The highest frequency observed so far is 40 encounters for a single patient.
-Each row represents a hospital encounter, not necessarily a different patient.
-Further analysis is needed to understand how repeated encounters relate to readmission outcomes.

4. Initial Readmission Analysis

Readmission Outcome Counts

| Readmission outcome | Encounters | Percentage |
| Readmitted within 30 days (`<30`) | 11,357 | 11.16% |
| Readmitted after 30 days (`>30`) | 35,545 | 34.93% |
| No recorded readmission (`NO`) | 54,864 | 53.92% |
| **Total** | **101,766** | **100.00%** |

Initial Observations
- The `NO` category represents the largest share of encounters.
- Readmission within 30 days accounts for approximately 11.16% of encounters.
- These percentages describe hospital encounters, not unique patients.
- The counts sum to 101,766, matching the total number of encounters in the dataset.


## Analysis 2: Length of Hospital Stay vs. Readmission

**Question:** Is the length of a hospital stay associated with readmission?

**Variables analyzed:**
- `time_in_hospital`: Number of days spent in the hospital.
- `readmitted`: Readmission outcome (`<30`, `>30`, `NO`).

**Method:**
Created an Excel PivotTable grouping encounters by length of hospital stay and readmission outcome. Displayed each outcome as a percentage of the total encounters within its length-of-stay group.

**Key observations:**
- Encounters with a 1-day hospital stay had an 8.18% 30-day readmission proportion.
- Encounters with an 8-day hospital stay had a 14.23% 30-day readmission proportion.
- The 30-day readmission proportion generally increased with length of stay, although the trend was not consistent for every additional day.
- The percentage of encounters with no recorded readmission generally decreased as length of stay increased.

**Preliminary interpretation:**

Longer hospital stays appear to be associated with a higher proportion of encounters followed by readmission within 30 days. This is contrary to the initial hypothesis that longer stays might be associated with fewer readmissions.

However, this analysis does not establish causation. Patients with more complex health conditions may require longer hospital stays and may also have a greater likelihood of readmission.

**Limitations:**
- Results represent hospital encounters, not unique patients.
- Encounter counts may differ substantially between length-of-stay groups.
- The analysis does not account for other factors that could influence readmission.
- The dataset contains historical records from 1999–2008.

---

## Analysis 3: Number of Diagnoses vs. Readmission

**Question:** Is the number of diagnoses recorded during a hospital encounter associated with readmission?

**Variables analyzed:**
- `number_diagnoses`: Number of diagnoses recorded for the encounter.
- `readmitted`: Readmission outcome (`<30`, `>30`, `NO`).

**Method:**
Created an Excel PivotTable grouping encounters by number of diagnoses and readmission outcome. Displayed each outcome as a percentage of the total encounters within each diagnosis-count group.

**Key observations:**
- Encounters with 1 recorded diagnosis had a 5.94% 30-day readmission proportion.
- Encounters with 9 recorded diagnoses had a 12.38% 30-day readmission proportion.
- The 30-day readmission proportion generally increased as the number of diagnoses increased across the lower diagnosis-count groups.
- The pattern was not consistent across all groups. Some groups with higher diagnosis counts showed fluctuations in their readmission proportions.

**Preliminary interpretation:**

A higher number of recorded diagnoses appears to be associated with a higher proportion of encounters followed by readmission within 30 days. The number of diagnoses may serve as a rough indicator of patient complexity, but it does not directly measure disease severity.

**Limitations:**
- Results represent encounters, not unique patients.
- Groups with high diagnosis counts may contain fewer encounters, making their percentages less stable.
- The analysis does not account for other patient or hospital characteristics.
- Association does not establish causation.
- The dataset contains historical records from 1999-2008.

---

## Summary of Initial Excel Analysis

The initial analysis identified two potential relationships worth investigating further:

1. **Length of hospital stay:** Longer stays generally showed a higher proportion of encounters followed by readmission within 30 days.
2. **Number of diagnoses:** Encounters with more recorded diagnoses generally showed a higher 30-day readmission proportion across the lower diagnosis-count groups.

These findings are preliminary and descriptive. Further analysis using SQL and Power BI will help validate the results, explore additional patterns, and communicate the findings more effectively.



## Power BI Analysis — Initial Findings

### 1. Readmission Outcome Distribution
The dataset contains 101,766 hospital encounters:
- No recorded readmission: 54,864 (53.92%)
- Readmitted after 30 days: 35,545 (34.93%)
- Readmitted within 30 days: 11,357 (11.16%)

These figures are encounter-level counts, not counts of unique patients. The categories describe the dataset's recorded readmission outcomes.

### 2. 30-Day Readmission Rate by Length of Stay
A Power BI line chart shows the percentage of encounters marked as readmitted within 30 days (`readmitted = <30`) for each length-of-stay group.

The observed rate generally rises from approximately 8.2% for a one-day stay to around 14% for stays of 8–10 days. Rates fluctuate for longer stays rather than increasing consistently.

### 3. Encounter Volume by Length of Stay
A column chart shows that encounter volume is highest for stays of approximately 1–4 days and declines as length of stay increases. Longer-stay groups contain fewer encounters, so their readmission-rate estimates should be interpreted cautiously.

### Preliminary Interpretation
In this historical dataset, longer hospital stays are associated with higher observed 30-day readmission rates across much of the length-of-stay range. This is a descriptive association, not evidence that longer stays cause readmission. Patient characteristics, differences between encounters, and group sizes may affect the observed pattern.

### Limitations
- The data represents hospital encounters from 1999–2008 and may not reflect current practice.
- Multiple encounters can belong to the same patient.
- Missing or unknown values require careful handling.
- These comparisons are descriptive and do not establish causation.
- Small groups may produce less stable percentages.

### Power BI Progress
- Imported `diabetic_data.csv`.
- Created a 30-day readmission-rate measure.
- Created visuals for readmission outcome counts, 30-day readmission rate by length of stay, and encounter volume by length of stay.
- Created KPI cards for the three recorded readmission outcomes.
- Next analysis: investigate 30-day readmission rate by number of diagnoses and check encounter counts for each group.

### 4. 30-Day Readmission Rate by Number of Diagnoses

A Power BI line chart compares the percentage of encounters readmitted within 30 days across diagnosis-count groups.

The rate generally increases across the more common groups, from approximately 6% for encounters with 1–2 diagnoses to around 12% for encounters with 8–9 diagnoses. The rate fluctuates sharply among groups with higher diagnosis counts.

An accompanying encounter-volume chart shows that the distribution is highly uneven, with the largest group at 9 diagnoses and substantially fewer encounters in most other groups. Rates in smaller groups should therefore be interpreted cautiously.

**Preliminary interpretation:** Recorded diagnosis count is associated with differences in observed 30-day readmission rates, but the relationship is not consistently increasing across all groups. Diagnosis count is not a direct measure of clinical severity, and this descriptive analysis does not establish causation.

## SQL Analysis Progress

### Database Setup and Validation
- Database: `healthcare_readmission`
- Table: `public.diabetic_data`
- Tooling: PostgreSQL and DBeaver Community Edition
- Successfully imported the diabetes 130-US hospitals dataset.
- Verified that the table contains **101,766 encounters**, matching the expected dataset size.
- Confirmed that `encounter_id` is unique in the dataset.
- Confirmed that `patient_nbr` can repeat, meaning one patient may have multiple encounters.
- Confirmed readmission outcome counts:
  - `<30`: 11,357 encounters (11.16%)
  - `>30`: 35,545 encounters (34.93%)
  - `NO`: 54,864 encounters (53.92%)

### SQL Skills Practiced
- `SELECT` to choose columns.
- `COUNT(*)` to count encounters.
- `CASE WHEN` inside `COUNT()` for conditional aggregation.
- `GROUP BY` to calculate metrics for categories.
- `ORDER BY` to sort results.
- `ROUND()` to format percentages.
- Multiplication by `100.0` to calculate percentages using decimal arithmetic.

### Analysis 1: Readmission Outcome Distribution
**Business question:** How many encounters fall into each recorded readmission category?

**Finding:** Of 101,766 encounters, 11,357 (11.16%) were followed by a recorded readmission within 30 days, 35,545 (34.93%) were in the `>30` category, and 54,864 (53.92%) were in the `NO` category.

**Interpretation:** These are encounter-level outcomes, not percentages of unique patients. The same patient may contribute multiple encounters.

### Analysis 2: Readmission by Length of Hospital Stay
**Business question:** Does the percentage of encounters followed by readmission within 30 days vary by length of stay?

**SQL output:** One row per `time_in_hospital` value, including total encounters, encounters with `readmitted = '<30'`, and the within-30-day readmission rate as a percentage.

**Finding:** The observed rate generally increased across the length-of-stay groups examined. For example, the rate was approximately 8.18% for a one-day stay and 14.23% for an eight-day stay.

**Interpretation:** Length of stay is associated with differences in the observed readmission rate in this dataset. This does not establish that a longer stay causes readmission. Encounter volume also matters when interpreting the rates.

### Analysis 3: Readmission by Number of Diagnoses
**Business question:** Does the 30-day readmission rate vary by the number of diagnoses recorded during an encounter?

**SQL output:** One row per `number_diagnoses` value, including total encounters, encounters with `readmitted = '<30'`, and the within-30-day readmission rate as a percentage.

**Finding:** The observed rate increased from approximately 5.94% for encounters with one diagnosis to 12.38% for encounters with nine diagnoses.

**Interpretation:** The rate was more than twice as high in the nine-diagnosis group compared with the one-diagnosis group. This is an association, not proof that a higher number of diagnoses causes readmission.

**Small-sample caution:** A rate such as 27.27% among encounters with 11 diagnoses is based on a small group. A small number of encounters can cause the percentage to fluctuate substantially. Do not use that percentage alone to claim that the group has the highest readmission risk.

**Reporting approach:** Consider the readmission rate alongside the total encounter count. Evaluate whether each group has enough observations to support a meaningful comparison before deciding which groups to emphasize. Do not exclude groups solely because their rates are inconvenient or unusually high.

### Analysis 4: Readmission by Age Group

Business question: Does the 30-day readmission rate differ across patient age groups?

SQL output: One row per age category, showing total encounters, encounters with readmitted = '<30', and the percentage readmitted within 30 days.

Method: Used conditional aggregation with COUNT(CASE WHEN ...), grouped by age, and calculated the rate using decimal division and rounding to two decimal places.

Interpretation status: Query written and syntax reviewed. Review the actual result values before documenting any conclusions about which age groups have higher or lower rates.

Sorting note: The age field contains text categories. ORDER BY age sorts alphabetically, so the output may not follow numerical age order

### Analysis 5: Readmission by Admission Type

**Business question:** Does the 30-day readmission rate differ by admission type?

**Method:** Grouped encounters by `admission_type_id`, counted total encounters and encounters with `readmitted = '<30'`, and calculated the percentage readmitted within 30 days.

**Findings:**
- Admission type 1 had the highest observed 30-day readmission rate at 11.52%.
- Admission type 7 had the lowest observed rate at 0%.
- Admission type 4 had 10 encounters, admission type 7 had 21, and admission type 8 had 320 encounters.

**Interpretation:** The observed rates should be considered alongside encounter counts. Rates based on small groups may be unstable, and a rate of 0% does not establish that the underlying risk is zero.

**Next improvement:** Use `IDS_mapping.csv` to translate admission type IDs into readable category labels before presenting the results to a business audience.

**Limitation:** These are encounter-level comparisons, and the observed relationships do not establish causation.


## Analysis 6: Readmission by Discharge Disposition

Business question: Does the 30-day readmission rate vary by discharge disposition?

Method: Grouped encounters by discharge_disposition_id, counted total encounters and encounters with readmitted = '<30', and calculated the within-30-day readmission rate as a percentage.

Findings:

Disposition ID 12 had the highest observed rate among the listed categories at 66.67%, but this represented only 2 readmissions out of 3 encounters.

Disposition ID 15 had a rate of 44.44%, representing 28 readmissions out of 63 encounters.

Disposition ID 22 had a rate of 27.70%, representing 552 readmissions out of 1,993 encounters.

Disposition ID 6 had a rate of 12.70%, representing 1,638 readmissions out of 12,902 encounters.

Several categories had 0% observed readmission rates, including some with very small sample sizes.

Interpretation: Discharge disposition categories show considerable variation in observed readmission rates. High percentages from very small groups are unstable and should not be used alone to rank categories or infer underlying risk. Categories with larger encounter counts provide a more informative starting point for comparison, though sample size alone does not establish statistical significance.

# Healthcare Readmission Analysis — Project Notes

## 1. Project Overview

**Objective:** Analyze hospital encounter data to understand how 30-day readmission rates vary by length of stay, number of diagnoses, age group, admission type, discharge disposition, and admission source.

**Dataset:** UCI Diabetes 130-US Hospitals, covering hospital encounters from 1999–2008.

**Tools:** Excel, Power BI, PostgreSQL, and DBeaver.

**Primary outcome:** `readmitted = '<30'` indicates readmission within 30 days.

**Unit of analysis:** Hospital encounter, not unique patient. A patient may have multiple encounters.

## 2. Data Validation and Preparation

- Total hospital encounters: 101,766.
- `encounter_id` is unique for each encounter.
- `patient_nbr` can repeat across encounters.
- The `readmitted` field contains three categories: `<30`, `>30`, and `NO`.
- Some fields contain `?` or other missing/unavailable values.
- The dataset is historical and should not be treated as representative of current hospital performance.

### Readmission Outcome Distribution

| Outcome | Encounters | Percentage |
|---|---:|---:|
| Readmitted within 30 days (`<30`) | 11,357 | 11.16% |
| Readmitted after 30 days (`>30`) | 35,545 | 34.93% |
| Not readmitted (`NO`) | 54,864 | 53.92% |
| **Total** | **101,766** | **100.00% approximately** |

Percentages may differ slightly from 100% due to rounding.

## 3. SQL Analyses Completed

The `readmission_analysis.sql` file contains these analyses:

1. Readmission outcome distribution.
2. Readmission rate by length of hospital stay.
3. Readmission rate by number of diagnoses.
4. Readmission rate by age group.
5. Readmission rate by admission type.
6. Readmission rate by discharge disposition.
7. Readmission rate by admission source.

For each grouped analysis, the query calculates total encounters, encounters readmitted within 30 days, and the 30-day readmission rate.

### Mapping Tables

Three lookup tables were imported into PostgreSQL:

- `admission_type_map`
- `discharge_disposition_map`
- `admission_source_map`

The admission-type, discharge-disposition, and admission-source analyses now use joins to display readable descriptions instead of relying exclusively on numeric IDs.

**Join strategy:** `LEFT JOIN` is used to preserve encounters that lack a matching mapping record.

**Validation still required:** Confirm that the total encounter counts across the groups in each mapped analysis sum to 101,766. Investigate unmatched IDs and missing descriptions if necessary.

## 4. Preliminary Findings

### Length of Stay

- The observed 30-day readmission rate was approximately 8.18% for a one-day stay and 14.23% for an eight-day stay.
- This suggests an association between length of stay and readmission in this dataset.
- The analysis does not establish that longer hospital stays cause readmissions.

### Number of Diagnoses

- The observed 30-day readmission rate was approximately 5.94% for encounters with one recorded diagnosis and 12.38% for encounters with nine diagnoses.
- Higher diagnosis counts may be associated with higher readmission rates in commonly represented groups.
- Diagnosis count is not a direct measure of illness severity. Results from groups with few encounters should be interpreted cautiously.

### Admission Type

Preliminary encounter counts and readmissions:

- Emergency: 53,990 encounters; 6,221 readmissions within 30 days.
- Elective: 18,869 encounters; 1,961 readmissions within 30 days.
- Urgent: 18,480 encounters; 2,066 readmissions within 30 days.

Emergency admissions have the largest absolute number of 30-day readmissions, but that does not necessarily mean they have the highest rate. Rates must be compared using each category's total encounter count.

Some admission-type labels are unavailable, unmapped, or NULL and should be documented in the final analysis.

### Age Group

- The highest observed 30-day readmission rate was 14.24% among encounters in the 20–30 age group (236 readmissions out of 1,657 encounters).
- Rates were also relatively elevated among older adults, reaching 12.08% in the 80–90 age group.
- The relationship was not consistently increasing across age groups.
- Smaller groups, particularly ages 0–10, should be interpreted cautiously.
- These findings describe associations in the historical dataset and do not establish causation.


### Discharge Disposition

- Encounters discharged to home had a 30-day readmission rate of 9.30% across 60,234 encounters.
- Encounters discharged to a skilled nursing facility had a rate of 14.66% across 13,954 encounters.
- Encounters discharged home with home health services had a rate of 12.70% across 12,902 encounters.
- Encounters discharged to another rehabilitation facility had a rate of 27.70% across 1,993 encounters.
- These differences suggest that observed readmission rates vary by discharge destination. They do not establish that the destination causes readmission.
- Extreme rates in small categories require caution. For example, the 66.67% rate for patients still in the hospital or expected to return for outpatient services was based on only three encounters.

### Admission Source

- Emergency-room admissions accounted for 57,494 encounters and had an 11.69% 30-day readmission rate.
- Physician referrals accounted for 29,565 encounters and had a 10.59% rate.
- Several other common admission sources had rates between approximately 9% and 12%.
- The rates among the largest groups were relatively similar, so admission source appears less distinctive than discharge disposition in this preliminary analysis.
- Categories with very few encounters should not be ranked as meaningful high- or low-readmission groups without additional context.

# Healthcare Readmission Analysis — Findings and Progress

## 1. Project Overview

**Objective:** Analyze hospital encounters from the UCI Diabetes 130-US Hospitals dataset to identify patterns associated with readmission within 30 days.

**Dataset:** 1999–2008 hospital encounters.

**Total encounters analyzed:** 101,766.

**Primary metric:** 30-day readmission rate, calculated as encounters with `readmitted = '<30'` divided by all encounters in the relevant category.

**Important distinction:** The analysis measures encounters, not unique patients. The same patient may appear multiple times.

## 2. Overall Readmission Outcomes

| Readmission outcome | Encounters | Percentage |
|---|---:|---:|
| No recorded readmission (`NO`) | 54,864 | 53.92% |
| Readmitted after 30 days (`>30`) | 35,545 | 34.93% |
| Readmitted within 30 days (`<30`) | 11,357 | 11.16% |
| **Total** | **101,766** | **100%** |

**Finding:** Approximately 1 in 9 encounters resulted in a recorded readmission within 30 days. Most encounters had no recorded readmission.

## 3. Readmission by Length of Stay

- The 30-day readmission rate generally increased with length of stay across the shorter and middle portions of the observed range.
- The rate rose from approximately **8.18% for a 1-day stay** to approximately **14.23% for an 8-day stay**.
- Rates fluctuated for longer stays rather than increasing consistently.
- Encounter volume declined as length of stay increased.

**Interpretation:** Longer stays were associated with higher 30-day readmission rates in several parts of the distribution. This does not establish that longer stays cause readmission. Lower encounter counts at longer stays also warrant caution.

## 4. Readmission by Number of Diagnoses

- The 30-day readmission rate was approximately **5.94% for encounters with one diagnosis**.
- It reached approximately **12.38% for encounters with nine diagnoses**.
- Nine diagnoses accounted for the largest encounter volume in this dataset.
- Some categories with more than nine diagnoses had volatile rates because they contained relatively few encounters. For example, 11 diagnoses had a rate of **27.27% based on 3 readmissions among 11 encounters**.

**Interpretation:** A higher number of recorded diagnoses was generally associated with higher readmission rates across much of the main encounter distribution. This is an association, not proof of causation, and the smallest categories should not be overinterpreted.

## 5. Readmission by Age Group

- The highest observed rate was approximately **14.23% for the `[20-30)` age group**.
- The `[0-10)` group had a rate of approximately **1.86%**, based on 161 encounters.
- The `[10-20)` group had a rate of approximately **5.79%**.
- Rates for most age groups from 30 years onward were approximately 9.7%–12.0%.

**Interpretation:** The 20–30 age group had the highest observed rate in this dataset, while the youngest groups had lower rates. These are descriptive comparisons and do not account for other differences between patients.

## 6. Readmission by Admission Type

- Admission types 1, 2, and 3 had rates of approximately **11.52%, 11.16%, and 10.38%**, respectively.
- Most of the commonly observed admission types had rates clustered around 10%–12%.
- Some categories had very small encounter counts, so their rates should be interpreted cautiously.

**Interpretation:** Readmission rates were relatively similar across the main admission types. Admission type alone did not show a large difference in the observed rates for the most common categories.

## 7. Readmission by Discharge Destination

Selected results from the SQL analysis:

| Discharge destination | Encounters | Readmitted within 30 days | Rate |
|---|---:|---:|---:|
| Discharged to home | 60,234 | 5,602 | 9.30% |
| Discharged/transferred to SNF | 13,954 | 2,046 | 14.66% |
| Discharged/transferred home with home health service | 12,902 | 1,638 | 12.70% |
| Transferred to another short-term hospital | 2,128 | 342 | 16.07% |
| Transferred to another rehabilitation facility | 1,993 | 552 | 27.70% |
| Transferred to a psychiatric hospital or psychiatric unit | 139 | 51 | 36.69% |
| Still a patient or expected to return for outpatient services | 3 | 2 | 66.67% |

**Findings:**

- Discharge to home was the most common destination and had a 9.30% 30-day readmission rate.
- Transfers to skilled nursing facilities had a 14.66% rate.
- Transfers to another rehabilitation facility had a 27.70% rate.
- Some less common destinations had substantially higher percentages, but small sample sizes affect how confidently those rates can be interpreted.
- The 66.67% rate for the category with only 3 encounters is especially unstable and should not be presented as evidence that this destination has the greatest readmission risk.

**Interpretation:** Readmission rates differed across discharge destinations. The differences may reflect patient condition, care needs, and other factors not controlled for in this descriptive analysis.

## 8. Readmission by Admission Source

Selected results:

| Admission source | Encounters | Readmitted within 30 days | Rate |
|---|---:|---:|---:|
| Emergency Room | 57,494 | 6,720 | 11.69% |
| Physician Referral | 29,565 | 3,130 | 10.59% |
| Transfer from a hospital | 3,187 | 309 | 9.70% |
| Transfer from another healthcare facility | 2,264 | 212 | 9.36% |
| Clinic Referral | 1,104 | 111 | 10.05% |
| Transfer from a Skilled Nursing Facility | 855 | 101 | 11.81% |
| HMO Referral | 187 | 29 | 15.51% |

**Findings:**

- The emergency room was the most common admission source and had an 11.69% 30-day readmission rate.
- Physician referrals accounted for the second-largest volume and had a 10.59% rate.
- Most high-volume admission sources had rates between approximately 9% and 12%.
- Some less common sources had higher rates, but the encounter counts were much smaller.

**Interpretation:** The most common admission sources had relatively similar rates. Higher percentages among less common sources should be interpreted alongside their sample sizes.

## 9. Power BI Dashboard Progress

### Page 1 — Overview
Includes:
- Total encounters by readmission outcome.
- KPI cards for encounters with no recorded readmission, readmission within 30 days, and readmission after 30 days.
- 30-day readmission rate by length of stay.
- Encounter volume by length of stay.
- 30-day readmission rate by number of diagnoses.
- Encounter volume by number of diagnoses.

### Page 2 — Factors Associated with Readmission
Includes:
- 30-day readmission rate by age group.
- 30-day readmission rate by admission source.
- 30-day readmission rate by admission type.
- 30-day readmission rate by discharge destination.

Encounter counts are included in the chart tooltips to provide context for each percentage.

## 10. Data Quality and Limitations

- The dataset contains 101,766 encounters, and the verified encounter total matches across the analyses.
- The same patient can have multiple encounters; encounter counts must not be described as unique patient counts.
- Missing or unmapped categories exist in the data and should be handled transparently.
- Small groups can produce extreme percentages that are not reliable estimates of broader risk.
- The dataset covers 1999–2008 and may not represent current hospital practices or readmission patterns.
- This is descriptive analysis. The observed associations do not establish causation.
- These findings do not account for all potential confounding factors or establish individual patient risk.

## 11. Main Takeaways

1. Approximately 11.16% of encounters resulted in recorded readmission within 30 days.
2. Readmission rates generally increased across much of the length-of-stay distribution, although the pattern was not consistent at every length.
3. Encounters with more recorded diagnoses generally had higher readmission rates across the main categories.
4. Readmission rates varied by age group, admission source, and discharge destination.
5. Discharge destination categories with high percentages sometimes had very small encounter counts, making sample-size context essential.
6. The most common admission types had broadly similar readmission rates.



