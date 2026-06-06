
-- Conteo General de todos los empleandos --
 
 select count(emp_no) AS total_employees FROM employees;
 
 -- Salarios Extremos: ¿Cuál es el salario más alto y el salario más bajo que se ha pagado en la historia de la empresa ? --
 
  select max(salary) AS highest_salary, min(salary) AS lowest_salary FROM salaries;

-- Promedio Salarial: ¿Cuál es el salario promedio de todos los empleados?

select AVG(salary) AS average_salary FROM salaries;

-- Agrupación por Género: Genera un reporte que muestre cuántos empleados hay de cada género (M y F). --

select gender, COUNT(*) AS total_number_of_employees FROM employees group by gender;

-- Conteo de Cargos: ¿Cuántos empleados han ostentado cada cargo (title) a lo largo del tiempo? Ordena los resultados del cargo más común al menos común. --

select title, COUNT(emp_no) AS total_number_of_employees_with_positions FROM titles group by title order by total_number_of_employees_with_positions desc;

-- Filtro de Grupos con HAVING: Muestra los cargos que han sido ocupados por más de 75,000 personas. --

select title, COUNT(emp_no) AS total_number_of_employees FROM titles group by title having COUNT(emp_no) > 75000;
 
-- Agrupación Múltiple: ¿Cuántos empleados masculinos y femeninos hay por cada cargo? --

select t.title, e.gender, COUNT(*) AS total_number_of_empleyees FROM titles t join employees e ON t.emp_no = e.emp_no group by t.title, e.gender order by t.title, e.gender;

-- Nombres de Departamentos: Muestra una lista de todos los empleados (emp_no, first_name) junto al nombre del departamento en el que trabajan actualmente. --

select e.emp_no, e.first_name, d.dept_name FROM employees AS e join dept_emp AS de on e.emp_no = de.emp_no join departments AS d ON de.dept_no = d.dept_no where de.to_date = '9999-01-01';

-- Empleados de un Departamento Específico: Obtén el nombre y apellido de todos los empleados que trabajan en el departamento de "MARKETING". --

 select e.first_name, e.last_name FROM employees AS e join dept_emp AS de ON e.emp_no = de.emp_no join departments AS d ON de.dept_no = d.dept_no WHERE d.dept_name = 'MARKETING' AND de.to_date = '9999-01-01';
 
 -- Gerentes Actuales: Genera una lista de los gerentes de departamento (managers) actuales, mostrando su número de empleado, nombre completo y el nombre del departamento que dirigen. --
 
 select e.emp_no, e.first_name, e.last_name, d.dept_name FROM employees AS e JOIN dept_manager AS dm ON e.emp_no = dm.emp_no JOIN departments AS d ON dm.dept_no = d.dept_no WHERE dm.to_date = '9999-01-01';

-- Salario por Departamento: Calcula el salario promedio actual para cada departamento. El reporte debe mostrar el nombre del departamento y su salario promedio. --

select d.dept_name, AVG (s.salary) AS average_salary FROM salaries AS s join dept_emp AS de ON s.emp_no = de.emp_no join departments AS d ON de.dept_no =d.dept_no WHERE s.to_date = '9999-01.01' AND de.to_date = '9999-01-01' GROUP BY d.dept_name ORDER BY d.dept_name;

-- Historial de Cargos de un Empleado: Muestra todos los cargos que ha tenido el empleado número 10006, junto con las fechas de inicio y fin de cada cargo. --

select title, from_date, to_date from titles where emp_no = 10006 ORDER BY from_date;

-- Departamentos sin Empleados (LEFT JOIN): ¿Hay algún departamento que no tenga empleados asignados? (Esta consulta teórica te ayudará a entender LEFT JOIN). --

select d.dept_name from departments AS d left join dept_emp AS de ON d.dept_no = de.dept_no where de.emp_no IS NULL;

-- Salario Actual del Empleado: Obtén el nombre, apellido y el salario actual de todos los empleados. --

select e.first_name, e.last_name, s.salary from employees AS e join salaries AS s ON e.emp_no = s.emp_no where s.to_date = '9999-01-01';

-- Salarios por Encima del Promedio: Encuentra a todos los empleados cuyo salario actual es mayor que el salario promedio de toda la empresa. --

select e.first_name, e.last_name, s.salary from employees AS e join salaries AS s ON e.emp_no = s.emp_no where s.to_date = '9999-01-01' and s.salary > ( select avg(salary) from salaries where to_date = '9999-01-01');

-- Nombres de los Gerentes: Usando una subconsulta con IN, muestra el nombre y apellido de todas las personas que son o han sido gerentes de un departamento. --

select first_name, last_name from employees where emp_no IN (select emp_no from dept_manager);

