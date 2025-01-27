namespace BusinessCentralex.Core.XLIFF;

using System.Reflection;

codeunit 50003 "XLIFF Suggest Translation Tool"
{
    //procedure SuggestTranslations(NewText: Text): List of [Text, Text, Decimal]
    procedure SuggestTranslation(NewText: Text): List of [Text]
    var
        TranslationRec: Record "XLIFF Translation Mapping";
        //Suggestions: List of [Text, Text, Decimal];
        Suggestions: List of [Text];
        Similarity: Decimal;
        Treshold: Integer;
    begin
        // Loop through the translation mappings
        if TranslationRec.FindSet() then
            repeat
                // Calculate similarity percentage
                Similarity := CalculateSimilarity(NewText, TranslationRec."Source Language Text");
                Similarity := CalculateWeightShortenedSimilarity(NewText, TranslationRec."Source Language Text");
                Similarity := CalculateSimpleSimilarity(NewText, TranslationRec."Source Language Text");
                Similarity := CalculateTresholdSimilarity(NewText, TranslationRec."Source Language Text");


                // Add to suggestions if similarity > threshold (e.g., 50%)
                if Similarity > 50 then
                    Suggestions.Add(TranslationRec."Source Language Text");
            until TranslationRec.Next() = 0;

        // Return suggestions
        exit(Suggestions);
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
        exit((1 - Distance / MaxLen) * 100);
    end;

    procedure CalculateWeightShortenedSimilarity(Text1: Text; Text2: Text): Decimal
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


        exit(((Len1 + Len2 - Distance) / (Len1 + Len2)) * 100);
    end;

    procedure CalculateSimpleSimilarity(Text1: Text; Text2: Text): Decimal
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

        exit((1 - (Distance / MaxLen)) * 100);
    end;

    procedure CalculateTresholdSimilarity(Text1: Text; Text2: Text): Decimal
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
        Treshold := StrLen(Text1) div (Abs(Distance - MaxLen));

        if Abs(Len1 - Len2) <= Treshold then
            exit(CalculateWeightShortenedSimilarity(Text1, Text2))
        else
            exit(CalculateSimpleSimilarity(Text1, Text2));
    end;

}
