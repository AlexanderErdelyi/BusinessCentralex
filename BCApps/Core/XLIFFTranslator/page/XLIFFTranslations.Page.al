namespace BusinessCentralex.Core.XLIFF;

using Core.Core;
page 50001 "XLIFF Translations"
{
    ApplicationArea = All;
    Caption = 'XLIFF Translations';
    PageType = List;
    SourceTable = "XLIFF Translation Header";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.', Comment = '%';
                }
                field("Source Language Code"; Rec."Source Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.', Comment = '%';
                }
                field("Target Language Code"; Rec."Target Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportXLIFFFile)
            {
                ApplicationArea = All;
                Caption = 'Import XLIFF File';
                ToolTip = 'Imports an XLIFF file into the system.';
                Image = Import;

                trigger OnAction()
                begin
                    XLIFFTranslationFileHandler.ImportXLIFFFile();
                end;
            }
            action(ReplaceXLIFFFile)
            {
                ApplicationArea = All;
                Caption = 'Replace XLIFF File';
                ToolTip = 'Replaces an XLIFF file in the system.';
                Image = ImportExport;
                trigger OnAction()
                begin
                    XLIFFTranslationFileHandler.ReplaceXLIFFile(Rec);
                end;
            }
            action(ExportXLIFFFile)
            {
                ApplicationArea = All;
                Caption = 'Export XLIFF File';
                ToolTip = 'Exports an XLIFF file from the system.';
                Image = Export;

                trigger OnAction()
                begin
                    XLIFFTranslationFileHandler.ExportXLIFFFile(Rec);
                end;
            }
            action(SaveXLIFFile)
            {
                ApplicationArea = All;
                Caption = 'Export Changed XLIFF File';
                ToolTip = 'Exports an Changed XLIFF file from the system.';
                Image = Export;

                trigger OnAction()
                begin
                    XLIFFTranslationFileHandler.ExportXLIFFChanges(Rec);
                end;
            }

        }

        area(Navigation)
        {
            action(OpenXLIFFTranslationCard)
            {
                ApplicationArea = All;
                Caption = 'Open XLIFF Translation Card';
                ToolTip = 'Opens the XLIFF Translation Card page.';
                Image = Document;
                RunObject = Page "XLIFF Translation Card";
                RunPageLink = "Document Entry No." = field("Entry No.");
                ShortcutKey = 'Return';
            }
        }
    }

    var
        XLIFFTranslationFileHandler: Codeunit "XLIFF Translation File Handler";
}
