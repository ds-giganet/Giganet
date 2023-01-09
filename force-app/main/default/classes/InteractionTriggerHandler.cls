public class InteractionTriggerHandler {
    public static void linkRecords(List<Interaction__c> interactions) {
        Map<String, Interaction__c> interactionsByEmail = new Map<String, Interaction__c>();
        Map<String, Interaction__c> interactionsByUPRN  = new Map<String, Interaction__c>();
        Map<String, Interaction__c> interactionsByUTM   = new Map<String, Interaction__c>();
        /*
        for(Interaction__c interaction : interactions) {
            // Builds interactionsByUPRN to be able to search Interactions based on UPRN
            if(String.isNotBlank(interaction.UPRN__c)) {
                interactionsByUPRN.put(interaction.UPRN__c, interaction);
                // Builds interactionsByEmail to be able to search Interactions based on Email
                if(String.isNotBlank(interaction.Email__c)) {
                    interactionsByEmail.put(interaction.Email__c, interaction);
                }
                // Builds interactionsByUTM to be able to search Interactions based on UTM
                if(String.isNotBlank(interaction.UTM__c)) {
                    interactionsByUTM.put(interaction.UTM__c, interaction);
        }   }   }
        // TBD - Locations might not always have a UPRN and in that case we can use Address Key
        if(interactionsByUPRN.size() > 0) {
            Map<String, Campaign> campaignsByUTM      = new Map<String, Campaign>();
            Map<String, Lead> leadsByEmail            = new Map<String, Lead>();
            Map<String, Location__c> locationsByEmail = new Map<String, Location__c>();
            Map<String, Location__c> locationsByUPRN  = new Map<String, Location__c>();
            List<Lead> newLeads                       = new List<Lead>();
            List<Location__c> newLocations            = new List<Location__c>();
            // Builds a map with Market Areas by Name
            LocationHelper.setAreasMap();
            // Builds locationsByUPRN to be able to search existing Locations based on UPRN
            for(Location__c location : [SELECT Id, Account__c, UPRN__c FROM Location__c WHERE UPRN__c IN : interactionsByUPRN.keySet()]) {
                locationsByUPRN.put(location.UPRN__c, location);
            }
            if(interactionsByEmail.size() > 0) {
                // Builds leadsByEmail to be able to search existing Leads based on Email
                for(Lead lead : [SELECT Id, Email FROM Lead WHERE Email IN : interactionsByEmail.keySet()]) {
                    leadsByEmail.put(lead.Email, lead);
            }   }
            if(interactionsByUTM.size() > 0) {
                // Builds campaignsByUTM to be able to search existing Campaigns based on UTM
                for(Campaign campaign : [SELECT Id, UTM__c FROM Campaign WHERE UTM__c IN : interactionsByUTM.keySet()]) {
                    campaignsByUTM.put(campaign.UTM__c, campaign);
            }   }
            for(Interaction__c interaction : interactions) {
                Campaign campaign    = campaignsByUTM.get(interaction.UTM__c);
                Lead lead            = leadsByEmail.get(interaction.Email__c);
                Location__c location = locationsByUPRN.get(interaction.UPRN__c);
                // Link the Interaction with the related Campaign based on the UTM
                if(campaign != null) {
                    interaction.Campaign__c = campaign.Id;
                }
                // Determines if there are existing Locations or will create a new ones
                if(location != null) {
                    interaction.Location__c = location.Id;
                    interaction.Account__c  = location.Account__c;
                }
                else {
                    location = InteractionHelper.createLocationFromInteraction(interaction);
                    // Determines if there are existing Leads or will create a new ones
                    if(lead != null) {
                        interaction.Lead__c = lead.Id;
                        location.Lead__c    = lead.Id;
                    }
                    else {
                        lead = InteractionHelper.createLeadFromInteraction(interaction);
                        // Link Lead with Campaign based on UTM
                        if(campaign != null) {
                            lead.Campaign__c = campaignsByUTM.get(interaction.UTM__c).Id;
                        }
                        newLeads.add(lead);
                    }
                    // Link Location with Market Area
                    if(String.isNotBlank(interaction.Market_Area__c)) {
                    	location.Parent_Location__c = LocationHelper.areasMap.get(interaction.Market_Area__c).Id;
                    }
                    newLocations.add(location);
            }   }
            // Checks if there are new Leads before insert
            if(newLeads.size() > 0) {
                insert newLeads;
                // After inserting new Leads links them with the Interactions
                for(Lead lead : newLeads) {
                    interactionsByEmail.get(lead.Email).Lead__c = lead.Id;
            }   } 
            // Checks if there are new Locations before insert
            if(newLocations.size() > 0) {
                // Link Locations with Leads
                for(Location__c location : newLocations) {
                    location.Lead__c = interactionsByUPRN.get(location.UPRN__c).Lead__c;
                }
                insert newLocations;
                // After inserting new Locations links them with the Interactions
                for(Location__c location : newLocations) {
                    interactionsByUPRN.get(location.UPRN__c).Location__c = location.Id;
}   }   }   */}   }