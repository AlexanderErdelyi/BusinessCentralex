namespace BusinessCentralex.Core.XLIFF;

using Microsoft.Utilities;
using BusinessCentralex.Core.XLIFF;
using System.Reflection;

codeunit 50004 "XLIFF Translation Mapping Tool"
{
    procedure UpdateTranslationMappingFromTranslationLine()
    var
        XLIFFTranslationHeader: Record "XLIFF Translation Header";
        XLIFFTranslationLine: Record "XLIFF Translation Line";
        XLIFFTranslationMapping: Record "XLIFF Translation Mapping";
        ProgressDialog: Codeunit "Progress Dialog";
        MaxRecordsToInsert: Integer;
        RecordsInserted: Integer;
    begin
        //MaxRecordsToInsert := 1000;
        RecordsInserted := 0;

        if XLIFFTranslationHeader.FindSet() then
            repeat
                XLIFFTranslationLine.SetRange("Document Entry No.", XLIFFTranslationHeader."Entry No.");
                Message(XLIFFTranslationHeader."File Name" + ' Count: ' + format(XLIFFTranslationLine.Count));
                ProgressDialog.OpenCopyCountMax('Lines', XLIFFTranslationLine.Count());
                if XLIFFTranslationLine.FindSet() then
                    repeat
                        //if MaxRecordsToInsert = RecordsInserted then
                        //    exit;

                        ProgressDialog.UpdateCopyCount();

                        XLIFFTranslationMapping.Reset();
                        XLIFFTranslationMapping.SetRange("Source Language Code", XLIFFTranslationHeader."Source Language Code");
                        XLIFFTranslationMapping.SetRange("Source Language Text", XLIFFTranslationLine."Source Translation");
                        XLIFFTranslationMapping.SetRange("Target Language Code", XLIFFTranslationHeader."Target Language Code");
                        XLIFFTranslationMapping.SetRange("Target Language Text", XLIFFTranslationLine."Target Translation");
                        if XLIFFTranslationMapping.IsEmpty() then begin
                            XLIFFTranslationMapping.Init();
                            XLIFFTranslationMapping."Source Language Code" := XLIFFTranslationHeader."Source Language Code";
                            XLIFFTranslationMapping."Source Language Text" := XLIFFTranslationLine."Source Translation";
                            XLIFFTranslationMapping."Target Language Code" := XLIFFTranslationHeader."Target Language Code";
                            XLIFFTranslationMapping."Target Language Text" := XLIFFTranslationLine."Target Translation";
                            XLIFFTranslationMapping."Source Language Short as Code" := CopyStr(XLIFFTranslationLine."Source Translation", 1, MaxStrLen(XLIFFTranslationMapping."Source Language Short as Code"));
                            XLIFFTranslationMapping.Insert(true);
                            RecordsInserted += 1;
                        end;
                    //if RecordsInserted mod 100 = 0 then
                    //    Commit();
                    until XLIFFTranslationLine.Next() = 0;
            until XLIFFTranslationHeader.Next() = 0;
    end;

    procedure GetSuggestedTranslation(Rec: Record "XLIFF Translation Line")
    var
        XLIFFTranslationSuggestion: Record "XLIFF Translation Suggestion";
        XLIFFTranslationMapping: Record "XLIFF Translation Mapping";
        SuggestedTranslations: List of [Integer];
        SuggestedTranslation: Integer;
        SimilarityList: List of [Decimal];
        Similarity: Decimal;
        LineNo: Integer;
        i: Integer;
    begin
        XLIFFTranslationSuggestion.SetRange("Document Entry No.", Rec."Document Entry No.");
        XLIFFTranslationSuggestion.SetRange("Trans-unit Id", Rec."Trans-unit Id");
        XLIFFTranslationSuggestion.DeleteAll();

        LineNo := 0;
        i := 0;

        SuggestTranslation(Rec."Source Translation", SuggestedTranslations, SimilarityList);

        foreach SuggestedTranslation in SuggestedTranslations do begin
            i += 1;
            XLIFFTranslationMapping.Get(SuggestedTranslation);
            LineNo += 10000;
            XLIFFTranslationSuggestion.Init();
            XLIFFTranslationSuggestion."Document Entry No." := Rec."Document Entry No.";
            XLIFFTranslationSuggestion."Trans-unit Id" := rec."Trans-unit Id";
            XLIFFTranslationSuggestion."Line No." := LineNo;
            XLIFFTranslationSuggestion."Suggested Translation Text" := XLIFFTranslationMapping."Target Language Text";
            XLIFFTranslationSuggestion."Suggested Similarity" := SimilarityList.Get(i);
            XLIFFTranslationSuggestion.Insert(true);

        end;
    end;

    procedure SuggestTranslation(NewText: Text; var XLIFFTranslationMappingList: List of [Integer]; var SimilarityList: List of [Decimal])
    var
        XLIFFTranslationMapping: Record "XLIFF Translation Mapping";
        ProgressDialog: Codeunit "Progress Dialog";
        //Suggestions: List of [Text, Text, Decimal];
        Suggestions: List of [Text];
        Similarity: Decimal;
        Treshold: Integer;
    begin
        // Loop through the translation mappings
        //XLIFFTranslationMapping.SetRange("Source Language Short as Code", CopyStr(NewText.ToUpper(), 1, MaxStrLen(XLIFFTranslationMapping."Source Language Short as Code")));
        //ProgressDialog.OpenCopyCountMax('Mapping', XLIFFTranslationMapping.Count());
        if XLIFFTranslationMapping.FindSet() then
            repeat
                //ProgressDialog.UpdateCopyCount();
                NewText := CopyStr(NewText.ToUpper(), 1, MaxStrLen(XLIFFTranslationMapping."Source Language Short as Code"));
                // Calculate similarity percentage
                //Similarity := CalculateSimilarity(NewText, XLIFFTranslationMapping."Source Language Text");
                Similarity := CalculateSimilarity(NewText, XLIFFTranslationMapping."Source Language Short as Code");

                // Add to suggestions if similarity > threshold (e.g., 50%)
                if Similarity > 50 then begin
                    XLIFFTranslationMappingList.Add(XLIFFTranslationMapping."Entry No.");
                    SimilarityList.Add(Similarity);
                end;
            until XLIFFTranslationMapping.Next() = 0;
    end;

    // Function to calculate similarity percentage
    procedure CalculateSimilarity(Text1: Text; Text2: Text): Decimal
    var
        TypeHelper: Codeunit "Type Helper";
        Len1, Len2 : Integer;
        Distance: Decimal;
        MaxLen: Decimal;
        DistanceFactor: Decimal;
        MinLenDistanceFactor: Decimal;
        Treshold: Decimal;
    begin
        // Example: Levenshtein Distance (can replace with another algorithm)
        Len1 := StrLen(Text1);
        Len2 := StrLen(Text2);
        Distance := TypeHelper.TextDistance(Text1, Text2);

        MaxLen := Len1 >= Len2 ? Len1 : Len2;
        if MaxLen = 0 then
            MaxLen := 1;
        exit((1 - Distance / MaxLen) * 100);
    end;
}
