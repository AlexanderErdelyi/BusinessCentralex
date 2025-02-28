namespace BusinessCentralex.Core.DeepLAPIConnector;

page 50010 "DeepL Glossary Card"
{
    ApplicationArea = All;
    Caption = 'DeepL Glossary Card';
    PageType = Card;
    SourceTable = "DeepL Glossary Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Glossary Id"; Rec."Glossary Id")
                {
                    ToolTip = 'Specifies the value of the Glossary Id field.', Comment = '%';
                }
                field(Ready; Rec.Ready)
                {
                    ToolTip = 'Specifies the value of the Ready field.', Comment = '%';
                }
                field("Creation Time"; Rec."Creation Time")
                {
                    ToolTip = 'Specifies the value of the Creation Time field.', Comment = '%';
                }
            }
        }
    }
}
