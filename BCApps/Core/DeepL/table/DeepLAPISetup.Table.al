namespace BusinessCentralex.Core.DeepLAPIConnector;
table 50150 "DeepL API Setup"
{
    Caption = 'DeepL API Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Config Id"; Code[20])
        {
            Caption = 'Entry No.';
        }
        field(10; "Is Active"; Boolean)
        {
            Caption = 'Is Active';
        }
        field(20; "Base URL"; Text[100])
        {
            Caption = 'Base URL';
            trigger OnValidate()
            begin
                if Rec."Base URL".EndsWith('/') then
                    Rec."Base URL" := Rec."Base URL".Remove(StrLen("Base URL"), 1);
            end;
        }
        field(25; "API Key"; Text[100])
        {
            Caption = 'API Key';
            ExtendedDatatype = Masked;
        }
        field(300; "Character Count"; Integer)
        {
            Caption = 'Character Count';
            Editable = false;
        }
        field(301; "Character Limit"; Integer)
        {
            Caption = 'Character Limit';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Config Id")
        {
            Clustered = true;
        }
    }
}
