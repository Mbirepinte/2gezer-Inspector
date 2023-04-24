public with sharing class LogHelper {

    @AuraEnabled
    public static void insertInLog (String layoutFullName, String userId, String layoutObject) {
        System.debug('layoutFullName in loghelper: ' + layoutFullName);
        System.debug('userId in loghelper: ' + userId);
        System.debug('layoutObject in loghelper: ' + layoutObject);
        try {
            InspectorLog__c log = new InspectorLog__c();
            log.LayoutFullName__c = layoutFullName;
            log.User_Id__c = userId;
            log.Object__c= layoutObject;
            insert log;
        } catch (DMLException e) {
            System.debug('Error: ' + e.getMessage());
        } 
    } 
}