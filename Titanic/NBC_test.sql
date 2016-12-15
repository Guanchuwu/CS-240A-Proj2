--CREATE TABLE NBC_test ("ID" INTEGER, "Decision" VARCHAR(10), "Predict" VARCHAR(10));
--CREATE TABLE NBC_Accuracy ("Accur" DECIMAL(11,10));
Insert Into NBC_test (ID,Decision,Predict)
	With TestProbClass (ID, Predict, Prob) AS
	(Select Test.ID,NBC.Decision,NBC.Probability
		From Test,NBC
		Where Test.Col=NBC.Col
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

