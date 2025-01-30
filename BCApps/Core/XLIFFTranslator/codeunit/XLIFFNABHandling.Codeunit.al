namespace BusinessCentralex.Core.XLIFF;

codeunit 50006 "XLIFF NAB Handling"
{
    procedure RemoveNABReview(var XLIFFTranslationLine: Record "XLIFF Translation Line")
    begin
        XLIFFTranslationLine."Suggested Translation" := RemoveNAB(XLIFFTranslationLine."Target Translation", '[NAB: REVIEW]');
        XLIFFTranslationLine.Modify();
    end;

    procedure RemoveNABSuggestion(var XLIFFTranslationLine: Record "XLIFF Translation Line")
    begin
        XLIFFTranslationLine."Suggested Translation" := RemoveNAB(XLIFFTranslationLine."Target Translation", '[NAB: SUGGESTION]');
        XLIFFTranslationLine.Modify();
    end;

    local procedure RemoveNAB(TargetTranslation: Text; NABParameter: Text): Text
    var
        LastIndexOfNABParameter: Integer;
    begin
        if not TargetTranslation.Contains(NABParameter) then
            Error('%1 does not contain %2!', TargetTranslation, NABParameter);
        LastIndexOfNABParameter := StrLen(NABParameter);
        exit(TargetTranslation.Remove(1, LastIndexOfNABParameter));
    end;
}
