namespace BusinessCentralex.Core.Tools;

using System.Reflection;

codeunit 50007 "Progress Dialog Advanced"
{
    trigger OnRun()
    begin
    end;

    var
        ProgressWindow: Dialog;
        WindowStartDateTime, WindowUpdateDateTime : DateTime;
        CurrentRecCount, MaxRecCount : Integer;
        ElapsedTime: Duration;
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
        WindowStartDateTime := CurrentDateTime;
        MaxRecCount := MaxCount;
        CurrentRecCount := 0;
        ProgressWindow.Open(ProgressCustomCountMaxMsg, CustomText, Type, CurrentRecCount, MaxCount);
        WindowUpdateDateTime := CurrentDateTime;
    end;

    procedure UpdateCustomCopyCount()
    begin
        ElapsedTime := CurrentDateTime - WindowStartDateTime;
        CurrentRecCount += 1;
        if CurrentDateTime - WindowUpdateDateTime >= 300 then begin
            WindowUpdateDateTime := CurrentDateTime;
            ProgressWindow.Update(2, CurrentRecCount);
            ProgressWindow.Update(3, ElapsedTime);
            ProgressWindow.Update(4, EstimateRemainingTime(ElapsedTime, (CurrentRecCount / MaxRecCount) * 100));
        end;
    end;
    #endregion

    procedure EstimateRemainingTime(ElapsedTime: Duration; ProgressPercentage: Decimal): Duration
    var
        TotalEstimatedTime: Duration;
        AvgElapsedTime: Duration;
    begin
        if (ProgressPercentage <= 0) or (ProgressPercentage > 100) then
            Error('Progress percentage must be between 0 and 100.');

        // Calculate the total estimated time based on elapsed time and progress percentage
        TotalEstimatedTime := Round(ElapsedTime * (100 / ProgressPercentage), 1000);

        // Calculate the remaining time
        exit(TotalEstimatedTime - ElapsedTime);
    end;

}