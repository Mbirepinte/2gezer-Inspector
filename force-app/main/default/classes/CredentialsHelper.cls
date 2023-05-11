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
            String clientId = '3MVG9OjW2TAjFKUvVIOtUZQmaM5b1P.XJfOHGZiJtUq6d0yy9jYtoA6SLkHwwE80_4YcXv.P19XbLiZhVEruK';
            String clientSecret = '3E71B5FFE4B18F50C3A5A7E3F73D44F451451207C8DE52995C56FB669DA0066A';
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