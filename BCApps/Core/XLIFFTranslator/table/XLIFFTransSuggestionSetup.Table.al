table 50005 "XLIFF Trans. Suggestion Setup"
{
    Caption = 'XLIFF Trans. Suggestion Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(10; "Trans. Lines Count"; Integer)
        {
            Caption = 'Translation Lines Count';
        }
        field(11; "Trans. Lines Updated Count"; Integer)
        {
            Caption = 'Translation Lines Updated Count';
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
