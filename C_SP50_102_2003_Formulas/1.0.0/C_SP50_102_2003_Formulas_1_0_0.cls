VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "C_SP50_102_2003_Formulas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private math As C_Math

Private Sub Class_Initialize()
    Set math = New C_Math
End Sub

Private Sub Class_Terminate()
    Set math = Nothing
End Sub

' ������� �.8
' K [��/�4]
' bp [�]
' E [���]
' I [�4]
Public Function E8(K As Double, bp As Double, E As Double, I As Double) As Double ' [1/�]

    If K = 0 Or bp = 0 Then
      MsgBox "SP50.102.2003 Formulas E.8 - K, and bp shall not be zero"
      Exit Function
    End If

    E8 = (K * bp / E / I) ^ (1 / 5)
End Function

' ������� �.12
' H0 [��]
' M0 [��*�]
' eHH [�/��]
' eHM [1/��*�]
Public Function E12(H0 As Double, M0 As Double, eHH As Double, eHM As Double) ' [�]
    E12 = H0 * eHH + M0 * eHM
End Function

' ������� �.13
' H0 [��]
' M0 [��*�]
' eMH [1/��]
' eMM [1/��*�]
Public Function E13(H0 As Double, M0 As Double, eMH As Double, eMM As Double) ' [���]
    E13 = H0 * eMH + M0 * eMM
End Function

' ������� �.14
' A0 [-]
' alpha_e [1/�]
' E [���]
' I [�4]
Public Function E14(A0 As Double, alpha_e As Double, E As Double, I As Double) As Double ' [�/��]
    E14 = A0/ (alpha_e ^ 3) / E / I
End Function

' ������� �.15
' B0 [-]
' alpha_e [1/�]
' E [���]
' I [�4]
Public Function E15(B0 As Double, alpha_e As Double, E As Double, I As Double) As Double ' [1/��]
    E15 = B0/ (alpha_e ^ 2) / E / I
End Function

' ������� �.16
' C0 [-]
' alpha_e [1/�]
' E [���]
' I [�4]
Public Function E16(C0 As Double, alpha_e As Double, E As Double, I As Double) As Double ' [1/��*�]
    E16 = C0 / alpha_e / E / I
End Function

' ������� �.17
' z [�]
' Y1 [��/�3]
' FI1 [����]
' C1 [���]
Public Function E17( _
        z As Double, _
        nu1 As Double, _ 
        nu2 As Double, _
        psi As Double, _
        Y1 As Double, _
        FI1 As Double, _
        C1 As Double _
    ) As Double ' ���

    Dim radians As Double
    radians = FI1 / 180 * math.pi
    E17 = nu1 * nu2 * 4 / Cos(radians) * (Y1 * z * tan (radians) + psi * C1)
End Function

' ������� �.19
' K [��/�4]
' alpha_e [1/�]
' z [�]
' E [���]
' I [�4]
' U0 [�]
' W0 [���]
' H0 [��]
' M0 [��*�]
' A1 [-]
' B1 [-]
' C1 [-]
' D1 [-]
Public Function E19( _
        K As Double, _
        alpha_e As Double, _ 
        z As Double, _
        E As Double, _
        I As Double, _
        U0 As Double, _
        W0 As Double, _
        M0 As Double, _
        H0 As Double, _
        A1 As Double, _
        B1 As Double, _
        C1 As Double, _
        D1 As Double _
    ) As Double ' ���

    E19 = K * z / alpha_e * (U0 * A1 - W0 * B1 / alpha_e + M0 * C1 / alpha_e ^ 2 / E / I + _ 
            H0 * D1 / alpha_e ^ 3 / E / I)
End Function

' ������� �.19
' H [��]
' L0 [�]
' E [���]
' I [�4]
' eMH [1/��]
' eMM [1/��*�]
Public Function E23( _
        H As Double, _
        L0 As Double, _ 
        E As Double, _
        I As Double, _
        eMH As Double, _
        eMM As Double _
    ) As Double ' ��*�

    E23 = -H * (eMH + L0 * eMM + L0 ^ 2 / 2 / E / I) / (eMM + L0 / E / I)
End Function