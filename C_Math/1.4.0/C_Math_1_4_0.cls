VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "C_Math"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

CONST VERSION = "1.4.0"

Function pi() As Double
    pi = 3.14159265358979
End Function

' ���������� ��� ����� Double
Public Function isEqualDoubles(a As Double, b As Double, Optional tolerance As Double = 0.00001 ) As Boolean
    isEqualDoubles = True
    If Abs(a-b) > tolerance Then isEqualDoubles = False
End Function

' ������������ �� ���� ���������� ������������� �������� ���������� �����
' valueArray - ������ � ��������� ����������, ������������� �� �����������
' value - ��������, ��� ������� ���������� �����
' resultArray - ������ ��������
Function interpolateOneDimensionalArray(value, valueArray, resultArray) As Variant
    Dim k As Long
    
    If IsArray(valueArray) And IsArray(resultArray) Then
    
        interpolateOneDimensionalArray = resultArray(UBound(resultArray))
        
        For k = LBound(valueArray) To UBound(valueArray)
            If (valueArray(k) >= value) Then
            
                If k = LBound(valueArray) Then
                    interpolateOneDimensionalArray = resultArray(LBound(resultArray))
                Else
                    interpolateOneDimensionalArray = resultArray(k - 1) + _
                        (value - valueArray(k - 1)) / (valueArray(k) - valueArray(k - 1)) * (resultArray(k) - resultArray(k - 1))
                End If
                
                Exit For
            End If
        Next k
    
    End If
    
End Function

' ���������� ������� ��������, �������� �������� >= value
' valueArray - ������ � ��������� ����������, ������������� �� �����������
' value - ��������, ��� ������� ���������� �����
Function findIdexOfFirstElementNotLessThan(value, sortedArray) As Integer
    
    If Not IsArray(sortedArray) Then Exit Function
    
    Dim k As Long
    For k = LBound(sortedArray) To UBound(sortedArray)
        If (sortedArray(k) >= value) Then
            findIdexOfFirstElementNotLessThan = k
            Exit Function
        End If
    Next k
    
End Function

' ���������� ������� ��������, �������� �������� = value
' valueArray - ������ � ��������� ����������
' value - ������� ��������
Function findIdexOfValueInArray(value, arr) As Long
    
    If Not IsArray(arr) Then Exit Function
    
    Dim k As Long
    For k = LBound(arr) To UBound(arr)
        If (arr(k) = value) Then
            findIdexOfValueInArray = k
            Exit Function
        End If
    Next k

    findIdexOfValueInArray = -1
    
End Function

' ���������� ����� �� ��� ������� ���� �����
Public Function isArraysSame(array1, array2, Optional tolerance As Double = 0.00001) As Boolean
    isArraysSame = True

    Dim isDouble As Boolean: isDouble = False
    Dim isString As Boolean: isString = False

    if (TypeName(array1(LBound(array1))) = "Double") Or (TypeName(array1(LBound(array1))) = "Decimal") Or _
        (TypeName(array2(LBound(array2))) = "Double") Or (TypeName(array2(LBound(array2))) = "Decimal") Then
            isDouble = True
    End if

    if TypeName(array1(LBound(array1))) = "String" Or TypeName(array2(LBound(array2))) = "String"  Then
        isString = True
    End if

    Dim i As Integer
    Dim isOk as Boolean : isOk = True
    For i = LBound(array1) to UBound(array1)

        Select Case isDouble
            Case True
                If Abs(array1(i) - array2(i)) > tolerance Then isOk = False
            Case False

                Select Case isString
                    Case True
                        If StrComp(array1(i), array2(i)) <> 0 Then isOk = False
                    Case False
                        If array1(i) <> array2(i) Then isOk = False
                End Select

        End Select

        If isOk = False Then
            isArraysSame = False
            Exit Function
        End If
    Next i

End Function

' ��������� ������������
' key1, key2 - ����� � �������� keyArray1, keyArray2
' keyArray1, keyArray2 - ���������� ������ ������, ������������� �� �����������
' valueArray - ��������� ������ �������
' Size(keyArray1, 0) = Size(valueArray, 0)
' Size(keyArray2, 0) = Size(valueArray, 1)
Function interpolateTwoDimensionalArray(key1, key2, keyArray1, keyArray2, valueArray) As Variant
    Dim i As Long
    Dim newArray
    ' Dim lengthOfNewArray As Long : lengthOfNewArray = 0
    
    If IsArray(keyArray1) And IsArray(keyArray2) And IsArray(valueArray) Then

        ReDim newArray(LBound(keyArray1) To UBound(keyArray1))

        For i = LBound(keyArray1) To UBound(keyArray1)
            newArray(i) = interpolateOneDimensionalArray(key2, keyArray2, valueArray(i))
        Next i

        interpolateTwoDimensionalArray = interpolateOneDimensionalArray(key1, keyArray1, newArray)
    
    End If
    
