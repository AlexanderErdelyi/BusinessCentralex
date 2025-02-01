table 50000 "FMD Regex"
{
    Caption = 'FMD Regex';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(10; "Regex Input"; Text[1024])
        {
            Caption = 'Regex Input';
        }
        field(11; "Regex Pattern"; Text[1024])
        {
            Caption = 'Regex Pattern';
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
