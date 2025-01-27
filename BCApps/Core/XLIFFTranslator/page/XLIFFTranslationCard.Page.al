namespace Core.Core;

using BusinessCentralex.Core.DeepLAPIConnector;
using System.Utilities;
using System.Environment.Configuration;
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
                field(SourceObjectFilter; SourceObjectFilter)
                {
                    Caption = 'SourceObjectFilter';
                    ToolTip = 'Specifies the value of the SourceObjectFilter field.';

                    trigger OnValidate()
                    begin
                        SetObjectsFilter();
                    end;
                }
            }
            repeater(General)
            {
                field("Trans-unit Id"; Rec."Trans-unit Id")
                {
                    ToolTip = 'Specifies the value of the Trans-unit Id field.', Comment = '%';
                    Caption = 'Trans-unit Id';
                    Visible = false;
                }
                field(Source; Rec.Source)
                {
                    ToolTip = 'Specifies the value of the Source field.', Comment = '%';
                    Caption = 'Source';
                }
                field(Target; Rec.Target)
                {
                    ToolTip = 'Specifies the value of the Target field.', Comment = '%';
                    Caption = 'Target';
                }
                field("Suggested Translation"; Rec."Suggested Translation")
                {
                    ToolTip = 'Specifies the value of the Suggested Translation field.', Comment = '%';
                }
                field("Object Source"; Rec."Object Source")
                {
                    ToolTip = 'Specifies the value of the Object Source field.', Comment = '%';
                    Caption = 'Object Source';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            fileuploadaction(UploadFolderToCreateFilter)
            {
                Caption = 'Upload folder to Create filter';
                AllowMultipleFiles = true;
                //AllowedFileExtensions = '.al';
                trigger OnAction(Files: List of [FileUpload])
                var
                    CurrentFile: FileUpload;
                    TempInStream: InStream;
                    TextLine: Text;
                    ObjectFound: Boolean;
                    XLIFFTranslationLine: Record "XLIFF Translation Line";
                    ToFilter: Text;
                begin
                    XLIFFTranslationLine.SetRange("Document Entry No.", TranslationFileFilter);
                    XLIFFTranslationLine.SetRange("Marked to Filter", true);
                    if not XLIFFTranslationLine.IsEmpty() then
                        XLIFFTranslationLine.ModifyAll("Marked to Filter", false);

                    foreach CurrentFile in Files do begin
                        CurrentFile.CreateInStream(TempInStream, TEXTENCODING::UTF8);
                        // Code here to handle the file
                        ObjectFound := false;
                        while (not TempInStream.EOS()) or (ObjectFound) do begin
                            TempInStream.Readtext(TextLine);

                            ToFilter := GetObjectFilter(TextLine);
                            if ToFilter <> '' then begin
                                XLIFFTranslationLine.SetRange("Document Entry No.", Rec."Document Entry No.");
                                XLIFFTranslationLine.SetFilter("Object Source", '@' + ToFilter + '*');
                                if XLIFFTranslationLine.FindSet() then
                                    repeat
                                        XLIFFTranslationLine."Marked to Filter" := true;
                                        XLIFFTranslationLine.Modify();
                                    until XLIFFTranslationLine.Next() = 0;
                            end;
                        end;
                    end;
                end;
            }

            action(SuggestTranslations)
            {
                Caption = 'Suggest Translations';
                Image = SuggestField;
                trigger OnAction()
                var
                    XLIFFTranslationLine: Record "XLIFF Translation Line";
                    DeepLAPIConnector: Codeunit "DeepL API Connector";
                begin
                    CurrPage.SetSelectionFilter(XLIFFTranslationLine);
                    if XLIFFTranslationLine.FindSet(true) then
                        repeat
                            XLIFFTranslationLine."Suggested Translation" := DeepLAPIConnector.Translate(SourceLanguageCode, TargetLanguageCode, XLIFFTranslationLine.Source);
                            XLIFFTranslationLine.Modify(false);
                        until XLIFFTranslationLine.Next() = 0;
                end;
            }
            action(ApplySuggestedTranslations)
            {
                ApplicationArea = All;
                Caption = 'Apply Suggested Translations';
                Image = SelectLineToApply;
                trigger OnAction()
                var
                    XLIFFTranslationLine: Record "XLIFF Translation Line";
                begin
                    CurrPage.SetSelectionFilter(XLIFFTranslationLine);
                    if XLIFFTranslationLine.FindSet(true) then
                        repeat
                            XLIFFTranslationLine.Target := XLIFFTranslationLine."Suggested Translation";
                            XLIFFTranslationLine.Modify(false);
                        until XLIFFTranslationLine.Next() = 0;
                end;
            }
        }
    }

    var
        TranslationFileFilter: Integer;
        TranslationFileName: Text;
        SourceLanguageCode, TargetLanguageCode : Code[10];
        SourceObjectFilter: Boolean;

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

    local procedure SetObjectsFilter()
    begin
        CurrPage.SaveRecord();
        Rec.SetRange("Marked to Filter", SourceObjectFilter);
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

    local procedure LookupTranslationSourceObject(var TranslationId: Text): Boolean
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

    local procedure GetObjectFilter(TextLine: Text): Text
    var
        TempRegexOptions: Record "Regex Options" temporary;
        TempMatches: Record Matches temporary;
        Regex: Codeunit Regex;
        ObjectString: Text;
    begin
        ObjectString := GetObjectString(TextLine);

        if ObjectString = '' then
            exit;

        exit(GetObjectType(ObjectString) + ' ' + GetObjectName(TextLine))
    end;

    local procedure GetObjectString(TextLine: Text): Text
    var
        TempRegexOptions: Record "Regex Options" temporary;
        TempMatches: Record Matches temporary;
        Regex: Codeunit Regex;
    begin
        TempRegexOptions.IgnoreCase := true;
        Regex.Regex('^(table|tableextension|codeunit|report|reportextension|page|pageextension|xmlport) \d+ "(.*)"', TempRegexOptions);
        Regex.Match(TextLine, TempMatches);
        if TempMatches.FindSet() then
            repeat
                exit(TempMatches.ReadValue());
            until TempMatches.Next() = 0;
    end;

    local procedure GetObjectType(TextLine: Text): Text
    var
        TempRegexOptions: Record "Regex Options" temporary;
        TempMatches: Record Matches temporary;
        Regex: Codeunit Regex;
    begin
        TempRegexOptions.IgnoreCase := true;
        //Regex.Regex('^(table|tableextension|codeunit|report|reportextension|page|pageextension|xmlport) \d+ "(.*)"', TempRegexOptions);        
        Regex.Regex('^(table|tableextension|codeunit|report|reportextension|page|pageextension|xmlport)\b', TempRegexOptions);
        Regex.Match(TextLine, TempMatches);
        if TempMatches.FindSet() then
            repeat
                exit(CopyStr(TempMatches.ReadValue(), 1, 1).ToUpper() + CopyStr(TempMatches.ReadValue(), 2).ToLower());
            until TempMatches.Next() = 0;
    end;

    local procedure GetObjectName(TextLine: Text): Text
    var
        TempRegexOptions: Record "Regex Options" temporary;
        TempMatches: Record Matches temporary;
        Regex: Codeunit Regex;
    begin
        TempRegexOptions.IgnoreCase := false;
        Regex.Regex('".*"', TempRegexOptions);
        Regex.Match(TextLine, TempMatches);
        if TempMatches.FindSet() then
            repeat
                exit(CopyStr(TempMatches.ReadValue(), 2, StrLen(TempMatches.ReadValue()) - 2));
            until TempMatches.Next() = 0;
    end;


}
