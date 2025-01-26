namespace BusinessCentralex.Core.DeepLAPIConnector;

using System.Globalization;
page 50152 "DeepL Translation Card"
{
    ApplicationArea = All;
    Caption = 'DeepL Translation Card';
    PageType = Card;
    UsageCategory = Tasks;
    SaveValues = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(SourceLanguageCode; SourceLanguageCode)
                {
                    Caption = 'Source Language Code';
                    TableRelation = Language;
                    ToolTip = 'Specifies the value of the Source Language Code field.', Locked = true;

                }
                field(TargetLanguageCode; TargetLanguageCode)
                {
                    Caption = 'Target Language Code';
                    TableRelation = Language;
                    ToolTip = 'Specifies the value of the Target Language Code field.', Locked = true;
                }
            }
            group(Translation)
            {
                Caption = 'Translation';
                field(TextToTranslate; TextToTranslate)
                {
                    Caption = 'Text to Translate';
                    ToolTip = 'Specifies the value of the Text to Translate field.', Locked = true;
                    MultiLine = true;
                }
                field(TranslatedText; TranslatedText)
                {
                    Caption = 'Translated Text';
                    ToolTip = 'Specifies the value of the Translated Text field.', Locked = true;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TranslateText)
            {
                Caption = 'Translate Text';
                Image = Translate;
                ToolTip = 'Executes the Translate Text action.';
                trigger OnAction()
                begin
                    TranslatedText := DeepLAPIConnector.Translate(SourceLanguageCode, TargetLanguageCode, TextToTranslate);
                end;
            }
        }
    }
    var
        DeepLAPIConnector: Codeunit "DeepL API Connector";
        SourceLanguageCode, TargetLanguageCode : Code[10];
        TextToTranslate, TranslatedText : Text;
}
