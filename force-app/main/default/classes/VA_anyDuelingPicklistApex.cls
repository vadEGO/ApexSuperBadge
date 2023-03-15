public with sharing class VA_anyDuelingPicklistApex {
	
    /**------------------------------------------------------------------------------------------
     *  getPicklistValuesApex: Receives what obj to search and what field to retrieve as well as what to filter.
     *              Returns a Map that can be used as a Picklist. 
     */
    @AuraEnabled
    public static List<Map<String, String>> getPicklistValuesApex(String objectAPIName, String fieldAPIName, String picklistFilter, String picklistValue){
        List<Map<String, String>> items = new List<Map<String, String>>();
        List<sObject> recordList = Database.query('SELECT Id, ' + fieldAPIName + ' FROM ' + objectAPIName + ' WHERE ' + fieldAPIName + ' LIKE \'%' + picklistFilter + '%\'');
        for (sObject temp : recordList) {
            if(picklistValue.length() == 0 || temp.Id != picklistValue){
            	items.add(new Map<String, String>{'value' => temp.Id, 'label' => (String)temp.get(fieldAPIName)});
            }
        }
        return items;
    }
        
    /**------------------------------------------------------------------------------------------
     *  getOptionsFlexible: Needs objectAPIName and what option to filter by. It can also search.
     *              Returns a list of options that can be used in the dueling picklists.
	 * 				Needs to have treatment of strings in order to be secure?
     */
    @AuraEnabled
    public static List<SelectOption> getOptionsFlexible(String objectAPIName, String fieldAPIName, String optionFieldAPIName, String optionFilter, String searchString, String maxRecords)
    {
        List<SelectOption> allOptions = new List<SelectOption>();
        List<sObject> records;
        
        String query = 'SELECT Id';
        
        if(objectAPIName.length() > 0 && optionFilter.length() > 0){
            if(fieldAPIName.length() > 0){query += ', ' + fieldAPIName;}
            if(optionFieldAPIName.length() > 0){query += ', ' + optionFieldAPIName;}
            
            query += ' FROM ' + objectAPIName;
            
            if(optionFilter.length() > 0 || searchString.length() > 0){
                query += ' WHERE ';
                Integer counter = 0;
                if(optionFilter.length() > 0){query += optionFieldAPIName + ' = \'' + optionFilter + '\'';counter++;}
                if(searchString.length() > 0){if(counter > 0){query += ' AND ';} searchString ='%'+searchString+'%'; query += fieldAPIName + ' LIKE \'' + searchString + '\'';}
            }
            
            if(maxRecords.length() > 0){query += ' LIMIT ' + maxRecords;}
        
            records = Database.query(query);
            for(sObject temp: records)
            {
                allOptions.add(new SelectOption(temp.Id,(String)temp.get(fieldAPIName)));
            }
        
        }
        return allOptions;
    }
        
    /**------------------------------------------------------------------------------------------
     *  saveRecordsApex: Receives a list of record Ids to change, what field to change and the new value.
     *              Changes and saves new records.
     */
    @AuraEnabled
    public static void saveRecordsApex(List<String> selectedRecordIds, String objectAPIName, String fieldAPIName, String newValue)
    {
        if(selectedRecordIds.size() > 0 && newValue.length() > 0){
            System.debug('Save Started');
            Set<String> recordIds = new Set<String>(selectedRecordIds);
            String query = 'SELECT Id, ' + fieldAPIName + ' FROM ' + objectAPIName  + ' WHERE Id IN :selectedRecordIds';
            System.debug('Query: '+query);
            List<sObject> updateRecords = Database.query(query);
            
            for(sObject temp: updateRecords){
                temp.put(fieldAPIName, newValue);
            }
            
            update(updateRecords);
            System.debug('Save Ended');   
        }
    }    
    
    /**------------------------------------------------------------------------------------------
     *  SelectOption: This class is used to define a Data Type that is used to 
     * 					facilitate Dueling Picklist option representation. 
     */
    public class SelectOption{
        public SelectOption (String value, String label)
        {
            this.value = value;
            this.label = label;
            this.disabled = false;
            this.escapeItem = false;
            this.selected = false;
        }
        public SelectOption(String value, String label, boolean isDisabled){
            this.value = value;
            this.label = label;
            this.disabled = isDisabled;
            this.escapeItem = false;
            this.selected = false;
        }
        @AuraEnabled
        public String label { get;set; }
        @AuraEnabled
        public String value { get;set; }
        @AuraEnabled
        public Boolean disabled { get;set; }
        @AuraEnabled
        public Boolean escapeItem { get;set; }
        @AuraEnabled
        public Boolean selected {get;set;}
        
    }
}