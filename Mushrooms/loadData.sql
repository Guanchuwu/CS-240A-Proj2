Create Table Dataset ("ID" Integer Not NULL Generated Always As Identity (Start With 1, Increment By 1, No Cache),
"Poison" Varchar(1),"Col1" Varchar(1),"Col2" Varchar(1),"Col3" Varchar(1),
"Col4" Varchar(1),"Col5" Varchar(1),"Col6" Varchar(1),
"Col7" Varchar(1),"Col8" Varchar(1),"Col9" Varchar(1),
"Col10" Varchar(1),"Col11" Varchar(1),"Col12" Varchar(1),
"Col13" Varchar(1),"Col14" Varchar(1),"Col15" Varchar(1),
"Col16" Varchar(1),"Col17" Varchar(1),"Col18" Varchar(1),
"Col19" Varchar(1),"Col20" Varchar(1),"Col21" Varchar(1),
"Col22" Varchar(1))@

Load From '/Users/guanchuwu/Desktop/CS240AProj2/Mushrooms/Dataset.data' Of del "Insert Into Dataset(Poison,Col1
Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9,Col10,Col11,Col12,Col13,Col14,Col15,Col16,Col17,Col18,Col19,Col20,Col21,Col22)"@


Create Table Test("ID" Integer,"Col" Integer,"Val" Varchar(10),"Decision" Varchar(10),"Weight" Integer)@
Create Table Train("ID" Integer,"Col" Integer,"Val" Varchar(10),"Decision" Varchar(10),"Weight" Integer)@

Begin ATOMIC
	Declare Weight Integer;
	For X As Select * From Dataset Order By ID Do
	If X.Col11 = '?' Then  Set Weight=0; Else Set Weight=1 End If;
	If rand()>0.75 Then --SELECT RECORDS ON RANDOM AND ADD TO TEST IF < 75 %
		Insert Into Test Values
		(X.ID,1,X.Col1,X.Poison,1),
		(X.ID,2,X.Col2,X.Poison,1),
		(X.ID,3,X.Col3,X.Poison,1),
		(X.ID,4,X.Col4,X.Poison,1),
		(X.ID,5,X.Col5,X.Poison,1),
		(X.ID,6,X.Col6,X.Poison,1),
		(X.ID,7,X.Col7,X.Poison,1),
		(X.ID,8,X.Col8,X.Poison,1),
		(X.ID,9,X.Col9,X.Poison,1),
		(X.ID,10,X.Col10,X.Poison,1),
		(X.ID,11,X.Col11,X.Poison,Weight),
		(X.ID,12,X.Col12,X.Poison,1),
		(X.ID,13,X.Col13,X.Poison,1),
		(X.ID,14,X.Col14,X.Poison,1),
		(X.ID,15,X.Col15,X.Poison,1),
		(X.ID,16,X.Col16,X.Poison,1),
		(X.ID,17,X.Col17,X.Poison,1),
		(X.ID,18,X.Col18,X.Poison,1),
		(X.ID,19,X.Col19,X.Poison,1),
		(X.ID,20,X.Col20,X.Poison,1),
		(X.ID,21,X.Col21,X.Poison,1),
		(X.ID,22,X.Col22,X.Poison,1);
	Else
		Insert Into Train Values
		(X.ID,1,X.Col1,X.Poison,1),
		(X.ID,2,X.Col2,X.Poison,1),
		(X.ID,3,X.Col3,X.Poison,1),
		(X.ID,4,X.Col4,X.Poison,1),
		(X.ID,5,X.Col5,X.Poison,1),
		(X.ID,6,X.Col6,X.Poison,1),
		(X.ID,7,X.Col7,X.Poison,1),
		(X.ID,8,X.Col8,X.Poison,1),
		(X.ID,9,X.Col9,X.Poison,1),
		(X.ID,10,X.Col10,X.Poison,1),
		(X.ID,11,X.Col11,X.Poison,Weight),
		(X.ID,12,X.Col12,X.Poison,1),
		(X.ID,13,X.Col13,X.Poison,1),
		(X.ID,14,X.Col14,X.Poison,1),
		(X.ID,15,X.Col15,X.Poison,1),
		(X.ID,16,X.Col16,X.Poison,1),
		(X.ID,17,X.Col17,X.Poison,1),
		(X.ID,18,X.Col18,X.Poison,1),
		(X.ID,19,X.Col19,X.Poison,1),
		(X.ID,20,X.Col20,X.Poison,1),
		(X.ID,21,X.Col21,X.Poison,1),
		(X.ID,22,X.Col22,X.Poison,1);
	End If;
	End For;
End@