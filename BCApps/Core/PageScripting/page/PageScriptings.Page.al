namespace BusinessCentralex.Core.PageScripting;

page 50006 "Page Scriptings"
{
    ApplicationArea = All;
    Caption = 'Page Scriptings';
    PageType = List;
    SourceTable = "Page Scripting";
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
                field(URL; Rec.URL)
                {
                    ToolTip = 'Specifies the value of the URL field.', Comment = '%';
                    ExtendedDatatype = URL;
                }
            }
        }
    }
}
