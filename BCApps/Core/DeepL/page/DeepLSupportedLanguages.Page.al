namespace BusinessCentralex.Core.DeepLAPIConnector;
page 50151 "DeepL Supported Languages"
{
    ApplicationArea = All;
    Caption = 'DeepL Supported Languages';
    PageType = List;
    SourceTable = "DeepL Supported Language";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("DeepL Language Code"; Rec."DeepL Language Code")
                {
                    ToolTip = 'Specifies the value of the DeepL Language Code field.', Comment = '%';
                }
                field("DeepL Language Name"; Rec."DeepL Language Name")
                {
                    ToolTip = 'Specifies the value of the DeepL Language Name field.', Comment = '%';
                }
                field("BC Language Code"; Rec."BC Language Code")
                {
                    ToolTip = 'Specifies the value of the BC Language Code field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateSupportedLanguages)
            {
                Caption = 'Update Supported Languages';
                Image = UpdateXML;
                ToolTip = 'Executes the Update Supported Languages action.';
                trigger OnAction()
                begin
                    DeepLAPIConnector.UpdateSupportedLanguages();
                end;
            }
        }
    }
    var
        DeepLAPIConnector: Codeunit "DeepL API Connector";
}
