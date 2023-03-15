({
    showModalDebug : function(component, helper)
    {
        helper.showPopupHelper(component, 'searchModal', 'slds-fade-in-');
        helper.showPopupHelper(component,'backdrop','slds-backdrop--');     
    },
    getPicklistValues:function(component, picklistValue)
    {
        console.log('getPicklistValues helper starting...');
        var action = component.get("c.getPicklistValuesApex");
        action.setParams({
            "objectAPIName": component.get("v.picklistObject"),
            "fieldAPIName": component.get("v.picklistField"),
            "picklistFilter": component.get("v.picklistFilter"),
            "picklistValue": picklistValue
        });
        action.setCallback(this, function(e){
            if(e.getState()==='SUCCESS')
            {
                var options = e.getReturnValue();
                if(picklistValue.length > 0){
                    var picklistValueR = component.get("v.rightPicklistValue");
                    if(picklistValue === picklistValueR){
                    	component.set('v.rightList', e.getReturnValue());
                        this.getRecordsHelper(component, '', "right");
                    }
                }
                else{
                    component.set('v.leftList', e.getReturnValue());
                    component.set('v.rightList', e.getReturnValue());
                }
            }
            else if (state === "ERROR") {
                //otherwise write errors to console for debugging
                alert('Not able to retrieve picklist values for object.');
                var errors = e.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    },
    getRecordsHelper:function(component, picklistValue, side)
    {
        var action = component.get("c.getOptionsFlexible");
        var searchComp = component.find('searchText');
        var searchString = searchComp.get('v.value')?searchComp.get('v.value'):'';
        console.log('Selected Picklist Value: ' + picklistValue);
        console.log('Search string length: ' + searchString.length);
        
        action.setParams({
            "objectAPIName": component.get("v.mainObject"),
            "fieldAPIName": component.get("v.mainObjectSearchField"),
            "optionFieldAPIName": component.get("v.mainLookupToPicklist"),
            "optionFilter": picklistValue,
            "searchString":searchString,
            "maxRecords": component.get("v.maxRecords")
        });
        action.setCallback(this, function(e){
            if(e.getState()==='SUCCESS')
            {
                if(side === 'left'){
                    var leftOptions = e.getReturnValue();
                    var leftOption = component.find('leftOptions');
                    leftOption.set("v.options",leftOptions);
                }
                else if(side === 'right'){
                    var rightOptions = e.getReturnValue();
                    var rightOption = component.find('rightOptions');
                    rightOption.set("v.options",rightOptions);
                }
            }
        });
        $A.enqueueAction(action);
    },
    showPopupHelper:function(component,componentId, className)
    {
        var modal = component.find(componentId);
        $A.util.removeClass(modal,className+'hide');
        $A.util.addClass(modal,className+'open');
    },
    hidePopupHelper:function(component,componentId, className)
    {
        var modal = component.find(componentId);
        $A.util.removeClass(modal,className+'open');
        $A.util.addClass(modal,className+'hide');
    },
    clearFields:function(component)
    {
        var rightComp = component.find('rightOptions');
        var leftComp = component.find('leftOptions');
        var empty = [];
        rightComp.set('v.options',empty);
        leftComp.set('v.options',empty);
        var searchComp = component.find('searchText');
        searchComp.set('v.value', '');
    },
    saveRecords:function(component)
    {
        var action = component.get("c.saveRecordsApex");
        var rightComp = component.find('rightOptions');
        var rightOptions = rightComp.get('v.options');
        var rightValues = [];
        for(var i=0;i<rightOptions.length;i++){
            rightValues.push(rightOptions[i].value);
            console.log('Options['+ i +']: '+ rightOptions[i].value); 
        }
        console.log('Options: '+ rightValues);
        action.setParams({
            "selectedRecordIds": rightValues,
            "newValue": component.get("v.rightPicklistValue"),
            "objectAPIName": component.get("v.mainObject"),
            "fieldAPIName": component.get("v.mainLookupToPicklist")
        });
        action.setCallback(this, function(e){
            if(e.getState()==='SUCCESS')
            {
                alert('Changes Saved Successfully!');
            }
            else if(e.getState()==='ERROR')
            {
                alert('An error occured!');
            }
        });
        $A.enqueueAction(action);
    }
})