public class LayoutHelper {
    @AuraEnabled (cacheable=true)
    public static String getLayoutFullName(String layoutId) {
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
        request.setHeader('Authorization', 'Bearer ' + '00D0900000DYC4N!AQUAQH0AufictLrIAUOt7drt.Lrms3AE5eF8ruGRGLJrm_y0ZcXs0j4x7Az31_y7hwhFK9XCnlVTU9QWiWt8UrTfkA0kVfd7');
        request.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> layoutInfo = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            layoutFullName = (String) layoutInfo.get('FullName') + UserInfo.getOrganizationId() + UserInfo.getProfileId() + UserInfo.getUserId() + UserInfo.getUserType() + UserInfo.getSessionId();
        } else {
            layoutFullName =  request.toString()  + response.toString() +
            + UserInfo.getOrganizationId() + UserInfo.getProfileId() + UserInfo.getUserId() + UserInfo.getUserType() + UserInfo.getSessionId();
        }
        
        return layoutFullName;
    }
}
