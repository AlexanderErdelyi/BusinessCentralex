namespace BusinessCentralex.Core.DeepLAPIConnector;
table 50009 "DeepL Glossary Line"
{
    Caption = 'DeepL Glossary Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[30])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; "Source Text"; Text[250])
        {
            Caption = 'Source Text';
        }
        field(11; "Target Text"; Text[250])
        {
            Caption = 'Target Text';
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
}
