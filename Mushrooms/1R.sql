--Create Table Class_Frequent ("Col" Integer, "Val" Varchar(1), "Frequency" Integer,"Decision" Varchar(1));
--Create Table One_Rule("Col" INTEGER);
--Create Table One_Rule_Accuracy ("Accur" DECIMAL(11,10));
--Calculate most frequent class of each predictor
Insert Into Class_Frequent
	With Class_Decision (Col,Val,Frequency,Decision) As 
	(Select Col, Val, Count(Decision), Decision
		From Train Group BY Col,Val,Decision),
	Max_Class(Col,Val,Max_Freq) As (Select Col, Val, Max(Frequency) From Class_Decision Group By Col,Val)
	(Select Class_Decision.Col,Class_Decision.Val,Class_Decision.Frequency,Class_Decision.Decision
		From Class_Decision,Max_Class
		Where Class_Decision.Frequency=Max_Class.Max_Freq And Class_Decision.Col=Max_Class.Col)@

--Find the best predictor (with minimum error)
Insert Into One_Rule
	With Error_Count As (Select Train.Col, Count(Train.Col) As Error 
		From Train, Class_Frequent
		Where Train.Col=Class_Frequent.Col
		And Train.Val=Class_Frequent.Val
		And Train.Decision!=Class_Frequent.Decision 
		Group By Train.Col)
		(Select Col From Error_Count Where Error = (Select Min(Error) From Error_Count))@

--Calculate the accuracy of One rule classifier
Insert Into One_Rule_Accuracy
	With Correct (Num) As
		(Select Count(Distinct Test.ID) From Test, One_Rule, Class_Frequent
			Where Test.Col=One_Rule.Col
			And Class_Frequent.Col=One_Rule.Col
			And Test.Val=Class_Frequent.Val
			And Test.Decision=Class_Frequent.Decision),
	Total (Num) As
		(Select Count(Distinct ID) From Test)
	(SELECT CAST(Correct.Num AS DECIMAL(10,0))/CAST(Total.Num AS DECIMAL(10,0))
	FROM Correct, Total)@	