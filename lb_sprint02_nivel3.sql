-- Nivell 3

/*Exercici 1
Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions amb un valor comprès entre 100 i 200 euros 
i en alguna d'aquestes dates: 29 d'abril del 2021, 20 de juliol del 2021 i 13 de març del 2022. 
Ordena els resultats de major a menor quantitat.*/

select company_name, phone, country, date(t.timestamp) as date, t.id as order_id, amount
from company as c
join transaction as t
on c.id = company_id
	where amount between 100 and 200
	and date(timestamp) in ('2021-04-29', '2021-07-20', '2022-03-13')
    and declined = 0
order by amount desc;


/*Exercici 2
Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, per la qual cosa et demanen 
la informació sobre la quantitat de transaccions que realitzen les empreses, 
però el departament de recursos humans és exigent i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.*/
  -- hacer von case
select 
    company_name,
    count(t.id) as client_orders,
    if(count(t.id) >= 4, '4 pedidos o mas', 'menos de 4 pedidos') as client_situation
from company as c
inner join transaction as t 
on c.id = company_id
group by c.id;

select
	company_name,
	count(t.id) as client_orders,
case
	when count(t.id) >= 4 then '4 or more orders'
    else 'less than 4 orders'
    end as 'client_category'
from company as c
inner join transaction as t
on c.id = company_id
group by company_name;


