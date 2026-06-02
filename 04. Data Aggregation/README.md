# 📘 PostgreSQL Data Aggregation Cheat Sheet

## 📑 Table of Contents

* [Grouping](#-grouping)
* [Aggregate Functions](#-aggregate-functions)
* [HAVING Clause](#-having-clause)
* [CASE Expressions](#-case-expressions)
* [COALESCE](#-coalesce)
* [Common Patterns](#-common-patterns)

---

## 🧩 Grouping

* `GROUP BY` consolidates rows into groups based on common values
* Commonly used with aggregate functions

### Basic Syntax

```sql id="x6ccax"
SELECT column_one,
       column_two
FROM table_name
GROUP BY column_one, column_two;
```

---

### Example

```sql id="b1uknh"
SELECT "department_id",
       SUM("salary")
FROM "employees"
GROUP BY "department_id";
```

---

## 📊 Aggregate Functions

* Used to analyze grouped data
* Most aggregate functions ignore `NULL` values

### Common Functions

```sql id="qmxznr"
COUNT()
SUM()
MAX()
MIN()
AVG()
```

---

### COUNT

Counts non-null values.

```sql id="jjsyx0"
SELECT "department_id",
       COUNT("id") AS "employee_count"
FROM "employees"
GROUP BY "department_id"
ORDER BY "department_id";
```

---

### COUNT and NULL

```sql id="36yz5f"
SELECT "department_id",
       COUNT("salary") AS "employee_count"
FROM "employees"
GROUP BY "department_id"
ORDER BY "department_id";
```

✔ `COUNT(salary)` ignores NULL salaries

---

### SUM

```sql id="dx2x8d"
SELECT "department_id",
       SUM("salary") AS "total_salaries"
FROM "employees"
GROUP BY "department_id"
ORDER BY "department_id";
```

---

### MAX

```sql id="3i3n9l"
SELECT "department_id",
       MAX("salary") AS "max_salary"
FROM "employees"
GROUP BY "department_id"
ORDER BY "department_id";
```

---

### MIN

```sql id="th8t4x"
SELECT "department_id",
       MIN("salary") AS "min_salary"
FROM "employees"
GROUP BY "department_id"
ORDER BY "department_id";
```

---

### AVG

```sql id="i4v4yf"
SELECT "department_id",
       AVG("salary") AS "avg_salary"
FROM "employees"
GROUP BY "department_id"
ORDER BY "department_id";
```

---

## 🔍 HAVING Clause

* `HAVING` filters grouped results
* Unlike `WHERE`, it works **after aggregation**

---

### Syntax

```sql id="3vtfhg"
SELECT "department_id",
       SUM("salary") AS "Total Salary"
FROM "employees"
GROUP BY "department_id"
HAVING SUM("salary") < 4200
ORDER BY "department_id";
```

---

### WHERE vs HAVING

| WHERE                          | HAVING                |
| ------------------------------ | --------------------- |
| Filters rows                   | Filters groups        |
| Before grouping                | After grouping        |
| Cannot use aggregates directly | Works with aggregates |

---

## ⚖️ CASE Expressions

* Similar to `if / else` logic
* Can be used in:

    * `SELECT`
    * `WHERE`
    * `GROUP BY`
    * `HAVING`

---

### General CASE Syntax

```sql id="yvq4ez"
CASE
    WHEN condition_1 THEN result_1
    WHEN condition_2 THEN result_2
    ELSE default_result
END
```
---

### Example in SELECT

```sql id="jlwm0h"
SELECT "id",
       "first_name",
       "salary",
       CASE
         WHEN "department_id" = 1 THEN 'Management'
         WHEN "department_id" = 2 THEN 'Kitchen Staff'
         WHEN "department_id" = 3 THEN 'Service Staff'
         ELSE 'Other'
         END AS "department_name"
FROM "employees";
```

---

### Simple CASE Syntax

```sql id="l9c97k"
CASE expression
    WHEN value_1 THEN result_1
    WHEN value_2 THEN result_2
    ELSE default_result
END
```

---

### Example

```sql id="e9xjlwm"
SELECT "id",
       "department_id",
       CASE "department_id"
         WHEN 1 THEN 'Management'
         WHEN 2 THEN 'Kitchen Staff'
         WHEN 3 THEN 'Service Staff'
         ELSE 'Other'
         END AS "department_name"
FROM "employees";
```

---

### CASE in Aggregate Functions

```sql id="d2g6pi"
SELECT SUM("salary") AS "total_salaries",
       SUM(
               CASE "department_id"
                 WHEN 1 THEN "salary" * 1.15
                 WHEN 2 THEN "salary" * 1.10
                 ELSE "salary" * 1.05
                 END
       )             AS "total_increased_salaries"
FROM "employees";
```

---

### CASE with GROUP BY

```sql id="jlwm8w"
SELECT CASE
         WHEN "category_id" IN (1, 2, 3) THEN 'Starters'
         WHEN "category_id" = 4 THEN 'Mains'
         ELSE 'Desserts'
         END AS "product_category",
       COUNT("id")
FROM "products"
GROUP BY "product_category";
```

---

### CASE with HAVING

```sql id="6ud8jv"
SELECT CASE
         WHEN "salary" < 1000 THEN 'Low'
         WHEN "salary" <= 3000 THEN 'Middle'
         ELSE 'High'
         END AS "salary_range",
       COUNT("salary")
FROM "employees"
GROUP BY "salary_range"
HAVING CASE COUNT("salary")
         WHEN 0 THEN FALSE
         ELSE TRUE
         END;
```

---

## 🛟 COALESCE

* Returns the first non-null value

### Example

```sql id="46dhmq"
SELECT CASE
           WHEN "salary" < 1000 THEN 'Low'
           WHEN "salary" <= 3000 THEN 'Middle'
           ELSE 'High'
           END AS "salary_range",
       COUNT("salary")
FROM "employees"
GROUP BY "salary_range"
HAVING COALESCE(COUNT("salary") > 0, FALSE);
```

---

## ⚙️ Common Patterns

---

### Total Salaries per Department

```sql id="lk9dtw"
SELECT "department_id",
       SUM("salary") AS "total_salary"
FROM "employees"
GROUP BY "department_id";
```

---

### Employees Count per Department

```sql id="76lyyr"
SELECT "department_id",
       COUNT("id") AS "employee_count"
FROM "employees"
GROUP BY "department_id";
```

---

### Departments with Small Salary Budget

```sql id="1u8f4x"
SELECT "department_id",
       SUM("salary") AS "total_salary"
FROM "employees"
GROUP BY "department_id"
HAVING SUM("salary") < 25000;
```

---

### Salary Ranges

```sql id="6rtsrt"
SELECT CASE
           WHEN "salary" < 1000 THEN 'Low'
           WHEN "salary" <= 3000 THEN 'Middle'
           ELSE 'High'
           END  AS "salary_range",
       COUNT(*) AS "employees_count"
FROM "employees"
GROUP BY "salary_range";
```

---

## ✅ Summary

* `GROUP BY` organizes data into logical groups
* Aggregate functions calculate statistics over groups
* `HAVING` filters grouped results
* `CASE` expressions add conditional logic to queries
* `COALESCE` helps safely handle NULL values
