public with sharing class CredentialsHelper {
    public static String getCredential () {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        String userName = 'mickael.birepinte@curious-bear-fztu10.com';
        String password = 'Jai1codesalesforce!JT5JZILjKTGcHD7N5WCNH0zL';
        String clientId='3MVG9SOw8KERNN08cHNRkZZ12_AWiJjen_Rzq1fvh_HJOSPFn19QV1TgkxRZb.YSlQ7XoTmPMG8MoQBBAaCxM';
        String clientSecret='5807A9C36A963E0AC6FB8DC25D1172F43616CBCEEF02D310EDD1DDD33052E97D';
        request.setBody('grant_type=password&username=' + username + '&password=' + password + '&client_id=' + clientId + '&client_secret=' + clientSecret);
        Http http = new Http();
        HTTPResponse response = http.send(request);
        String accessToken = '';
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            accessToken = (String) responseMap.get('access_token');
        } else {
            accessToken = response.getBody();
            System.debug('Error: ' + response.getBody());
        }
        return accessToken;
        } 
}