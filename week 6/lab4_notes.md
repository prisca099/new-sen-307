# Lab 4 Notes: Referential Integrity

**Error received (Part 4):** When I tried to delete the "Library and Information Science" department, MySQL returned Error 1451: "Cannot delete or update a parent row: a foreign key constraint fails".

**Why MySQL refuses:** The Student table has a foreign key (`dept_id`) pointing to Department. The student "Transfer Student" still referred to that department, so deleting it would leave a student pointing to a department that no longer exists (an orphan record). MySQL blocks this to protect referential integrity, so every foreign key always points to a real row.

**How I fixed it:** I first ran an UPDATE to reassign the dependent student to the Software Engineering department. With no student referencing the department any more, the DELETE succeeded, and the student was moved rather than lost. The Department table was back to 5 rows.

**Another fix I could have used:** I could have defined the foreign key with `ON DELETE CASCADE`, which automatically deletes the dependent students when the department is deleted (risky because data is lost), or `ON DELETE SET NULL`, which keeps the student but sets their `dept_id` to NULL (the column must allow NULL). I could also have deleted the dependent student record manually before deleting the department.
