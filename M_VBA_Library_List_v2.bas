Attribute VB_Name = "M_VBA_Library_List_v2"
Option Explicit

Public Function getListOfRequiredModules() As Dictionary
    Dim dic As New Dictionary

    ' ������ ������
    ' "AB.B.B"
    ' A = ["", "=", ">", "<", ">=", "<="]
    ' B = "*" ���� ���������� ���� ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    ' ��������� ������ ����������� ������������� �������� ��������, ��������� � package.json
    ' ������� ������. ��� ��������� ����� �����������, ���������� ������������ ������
    ' ������, ����������� ��� �������. ��� ������ ����������� �����, ���� �����������
    ' ���������� ��������. ���� ������ �� ������������� ����� �����������, �������� ������
    
    dic.Item("C_Soil_Database") = "1.1.0"
    
    Set getListOfRequiredModules = dic
End Function
