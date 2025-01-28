namespace BusinessCentralex.Core.XLIFF;

codeunit 50005 "XLIFF Scheduled Trans. Mapping"
{
    trigger OnRun()
    begin
        ExecuteTranslationSuggestion();
    end;

    local procedure ExecuteTranslationSuggestion()
    var
        XLIFFTranslationLine: Record "XLIFF Translation Line";
        XLIFFTransSuggestionSetup: Record "XLIFF Trans. Suggestion Setup";
        XLIFFTranslationMappingTool: Codeunit "XLIFF Translation Mapping Tool";
        Counter: Integer;
    begin
        if not XLIFFTransSuggestionSetup.Get() then begin
            XLIFFTransSuggestionSetup.Init();
            XLIFFTransSuggestionSetup.Insert(true);
        end;

        Counter := 0;
        XLIFFTransSuggestionSetup."Trans. Lines Count" := XLIFFTranslationLine.Count();
        if XLIFFTranslationLine.FindSet() then
            repeat
                if Counter mod 10 = 0 then begin
                    XLIFFTransSuggestionSetup."Trans. Lines Updated Count" := Counter;
                    XLIFFTransSuggestionSetup.Modify();
                    Commit();
                end;

                XLIFFTranslationMappingTool.GetSuggestedTranslation(XLIFFTranslationLine);

                Counter += 1;

            until XLIFFTranslationLine.Next() = 0;
    end;
}
