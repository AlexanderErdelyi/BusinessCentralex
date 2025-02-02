namespace BusinessCentralex.Core.Tools;

using System.Utilities;

codeunit 50008 "Create Test Mail Address"
{
    var
        TestEmailAddress: Text;

    procedure SetTestEMailAddress(NewTestEmailAddress: Text)
    begin
        TestEmailAddress := NewTestEmailAddress;
    end;

    procedure ModifyEmailForTestSystem(OriginalEmailAddresses: Text) RetVal: Text
    var
        OriginalEmailAddressesList: List of [Text];
        EmailAddress: Text;
        OriginalTestEmailAddressesList: List of [Text];
        TestEMailAddressesList: List of [Text];
        TestEMailAddressLocalPart: Text;
        TestEMailAddressDomainPart: Text;
        TestEmailAddress: Text;
    begin
        OriginalTestEmailAddressesList := TestEmailAddress.Split(';');
        OriginalEmailAddressesList := OriginalEmailAddresses.Split(';');

        foreach EmailAddress in OriginalEmailAddressesList do
            foreach TestEmailAddress in OriginalTestEmailAddressesList do begin
                TestEMailAddressLocalPart := GetMailLocalPart(TestEmailAddress);
                TestEMailAddressDomainPart := GetMailDomain(TestEmailAddress);

                TestEmailAddressesList.Add(TestEMailAddressLocalPart + '+' + GetMailLocalPart(EmailAddress) + TestEMailAddressDomainPart);
            end;

        foreach EMailAddress in TestEmailAddressesList do
            RetVal += EmailAddress + ';';

        RetVal := RetVal.Substring(1, StrLen(RetVal) - 1);
    end;

    local procedure GetMailDomain(EMailAddress: Text): Text
    var
        TempRegexOptions: Record "Regex Options" temporary;
        TempMatches: Record Matches temporary;
        Regex: Codeunit Regex;
    begin
        TempRegexOptions.IgnoreCase := true;
        Regex.Regex('@([^@]+)', TempRegexOptions);
        Regex.Match(EMailAddress, TempMatches);
        if TempMatches.FindFirst() then
            exit(TempMatches.ReadValue());
    end;

    local procedure GetMailLocalPart(EMailAddress: Text): Text
    var
        TempRegexOptions: Record "Regex Options" temporary;
        TempMatches: Record Matches temporary;
        Regex: Codeunit Regex;
    begin
        TempRegexOptions.IgnoreCase := true;
        Regex.Regex('^([^@]+)', TempRegexOptions);
        Regex.Match(EMailAddress, TempMatches);
        if TempMatches.FindFirst() then
            exit(TempMatches.ReadValue());
    end;

}
