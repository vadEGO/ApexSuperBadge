global class VA_ADP_myIconPositionPicklist extends VisualEditor.DynamicPickList{
    
    /* Default value for icon picklist */
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('None', ' ');
        return defaultValue;
    }
    
    /* All values for icon picklist */
    global override VisualEditor.DynamicPickListRows getValues() {
        
        /* To add new: Define The values (lable, value) */
        VisualEditor.DataRow none = new VisualEditor.DataRow('None', ' ');
        VisualEditor.DataRow left = new VisualEditor.DataRow('Left', 'left');
        VisualEditor.DataRow right = new VisualEditor.DataRow('Right', 'right');
        
        /* Then make sure variables are being added here. */
        VisualEditor.DynamicPickListRows  myClasses = new VisualEditor.DynamicPickListRows();
        myClasses.addRow(none);
        myClasses.addRow(left);
        myClasses.addRow(right);
        
        /* End */
        return myClasses;
    }
}