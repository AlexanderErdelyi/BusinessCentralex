namespace BusinessCentralex.Core.XLIFF;
table 50003 "XLIFF Translation Mapping"
{
    Caption = 'XLIFF Translation Mapping';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(10; "Translation Source"; Text[20])
        {
            Caption = 'Translation Source';
            //ToDo put into Enum with XLIFF or DEPPL
        }
        field(20; "Source Language Code"; Code[10])
        {
            Caption = 'Source Language Code';
        }
        field(21; "Source Language Text"; Text[2048])
        {
            Caption = 'Source';
        }
        field(30; "Target Language Code"; Code[10])
        {
            Caption = 'Target Language Code';
        }
        field(31; "Target Language Text"; Text[2048])
        {
            Caption = 'Target';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Source Language Code", "Source Language Text", "Target Language Code", "Target Language Text")
        {

        }
    }

    trigger OnInsert()
    begin
        Rec."Entry No." := GetNextEntryNo();
    end;

    local procedure GetNextEntryNo(): Integer
    var
        XLIFFTranslationMapping: Record "XLIFF Translation Mapping";
    begin
        if not XLIFFTranslationMapping.FindLast() then
            exit(1)
        else
            exit(XLIFFTranslationMapping."Entry No." + 1);

    end;
}