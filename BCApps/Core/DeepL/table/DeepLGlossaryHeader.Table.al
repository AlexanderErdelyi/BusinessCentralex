namespace BusinessCentralex.Core.DeepLAPIConnector;
table 50008 "DeepL Glossary Header"
{
    Caption = 'DeepL Glossary Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[30])
        {
            Caption = 'Document No.';
        }
        field(10; "Glossary Id"; Guid)
        {
            Caption = 'Glossary Id';
        }
        field(11; Ready; Boolean)
        {
            Caption = 'Ready';
        }
        field(20; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(21; "Source Language Code"; Code[10])
        {
            Caption = 'Source Language Code';
            TableRelation = "DeepL Supported Language";
        }
        field(22; "Target Language Code"; Code[10])
        {
            Caption = 'Target Language Code';
            TableRelation = "DeepL Supported Language";
        }
        field(30; "Creation Time"; DateTime)
        {
            Caption = 'Creation Time';
        }
        field(40; "Entry Count"; Integer)
        {
            Caption = 'Entry Count';
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
