--Truncate Table Train IMMEDIATE@

--Load From '/Users/guanchuwu/Desktop/CS240AProj2/Titanic/train.txt' Of del "Insert Into train(ID,Col,Val,Decision,Weight)"@
--Load From '/Users/guanchuwu/Desktop/CS240AProj2/Titanic/NBC.txt' Of del "Insert Into NBC(Col,Val,Decision,Probability)"@
--Insert into NBC_S Values ('no',0.6709090909),('yes',0.3290909090)@

Update Train Set Weight = Weight*2 Where Col=20@

--Update NBC
Truncate Table NBC IMMEDIATE@
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

Truncate Table NBC_S IMMEDIATE@
Insert Into NBC_S (Decision,Probability)
	With Total (Value) As (Select Sum (Weight) From Train Where Col=1),
		DecisionTotal (Decision,Value) As (Select Decision, Sum(Weight) From Train Where Col=1 Group By Decision)
	(Select DecisionTotal.Decision, 
		Cast(DecisionTotal.Value As Decimal(10,0))/ Cast(Total.Value As Decimal(10,0))
		From DecisionTotal,Total)@


Truncate Table NBC_test IMMEDIATE@

Insert Into NBC_test (ID,Decision,Predict)
	With TestProbClass (ID, Predict, Prob) AS
	(Select Test.ID,NBC.Decision,NBC.Probability
		From Test,NBC
		Where Test.Col=NBC.Col
		And Test.Weight>0
		And Test.Val=NBC.val),
	ProbSum (ID,Predict,Prob) AS
	(Select ID,Predict,Sum(Log(Prob)) From TestProbClass Group By ID,Predict),
	TestProbSum (ID,Predict,Prob) AS
	(Select ProbSum.ID,ProbSum.Predict,ProbSum.Prob+Log(NBC_s.Probability)
		From ProbSum,NBC_s
		Where ProbSum.Predict = NBC_s.Decision),
	MaxProb (ID,Prob) AS
	(Select ID, Max(Prob) From TestProbSum Group By ID)
	(Select Test.ID,Test.Decision,TestProbSum.Predict
		From Test,TestProbSum,MaxProb
		Where Test.ID=MaxProb.ID
		And Test.ID = TestProbSum.ID
		And MaxProb.Prob=TestProbSum.Prob
		And Test.Col =1)@

Insert Into NBC_Accuracy (Accur)
	With 
		Correct(Num) AS
			(Select Count(ID) From NBC_test Where Decision=Predict),
		Total (Num) AS
			(Select Count(ID) From NBC_test)
		(SELECT CAST(Correct.Num AS DECIMAL(10,0))/CAST(Total.Num AS DECIMAL(10,0))
		FROM Correct, Total)@