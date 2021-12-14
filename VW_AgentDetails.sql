Select agents.IDAgent, agents.Name, agents.Phone, agents.Priority, type_agents.Name, CASE WHEN A.Сумма_Продаж < 10000 Then 5 WHEN A.Сумма_Продаж >= 10000 THEN 25 END AS [Скидка]
From (Select s.InAgent, SUM(s.[Количество продукции] * p.MinPriceForAgent) As [Сумма_Продаж]
		From products p inner join productSale s on p.Id = s.ID
		Group By  s.InAgent) As A left outer join
		(Select s.InAgent, SUM(s.[Количество продукции] * p.MinPriceForAgent) As [Сумма_Продаж_ЗаГод]
		From products p inner join productSale s on p.Id = s.ID
		Where YEAR(s.[Дата реализации]) = YEAR(GETDATE())
		Group By  s.InAgent) as b on a.InAgent = b.InAgent inner join agents on a.InAgent = agents.IDAgent
		inner join type_agents on type_agents.ID = agents.IdType
