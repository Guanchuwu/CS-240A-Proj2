--Connect to Titanic@
--Create Data base
--Drop Table Dataset@
--Create Table Dataset("ID" Integer Not NULL Generated Always As Identity (Start With 1, Increment By 1, No Cache), "Class" Varchar(10),"Type" Varchar (10),"Sex" Varchar (10), "Survived" Varchar(10))@
--Load From '/Users/guanchuwu/Desktop/CS240AProj2/Dataset.data' Of del "Insert Into Dataset(Class,Type,Sex,Survived)"@
--Drop Table Test@
--Drop Table Train@
--Create Test and Train Table
--Create Table Test("ID" Integer,"Col" Integer,"Val" Varchar(10),"Decision" Varchar(10),"Weight" Integer)@
--Create Table Train("ID" Integer,"Col" Integer,"Val" Varchar(10),"Decision" Varchar(10),"Weight" Integer)@

Begin ATOMIC
	For X As Select * From Dataset Order By ID Do
	If rand()>0.75 Then --SELECT RECORDS ON RANDOM AND ADD TO TEST IF < 75 %
		Insert Into Test Values
		(X.ID,1,X.Class,X.Survived,1),
		(X.ID,2,X.Type,X.Survived,1),
		(X.ID,3,X.Sex,X.Survived,1);
	Else
		Insert Into Train Values
		(X.ID,1,X.Class,X.Survived,1),
		(X.ID,2,X.Type,X.Survived,1),
		(X.ID,3,X.Sex,X.Survived,1);
	End If;
	End For;
End@