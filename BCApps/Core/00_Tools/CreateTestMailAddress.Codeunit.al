namespace BusinessCentralex.Core.Tools;

using System.Utilities;

codeunit 50008 "Create Test Mail Address"
{
    var
        TestEmailAddress: Text;

    procedure SetTestEMailAddress(EmailAddress: Text)
    begin
        this.TestEmailAddress := EmailAddress;
    end;

    procedure ConvertEmailAddressToTest(EmailAddress: Text; OriginalEmailAddresses: Text) RetVal: Text
    begin
        this.TestEmailAddress := EmailAddress;

        RetVal := this.ConvertEmailAddressToTest(OriginalEmailAddresses);
    end;

    procedure ConvertEmailAddressToTest(OriginalEmailAddresses: Text) RetVal: Text
    var
        OriginalEmailAddressesList: List of [Text];
        EmailAddress, EmailAddress2 : Text;
        OriginalTestEmailAddressesList: List of [Text];
        TestEMailAddressesList: List of [Text];
        TestEMailAddressLocalPart: Text;
        TestEMailAddressDomainPart: Text;
    begin
        OriginalTestEmailAddressesList := TestEmailAddress.Split(';');
        OriginalEmailAddressesList := OriginalEmailAddresses.Split(';');

        foreach EmailAddress in OriginalEmailAddressesList do
            foreach EmailAddress2 in OriginalTestEmailAddressesList do begin
                TestEMailAddressLocalPart := GetMailLocalPart(EmailAddress2);
                TestEMailAddressDomainPart := GetMailDomain(EmailAddress2);

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
            exit(TempMatches.ReadValue().Trim());
    end;

}
