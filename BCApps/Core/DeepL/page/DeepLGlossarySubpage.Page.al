namespace BusinessCentralex.Core.DeepLAPIConnector;

page 50011 "DeepL Glossary Subpage"
{
    ApplicationArea = All;
    Caption = 'DeepL Glossary Subpage';
    PageType = ListPart;
    SourceTable = "DeepL Glossary Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Source Text"; Rec."Source Text")
                {
                    ToolTip = 'Specifies the value of the Source Text field.', Comment = '%';
                }
                field("Target Text"; Rec."Target Text")
                {
                    ToolTip = 'Specifies the value of the Target Text field.', Comment = '%';
                }
            }
        }
    }
}
