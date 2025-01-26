namespace Core.Core;

using BusinessCentralex.Core.XLIFF;
using System.Globalization;

page 50002 "XLIFF Translation Card"
{
    ApplicationArea = All;
    Caption = 'XLIFF Translation Card';
    PageType = List;
    SourceTable = "XLIFF Translation Line";
    UsageCategory = Tasks;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Filter)
            {
                field(TranslationFileFilter; TranslationFileFilter)
                {
                    Caption = 'Translation File Filter';
                    ToolTip = 'Specifies the value of the Translation File Filter field.', Comment = '%';

                    trigger OnValidate()
                    begin
                        SetRecFilters();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(LookupTranslationId(Text));
                    end;
                }
                field(TranslationFileName; TranslationFileName)
                {
                    Caption = 'Translation File Name';
                    ToolTip = 'Specifies the value of the Translation File Name field.', Comment = '%';
                    Editable = false;
                }
                field(SourceLanguageCode; SourceLanguageCode)
                {
                    Caption = 'Source Language Code';
                    ToolTip = 'Specifies the value of the Source Language Code field.', Comment = '%';
                    Editable = false;
                }
                field(TargetLanguageCode; TargetLanguageCode)
                {
                    Caption = 'Target Language Code';
                    ToolTip = 'Specifies the value of the Target Language Code field.', Comment = '%';
                    Editable = false;
                }
            }
            repeater(General)
            {
                field("Trans-unit Id"; Rec."Trans-unit Id")
                {
                    ToolTip = 'Specifies the value of the Trans-unit Id field.', Comment = '%';
                }
                field(Source; Rec.Source)
                {
                    ToolTip = 'Specifies the value of the Source field.', Comment = '%';
                }
                field(Target; Rec.Target)
                {
                    ToolTip = 'Specifies the value of the Target field.', Comment = '%';
                }
                field("Object Source"; Rec."Object Source")
                {
                    ToolTip = 'Specifies the value of the Object Source field.', Comment = '%';
                }
            }
        }
    }

    var
        TranslationFileFilter: Integer;
        TranslationFileName: Text;
        SourceLanguageCode, TargetLanguageCode : Code[10];

    trigger OnOpenPage()
    var
        XLIFFTranslationHeader: Record "XLIFF Translation Header";
    begin
        if Evaluate(TranslationFileFilter, Rec.GetFilter("Document Entry No.")) then begin
            XLIFFTranslationHeader.Get(TranslationFileFilter);
            TranslationFileName := XLIFFTranslationHeader."File Name";
            SourceLanguageCode := XLIFFTranslationHeader."Source Language Code";
            TargetLanguageCode := XLIFFTranslationHeader."Target Language Code";
        end;
    end;

    local procedure SetRecFilters()
    begin
        CurrPage.SaveRecord();
        Rec.SetRange("Document Entry No.", TranslationFileFilter);
        CurrPage.Update(false);
    end;

    local procedure LookupTranslationId(var TranslationId: Text): Boolean
    var
        XLIFFTranslationHeader: Record "XLIFF Translation Header";
        XLIFFTranslations: Page "XLIFF Translations";
    begin
        XLIFFTranslations.LookupMode(true);
        XLIFFTranslations.SetTableView(XLIFFTranslationHeader);
        if XLIFFTranslations.RunModal() = Action::LookupOK then begin
            XLIFFTranslations.GetRecord(XLIFFTranslationHeader);
            TranslationId := format(XLIFFTranslationHeader."Entry No.");
            TranslationFileName := XLIFFTranslationHeader."File Name";
            SourceLanguageCode := XLIFFTranslationHeader."Source Language Code";
            TargetLanguageCode := XLIFFTranslationHeader."Target Language Code";
            exit(true);
        end;
    end;
}
