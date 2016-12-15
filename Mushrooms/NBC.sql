--connect to Titanic;
--Table NBC_S represent P(sruivived)
--Table NBC represent P(Col|survived)

--Create Table NBC_S ("Decision" Varchar(10),"Probability" Decimal (11,10));
--Create Table NBC ("Col" Integer, "Val" Varchar(10), "Decision" Varchar(10), "Probability" Decimal (11,10));

Insert Into NBC(Col, Val, Decision, Probability)
	With temp (Col, Val, Decision, TotalWeight) As
	(Select Col, Val, Decision, SUM(Weight)
		From Train
		Group By GROUPING SETS ((Col,Decision),(Col,Val,Decision)))
	(Select temp1.Col,temp1.Val,temp1.Decision,
		Cast (temp1.TotalWeight AS Decimal(6,0))/Cast (temp2.TotalWeight As Decimal(6,0))
		From temp As temp1, temp As temp2
		Where temp1.Col=temp2.Col
		And temp1.Decision=temp2.Decision
		And temp1.Val Is Not NULL
		And temp2.Val Is NULL)@


Insert Into NBC_S (Decision,Probability)
	With Total (Value) As (Select Sum (Weight) From Train Where Col=1),
		DecisionTotal (Decision,Value) As (Select Decision, Sum(Weight) From Train Where Col=1 Group By Decision)
	(Select DecisionTotal.Decision, 
		Cast(DecisionTotal.Value As Decimal(10,0))/ Cast(Total.Value As Decimal(10,0))
		From DecisionTotal,Total)@