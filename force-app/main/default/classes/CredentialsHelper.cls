public with sharing class CredentialsHelper {
    public static String getCredential () {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        String userName = System.Label.userName;
        String password = System.Label.password;
        String clientId = System.Label.clientId;
        String clientSecret = System.Label.clientSecret;
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
            System.debug('username: ' + username);
            System.debug('password: ' + password);
            System.debug('clientId: ' + clientId);
            System.debug('clientSecret: ' + clientSecret);
        }
        return accessToken;
        } 

        public static String getAccessToken () {
            String clientId = System.Label.clientId;
            String clientSecret = System.Label.clientSecret;
            String myDomain = URL.getSalesforceBaseUrl().toExternalForm();
            String accessToken = '';
            HttpRequest request = new HttpRequest();
            request.setEndpoint(myDomain + '/services/oauth2/token');
            request.setBody('grant_type=client_credentials' + '&client_id=' + clientId + '&client_secret=' + clientSecret);
            request.setMethod('POST');
            Http http = new Http();
            HTTPResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                accessToken = (String) responseMap.get('access_token');
            } else {
                accessToken = response.getBody();
                System.debug('Error: ' + response.getBody());
                System.debug('clientId: ' + clientId);
                System.debug('clientSecret: ' + clientSecret);
            }
            return accessToken;
            } 
}