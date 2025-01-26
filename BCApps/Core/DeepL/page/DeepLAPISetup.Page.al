namespace BusinessCentralex.Core.DeepLAPIConnector;
page 50100 "DeepL API Setup"
{
    ApplicationArea = Basic, Suite;
    Caption = 'DeepL API Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "DeepL API Setup";
    ContextSensitiveHelpPage = '/Test';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Is Active"; Rec."Is Active")
                {
                    ToolTip = 'Specifies the value of the Is Active field.', Comment = '%', Locked = true;
                }
                field("Base URL"; Rec."Base URL")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Base URL field.', Comment = '%', Locked = true;
                }
                field("API Key"; Rec."API Key")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the API Key field.', Comment = '%', Locked = true;
                }
                field("Character Count"; Rec."Character Count")
                {
                    ToolTip = 'Specifies the value of the Character Count field.', Comment = '%';
                }
                field("Character Limit"; Rec."Character Limit")
                {
                    ToolTip = 'Specifies the value of the Character Limit field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CheckConnection)
            {
                Caption = 'Check Connection';
                Image = LaunchWeb;
                ToolTip = 'Executes the Check Connection action.';
                trigger OnAction()
                begin
                    DeepLAPIConnector.TestConnection();
                end;
            }
            action(UpdateUsage)
            {
                Caption = 'Update Usage';
                Image = UpdateXML;
                ToolTip = 'Executes the Update Usage action.';
                trigger OnAction()
                begin
                    DeepLAPIConnector.UpdateUsage();
                end;
            }
            action(OpenSupportedLanguages)
            {
                Caption = 'Open Supported Languages';
                Image = LaunchWeb;
                ToolTip = 'Executes the Open Supported Languages action.';
                RunObject = Page "DeepL Supported Languages";
            }

        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Base URL" := 'https://api-free.deepl.com/v2';
            Rec.Insert();
        end;
    end;

    var
        DeepLAPIConnector: Codeunit "DeepL API Connector";
}
