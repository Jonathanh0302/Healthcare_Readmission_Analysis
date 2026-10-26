# Healthcare Readmission Analysis

## Project Overview

This project analyzes hospital encounter data to explore patterns associated with 30-day readmissions, hospital length of stay, and other recorded encounter characteristics.

Using SQL, Excel, and Power BI, I examined readmission rates across several categories and built an interactive-style dashboard to communicate the findings. The goal was to identify patterns that healthcare operations teams could investigate further, while accounting for encounter volumes, missing data, and analytical limitations.

**Business question:** What patterns in hospital utilization and patient encounters are associated with readmission, and what should hospital operations teams investigate further?

## Dashboard

### Page 1 — Overall Readmission Patterns

Hospital Readmission Analysis dashboard overview

This page presents the overall readmission outcome distribution, 30-day readmission rates by length of stay and number of diagnoses, and encounter volumes for those same groups.

### Page 2 — Readmission Factors

Readmission rates by age, admission source, admission type, and discharge disposition

This page compares observed 30-day readmission rates across age groups, admission sources, admission types, and discharge dispositions.



## Dataset

- **Dataset:** Diabetes 130-US Hospitals for Years 1999–2008
- **Period:** 1999–2008
- **Total records:** 101,766 hospital encounters
- **Unit of analysis:** Hospital encounter
- **Primary outcome:** `readmitted`

The `readmitted` field contains three categories:

- `<30`: Readmitted within 30 days
- `>30`: Readmitted after more than 30 days
- `NO`: No readmission recorded in the dataset's defined follow-up period

Each row represents an encounter, not necessarily a unique patient. The same patient may appear in multiple records.

## Tools Used

- **Excel:** Initial data exploration and PivotTable analysis
- **PostgreSQL:** Data validation, aggregation, and readmission analysis
- **DBeaver:** SQL development and database exploration
- **Power BI:** KPI cards, charts, and dashboard development

## Methodology

### 1. Data validation

- Verified that the dataset contains 101,766 encounters.
- Checked that `encounter_id` is unique for each encounter.
- Confirmed that `patient_nbr` can repeat across multiple encounters.
- Identified missing or unknown values represented by `?` and other unavailable category labels.

### 2. Exploratory analysis in Excel

Used PivotTables to compare readmission outcomes across hospital length-of-stay groups and diagnosis-count groups.

### 3. SQL analysis in PostgreSQL

Created grouped queries to calculate:
- Total encounters per category
- Encounters readmitted within 30 days
- 30-day readmission rate as a percentage

Used conditional aggregation with `COUNT(CASE WHEN ...)`, `GROUP BY`, `ORDER BY`, and window functions for the overall outcome distribution.

Imported lookup tables for admission type, admission source, and discharge disposition. Used `LEFT JOIN` to preserve encounters even when a matching mapping label was unavailable.

### 4. Power BI visualization

Created KPI cards and charts to compare readmission outcomes, readmission rates, and encounter volumes. Rate and volume charts are presented together where relevant to help distinguish common patterns from results based on smaller groups.

## Key Findings

### 1. Overall readmission outcomes

Of the 101,766 hospital encounters:

| Recorded outcome | Encounters | Percentage |
|---|---:|---:|
| No recorded readmission (`NO`) | 54,864 | 53.92% |
| Readmitted after 30 days (`>30`) | 35,545 | 34.93% |
| Readmitted within 30 days (`<30`) | 11,357 | 11.16% |

Approximately 11.16% of encounters were followed by a recorded readmission within 30 days. These are encounter-level proportions, not percentages of unique patients.

### 2. Length of hospital stay

The observed 30-day readmission rate was approximately **8.18% for one-day stays** and **14.23% for eight-day stays**.

Rates generally increased across much of the length-of-stay range, although the pattern was not consistent for every additional day. Encounter volume also declined as length of stay increased, so rates for longer stays should be interpreted alongside their group sizes.

### 3. Number of diagnoses

The observed 30-day readmission rate increased from approximately **5.94% for encounters with one recorded diagnosis** to **12.38% for encounters with nine recorded diagnoses**.

The relationship was not consistently increasing across every diagnosis-count group. Diagnosis count may reflect differences in recorded clinical complexity, but it is not a direct measure of disease severity.

Groups with very few encounters can produce unstable percentages. For example, a rate of 27.27% in a group of 11 encounters should not be treated as conclusive evidence that the group has the highest underlying readmission risk.

### 4. Age group

The observed 30-day readmission rate varied across age categories. The 20–30 age group had a rate of approximately **14.24%**, while most groups aged 30 and above fell roughly between 9.7% and 12.1%.

These differences describe patterns in the dataset and do not establish why the rates differ.

### 5. Admission type

Readmission rates for the more common admission types were broadly similar, generally around 10–12%. Emergency admissions had an observed rate of approximately **11.52%**.

Some admission-type categories contained very few encounters. Rates from these groups should not be used to make strong comparisons without considering their denominators.

### 6. Discharge disposition and admission source

Observed readmission rates varied across discharge dispositions and admission sources. For example, the discharge-disposition analysis showed rates of approximately **9.30% for encounters discharged home**, **14.66% for encounters discharged to a skilled nursing facility**, and **12.70% for encounters discharged with home health care**.

Some categories had substantially higher observed rates but relatively few encounters. These findings are useful for identifying areas for further investigation, not for establishing causation or ranking patient risk.

## Limitations

- **Historical data:** The dataset covers 1999–2008 and may not represent current hospital practices.
- **Encounter-level analysis:** Patients can contribute multiple encounters, so encounter counts are not unique-patient counts.
- **Observational analysis:** The project identifies associations and differences, not causal relationships.
- **Uneven group sizes:** Small groups can produce unstable readmission-rate estimates.
- **Missing and unmapped values:** Some records contain missing information or category labels that could not be mapped.
- **Limited adjustment:** The comparisons do not control for all patient, clinical, or hospital characteristics.
- **No predictive modeling:** This project is descriptive and exploratory; it does not predict individual readmission risk.

## Future Improvements

- Validate unmatched and missing category mappings across all joined analyses.
- Add more contextual information about encounter volumes to the dashboard.
- Investigate whether observed patterns persist after accounting for additional patient and encounter characteristics.
- Explore patient-level analysis that accounts for repeated encounters, where appropriate.
- Improve the dashboard's annotations and business-focused explanations.

## Conclusion

This project demonstrates a complete descriptive analytics workflow, from initial data exploration and validation to SQL-based analysis and Power BI visualization.

The analysis found differences in observed 30-day readmission rates across length of stay, diagnosis count, age group, admission characteristics, and discharge disposition. These patterns provide starting points for further investigation, but should be interpreted in the context of historical data, group sizes, repeated encounters, and the limitations of descriptive analysis.
