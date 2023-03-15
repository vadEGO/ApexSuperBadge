@isTest
public class VA_ADP_myIconPositionPicklistTest {
    /* Since we know the default value we can test if it's coming out correctly. */
    public static testmethod  void testDataRows(){
        VA_ADP_myIconPositionPicklist mip = new VA_ADP_myIconPositionPicklist();
        
        /* Default not null. */
        VisualEditor.DataRow testResultDefault = mip.getDefaultValue();
        System.assertNotEquals(null, testResultDefault);
        
        /* Others are not null. */
		VisualEditor.DynamicPickListRows testResultGeneral = mip.getValues();
        System.assert(testResultGeneral.size() > 0);
    }
}