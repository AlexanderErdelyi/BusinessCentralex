namespace BusinessCentralex.Core.XLIFF;
table 50001 "XLIFF Translation Header"
{
    Caption = 'XLIFF Translation';
    DataClassification = ToBeClassified;
    DrillDownPageId = "XLIFF Translations";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(10; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(20; Content; Media)
        {
            Caption = 'Content';
        }
        field(30; "Is Global Translation"; Boolean)
        {
            Caption = 'Is Global Translation';
        }
        field(40; "Source Language Code"; Code[10])
        {
            Caption = 'Source Language Code';
        }
        field(41; "Target Language Code"; Code[10])
        {
            Caption = 'Target Language Code';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
