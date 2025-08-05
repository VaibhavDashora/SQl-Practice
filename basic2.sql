RENAME TABLE `appointments - appointments`  TO appointments;
RENAME TABLE `patients - patients`  TO patients;

-- query will insert a new record for a patient named "sarah johnson".....

insert into patients(
Patient_ID, 
Patient_Name, 
Age,
Gender)
Values(
"P006",
"Sarah Johnson",
30,
"Female");

-- check it
select * from patients where Patient_ID = "P006";


-- query to update the age of "Todd Ross"....
update patients set age = 63 where patient_ID = "P001";
select * from patients where Patient_ID = "P001";


-- query to delete the appointment with id A003
delete from appointments where appointment_ID = "A003";


-- query to retrieve all patients who had appointments in the 'dermatology' department
select * from  patients as p
inner join appointments as a on a.patient_id = p.patient_id
where Department = "Dermatology";

-- query will return all patients from the patients table, even if they do not have a corresponding appointment
select * from patients as p
left join appointments as a 
On p.Patient_ID = a.Patient_ID;

-- query will list all appointments, including those may not have a corresponding patient in the patients table?
select * from appointments as a 
right join patients as p 
On p.Patient_ID = a.Patient_ID;

-- query will combine the result of two diff select query, retaining duplicate row
select * from patients 
union all
select * from appointments;


-- query will retrieve all patients who have attended more than two appointments:

select patient_ID , count(appointment_id)
from appointments 
group by patient_id 
having count(Appointment_ID) > 2;


-- query use to update the department of all patients with patient_id starting with "PO" to cardiology

update appointments set department = "cardiology"
where patients_Id like "P0";

-- query will retrieve patients who have the same name

select patient_name , count(*)
from patients 
group by patient_name
having count(*) > 1;

-- query to display the sum of ages of all patients who are admitted after 2024 jan

select sum(age)
from patients 
where Admission_Date > '01-01-2024';







 


