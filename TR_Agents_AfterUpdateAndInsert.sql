Create Trigger TR_Agents_InsertAndUpdate On agents
After Update, Insert
As
IF EXISTS(Select * From inserted) and Exists (Select * from deleted) And UPDATE([Priority])
BEGIN
	Insert Into [dbo].[HistoryPriority] ([oldPriority], [newPriority])
	Select d.Priority, i.Priority
	From inserted i inner join deleted d on i.IDAgent = d.IDAgent
END;
IF EXISTS(Select * From inserted) and not exists (Select * from deleted)
BEGIN
Insert Into [dbo].[HistoryPriority] ([oldPriority], [newPriority])
	Select null, i.Priority
	From inserted i inner join deleted d on i.IDAgent = d.IDAgent
END;