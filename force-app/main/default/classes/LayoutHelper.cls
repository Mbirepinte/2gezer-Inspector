public with sharing class LayoutHelper {

    @AuraEnabled
    public static String getLayoutFullName(String layoutId) {
        String layoutFullName;
        String UserApiVersion ='57.0';
        String query ='/tooling/sobjects/Layout/';
        
        HttpRequest request = new HttpRequest();
 /*        request.setEndpoint('callout:Tooling_API_Credential'
        + '/services/data/v' 
        + UserApiVersion
        + query 
        + layoutId
        +''
        ); */
         request.setEndpoint('callout:Tooling_API_Credential'
            //URL.getSalesforceBaseUrl().toExternalForm()
        + '/services/data/v' 
        + UserApiVersion
        + query 
        + layoutId
        +''
        ); 
        request.setMethod('GET');
        //request.setHeader('Authorization', 'Bearer ' + '00D3O0000005n8L!ARMAQEQMHYLW0MtX96cxZfHcMYy9kumC1llbHS.O79RsKBrlTsltihTBCobIZl5x.1FRmifyxSWZOz_ZSIYE__trR8WvgZ4J');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        //request.setHeader('Authorization', 'Bearer ' + CredentialsHelper.getCredential());
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
    