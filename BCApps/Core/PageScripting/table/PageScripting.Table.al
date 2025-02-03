namespace BusinessCentralex.Core.PageScripting;
table 50006 "Page Scripting"
{
    Caption = 'Page Scripting';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(20; URL; Text[2024])
        {
            Caption = 'URL';  //
            ExtendedDatatype = URL;
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
