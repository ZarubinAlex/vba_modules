VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "C_Borehole"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private pName As String
Private pTopElevation As Double '���������� ������� (�)
Private pWaterDepth As Double ' ������� ���� (�)
Private pLayerDepth() As Double ' ������� ���� ���� ������ (�)
Private pLayerName() As String ' ��� ���� ������ (�)
Private countOfLayers As Integer

Private Sub Class_Initialize() 
    countOfLayers = 0
    pWaterDepth = -1000
End Sub 

' ��� ��������
Property Let nameOfBorehole(word As String)
    pName = word
End Property

Property Get nameOfBorehole() As String
    nameOfBorehole = pName
End Property

' ������� ����� ��������
Property Let topElevation(elevation As Double)
     pTopElevation = elevation
End Property

Property Get topElevation() As Double
    topElevation = pTopElevation
End Property

' ������� ��������� ���
Property Let waterDepth(depth As Double)
     pWaterDepth  = depth
End Property

Property Get waterDepth() As Double
    waterDepth = pWaterDepth
End Property

' ���������� ����
Public Sub addLayer(name As String, bottomOfLayer As Double)

    If bottomOfLayer <=0 Then
        MsgBox "C_Borehole - ��� ���� " & name & " ������ ���� > 0. �������� " & nameOfBorehole, vbOK, "ERROR"
        Exit Sub
    End If

    ReDim Preserve pLayerDepth(countOfLayers)
    ReDim Preserve pLayerName(countOfLayers)
    countOfLayers = countOfLayers + 1

    pLayerDepth(UBound(pLayerDepth)) = bottomOfLayer
    pLayerName(UBound(pLayerName)) = name

End Sub

' �������� ��� ������ �� ������������ �������
Public Property Get getSoilNameAtDepth(depth As Double) As String
    
    If depth >=  pLayerDepth(UBound(pLayerDepth)) Then
        MsgBox "C_Borehole - ��������� ������� ��������. ������� " _
             & nameOfBorehole & " �.�. > " & depth, vbOK, "ERROR"
        Exit Sub
    End If

    Dim i As Integer
    For i = LBound(pLayerDepth) To UBound(pLayerDepth)
        If pLayerDepth(i) > depth Then
            getSoilNameAtDepth = pLayerName(i)
            Exit For
        End If
    Next i
    
End Property

' ���� �� ���� �� ������ �������
Public Property Get isWaterAtDepth(depth As Double) As Boolean
    
    If (depth >= pWaterDepth) Then
        isWaterAtDepth = True
    Else
        isWaterAtDepth = False
    End If
    
End Property

Public Function DeepCopy() As C_Borehole
    Dim other As New C_Borehole

    other.nameOfBorehole = Me.nameOfBorehole
    other.topElevation = Me.topElevation
    other.waterDepth = Me.waterDepth

    If (Not Not pLayerDepth) <> 0 Then ' Array has been initialized, so you're good to go.

        Dim i As Integer
        For i = LBound(pLayerDepth) To UBound(pLayerDepth)
            Call other.addLayer(pLayerName(i), pLayerDepth(i))
        Next i

    End if

    Set DeepCopy = other
End Function