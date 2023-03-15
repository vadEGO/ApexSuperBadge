({
    doInit: function(component, event, helper)
    {
        var debugModal = component.get("v.modalDebug");
        if(debugModal){
            helper.showModalDebug(component, helper);
        }
    },
    getLeftRecords: function(component, event, helper)
    {
        var picklistValue = component.get("v.leftPicklistValue");
        if(picklistValue.length > 0){
            helper.getPicklistValues(component, picklistValue);
            helper.getRecordsHelper(component, picklistValue, "left");
        }
    },
    getRightRecords: function(component, event, helper)
    {
        var picklistValue = component.get("v.rightPicklistValue");
        console.log("Right value: "+ picklistValue)
        helper.getRecordsHelper(component, picklistValue, "right");
    },
    moveLeft:function(component,event,helper)
    {
        console.log('Trying to move left');
        debugger;
        var leftComp = component.find('leftOptions');
        var rightComp = component.find('rightOptions');
        var rightOptions = rightComp.get('v.options');
        var rightValue = rightComp.get('v.value');
        if(!rightValue)return;
        var leftOptions = leftComp.get('v.options');
        if(!leftOptions)
            leftOptions=[];        
        
        var values = rightValue.split(';');
        for(var i=0;i<values.length;i++)
        {
            for(var j=0;j<rightOptions.length;j++)
            {
                if(values[i]===rightOptions[j].value)
                {
                    leftOptions.push({'label':rightOptions[j].label,
                                      'value':rightOptions[j].value});
                    rightOptions.splice(j,1);
                    break;
                }
            }
        } 
        rightComp.set('v.options',rightOptions);
        if(leftOptions.length>0)
        {
            leftComp.set('v.options',leftOptions);
        }
        
    },
    moveRight:function(component,event, helper)
    {
        console.log('Trying to move right');
        debugger;
        var leftComp = component.find('leftOptions');
        var rightComp = component.find('rightOptions');
        var leftOptions = leftComp.get('v.options');
        var leftValue = leftComp.get('v.value');
        if(!leftValue)
            return;
        var rightOptions = rightComp.get('v.options');
        if(!rightOptions)
            rightOptions = [];
        if(leftValue!='undefined'&& leftValue!='')
        {
            var values = leftValue.split(';');
            for(var i=0;i<values.length;i++)
            {
                for(var j=0;j<leftOptions.length;j++)
                {
                    if(values[i]===leftOptions[j].value)
                    {
                        rightOptions.push({'label':leftOptions[j].label,
                                           'value':leftOptions[j].value});
                        leftOptions.splice(j,1);
                        break;
                    }
                }
            } 
            leftComp.set('v.options',leftOptions);
        }
        if(rightOptions.length>0)
        {
            rightComp.set('v.options',rightOptions);
        }
        
        console.log('left Comp'+leftComp.get('v.options'));
        console.log('right Comp'+rightComp.get('v.options'));
        
    },
    save:function(component, event, helper)
    {
        helper.saveRecords(component);
        helper.hidePopupHelper(component, 'searchModal', 'slds-fade-in-');
        helper.hidePopupHelper(component,'backdrop','slds-backdrop--');
        helper.clearFields(component);
    },
    showModal : function(component, event, helper)
    {
        helper.getPicklistValues(component, '');
        helper.showPopupHelper(component, 'searchModal', 'slds-fade-in-');
        helper.showPopupHelper(component,'backdrop','slds-backdrop--');        
    },
    closeModal:function(component, event, helper)
    {
        helper.hidePopupHelper(component, 'searchModal', 'slds-fade-in-');
        helper.hidePopupHelper(component,'backdrop','slds-backdrop--');
        helper.clearFields(component);
    }
})