-- Empleados que no son Gerentes: Encuentra a todos los empleados que nunca han sido gerentes de un departamento, usando NOT IN. --

select first_name, last_name from employees where emp_no NOT IN (select emp_no from dept_manager);

-- Último Empleado Contratado: ¿Quién es el último empleado que fue contratado? Muestra su nombre completo y fecha de contratación. --

select first_name, last_name, hire_date FROM employees order by hire_date DESC LIMIT 1;

-- Jefes del Departamento de "Development": Obtén los nombres de todos los gerentes que han dirigido el departamento de "Development". --

select e.first_name, last_name FROM employees AS e JOIN dept_manager AS dm ON e.emp_no = dm.emp_no JOIN departments AS d ON dm.dept_no = d.dept_no where d.dept_name = 'Developmet Department';

-- Empleados con el Salario Máximo: Encuentra al empleado (o empleados) que tiene el salario más alto registrado en la tabla de salarios. --

select e.first_name, e.last_name, s.salary from employees AS e join salaries AS s ON e.emp_no = s.emp_no where s.to_date = '9999-01-01' AND s.salary = ( select max(salary)  from salaries where to_date = '9999-01-01');

-- Nombres Completos: Muestra una lista de los primeros 100 empleados con su nombre y apellido combinados en una sola columna llamada nombre_completo. --

select CONCAT(first_name, ' ', last_name) AS full_name from employees LIMIT 100;

-- Antigüedad del Empleado: Calcula la antigüedad en años de cada empleado (desde hire_date hasta la fecha actual). Muestra el número de empleado y su antigüedad. --

select emp_no, truncate(datediff(NOW(), hire_date) / 365.25, 2) AS anos_antiguedad from employees;

-- Categorización de Salarios con CASE: Clasifica los salarios actuales de los empleados en tres categorías: o 'Bajo': si es menor a 50,000. o 'Medio': si está entre 50,000 y 90,000. o 'Alto': si es mayor a 90,000. --

select emp_no, salary, CASE when salary < 50000 then 'Bajo' when salary between 50000 and 90000 then 'Medio' else 'Alto' end AS salary_category from salaries where to_date = '9999-01-01' order by salary DESC;

-- Mes de Contratación: Genera un reporte que cuente cuántos empleados fueron contratados en cada mes del año (independientemente del año). --

select month(hire_date) AS month_of_hiring, COUNT(*) AS total_empleyees from employees group by month_of_hiring order by month_of_hiring;

-- Iniciales de Empleados: Crea una columna que muestre las iniciales de cada empleado (por ejemplo, para 'Georgi Facello' sería 'G.F.'). --

select CONCAT(substring(first_name, 1, 1), '.', substring(last_name, 1, 1),'.') AS initials from employees;

-- Departamento con el Mejor Salario Promedio: ¿Qué departamento tiene el salario promedio actual más alto? --

SELECT d.dept_name, AVG(s.salary) AS salario_promedio FROM salaries AS s JOIN dept_emp AS de ON s.emp_no = de.emp_no JOIN departments AS d ON de.dept_no = d.dept_no WHERE s.to_date = '9999-01-01' AND de.to_date = '9999-01-01' GROUP BY d.dept_name ORDER BY salario_promedio DESC LIMIT 1

-- Gerente con Más Tiempo en el Cargo: Encuentra al gerente que ha estado en su puesto por más tiempo. Muestra su nombre y el número de días en el cargo

select e.first_name, e.last_name, t.title, Datediff(t.to_date, t.from_date) AS days_in_title from employees as e join titles t ON e.emp_no = t.emp_no order by days_in_title desc limit 1;

-- Incremento Salarial por Empleado: Para el empleado 10001, calcula la diferencia entre su primer salario y su salario actual. --

select e.emp_no, MIN(s.salary) AS first_salary, MAX(s.salary) AS current_salary, (MAX(s.salary) - MIN(s.salary)) AS increase from employees e join salaries s ON e.emp_no = s.emp_no where e.emp_no = 10001;

-- Empleados Contratados el Mismo Día: Encuentra todos los pares de empleados que fueron contratados en la misma fecha. --

select hire_date, COUNT(*) AS contracted_employees FROM employees group by hire_date having count(*) > 1 order by hire_date;

-- El Ingeniero Mejor Pagado: ¿Quién es el 'Senior Engineer' con el salario actual más alto en toda la empresa? Muestra su nombre, apellido y salario.0. -- 

select e.first_name, e.last_name, s.salary FROM employees e join titles t on e.emp_no = t.emp_no and t.title = 'Senior Engineer' and t.to_date = '9999-01-01' join salaries s on e.emp_no = s.emp_no and s.to_date = '9999-01-01' order by s.salary desc limit 1;
