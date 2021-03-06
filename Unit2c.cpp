//---------------------------------------------------------------------------
//
#include <vcl.h>
#include "stdio.h"
//
#include <Clipbrd.hpp>
#include <IniFiles.hpp>
#include <SysUtils.hpp> // ��� DeleteFile
#include <io.h> // ��� chmod
#include <dos.h> // FA_RDONLY + sleep
#include <share.h> // SH_COMPAT
//
#pragma hdrstop
//
#include "Unit2c.h"
#include "Unit1c.h" // ����� ��� ������ � F1 (����� ������ � Lua)
//
//------------------------------------------------------------------------------
//
#pragma package(smart_init)
#pragma resource "*.dfm"
TF2 *F2;
//
////////////////////////////////////////////////////////////////////////////////
extern const int minW_F2=850, minH_F2=600; // ����������� ������ �������� ����� F2
////////////////////////////////////////////////////////////////////////////////
extern char FileNameEdges[]; // ��� ����� ���
////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
__fastcall TF2::TF2(TComponent* Owner): TForm(Owner)
{
 F2->Position = poDefault; // ����� �� ������ ����������������...
/*
 SetWindowLong(Handle, GWL_STYLE, // ������� ���� ��� ���������
               GetWindowLong( Handle, GWL_STYLE ) && (! WS_CAPTION));
 ClientHeight=Height;
*/
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF2::M1_PM_ClearAll(TObject *Sender)
{ // �������� M1
 M1->Clear(); // ��������� �������� M1 (TMemo)
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF2::M1_PM_CopyAll(TObject *Sender)
{ // ���������� � Clipboard �� �� M1 (TMemo)
// Clipboard->AsText = M1->Text.
 M1->SelectAll(); // �������� ���� ����� � M1
 M1->CopyToClipboard(); // ���������� �� �� M1 � Clipboard
 M1->SelLength = 0; // ����� ���������
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF2::M1_PM_CopyToNotepad(TObject *Sender)
{ // ���������� � NotePad �� �� M1 (TMemo)
 char FileName[256];
 strcpy( FileName, ChangeFileExt( FileNameEdges, ".txt" ).c_str()); // ��� ������ + "txt"
 M1->Lines->SaveToFile( FileName ); // ������ ��� ������ �� M1 � ���� FileName
 ShellExecute( Handle, "open", FileName, NULL, NULL, SW_RESTORE ); // ������� ���� FileName
//
 sleep( 1 ); // #include <dos.h>
//
 DeleteFile( FileName ); // ���������� (���������) ����
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF2::CopyPictureToClipboard(TObject *Sender)
{ // �������� �������� � Clipboard
//
 try
 {
  Clipboard()->Assign(IM1->Picture); // ���������� ��� � Clipboard
// IM1->Picture->SaveToFile("pict_01.bmp"); // ��������� � ����
  MessageBeep(MB_OK); // it's OK...
 }
 catch(...)
 {
  MessageBeep(MB_ICONEXCLAMATION); // it's no OK...
 }
//
} //---- ����� CopyPictureToClipboard ------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF2::OnResize_F2(TObject *Sender)
{ // ���������� ��� ��������� �������� F2
 int W = F2->Width, // ����� ������� ������ �������� ���� ���������
     H = F2->Height;
// MessageBeep(MB_OK);

 if( W < minW_F2 ) // ���� �� ����� ���� ����� minW_F2 * minH_F2
  W = minW_F2;

 if( H < minH_F2 ) // ...
  H = minH_F2;

// ������ ����� ���������� ������� �������� ���� � ���� �������

 F2->Width  = W; // ����� ������ ���� ���������
 F2->Height = H;

// ���������� ���������� ���� F2

 PN1->Left   = F2->Width  - PN1->Width - 20 ; // ������-��������� ������������ ������
 PN1->Height = F2->Height - PN1->Top   - 102 ;

 M1->Width  = PN1->Left - M1->Left - 3; // ���� ���������� ������ (����� ������)
 M1->Height = PN1->Height; // ������ �������  ���������� � PN1

 L_GP->Top   = F2->Height - 99; // ����� ����� �����
 L_GP->Width = IM_Logo->Left - L_GP->Left - 5 ; // ������ ����� ������

 L_OM->Left = PN1->Left ; // ����� ������ c�����

 IM_Logo->Left = PN1->Left + PN1->Width - IM_Logo->Width ;  // ������� - ��������������
 IM_Logo->Top  = PN1->Top  + PN1->Height + 3 ;

} //----------------------------------------------------------------------------








