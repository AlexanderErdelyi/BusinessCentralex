namespace BusinessCentralex.Core.XLIFF;

using BusinessCentralex.Core.XLIFF;

page 50003 "XLIFF Translation Mappings"
{
    ApplicationArea = All;
    Caption = 'XLIFF Translation Mappings';
    PageType = List;
    SourceTable = "XLIFF Translation Mapping";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Source Language Code"; Rec."Source Language Code")
                {
                    ToolTip = 'Specifies the value of the Source Language Code field.', Comment = '%';
                }
                field("Source Language Text"; Rec."Source Language Text")
                {
                    ToolTip = 'Specifies the value of the Source field.', Comment = '%';
                }
                field("Target Language Code"; Rec."Target Language Code")
                {
                    ToolTip = 'Specifies the value of the Target Language Code field.', Comment = '%';
                }
                field("Target Language Text"; Rec."Target Language Text")
                {
                    ToolTip = 'Specifies the value of the Target field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetSuggestion)
            {
                trigger OnAction()
                var
                    XLIFFSuggestTranslationTool: Codeunit "XLIFF Suggest Translation Tool";
                    Suggestions: List of [Text];
                    Suggestion: Text;
                begin
                    Suggestions := XLIFFSuggestTranslationTool.SuggestTranslation('Description 2');

                    foreach Suggestion in Suggestions do
                        Message(Suggestion);
                end;
            }

            action(FillMappingFromTranslationLines)
            {
                trigger OnAction()
                var
                    XLIFFTranslationMappingTool: Codeunit "XLIFF Translation Mapping Tool";
                begin
                    XLIFFTranslationMappingTool.UpdateTranslationMappingFromTranslationLine();
                end;
            }
        }
    }
}
