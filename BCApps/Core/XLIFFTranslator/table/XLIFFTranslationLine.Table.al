table 50002 "XLIFF Translation Line"
{
    Caption = 'XLIFF Translation Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Entry No."; Integer)
        {
            Caption = 'Document Entry No.';
        }
        // field(2; "Line No."; Integer)
        // {
        //     Caption = 'Line No.';
        // }
        field(30; "Trans-unit Id"; Text[250])
        {
            Caption = 'Trans-unit Id';
        }
        field(50; Source; Text[2048])
        {
            Caption = 'Source';
        }
        field(51; Target; Text[2048])
        {
            Caption = 'Target';
        }
        field(70; "Object Source"; Text[250])
        {
            Caption = 'Object Source';
        }
    }
    keys
    {
        key(PK; "Document Entry No.", "Trans-unit Id")
        {
            Clustered = true;
        }
    }
}
