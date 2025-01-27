namespace BusinessCentralex.Core.XLIFF;

table 50004 "XLIFF Translation Suggestion"
{
    Caption = 'XLIFF Translation Suggestion';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Entry No."; Integer)
        {
            Caption = 'Document Entry No.';
        }
        field(2; "Trans-unit Id"; Text[250])
        {
            Caption = 'Trans-unit Id';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(20; "Suggested Translation Text"; Text[2048])
        {
            Caption = 'Suggested Translation Text';
        }
        field(30; "Suggested Distance"; Integer)
        {
            Caption = 'Suggested Distance';
        }
        field(31; "Suggested Similarity"; Decimal)
        {
            Caption = 'Suggested Similarity';
        }
    }
    keys
    {
        key(PK; "Document Entry No.", "Trans-unit Id", "Line No.")
        {
            Clustered = true;
        }
    }
}
