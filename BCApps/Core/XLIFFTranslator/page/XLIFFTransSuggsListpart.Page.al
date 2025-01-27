namespace BusinessCentralex.Core.XLIFF;
page 50004 "XLIFF Trans. Suggs. Listpart"
{
    ApplicationArea = All;
    Caption = 'XLIFF Trans. Suggs. Listpart';
    PageType = ListPart;
    SourceTable = "XLIFF Translation Suggestion";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Suggested Translation Text"; Rec."Suggested Translation Text")
                {
                    ToolTip = 'Specifies the value of the Suggested Translation Text field.', Comment = '%';
                }
                field("Suggested Distance"; Rec."Suggested Distance")
                {
                    ToolTip = 'Specifies the value of the Suggested Distance field.', Comment = '%';
                }
                field("Suggested Similarity"; Rec."Suggested Similarity")
                {
                    ToolTip = 'Specifies the value of the Suggested Similarity field.', Comment = '%';
                }
            }
        }
    }
}
