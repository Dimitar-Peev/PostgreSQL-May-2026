# 📘 Database Programmability

## 📑 Table of Contents

* [User-Defined Functions](#-user-defined-functions)
* [Stored Procedures](#-stored-procedures)
* [Transactions](#-transactions)
* [Triggers](#-triggers)
* [Common Patterns](#-common-patterns)

---

## ⚙️ User-Defined Functions

* Functions encapsulate reusable database logic
* Write once → call multiple times

### Function Types

* Scalar → returns a single value
* Table-valued → returns a table

---

### Function Syntax

```sql id="5r8ldd"
CREATE [OR REPLACE] FUNCTION function_name(arguments)
RETURNS return_datatype
AS $variable_name$
DECLARE
    variable_name datatype;
BEGIN
    -- logic
    RETURN value;
END;
$variable_name$
       LANGUAGE plpgsql;
```

---

### Example: Count Employees by Town

```sql id="4f8xuq"
CREATE FUNCTION fn_count_employees_by_town("town_name" VARCHAR(20))
    RETURNS INT
AS
$$
DECLARE
    "e_count" INT;
BEGIN
    SELECT COUNT("employee_id")
    INTO "e_count"
    FROM "employees" AS e
             JOIN "addresses" AS a
                  ON a."address_id" = e."address_id"
             JOIN "towns" AS t
                  ON t.town_id = a."town_id"
    WHERE t."name" = "town_name";

    RETURN "e_count";
END;
$$ LANGUAGE plpgsql;
```

---

### Function Call

```sql id="l2m5fk"
SELECT fn_count_employees_by_town('Sofia');
```

---

## 🧩 Stored Procedures

* Stored procedures encapsulate multiple SQL operations
* Help:

    * Reduce network traffic
    * Improve security
    * Reuse complex logic

---

### Procedure Syntax

```sql id="j6bh6w"
CREATE PROCEDURE procedure_name(parameters)
    LANGUAGE plpgsql
AS
$$
BEGIN
    -- logic
END;
$$;
```

---

### Example Procedure

```sql id="55rf1r"
CREATE PROCEDURE sp_employees_count_by_work_experience()
  LANGUAGE plpgsql
AS
$$
DECLARE
  "employees_count" INT;
BEGIN
  SELECT COUNT("employee_id")
  INTO "employees_count"
  FROM "employees"
  WHERE DATE_PART('year', AGE(NOW(), "hire_date")) < 18;

  RAISE NOTICE 'Employees count: %', "employees_count";
END;
$$;
```

---

### Execute Procedure

```sql id="cnvg9o"
CALL sp_employees_count_by_work_experience();
```

---

### Drop Procedure

```sql id="4t7lnf"
DROP PROCEDURE sp_employees_count_by_work_experience;
```

---

### Procedure with Parameters

```sql id="9g9g2h"
CREATE PROCEDURE sp_select_employees_by_experience("min_years_at_work" INT)
    LANGUAGE plpgsql
AS
$$
DECLARE
    "employee_count" INT;
BEGIN
    SELECT COUNT("employee_id")
    INTO "employee_count"
    FROM "employees"
    WHERE DATE_PART('year', AGE(NOW(), "hire_date")) > "min_years_at_work";

    RAISE NOTICE '%', "employee_count";
END;
$$;
```

---

### Call Parameterized Procedure

```sql id="f6b4hl"
CALL sp_select_employees_by_experience(23);
```

---

### Example: Increase Salaries

```sql id="gm0n2n"
CREATE PROCEDURE sp_increase_salaries("department_name" VARCHAR(50))
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE "employees" AS e
    SET "salary" = "salary" * 1.05
    WHERE e."department_id" = (SELECT "department_id"
                               FROM "departments"
                               WHERE "name" = "department_name");
END;
$$;
```

---

## 🔄 Transactions

* Transactions group operations into a single unit
* Either:

    * ALL operations succeed
    * OR all fail

---

### Transaction Syntax

```sql id="vvj8hz"
BEGIN;

-- operations

COMMIT;
```

---

### Rollback Example

```sql id="rwp1gx"
BEGIN;

-- operations

ROLLBACK;
```

---

### Savepoints

```sql id="jpjv5y"
BEGIN;

SAVEPOINT my_savepoint;

-- operations

ROLLBACK TO my_savepoint;

COMMIT;
```

---

### ACID Properties

| Property    | Meaning                        |
| ----------- | ------------------------------ |
| Atomicity   | All or nothing                 |
| Consistency | Valid database state           |
| Isolation   | Independent transactions       |
| Durability  | Saved permanently after commit |



---

### Example: Transactional Salary Increase

```sql id="3g73ra"
CREATE PROCEDURE sp_increase_salary_by_id("id" INT)
  LANGUAGE plpgsql
AS
$$
BEGIN
  IF (SELECT COUNT("employee_id")
      FROM "employees"
      WHERE "employee_id" = "id") != 1 THEN

    ROLLBACK;

  ELSE

    UPDATE "employees"
    SET "salary" = "salary" * 1.05
    WHERE "employee_id" = "id";

  END IF;

  COMMIT;
END;
$$;
```

---

## ⚡ Triggers

* Triggers execute automatically on table events
* Events:

    * INSERT
    * UPDATE
    * DELETE
    * TRUNCATE

---

### Trigger Types

| Type   | Execution    |
| ------ | ------------ |
| BEFORE | Before event |
| AFTER  | After event  |

---

### Trigger Function

```sql id="odm5uo"
CREATE FUNCTION trigger_fn_on_employee_delete()
  RETURNS TRIGGER
  LANGUAGE plpgsql
AS
$$
BEGIN
  INSERT INTO "deleted_employees"("first_name",
                                  "last_name",
                                  "middle_name",
                                  "job_title",
                                  "department_id",
                                  "salary")
  VALUES (OLD."first_name",
          OLD."last_name",
          OLD."middle_name",
          OLD."job_title",
          OLD."department_id",
          OLD."salary");

  RETURN NULL;
END;
$$;
```

---

### Create Trigger

```sql id="evuvvw"
CREATE TRIGGER tr_deleted_employees
  AFTER DELETE
  ON "employees"
  FOR EACH ROW
EXECUTE FUNCTION trigger_fn_on_employee_delete();
```

---

### Create Log Table

```sql id="19q7yf"
CREATE TABLE "deleted_employees"
(
  "employee_id"   SERIAL PRIMARY KEY,
  "first_name"    VARCHAR(20),
  "last_name"     VARCHAR(20),
  "middle_name"   VARCHAR(20),
  "job_title"     VARCHAR(50),
  "department_id" INT,
  "salary"        NUMERIC(19, 4)
);
```

---

### Trigger Example

```sql id="i2p6gj"
DELETE
FROM "employees"
WHERE "employee_id" = 1;
```

✔ Deleted employee automatically moves to `deleted_employees`

---

## ⚙️ Common Patterns

---

### Simple Scalar Function

```sql id="7l6fr7"
CREATE FUNCTION fn_square("num" INT)
  RETURNS INT
AS
$$
BEGIN
  RETURN "num" * "num";
END;
$$ LANGUAGE plpgsql;
```

---

### Procedure for Bulk Updates

```sql id="s20j6e"
CREATE PROCEDURE sp_raise_department_salaries("department_id" INT)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE "employees"
    SET "salary" = "salary" * 1.10
    WHERE employees."department_id" = "department_id";
END;
$$;
```

---

### Transaction Example

```sql id="4e0u3s"
BEGIN;

UPDATE "accounts"
SET "balance" = "balance" - 100
WHERE "id" = 1;

UPDATE "accounts"
SET "balance" = "balance" + 100
WHERE "id" = 2;

COMMIT;
```

---

### Audit Trigger

```sql id="y8z0mf"
CREATE TRIGGER tr_audit_delete
    AFTER DELETE
    ON "employees"
    FOR EACH ROW
EXECUTE FUNCTION trigger_fn_on_employee_delete();
```

---

## ✅ Summary

* Functions encapsulate reusable logic
* Stored procedures group multiple SQL operations
* Transactions ensure data consistency and integrity
* ACID guarantees reliable database operations
* Triggers execute automatically on table events
* Database programmability reduces duplicated logic and improves maintainability
