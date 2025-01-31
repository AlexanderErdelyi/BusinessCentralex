namespace BusinessCentralex.Core.Tools;

codeunit 50007 "Progress Dialog"
{
    trigger OnRun()
    begin
    end;

    var
        ProgressWindow: Dialog;
        WindowUpdateDateTime: DateTime;
        CurrentRecCount: Integer;
        ProgressCopyCountMaxMsg: Label 'Copying #1###### #2###### out of #3#######', Comment = '#1######=Type of object copied; #2######=amount copied;#3#######=total amount to copy';
        ProgressCustomCountMaxMsg: Label '#1################## #2################## #3################## out of #4##################', Comment = '#1######=Type of object copied; #2######=amount copied;#3#######=total amount to copy';
        ProgressCopyCountMsg: Label 'Copying #1###### #2######', Comment = '#1######=Type of object copied; #2######=amount copied';

    #region CopyCount
    procedure OpenCopyCountMax(Type: Text; MaxCount: Integer)
    begin
        CurrentRecCount := 0;
        ProgressWindow.Open(ProgressCopyCountMaxMsg, Type, CurrentRecCount, MaxCount);
        WindowUpdateDateTime := CurrentDateTime;
    end;

    procedure OpenCopyCount(Type: Text)
    begin
        CurrentRecCount := 0;
        ProgressWindow.Open(ProgressCopyCountMsg, Type, CurrentRecCount);
        WindowUpdateDateTime := CurrentDateTime;
    end;

    procedure UpdateCopyCount()
    begin
        CurrentRecCount += 1;
        if CurrentDateTime - WindowUpdateDateTime >= 300 then begin
            WindowUpdateDateTime := CurrentDateTime;
            ProgressWindow.Update(2, CurrentRecCount);
        end;
    end;
    #endregion

    #region Custom Dialog
    procedure OpenCustomCountMax(CustomText: Text; Type: Text; MaxCount: Integer)
    begin
        CurrentRecCount := 0;
        ProgressWindow.Open(ProgressCustomCountMaxMsg, CustomText, Type, CurrentRecCount, MaxCount);
        WindowUpdateDateTime := CurrentDateTime;
    end;
    #endregion
}