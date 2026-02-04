/* ------------------------------------------------------------
   Example 1: FOR Loop (Range-Based)
   Purpose:
   - Demonstrates a simple FOR loop
   - Executes a fixed number of iterations (1 to 5)
   ------------------------------------------------------------ */

DO $$
BEGIN
    FOR i IN 1..5 LOOP
        RAISE NOTICE 'Iteration Number: %', i;
    END LOOP;
END $$;
/* ------------------------------------------------------------
   Example 2: FOR Loop with Query
   Purpose:
   - Iterates over records from the Violations table
   - Processes one row at a time
   ------------------------------------------------------------ */

-- Display all records from Violations table
SELECT * FROM Violations;

DO $$
DECLARE
    rec RECORD;   -- Record variable to store one row at a time
BEGIN
    FOR rec IN SELECT entity_name, violation_count FROM Violations LOOP
        RAISE NOTICE 'Entity: %, Violations: %',
                     rec.entity_name, rec.violation_count;
    END LOOP;
END $$;
/* ------------------------------------------------------------
   Example 3: WHILE Loop
   Purpose:
   - Executes repeatedly as long as the condition is true
   - Demonstrates condition-controlled iteration
   ------------------------------------------------------------ */

DO $$
DECLARE
    counter INT := 1;   -- Initialize counter variable
BEGIN
    WHILE counter <= 5 LOOP
        RAISE NOTICE 'Counter Value: %', counter;
        counter := counter + 1;   -- Increment counter
    END LOOP;
END $$;
/* ------------------------------------------------------------
   Example 4: LOOP with EXIT WHEN
   Purpose:
   - Demonstrates an infinite LOOP
   - Loop terminates explicitly using EXIT condition
   ------------------------------------------------------------ */

DO $$
DECLARE
    counter INT := 1;   -- Initialize counter
BEGIN
    LOOP
        RAISE NOTICE 'Loop Count: %', counter;
        counter := counter + 1;
        EXIT WHEN counter > 5;   -- Exit condition
    END LOOP;
END $$;
/* ------------------------------------------------------------
   Example 5: Salary Increment Using FOR Loop
   Purpose:
   - Iterates through Employees table
   - Increases salary of each employee by 1000
   - Simulates real-world payroll processing
   ------------------------------------------------------------ */

DO $$
DECLARE
    rec RECORD;   -- Record to hold employee details
BEGIN
    FOR rec IN SELECT emp_id, salary FROM Employees LOOP
        UPDATE Employees
        SET salary = salary + 1000
        WHERE emp_id = rec.emp_id;
    END LOOP;
END $$;

-- Display updated employee records
SELECT * FROM Employees;
/* ------------------------------------------------------------
   Example 6: LOOP with IF Condition
   Purpose:
   - Processes student records one by one
   - Classifies students based on marks
   ------------------------------------------------------------ */

-- Display all student records
SELECT * FROM StudentGrades;

DO $$
DECLARE
    rec RECORD;   -- Record variable for student details
BEGIN
    FOR rec IN SELECT student_name, marks FROM StudentGrades LOOP
        IF rec.marks >= 75 THEN
            RAISE NOTICE '% : Distinction', rec.student_name;
        ELSE
            RAISE NOTICE '% : Needs Improvement', rec.student_name;
        END IF;
    END LOOP;
END $$;
