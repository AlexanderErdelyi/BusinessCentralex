namespace BusinessCentralex.Core.XLIFF;

using System.Utilities;
using BusinessCentralex.Core.XLIFF;
using System.Globalization;
using System.Environment;

codeunit 50002 "XLIFF Transformation Handler"
{
    procedure TransformXLIFF(XLIFFTranslationHeader: Record "XLIFF Translation Header")
    var
        XLIFFTranslationLine: Record "XLIFF Translation Line";
        TenantMedia: Record "Tenant Media";
        InStr: InStream;
        FileName: Text;

        XLIFFXMLDoc: XmlDocument;
        Root: XmlElement;
        nsmgr: XmlNamespaceManager;
        nsuri: Text;

        xliffNodeList: XmlNodeList;
        xliffNode: XmlNode;
        xliffElement: XmlElement;
        xliffAttributeCollection: XmlAttributeCollection;
        xliffAttribute: XmlAttribute;

        fileNodeList: XmlNodeList;
        fileNode: XmlNode;
        fileElement: XmlElement;
        fileAttributeCollection: XmlAttributeCollection;
        fileAttribute: XmlAttribute;

        transUnitNodeList: XmlNodeList;
        transUnitNode: XmlNode;
        transUnitElement: XmlElement;
        transUnitAttributeCollection: XmlAttributeCollection;
        transUnitAttribute: XmlAttribute;

        sourceNode: XmlNode;
        targetNode: XmlNode;

        noteNodeList: XmlNodeList;
        noteNode: XmlNode;
        noteElement: XmlElement;
        noteAttributeCollection: XmlAttributeCollection;
        noteAttribute: XmlAttribute;
        noteAttributeNode: XmlNode;
    begin
        //Get the media content from the XLIFF Translation Header into Stream
        if TenantMedia.Get(XLIFFTranslationHeader.Content.MediaId()) then begin
            TenantMedia.CalcFields(Content);
            if TenantMedia.Content.HasValue() then begin

                TenantMedia.Content.CreateInStream(InStr, TextEncoding::UTF8);

                if not XmlDocument.ReadFrom(InStr, XLIFFXMLDoc) then
                    Error('Failed to read XLIFF file.');

                //Get the root element of the XLIFF XML Document and set the namespace manager 
                XLIFFXMLDoc.GetRoot(Root);
                nsuri := Root.NamespaceURI();
                nsmgr.NameTable(XLIFFXMLDoc.NameTable());
                nsmgr.AddNamespace('ns', nsuri);

                //Get the file Node to get the Source and Target Language Codes
                XLIFFXMLDoc.SelectNodes('//ns:file', nsmgr, fileNodeList);
                foreach fileNode in fileNodeList do begin
                    fileElement := fileNode.AsXmlElement();
                    fileAttributeCollection := fileElement.Attributes();
                    foreach fileAttribute in fileAttributeCollection do
                        case FileAttribute.Name of
                            'target-language':
                                XLIFFTranslationHeader."Target Language Code" := EvaluateXLIFFLanguageCode(FileAttribute.Value);
                            'source-language':
                                XLIFFTranslationHeader."Source Language Code" := EvaluateXLIFFLanguageCode(FileAttribute.Value);
                        end;
                    XLIFFTranslationHeader.Modify();
                end;

                //Loop through Trans-Unit Nodes to get the Id and other attributes
                XLIFFXMlDoc.SelectNodes('//ns:file/ns:body/ns:group/ns:trans-unit', nsmgr, transUnitNodeList);
                foreach Transunitnode in transUnitNodeList do begin
                    XLIFFTranslationLine.Init();
                    XLIFFTranslationLine."Document Entry No." := XLIFFTranslationHeader."Entry No.";

                    TransUnitElement := TransUnitNode.AsXmlElement();
                    TransUnitAttributeCollection := TransUnitElement.Attributes();
                    foreach TransUnitAttribute in TransUnitAttributeCollection do
                        case TransUnitAttribute.Name of
                            'id':
                                XLIFFTranslationLine."Trans-unit Id" := TransUnitAttribute.Value;
                        end;

                    transUnitNode.SelectSingleNode('ns:source', nsmgr, sourceNode);
                    XLIFFTranslationLine.Source := sourceNode.AsXmlElement().InnerText();

                    transUnitNode.SelectSingleNode('ns:target', nsmgr, targetNode);
                    XLIFFTranslationLine.Target := targetNode.AsXmlElement().InnerText();

                    transUnitNode.SelectNodes('ns:note', nsmgr, noteNodeList);
                    foreach noteNode in NoteNodeList do begin
                        noteElement := noteNode.AsXmlElement();
                        noteAttributeCollection := noteElement.Attributes();
                        foreach noteAttribute in noteAttributeCollection do
                            case noteAttribute.Name of
                                'from':
                                    if noteAttribute.Value() = 'Xliff Generator' then begin
                                        XLIFFTranslationLine."Object Source" := noteElement.InnerText();
                                    end;
                            end;
                    end;

                    XLIFFTranslationLine.Insert(true);
                end;
            end;
        end;
    end;

    procedure SaveXLIFFChanges(XLIFFTranslationHeader: Record "XLIFF Translation Header")
    var
        XLIFFTranslationLine: Record "XLIFF Translation Line";
        TenantMedia: Record "Tenant Media";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;

        TransUnitId: Text;

        XLIFFXMLDoc: XmlDocument;
        Root: XmlElement;
        nsmgr: XmlNamespaceManager;
        nsuri: Text;

        xliffNodeList: XmlNodeList;
        xliffNode: XmlNode;
        xliffElement: XmlElement;
        xliffAttributeCollection: XmlAttributeCollection;
        xliffAttribute: XmlAttribute;

        fileNodeList: XmlNodeList;
        fileNode: XmlNode;
        fileElement: XmlElement;
        fileAttributeCollection: XmlAttributeCollection;
        fileAttribute: XmlAttribute;

        transUnitNodeList: XmlNodeList;
        transUnitNode: XmlNode;
        transUnitElement: XmlElement;
        transUnitAttributeCollection: XmlAttributeCollection;
        transUnitAttribute: XmlAttribute;

        sourceNode: XmlNode;
        sourceElement: XmlElement;
        targetNode, targetNode2 : XmlNode;
        targetElement: XmlElement;
        targetAttributeCollection: XmlAttributeCollection;
        targetAttribute: XmlAttribute;


    begin
        //Get the media content from the XLIFF Translation Header into Stream
        if TenantMedia.Get(XLIFFTranslationHeader.Content.MediaId()) then begin
            TenantMedia.CalcFields(Content);
            if TenantMedia.Content.HasValue() then begin

                TenantMedia.Content.CreateInStream(InStr, TextEncoding::UTF8);

                if not XmlDocument.ReadFrom(InStr, XLIFFXMLDoc) then
                    Error('Failed to read XLIFF file.');

                //Get the root element of the XLIFF XML Document and set the namespace manager 
                XLIFFXMLDoc.GetRoot(Root);
                nsuri := Root.NamespaceURI();
                nsmgr.NameTable(XLIFFXMLDoc.NameTable());
                nsmgr.AddNamespace('ns', nsuri);

                //Get the file Node to get the Source and Target Language Codes
                // XLIFFXMLDoc.SelectNodes('//ns:file', nsmgr, fileNodeList);
                // foreach fileNode in fileNodeList do begin
                //     fileElement := fileNode.AsXmlElement();
                //     fileAttributeCollection := fileElement.Attributes();
                //     foreach fileAttribute in fileAttributeCollection do
                //         case FileAttribute.Name of
                //             'target-language':
                //                 XLIFFTranslationHeader."Target Language Code" := EvaluateXLIFFLanguageCode(FileAttribute.Value);
                //             'source-language':
                //                 XLIFFTranslationHeader."Source Language Code" := EvaluateXLIFFLanguageCode(FileAttribute.Value);
                //         end;
                //     XLIFFTranslationHeader.Modify();
                // end;

                //Loop through Trans-Unit Nodes to get the Id and other attributes
                XLIFFXMlDoc.SelectNodes('//ns:file/ns:body/ns:group/ns:trans-unit', nsmgr, transUnitNodeList);
                foreach Transunitnode in transUnitNodeList do begin
                    XLIFFTranslationLine.Init();
                    XLIFFTranslationLine."Document Entry No." := XLIFFTranslationHeader."Entry No.";

                    TransUnitElement := TransUnitNode.AsXmlElement();
                    TransUnitAttributeCollection := TransUnitElement.Attributes();
                    foreach TransUnitAttribute in TransUnitAttributeCollection do
                        case TransUnitAttribute.Name of
                            'id':
                                TransUnitId := TransUnitAttribute.Value;
                        end;

                    transUnitNode.SelectSingleNode('ns:source', nsmgr, sourceNode);
                    XLIFFTranslationLine.Source := sourceNode.AsXmlElement().InnerText();

                    if XLIFFTranslationLine.Get(XLIFFTranslationHeader."Entry No.", TransUnitId) then begin
                        transUnitNode.SelectSingleNode('ns:target', nsmgr, targetNode);
                        targetElement := XmlElement.Create('target', nsuri, XLIFFTranslationLine.Target);
                        targetNode.ReplaceWith(targetElement);
                    end;

                    //XLIFFTranslationLine.Insert(true);
                end;
            end;

            FileName := XLIFFTranslationHeader."File Name";
            TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
            XLIFFXMLDoc.WriteTo(OutStr);
            TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
            DownloadFromStream(InStr, '', '', '', FileName);
        end;
    end;

    local procedure EvaluateXLIFFLanguageCode(XLIFFLanguageCode: Text): Code[10]
    var
        WindowsLanguage: Record "Windows Language";
    begin
        WindowsLanguage.SetRange("Language Tag", XLIFFLanguageCode);
        if WindowsLanguage.FindFirst() then
            exit(WindowsLanguage."Abbreviated Name")
        else
            exit('');
    end;

}
