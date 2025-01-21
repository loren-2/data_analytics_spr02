-- Nivel 2--
-- Exercici 1
/* Identifica els cinc dies que es va generar la quantitat més gran d'ingressos 
a l'empresa per vendes. Mostra la data de cada transacció juntament amb el total de les vendes.*/

select date(timestamp) as date, sum(amount) as amount_day
from transaction
where declined = 0
group by date(timestamp)
order by sum(amount) desc
limit 5;

/*Exercici 2
Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.*/

select country, round(avg(amount),2) as average
from company as c
inner join transaction
on c.id = company_id
group by country 
order by avg(amount) desc;

-- Exercici 3
/*En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència 
a la companyia "Non Institute". Per a això, et demanen la llista de totes les transaccions realitzades per empreses 
que estan situades en el mateix país que aquesta companyia.*/

-- Mostra el llistat aplicant JOIN i subconsultes. -- da 70 rows
select c.id, company_name, country, t.id as order_id, amount
from transaction as t
inner join company as c
on c.id = company_id
where country = (select country from company
where company_name = 'Non Institute');  

select *
from transaction
inner join company as c
on c.id = company_id
where country = (select country from company
where company_name = 'Non Institute');  

-- Mostra el llistat aplicant solament subconsultes.
select
    t.id as order_id,
    amount,
    c.id,
    company_name,
    country
from transaction as t,
     company as c
where company_id = c.id
  and country = (
      select country 
      from company 
      where company_name = 'Non Institute'
  );