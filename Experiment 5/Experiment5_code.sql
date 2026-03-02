/* -----------------------------------------------------------
   Create Employee Table
   ----------------------------------------------------------- */

CREATE TABLE Employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    salary NUMERIC(10,2),
    experience INT,           -- Years of experience
    performance_score INT     -- Rating out of 10
);

INSERT INTO Employee (emp_name, salary, experience, performance_score) VALUES
('Amit', 40000, 2, 6),
('Neha', 60000, 5, 8),
('Rohit', 55000, 4, 7),
('Priya', 75000, 8, 9),
('Karan', 30000, 1, 5);

select * from Employee

/* -----------------------------------------------------------
   STEP 1: Simple Forward-Only Cursor
   - Fetch records one by one
   - Display employee details
   ----------------------------------------------------------- */

DO $$
DECLARE
    emp_record RECORD;      -- Variable to hold one row
    emp_cursor CURSOR FOR   -- Declare cursor
        SELECT emp_id, emp_name, salary
        FROM Employee;
BEGIN

    OPEN emp_cursor;   -- Open cursor

    LOOP
        FETCH emp_cursor INTO emp_record;   -- Fetch one row

        EXIT WHEN NOT FOUND;   -- Exit when no more rows

        RAISE NOTICE 'ID: %, Name: %, Salary: %',
                     emp_record.emp_id,
                     emp_record.emp_name,
                     emp_record.salary;

    END LOOP;

    CLOSE emp_cursor;   -- Close cursor

END $$;
/* -----------------------------------------------------------
   STEP 2: Complex Row-by-Row Manipulation
   Table Name: Employee
   Purpose:
   - Use cursor for sequential processing
   - Calculate dynamic increment
   - Update salary based on business formula
   ----------------------------------------------------------- */

DO $$
DECLARE
    emp_record RECORD;

    -- Declare cursor
    emp_cursor CURSOR FOR
        SELECT emp_id, salary, experience, performance_score
        FROM Employee;

    increment_percent NUMERIC;
    new_salary NUMERIC;

BEGIN

    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;

        EXIT WHEN NOT FOUND;

        /* Calculate increment percentage */
        increment_percent :=
            (emp_record.experience * emp_record.performance_score) / 10.0;

        /* Calculate new salary */
        new_salary :=
            emp_record.salary +
            (emp_record.salary * increment_percent / 100);

        /* Update salary */
        UPDATE Employee
        SET salary = new_salary
        WHERE emp_id = emp_record.emp_id;

        /* Display update message */
        RAISE NOTICE
        'Employee ID: %, Increment: %%%, New Salary: %',
        emp_record.emp_id,
        increment_percent,
        new_salary;

    END LOOP;

    CLOSE emp_cursor;

END $$;

/* -----------------------------------------------------------
   STEP 3: Exception and Status Handling
   Table: Employee
   Purpose:
   - Handle empty result set
   - Handle runtime errors
   - Provide status messages
   ----------------------------------------------------------- */

-- DO $$
-- DECLARE
--     emp_record RECORD;
--     emp_cursor CURSOR FOR
--         SELECT emp_id, salary, experience, performance_score
--         FROM Employee;

--     increment_percent NUMERIC;
--     new_salary NUMERIC;
--     row_count INT := 0;

-- BEGIN

--     -- Check if table is empty
--     IF NOT EXISTS (SELECT 1 FROM Employee) THEN
--         RAISE NOTICE 'No employees found. Cursor execution skipped.';
--         RETURN;
--     END IF;

--     OPEN emp_cursor;

--     LOOP
--         FETCH emp_cursor INTO emp_record;

--         EXIT WHEN NOT FOUND;

--         row_count := row_count + 1;

--         -- Business logic calculation
--         increment_percent :=
--             (emp_record.experience * emp_record.performance_score) / 10.0;

--         new_salary :=
--             emp_record.salary +
--             (emp_record.salary * increment_percent / 100);

--         UPDATE Employee
--         SET salary = new_salary
--         WHERE emp_id = emp_record.emp_id;

--         RAISE NOTICE
--         'Processed Employee ID: %, Increment: %%%, New Salary: %',
--         emp_record.emp_id,
--         increment_percent,
--         new_salary;

--     END LOOP;

--     CLOSE emp_cursor;

--     -- Completion status
--     RAISE NOTICE 'Cursor execution completed. Total records processed: %',
--                  row_count;

-- EXCEPTION
--     WHEN OTHERS THEN
--         RAISE NOTICE 'An error occurred: %', SQLERRM;
--         -- Optional rollback logic could go here

-- END $$;

/* -----------------------------------------------------------
   STEP 3: Exception Demonstration
   Purpose:
   - Intentionally raise an exception
   - Handle it gracefully
   ----------------------------------------------------------- */

DO $$
DECLARE
    emp_record RECORD;

    emp_cursor CURSOR FOR
        SELECT emp_id, salary
        FROM Employee;

BEGIN

    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;

        EXIT WHEN NOT FOUND;

        -- Intentionally raise exception if salary < 35000
        IF emp_record.salary < 35000 THEN
            RAISE EXCEPTION 
            'Salary too low for Employee ID: %',
            emp_record.emp_id;
        END IF;

        RAISE NOTICE 
        'Processed Employee ID: %, Salary: %',
        emp_record.emp_id,
        emp_record.salary;

    END LOOP;

    CLOSE emp_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Exception Caught Successfully!';
        RAISE NOTICE 'Error Message: %', SQLERRM;
        RAISE NOTICE 'Execution stopped safely.';

END $$;
