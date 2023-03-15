@isTest
public class VA_ADP_myStylePicklistTest {
    /* Since we know the default value we can test if it's coming out correctly. */
    public static testmethod  void testDataRows(){
        VA_ADP_myStylePicklist mspl = new VA_ADP_myStylePicklist();
        
        /* Default not null. */
        VisualEditor.DataRow testResultDefault = mspl.getDefaultValue();
        System.assertNotEquals(null, testResultDefault);
        
        /* Others are not null. */
		VisualEditor.DynamicPickListRows testResultGeneral = mspl.getValues();
        System.assert(testResultGeneral.size() > 0);
    }
}