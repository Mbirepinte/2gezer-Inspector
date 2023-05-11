public with sharing class LayoutHelper {

    @AuraEnabled
    public static String getLayoutFullName(String layoutId) {
        String layoutFullName;
        String UserApiVersion ='57.0';
        String query ='/tooling/sobjects/Layout/';
        
        HttpRequest request = new HttpRequest();
         request.setEndpoint(
            URL.getSalesforceBaseUrl().toExternalForm()
        + '/services/data/v' 
        + UserApiVersion
        + query 
        + layoutId
        +''
        ); 
        request.setMethod('GET');
          request.setHeader('Authorization', 'Bearer ' + CredentialsHelper.getAccessToken());
        request.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> layoutInfo = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            layoutFullName = (String) layoutInfo.get('FullName');
        } else {
            layoutFullName =  request.toString()  + response.toString();
            }  
          System.debug('getLayoutFullName  ' + layoutFullName);
          return layoutFullName;
        }      
    }
    