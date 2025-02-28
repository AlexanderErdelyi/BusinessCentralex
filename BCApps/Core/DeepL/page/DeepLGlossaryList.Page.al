namespace BusinessCentralex.Core.DeepLAPIConnector;

page 50009 "DeepL Glossary List"
{
    ApplicationArea = All;
    Caption = 'DeepL Glossary List';
    PageType = List;
    SourceTable = "DeepL Glossary Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Source Language Code"; Rec."Source Language Code")
                {
                    ToolTip = 'Specifies the value of the Source Language Code field.', Comment = '%';
                }
                field("Target Language Code"; Rec."Target Language Code")
                {
                    ToolTip = 'Specifies the value of the Target Language Code field.', Comment = '%';
                }
                field(Ready; Rec.Ready)
                {
                    ToolTip = 'Specifies the value of the Ready field.', Comment = '%';
                }
                field("Entry Count"; Rec."Entry Count")
                {
                    ToolTip = 'Specifies the value of the Entry Count field.', Comment = '%';
                }
            }
        }
    }
}
