namespace BusinessCentralex.Core.Sample;

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
        }
    }

    var
        ProgressDialogAdvanced: Codeunit "Progress Dialog Advanced";
}
