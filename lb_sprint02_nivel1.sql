-- Nivel 1
-- Exercici 2

-- Llistat dels països que estan fent compres.

select country, sum(amount) as total_amount
from company as c
inner join transaction
on company_id = c.id
group by country;

-- Des de quants països es realitzen les compres.

select count(distinct country) as country_number, sum(amount) as total_amount
from company as c
inner join transaction
on company_id = c.id;


-- Identifica la companyia amb la mitjana més gran de vendes.

select company_name, avg(amount) as average
from company as c
inner join transaction
on company_id = c.id
	where declined = 0
group by company_name
order by avg(amount) desc
limit 1; 

-- Con el average redondeado 
select company_name, round(avg(amount),2) as average
from company as c
inner join transaction
on company_id = c.id
	where declined = 0
group by company_name
order by avg(amount) desc
limit 1;

-- Mostra totes les transaccions realitzades per empreses d'Alemanya

select id as order_id, amount
from transaction
where company_id in (select c.id
    from company as c
    where country = 'Germany');

-- Muestro los campos de company_name y country
select 
	t.id as order_id,
	amount, 
	(select company_name from company where id = t.company_id) as company_name,
	(select country from company where id = company_id) as country 
	from transaction as t
where company_id in(
		select id
		from company as c
		where country = 'Germany'
	);
    
-- Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions
        
/* Este script lista todas las transacciones cuyo monto supera la media de todas las transacciones. No es lo que nos piden.

select company_id, 
(select company_name from company where id = company_id) as companies, 
id as order_id, 
amount
from transaction
	where company_id in (select id from
	company) and 
	amount > (select avg(amount)
	from transaction);*/
        
-- CORRECCION: debe listarse las empresas que tengan pedidos superiores a la media, no las transacciones (70 rows)
                
select id, company_name
from company
where id in (
    select distinct company_id
    from transaction
    where amount > (select avg(amount) from transaction)
);


-- Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.

select id, company_name 
from company
	where id not in (select distinct company_id
    from transaction);

-- Compruebo con count 
select count(distinct company_id)
from transaction;
    
select count(id)
from company;