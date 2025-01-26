namespace BusinessCentralex.Core.DeepLAPIConnector;

using System.Globalization;
table 50151 "DeepL Supported Language"
{
    Caption = 'DeepL Supported Language';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "DeepL Language Code"; Code[3])
        {
            Caption = 'DeepL Language Code';
        }
        field(2; "DeepL Language Name"; Text[50])
        {
            Caption = 'DeepL Language Name';
        }
        field(10; "BC Language Code"; Code[10])
        {
            Caption = 'BC Language Code';
            TableRelation = Language;
        }
    }
    keys
    {
        key(PK; "DeepL Language Code")
        {
            Clustered = true;
        }
    }
}
