page 50000 "FMD Regex List"
{
    ApplicationArea = All;
    Caption = 'FMD Regex List';
    PageType = List;
    SourceTable = "FMD Regex";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Regex Input"; Rec."Regex Input")
                {
                    ToolTip = 'Specifies the value of the Regex Input field.', Comment = '%';
                }
                field("Regex Pattern"; Rec."Regex Pattern")
                {
                    ToolTip = 'Specifies the value of the Regex Pattern field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetMatchBtn)
            {
                Caption = 'Get Match';
                Image = TextFieldConfirm;
                ToolTip = 'Executes the Get Match action.';
                trigger OnAction()
                begin
                    GetMatch();
                end;
            }
        }
    }

    local procedure GetMatch()
    var
        Regex: Codeunit Regex;
        RegexOptions: Record "Regex Options" temporary;
        Matches: Record Matches temporary;
    begin
        RegexOptions.IgnoreCase := true;
        Regex.Regex('\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b', RegexOptions);
        Regex.Match(Rec."Regex Input", Matches);

        if Matches.FindSet() then
            repeat
                Message(Matches.ReadValue());
            until Matches.Next() = 0;
    end;
}
