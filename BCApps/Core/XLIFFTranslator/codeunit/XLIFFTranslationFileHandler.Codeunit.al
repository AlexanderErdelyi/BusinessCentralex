namespace BusinessCentralex.Core.XLIFF;

using BusinessCentralex.Core.XLIFF;
using System.IO;
using System.Environment;

codeunit 50001 "XLIFF Translation File Handler"
{
    var
        XLIFFTransformationHandler: Codeunit "XLIFF Transformation Handler";

    procedure ImportXLIFFFile()
    var
        XLIFFTranslation: Record "XLIFF Translation Header";
        FromFileName: Text;
        InStr: InStream;
    begin
        if UploadIntoStream('Import XLIFF File', '', 'XLIFF Files (*.xlf)|*.xlf', FromFileName, InStr) then begin
            XLIFFTranslation.Init();
            XLIFFTranslation."Entry No." := 0;
            XLIFFTranslation.Content.ImportStream(InStr, FromFileName);
            XLIFFTranslation."File Name" := FromFileName;
            XLIFFTranslation.Insert(true);

            XLIFFTransformationHandler.TransformXLIFF(XLIFFTranslation);
        end;
    end;

    procedure ReplaceXLIFFile(XLIFFTranslation: Record "XLIFF Translation Header")
    var
        FromFileName: Text;
        InStr: InStream;
    begin
        if UploadIntoStream('Import XLIFF File', '', 'XLIFF Files (*.xlf)|*.xlf', FromFileName, InStr) then begin
            XLIFFTranslation.Content.ImportStream(InStr, FromFileName);
            XLIFFTranslation."File Name" := FromFileName;
            XLIFFTranslation.Modify();

            XLIFFTransformationHandler.TransformXLIFF(XLIFFTranslation);
        end;
    end;

    procedure ExportXLIFFFile(XLIFFTranslation: Record "XLIFF Translation Header")
    var
        TenantMedia: Record "Tenant Media";
        InStr: InStream;
        FileName: Text;
    begin
        if TenantMedia.Get(XLIFFTranslation.Content.MediaId()) then begin
            TenantMedia.CalcFields(Content);
            if TenantMedia.Content.HasValue() then begin
                FileName := XLIFFTranslation."File Name";
                TenantMedia.Content.CreateInStream(InStr);
                DownloadFromStream(InStr, '', '', '', FileName);
            end;
        end;
    end;

    procedure ExportXLIFFChanges(XLIFFTranslationHeader: Record "XLIFF Translation Header")
    begin
        XLIFFTransformationHandler.SaveXLIFFChanges(XLIFFTranslationHeader);
    end;
}
