global class VA_ADP_myStylePicklist extends VisualEditor.DynamicPickList{
    
    /* Default value for icon picklist */
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Standard (Brand)', ' slds-button--brand');
        return defaultValue;
    }
    
    /* All values for icon picklist */
    global override VisualEditor.DynamicPickListRows getValues() {
        
        /* To add new: Define The values (lable, value) */
        VisualEditor.DataRow brand = new VisualEditor.DataRow('Brand', ' slds-button--brand');
        VisualEditor.DataRow neutral = new VisualEditor.DataRow ('Neutral', ' slds-button--neutral');
        VisualEditor.DataRow outlineBrand = new VisualEditor.DataRow ('Outline Brand', ' slds-button--outline_brand');
        VisualEditor.DataRow destructive = new VisualEditor.DataRow ('Destructive', ' slds-button--destructive');
        VisualEditor.DataRow success = new VisualEditor.DataRow ('Success', ' slds-button--success');
        
        /* Then make sure variables are being added here. */
        VisualEditor.DynamicPickListRows  myClasses = new VisualEditor.DynamicPickListRows();
        myClasses.addRow(brand);
        myClasses.addRow(neutral);
        myClasses.addRow(success);
        myClasses.addRow(destructive);
        myClasses.addRow(outlineBrand);
        
        /* End */
        return myClasses;
    }
}