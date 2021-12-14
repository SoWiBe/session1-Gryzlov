Select agents.IDAgent, agents.Name, agents.Phone, agents.Priority, type_agents.Name, CASE WHEN A.�����_������ < 10000 Then 5 WHEN A.�����_������ >= 10000 THEN 25 END AS [������]
From (Select s.InAgent, SUM(s.[���������� ���������] * p.MinPriceForAgent) As [�����_������]
		From products p inner join productSale s on p.Id = s.ID
		Group By  s.InAgent) As A left outer join
		(Select s.InAgent, SUM(s.[���������� ���������] * p.MinPriceForAgent) As [�����_������_�����]
		From products p inner join productSale s on p.Id = s.ID
		Where YEAR(s.[���� ����������]) = YEAR(GETDATE())
		Group By  s.InAgent) as b on a.InAgent = b.InAgent inner join agents on a.InAgent = agents.IDAgent
		inner join type_agents on type_agents.ID = agents.IdType
