create table if not exists `Company` (
  `company_code` varchar(10),
  `founder` varchar(100)
);
insert into `Company` values
('C1', 'Monika'),
('C2', 'Samantha');

create table if not exists `Lead_Manager` (
  `lead_manager_code` varchar(10),
  `company_code` varchar(10)
);
insert into `Lead_Manager` values
('LM1', 'C1'),
('LM2', 'C2');

create table if not exists `Senior_Manager` (
  `senior_manager_code` varchar(10),
  `lead_manager_code` varchar(10),
  `company_code` varchar(10)
);
insert into `Senior_Manager` values
('SM1', 'LM1', 'C1'),
('SM2', 'LM1', 'C1'),
('SM3', 'LM2', 'C2');

create table if not exists `Manager` (
  `manager_code` varchar(10),
  `senior_manager_code` varchar(10),
  `lead_manager_code` varchar(10),
  `company_code` varchar(10)
);
insert into `Manager` values
('M1', 'SM1', 'LM1', 'C1'),
('M2', 'SM3', 'LM2', 'C2'),
('M3', 'SM3', 'LM2', 'C2');

create table if not exists `Employee` (
  `employee_code` varchar(10),
  `manager_code` varchar(10),
  `senior_manager_code` varchar(10),
  `lead_manager_code` varchar(10),
  `company_code` varchar(10)
);
insert into `Employee` values
('E1', 'M1', 'SM1', 'LM1', 'C1'),
('E2', 'M1', 'SM1', 'LM1', 'C1'),
('E3', 'M2', 'SM3', 'LM2', 'C2'),
('E4', 'M3', 'SM3', 'LM2', 'C2');

-- too big, not optimized
select Company.company_code, Company.founder, count(distinct T1.LMC) as LMC, count(distinct T1.SMC) as SMC, count(distinct T2.MC) as MC, count(distinct T3.EC) as EC from Company
left join (
select Lead_Manager.company_code, Lead_Manager.lead_manager_code as LMC, Senior_Manager.senior_manager_code as SMC from Lead_Manager, Senior_Manager
where Lead_Manager.company_code = Senior_Manager.company_code
and Lead_Manager.lead_manager_code = Senior_Manager.lead_manager_code
) as T1
on Company.company_code = T1.company_code
left join (
select Lead_Manager.company_code, Lead_Manager.lead_manager_code as LMC, Senior_Manager.senior_manager_code as SMC, Manager.manager_code as MC from Lead_Manager, Senior_Manager, Manager
where Lead_Manager.company_code = Senior_Manager.company_code
and Lead_Manager.lead_manager_code = Senior_Manager.lead_manager_code
and Senior_Manager.senior_manager_code = Manager.senior_manager_code
) as T2
on T1.company_code = T2.company_code
left join (
select Lead_Manager.company_code, Lead_Manager.lead_manager_code as LMC, Senior_Manager.senior_manager_code as SMC, Manager.manager_code as MC, Employee.employee_code as EC from Lead_Manager, Senior_Manager, Manager, Employee
where Lead_Manager.company_code = Senior_Manager.company_code
and Lead_Manager.lead_manager_code = Senior_Manager.lead_manager_code
and Senior_Manager.senior_manager_code = Manager.senior_manager_code
and Manager.manager_code = Employee.manager_code
) as T3
on T2.company_code = T3.company_code
group by Company.company_code, Company.founder
order by Company.company_code;

-- better version
select C.company_code, C.founder, count(distinct L.lead_manager_code), count(distinct S.senior_manager_code), count(distinct M.manager_code), count(distinct E.employee_code) from Company as C, Lead_Manager as L, Senior_Manager as S, Manager as M, Employee as E where C.company_code = L.company_code and L.lead_manager_code = S.lead_manager_code and S.senior_manager_code = M.senior_manager_code and M.manager_code = E.manager_code group by C.company_code, C.founder order by C.company_code;