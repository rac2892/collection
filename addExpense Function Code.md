```
'Author: rac2892
'Date: 11/16/2019

'Future Changes
'--An error check to guarantee variables are sized properly
'--An error check to guarantee variables contain values they need to hold
'--Improve the way the for loop looks through each cell

'The code's purpose is to add up expenses based on an assigned catagory.
'Ex. Gas payments would be in the Car catagory

Option Explicit
Function addExpense(exp_Name As String, rn_Expense As Range, rn_ExpType As Range) As Double
'The function's inputs are:
'--The expense catagory's name that is being summed
'--The cost of each expense as a single row/column (should check this-Shouldn't work)
'--The catagory of each expense as a single row/column (should check this-Shouldn't work)

'The cost and type of expenses should be both rows or should both be columns.

'The function's outputs are:
'--The total cost of the chosen expense catagory

Dim expense As Range
Dim total As Double
Dim i As Integer

total = 0#
i = 1


'For every cell in the rn_Expense row/column of cells the expense's catagory is checked
    'against the expense catagory being added up. If the catagories match then the
    'expense's cost is added to the total before the next expense is checked. If the
    'catagories don't match then the next expense is checked.
'Ex. You want to add up all Food expenses and the expense catagory for the expense being
    'checked is Car then it won't be added.
'The for loop uses the range with the expense's costs so to know the corresponding catagory
    'the index variable 'i' is used to compare the correct catagory.
For Each expense In rn_Expense

    If StrComp(exp_Name, rn_ExpType.Cells(i, 1)) = 0 Then
        total = total + expense.Value
    End If
    
    i = i + 1
    
Next expense

addExpense = total

End Function
```
