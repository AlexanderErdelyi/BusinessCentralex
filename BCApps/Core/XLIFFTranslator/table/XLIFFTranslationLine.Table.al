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
        field(50; "Source Translation"; Text[2048])
        {
            Caption = 'Source Translation';
        }
        field(51; "Target Translation"; Text[2048])
        {
            Caption = 'Target Translation';
        }
        field(52; "Suggested Translation"; Text[2048])
        {
            Caption = 'Suggested Translation';
        }
        field(70; "Object Source"; Text[250])
        {
            Caption = 'Object Source';
        }
        field(300; "Marked to Filter"; Boolean)
        {
            Caption = 'Marked to filter';
        }
        field(320; "Recent Update"; Boolean)
        {
            Caption = 'Recent Update';
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