End Function

' ������� ������ ����� �� min �� max � ����� pitch
Function makeArrayWithStep(min As Long, max As Long, pitch As Long) As Long()
    Dim result() As Long
    Dim lengthOfArray As Long
    lengthOfArray = 0

    Dim i As Long
    For i = min To max Step pitch
        Redim Preserve result(lengthOfArray)
        result(UBound(result)) = i
        lengthOfArray = lengthOfArray + 1
    Next i

    makeArrayWithStep = result
End Function

Function mergeTwoArrays(array1, array2) As Variant
    Dim result : result = array1
    Redim Preserve result (LBound(array1) To (UBound(result) + UBound(array2) - LBound(array2) + 1))

    Dim i As Long
    Dim k As Long
    k = LBound(array2)
    For i = UBound(array1) + 1 To Ubound(result)
        result(i) = array2(k)
        k = k + 1
    Next i

    mergeTwoArrays = result
End Function

Function max(a As Double, b As Double) As Double
    If (a > b) Then
        max = a
    Else
        max = b
    End If
End Function

Function min(a As Double, b As Double) As Double
    If (a < b) Then
        min = a
    Else
        min = b
    End If
End Function

'Decimal To Binary
' =================

' NOTE: You can limit the size of the returned
'              answer by specifying the number of bits
' Work only with POSITIVE numbers
Function dec2bin(ByVal DecimalIn As Variant, _
              Optional NumberOfBits As Variant) As String
    dec2bin = ""
    DecimalIn = Int(CDec(DecimalIn))

    If DecimalIn = 0 Or DecimalIn = -0 Then
        dec2bin = "0"
        GoTO Handler
    End If

    Do While DecimalIn <> 0
        dec2bin = Format$(DecimalIn - 2 * Int(DecimalIn / 2)) & dec2bin
        DecimalIn = Int(DecimalIn / 2)
    Loop

Handler:

    If Not IsMissing(NumberOfBits) Then
       If Len(dec2bin) > NumberOfBits Then
          dec2bin = "Error - Number exceeds specified bit size"
       Else
          dec2bin = Right$(String$(NumberOfBits, "0") & dec2bin, NumberOfBits)
       End If
    End If
End Function
 
'Binary To Decimal
' =================
Function bin2dec(BinaryString As String) As Variant
    Dim X As Integer
    For X = 0 To Len(BinaryString) - 1
        bin2dec = CDec(bin2dec) + Val(Mid(BinaryString, _
                  Len(BinaryString) - X, 1)) * 2 ^ X
    Next
End Function

' �� �������������� !!!
Public Function hex2ascii(st As String) As String
    Dim com As String
    Dim x As Long
    Dim k As String

    For x = 1 To Len(st) - 1 Step 2
        k = Mid(st, x, 2)
        com = com & ChrW(CInt("&H" & k))
    Next

    hex2ascii = com
End Function

' Function decodes 8 bytes string into Double number
Function bytes2double(bytes As String, MNO As Double, STEP As Integer) As Double

    Dim i As Integer

    ' �������������� ������
    Dim number As String
    number = StrReverse(bytes)

    ' ������� ������ � �������� �������
    Dim mas(1 To 8) As String
    For i = 1 To 8
        mas(i) = dec2bin(Asc(Mid(number, i, 1)), 8)
    Next i

    ' C������ 64 ������ ������
    Dim s As String
    s = Join(mas, "")

    ' ��������� �� ���� �����, ���������� � ��������
    Dim znak As String
    Dim exponent As String
    Dim mant As String
    znak = Mid(s, 1, 1)
    exponent = Mid(s, 2, 11)
    mant = Mid(s, 13, 52)

    ' ������� ���������
    Dim a As Double, b As Double, c As Double
    a = (-1) ^ bin2dec(znak)
    b = 2 ^ (bin2dec(exponent) - STEP - 1023)
    c = 1 + bin2dec(mant) / (2 ^ 52)

    ' ������� ���������
     bytes2double = a * b * c * MNO

End Function
