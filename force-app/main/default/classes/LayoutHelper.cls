public with sharing class LayoutHelper {

    @AuraEnabled
    public static String getLayoutFullName(String layoutId, String userId, String object_c) {
        String layoutFullName;
        String UserApiVersion ='57.0';
        String query ='/tooling/sobjects/Layout/';
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()
        + '/services/data/v' 
        + UserApiVersion
        + query 
        + layoutId
        +''
        );
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + CredentialsHelper.getCredential());
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
          System.debug('getUserId_c  ' + userId);
          System.debug('getObject_c  ' + object_c);
          //LogHelper.insertInLog(layoutFullName, userId, object_c);
          return layoutFullName;
        }   
        
    }
    