namespace BusinessCentralex.Core.DeepLAPIConnector;

using System.Globalization;
using BusinessCentralex.Core.DeepLAPIConnector;
using Microsoft.Inventory.Item;

pageextension 50000 "DeepL Item Translations" extends "Item Translations"
{
    actions
    {
        addfirst(Processing)
        {
            action(AddAllTranslations)
            {
                ApplicationArea = All;
                Caption = 'Add All Translations';
                ToolTip = 'Executes the Add All Translations action.';
                Image = AddAction;

                trigger OnAction()
                begin
                    AddAllTranslations();
                end;
            }
        }
    }

    local procedure AddAllTranslations()
    var
        Item: Record Item;
        ItemTranslation: Record "Item Translation";
        DeepLSupportedLanguage: Record "DeepL Supported Language";
        DeepLAPIConnector: Codeunit "DeepL API Connector";
        Language: Codeunit Language;
        DeepLDefaultLanguageCode: Code[10];
    begin
        DeepLSupportedLanguage.SetRange("BC Language Code", Language.GetLanguageCode(Language.GetDefaultApplicationLanguageId()));
        if DeepLSupportedLanguage.FindFirst() then
            DeepLDefaultLanguageCode := DeepLSupportedLanguage."DeepL Language Code";

        Item.Get(Rec.GetFilter("Item No."));

        DeepLSupportedLanguage.Reset();
        if DeepLSupportedLanguage.FindSet(false) then
            repeat
                if not ItemTranslation.Get(Item."No.", '', DeepLSupportedLanguage."BC Language Code") then begin
                    ItemTranslation.Init();
                    ItemTranslation."Item No." := Item."No.";
                    ItemTranslation."Language Code" := DeepLSupportedLanguage."BC Language Code";
                    ItemTranslation.Description := DeepLAPIConnector.Translate(DeepLDefaultLanguageCode, DeepLSupportedLanguage."DeepL Language Code", Item.Description);
                    ItemTranslation."Description 2" := DeepLAPIConnector.Translate(DeepLDefaultLanguageCode, DeepLSupportedLanguage."DeepL Language Code", Item."Description 2");
                    ItemTranslation.Insert(true);
                end;
            until DeepLSupportedLanguage.Next() = 0;
    end;
}
