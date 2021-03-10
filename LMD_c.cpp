//
int outGlobal = 0; // ������ ��� �����������, �� ������ MenuItem ������ CD0
//
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void ShowSearchNotFound() // ����� ������������ � SearcExecute,ReplaceExecute,SearchNextExecute
{
 AnsiString s = F1->LMD_EV0->SearchLastArgs.Search; // ����� ������ ���������� ������
 MessageDlg( Format("������ ������ '%s' �� �������...",
             ARRAYOFCONST(( s )) ), mtInformation, TMsgDlgButtons() << mbOK, -1 );
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::SearcInScriptText(TObject *Sender)
{ // ����� � ������ �������
 if ( LMDEditExecFindDialog("����� � ������ ������� Lua", LMD_EV0, FSearchOptions) == srNotFound )
  ShowSearchNotFound();
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::ReplaceInScriptText(TObject *Sender)
{ // �������� � ������ �������
 if (LMD_EV0->SelAvail)
   FSearchOptions.ReplaceAllBounds = rbSelection;
 else
   FSearchOptions.ReplaceAllBounds = rbAllText;

 TLMDEditSearchResult Res =
  LMDEditExecReplaceDialog("������ � ������ ������� Lua", LMD_EV0, FSearchOptions);

 if (Res == srNotFound)
 {
  ShowSearchNotFound();
 }
 else if (( Res == srFound )                     &&
          ( FSearchOptions.WasReplaceAllChosen ) &&
          ( FSearchOptions.LastNumberOfReplacements > 0 ) )
 {
  MessageDlg(Format("����� �����: %d",
             ARRAYOFCONST(( FSearchOptions.LastNumberOfReplacements ))),
             mtInformation, TMsgDlgButtons() << mbOK, -1);
 }
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::FinfReplaceRepeat(TObject *Sender)
{ // ����� ��� �������� � ������ �������
 bool Ok = true;

 switch ( LMD_EV0->SearchState ) // ����� ����� - ����� ��� ������ ?
 {
  case stInSearch: // ����� ������ (Ctrl+F)
       Ok = LMD_EV0->SearchNext();
       break;
  case stInReplace: // ����� ������ (Ctrl+R)
       Ok = LMD_EV0->ReplaceNext();
       break;
  default:
       Beep();
 }

 if ( !Ok )
  ShowSearchNotFound();

} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::PrintExecute(TObject *Sender)
{ // �������� ���� Print
 PrintTask->View = LMD_EV0; // �������� �� EditView

 PrintTask->PreparePages();

 try
 {
  PrintTask->ExecPrintDlg();
 }
 __finally
 {
  PrintTask->FinalizePages();
 }
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::PrintPreview(TObject *Sender)
{ // �������� PrintPreview
 PrintTask->View = LMD_EV0; // �������� �� EditView

 PrintTask->PreparePages();

 try
 {
  PrintTask->ExecPrintPreviewDlg();
 }
 __finally
 {
  PrintTask->FinalizePages();
 }
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::PageSetupExecute(TObject *Sender)
{ // �������� PageSetup
 Printer->ExecPageSetupDlg();
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::PrinterSetupExecute(TObject *Sender)
{ // �������� PrintSetup
 Printer->ExecPrintSetupDlg();
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::actBreakSetExecute(TObject *Sender)
{ // ���������� ����� �������� (Breakpoint)
 int Ph = LMD_EV0->ScrollToPhysical(LMD_EV0->CursorPos.y); // ������� �� ������ y
 _di_ILMDMark Brk = LMD_EV0->Document->Breakpoints->CreateMarkAtLine(Ph); // �������
//mkBreakDisabled; mkBreakInactive; mkBreakActive;
 LMD_EV0->Document->SetBreakpointKind(Brk, mkBreakActive); // ��������
} // ----- ����� actBreakSetExecute --------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::actBreakDeleteAllExecute(TObject *Sender)
{  // �������� ��� ����� �������� (Breakpoint)
 LMD_EV0->Document->Breakpoints->Clear();
} // ----- ����� actBreakDeleteAllExecute --------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::UndoExecute(TObject *Sender)
{ // ������� Undo
 if( LMD_ED0->CanUndo )
  LMD_ED0->Undo();
 else
  Beep();
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::RedoExecute(TObject *Sender)
{ // ������� Redo
 if( LMD_ED0->CanRedo )
  LMD_ED0->Redo();
 else
  Beep();
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::SelectColors(TObject *Sender)
{ // ����� ������ ���� ��������� Lua
 outGlobal = ((TComponent *)Sender)->Tag; // ����� �� 8 ��������� MenuItem ������ ��� ���������
//
 switch( outGlobal ) // ����� �� �������� outGlobal
 {
  case 1: CD0->Color = LMD_EV0->Gutter->LinesBarBg;
          if( CD0->Execute() )
           LMD_EV0->Gutter->LinesBarBg = CD0->Color;
          break;
  case 2: CD0->Color = LMD_EV0->Gutter->LinesBarTextColor;
          if( CD0->Execute() )
           LMD_EV0->Gutter->LinesBarTextColor = CD0->Color;
          break;
  case 3: CD0->Color = LMD_EV0->Gutter->FoldsBarBg;
          if( CD0->Execute() )
           LMD_EV0->Gutter->FoldsBarBg = CD0->Color;
          break;
  case 4: CD0->Color = LMD_EV0->Gutter->FoldsBarLineColor;
          if( CD0->Execute() )
           LMD_EV0->Gutter->FoldsBarLineColor = CD0->Color;
          break;
  case 5: CD0->Color = LMD_EV0->Gutter->CustomBarBg;
          if( CD0->Execute() )
           LMD_EV0->Gutter->CustomBarBg = CD0->Color;
          break;
  case 6: CD0->Color = LMD_EV0->SelectionBg;
          if( CD0->Execute() )
           LMD_EV0->SelectionBg = CD0->Color;
          break;
  case 7: CD0->Color = LMD_EV0->SelectionColor;
          if( CD0->Execute() )
           LMD_EV0->SelectionColor = CD0->Color;
          break;
  case 8: CD0->Color = LMD_EV0->Color;
          if( CD0->Execute() )
           LMD_EV0->Color = CD0->Color;
          break;
  default:Beep();
          break;
 }
//
 Write_Config(); // ��������� ��������� ������
//
} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::CD0_Show(TObject *Sender)
{ // ���������� ��� ��������� ���� ColorDialog
 switch( outGlobal ) // ����� �� �������� outGlobal
 {
  case 1: SetWindowText( CD0->Handle, "������� ���� ���� ������� ��������� �����");
          break;
  case 2: SetWindowText( CD0->Handle, "������� ���� �������� ��������� �����");
          break;
  case 3: SetWindowText( CD0->Handle, "������� ���� ���� ������� ������ ����������");
          break;
  case 4: SetWindowText( CD0->Handle, "������� ���� �������� ������ ����������");
          break;
  case 5: SetWindowText( CD0->Handle, "������� ���� �������-�����������");
          break;
  case 6: SetWindowText( CD0->Handle, "������� ���� ���� ���������� ��������");
          break;
  case 7: SetWindowText( CD0->Handle, "������� ���� ���������� ��������");
          break;
  case 8: SetWindowText( CD0->Handle, "������� ���� ���� ���� ��������������");
          break;
  default:break;
 }

} //----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void __fastcall TF1::ED0_Changed(TLMDEditDocument *Sender,
                                 TLMDDocStatusChanges AChanges)
{ // ????????? ? ????????? ED0
 if( LMD_ED0->CanUndo )
  SB_UndoExecute->Enabled = TRUE;
//  SB_CopyToNotepad->Enabled = TRUE;
 else
  SB_UndoExecute->Enabled = FALSE;
//  SB_CopyToNotepad->Enabled = FALSE;

 if( LMD_ED0->CanRedo )
  SB_RedoExecute->Enabled = TRUE;
 else
  SB_RedoExecute->Enabled = FALSE;

// MessageBeep( MB_OK ); // ???????? ??????????????...

} //----------------------------------------------------------------------------
