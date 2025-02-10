namespace BusinessCentralex.Core.Sample;

page 50008 "Input Page"
{
    Caption = 'Input Card';
    PageType = StandardDialog;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Locked = true;

                field(TextInput; TextInput)
                {
                    Caption = 'Text Input', Locked = true;
                    CaptionClass = SetGetFieldCaption('');
                    Visible = true;
                    ToolTip = 'Specifies the value of the Text Input field.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.Caption(PageCaptionLbl);
        FieldCaptionValue := TextInputLbl;
    end;

    var
        TextInput: Text;
        PageCaptionValue, FieldCaptionValue : Text;
        PageCaptionLbl: Label 'Input Card';
        TextInputLbl: Label 'Text Input';

    procedure SetGetPageCaption(Caption: Text): Text
    begin
        if Caption <> '' then
            PageCaptionValue := Caption;
        exit(PageCaptionValue);
    end;

    procedure SetGetFieldCaption(Caption: Text): Text
    begin
        if Caption <> '' then
            FieldCaptionValue := Caption;
        exit(FieldCaptionValue);
    end;

    procedure GetValue(): Code[20]
    begin
        exit(TextInput);
    end;

    procedure GetValueAsCode() RetVal: Code[20]
    begin
        //ToDo
        //if StrLen(this.TextInput) > MaxStrLen(RetVal) then
        //    Error();
        RetVal := CopyStr(this.TextInput, 1, MaxStrLen(RetVal));
    end;
}
