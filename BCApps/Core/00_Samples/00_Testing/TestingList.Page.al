namespace BusinessCentralex.Core.Sample;

using BusinessCentralex.Core.Sample;
using BusinessCentralex.Core.Tools;
page 50007 "Testing List"
{
    ApplicationArea = All;
    Caption = 'Testing List';
    PageType = List;
    SourceTable = "Testing Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
            group(Test)
            {
                usercontrol(ProgressBarControl; "ProgressBarControlAddin")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(TestProgressDialogAction)
            {
                Caption = 'Test Progress Dialog Action';
                Image = TestFile;
                ToolTip = 'Executes the Test Progress Dialog Action action.';
                trigger OnAction()
                var
                    i: Integer;
                begin
                    ProgressDialogAdvanced.OpenCustomCountMax('Loop Integer', 'Record', 10);
                    for i := 1 to 10 do begin
                        Sleep(1000);
                        ProgressDialogAdvanced.UpdateCustomCopyCount();
                    end;
                end;
            }
            action(ShowProgress)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    i: Integer;
                begin
                    for i := 1 to 100 do begin
                        CurrPage.ProgressBarControl.UpdateProgress(i);
                        Sleep(100); // Simulate task
                    end;
                end;
            }
            action(ChangeFieldValueAction)
            {
                trigger OnAction()
                begin
                    ChangeFieldValue();
                end;
            }
        }
    }

    var
        ProgressDialogAdvanced: Codeunit "Progress Dialog Advanced";

    local procedure ChangeFieldValue()
    var
        TestingHeader: Record "Testing Header";
        InputPage: Page "Input Page";
        ChangeDocuwareDocumentNoLbl: Label 'Change Docuware Document No.';
        ChangeQst: Label 'Are you sure you want to change the %1 to %2 for the selected %3?', Comment = '%1=DW Doc. No Field Caption, %2=DW Doc. No Value, %3=Page Caption';
        DWDocNo: Code[20];
    begin
        InputPage.Caption(ChangeDocuwareDocumentNoLbl);
        InputPage.SetGetFieldCaption(Rec.FieldCaption(Description));
        InputPage.LookupMode(true);
        if InputPage.RunModal() = Action::LookupOK then
            DWDocNo := InputPage.GetValueAsCode()
        else
            exit;

        if not Confirm(ChangeQst, true,
            Rec.FieldCaption(Description),
            DWDocNo,
            CurrPage.Caption())
        then
            exit;

        CurrPage.SetSelectionFilter(TestingHeader);
        if TestingHeader.FindSet(true) then
            repeat
                TestingHeader.Validate(Description, DWDocNo);
                TestingHeader.Modify(true);
            until TestingHeader.Next() = 0;
    end;
}
