namespace BusinessCentralex.Core.XLIFF;

page 50005 "XLIFF Trans. Suggestion Setup"
{
    ApplicationArea = All;
    Caption = 'XLIFF Trans. Suggestion Setup';
    PageType = Card;
    SourceTable = "XLIFF Trans. Suggestion Setup";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Trans. Lines Count"; Rec."Trans. Lines Count")
                {
                    ToolTip = 'Specifies the value of the Translation Lines Count field.', Comment = '%';
                }
                field("Trans. Lines Updated Count"; Rec."Trans. Lines Updated Count")
                {
                    ToolTip = 'Specifies the value of the Translation Lines Updated Count field.', Comment = '%';
                }
            }
        }
    }
}
