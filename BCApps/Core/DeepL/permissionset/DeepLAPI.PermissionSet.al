namespace BusinessCentralex.Core.DeepLAPIConnector;
permissionset 50150 "DeepL API"
{
    Assignable = true;
    Caption = 'DeepL API', MaxLength = 30;
    Permissions =
        table "DeepL API Setup" = X,
        tabledata "DeepL API Setup" = RMID,
        table "DeepL Supported Language" = X,
        tabledata "DeepL Supported Language" = RIMD,
        page "DeepL API Setup" = X,
        page "DeepL Supported Languages" = X,
        page "DeepL Translation Card" = X,
        codeunit "DeepL API Connector" = X;
}
