```
'Author: rac2892
'Date: 12/10/2019

'The code's purpose is to add up expenses based on an assigned catagory.
'Ex. Gas payments would be in the Car catagory*


'The function's inputs are:
'--The expense catagory's name that is being summed
'--The cost of each expense as a single column
'--The catagory of each expense as a single column

'The function's outputs are:
'--The total cost of the chosen expense catagory
'--An error message if:
    '-the lists of the expenses' costs and catagories aren't the same size
    '-the lists are not columns
    '-there is a non-numeric value in the cost list
    '-there is a non-text value in the catagory list

Option Explicit
Function addExpense(expenseName As String, expenseCosts As Range, expenseCatagory As Range) As Variant


Dim total As Double
Dim i As Integer
total = 0#
Dim errormsg As String

errormsg = "Function won't work properly because: "

'Checks if the expenseCosts and expenseCatagory are columns by looking at how many
    'columns are in the selected ranges
'If the lists are not columns the error message is updated and the function jumps
    'down to the end.
If expenseCosts.Columns.Count <> 1 And expenseCatagory.Columns.Count <> 1 Then
    errormsg = errormsg & "Function only works with columns"
    GoTo LastCheck
End If
'Checks if the expenseCosts and expenseCatagory are the same length by comparing
    'how many rows are in the selected ranges
'If the selected list lengths don't match the error message is updated and the
    'function jumps down to the end.
If expenseCosts.Rows.Count <> expenseCatagory.Rows.Count Then
    errormsg = errormsg & "The selected cell ranges are not equal"
    GoTo LastCheck
End If

For i = 1 To expenseCosts.Rows.Count
'If one of the expense's cells in the catagory list has a non-text value and the cell is not empty
    'then the error message is updated and the function jumps down to the end.
    If Not Application.WorksheetFunction.IsText(expenseCatagory.Cells(i, 1).Value) And Not IsEmpty(expenseCatagory.Cells(i, 1).Value) Then
       errormsg = errormsg & "There is a non-text value in the Expense Catagory list"
       GoTo LastCheck
    End If
'If one of the expense's cells in the cost list has a non-numeric value and the cell is not empty
    'then the error message is updated and the function jumps down to the end.
   If Not IsNumeric(expenseCosts.Cells(i, 1).Value) And Not IsEmpty(expenseCosts.Cells(i, 1).Value) Then
       errormsg = errormsg & "There is a non-numeric value in the Expense Cost list"
       GoTo LastCheck
   End If
'If expense that is being evaluated has the same catagory as the one specified by the expenseName variable
    'then the cost of that expense is added to the total
   If StrComp(expenseName, expenseCatagory.Cells(i, 1).Value) = 0 Then
       total = total + expenseCosts.Cells(i, 1)
   End If
    
Next i

'This is where the function jumps to
'If there was no changes to the error message then the total is shown but if there were
    'changes the error message is shown instead
LastCheck:
If StrComp(errormsg, "Function won't work properly because: ") = 0 Then
    addExpense = total
Else
    addExpense = errormsg
End If

End Function
```
