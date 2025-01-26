
namespace BusinessCentralex.Core.DeepLAPIConnector;

using System.Globalization;
codeunit 50100 "DeepL API Connector"
{
    var
        DeepLAPISetup: Record "DeepL API Setup";
        HttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeaders: HttpHeaders;
        Response: Text;

    local procedure CheckIsActive(): Boolean
    begin
        DeepLAPISetup.Get();
        exit(DeepLAPISetup."Is Active");
    end;

    procedure SendRequest(Method: Text; EndPoint: Text; Content: Text; var p_ResponseMessage: HttpResponseMessage; var p_Response: Text): Boolean
    var
        ContentHeaders: HttpHeaders;
    begin
        ClearAll();
        if not CheckIsActive() then
            exit;

        RequestMessage.SetRequestUri(DeepLAPISetup."Base URL" + EndPoint);
        RequestMessage.Method(Method);

        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Authorization', 'DeepL-Auth-Key ' + DeepLAPISetup."API Key");
        if Content <> '' then begin
            RequestMessage.Content.WriteFrom(Content);
            RequestMessage.Content.GetHeaders(ContentHeaders);
            ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
        end;


        if HttpClient.Send(RequestMessage, p_ResponseMessage) then begin
            p_ResponseMessage.Content.ReadAs(p_Response);
            if p_ResponseMessage.IsSuccessStatusCode() then
                exit(true)
            else
                Message('%1 \ %2', format(p_ResponseMessage.HttpStatusCode), p_ResponseMessage.ReasonPhrase);
        end;
    end;

    procedure TestConnection()
    begin
        if SendRequest('GET', '/usage', '', ResponseMessage, Response) then
            Message('Success!')
        else
            Message(Response);
    end;

    procedure UpdateUsage()
    var
        JObject: JsonObject;
    begin
        if SendRequest('GET', '/usage', '', ResponseMessage, Response) then begin
            DeepLAPISetup.Get();

            JObject.ReadFrom(Response);
            DeepLAPISetup."Character Count" := GetJsonFieldValue(JObject, 'character_count', DeepLAPISetup."Character Count");
            DeepLAPISetup."Character Limit" := GetJsonFieldValue(JObject, 'character_limit', DeepLAPISetup."Character Limit");
            DeepLAPISetup.Modify();
        end;
    end;

    procedure UpdateSupportedLanguages()
    var
        DeepLSupportedLanguage: Record "DeepL Supported Language";
        Language: Record Language;
        JArray: JsonArray;
        JObject: JsonObject;
        JToken: JsonToken;
    begin
        if SendRequest('GET', '/languages', '', ResponseMessage, Response) then begin
            JArray.ReadFrom(Response);

            foreach JToken in Jarray do begin
                JObject := JToken.AsObject();
                DeepLSupportedLanguage.Init();
                DeepLSupportedLanguage."DeepL Language Code" := GetJsonFieldValue(JObject, 'language', DeepLSupportedLanguage."DeepL Language Code");
                DeepLSupportedLanguage."DeepL Language Name" := GetJsonFieldValue(JObject, 'name', DeepLSupportedLanguage."DeepL Language Name");
                DeepLSupportedLanguage.Insert(true);
                Language.SetFilter("Windows Language Name", '@*' + DeepLSupportedLanguage."DeepL Language Name" + '*');
                if Language.FindFirst() then begin
                    DeepLSupportedLanguage."BC Language Code" := Language.Code;
                    DeepLSupportedLanguage.Modify();
                end;
            end;

            DeepLSupportedLanguage.Reset();
            DeepLSupportedLanguage.SetRange("BC Language Code", '');
            if not DeepLSupportedLanguage.IsEmpty() then
                DeepLSupportedLanguage.DeleteAll();
        end
        else
            Message(Response);
    end;

    procedure Translate(SourceLanguageCode: Code[10]; TargetLanguageCode: Code[10]; TextToTranslate: Text) TranslatedText: Text
    var
        JObject, JObjectTranslation : JsonObject;
        JArray: JsonArray;
        JTokenTranslations, JTokenTranslation : JsonToken;
    begin
        GetDeepLSourceAndTargetLanguageCode(SourceLanguageCode, TargetLanguageCode);
        FillTextToTranslate(SourceLanguageCode, TargetLanguageCode, TextToTranslate);

        if SendRequest('POST', '/translate', TextToTranslate, ResponseMessage, Response) then begin
            ResponseMessage.Content.ReadAs(Response);

            JObject.ReadFrom(Response);
            JObject.Get('translations', JTokenTranslations);
            JArray := JTokenTranslations.AsArray();

            foreach JTokenTranslation in JArray do begin
                JObjectTranslation := JTokenTranslation.AsObject();
                TranslatedText := GetJsonFieldValue(JObjectTranslation, 'text', TranslatedText);
            end;
        end;
    end;



    #region Utils
    local procedure FillTextToTranslate(SourceLanguageCode: Code[10]; TargetLanguageCode: Code[10]; var TextToTranslate: Text)
    var
        JArray: JsonArray;
        JObject: JsonObject;
    begin
        JArray.Add(TextToTranslate);
        JObject.Add('text', JArray);
        JObject.Add('target_lang', TargetLanguageCode);
        JObject.Add('source_lang', SourceLanguageCode);
        JObject.WriteTo(TextToTranslate);
    end;

    local procedure GetDeepLSourceAndTargetLanguageCode(var SourceLanguageCode: Code[10]; var TargetLanguageCode: Code[10])
    var
        DeepLSupportedLanguage: Record "DeepL Supported Language";
    begin
        DeepLSupportedLanguage.SetRange("BC Language Code", SourceLanguageCode);
        if DeepLSupportedLanguage.FindFirst() then
            SourceLanguageCode := DeepLSupportedLanguage."DeepL Language Code";

        DeepLSupportedLanguage.SetRange("BC Language Code", TargetLanguageCode);
        if DeepLSupportedLanguage.FindFirst() then
            TargetLanguageCode := DeepLSupportedLanguage."DeepL Language Code";
    end;

    local procedure GetJsonFieldValue(JObject: JsonObject; FieldName: Text; FieldVariant: Variant): Variant
    var
        JToken: JsonToken;
        JValue: JsonValue;
    begin
        JObject.Get(FieldName, JToken);
        JValue := JToken.AsValue();
        case true of
            FieldVariant.IsInteger():
                exit(JValue.AsInteger());
            FieldVariant.IsText:
                exit(JValue.AsText());
            FieldVariant.IsCode:
                exit(JValue.AsCode());
        end;
    end;
    #endregion



}
