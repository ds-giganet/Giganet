public class LocationHelper {
    public static Map<String, Location__c> areasMap;
    // Builds areasMap to be able to search based on Name
    public static void setAreasMap() {
        if(areasMap == null) {
            areasMap = new Map<String, Location__c>();
            // Selects Market Areas records
            for(Location__c location : [SELECT Id, Name FROM Location__c WHERE Type__c =: Constants.LOCATION_TYPE_2]) {
                areasMap.put(location.Name, location);
}   }   }   }