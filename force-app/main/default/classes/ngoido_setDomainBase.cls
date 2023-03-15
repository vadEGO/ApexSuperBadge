public class ngoido_setDomainBase {

    @InvocableMethod (label='NGO IDO - Set Domain Base' description= 'Look up base domain URL for this org')
    public static void ngoido_setDomainBase() {
    String baseURL = System.URL.getSalesforceBaseURL().gethost();
    Site DonorExperienceSite = [SELECT Subdomain, UrlPathPrefix FROM Site WHERE Name = 'Donor_Experience'];
    String donorExperienceURL = 'https://' + DonorExperienceSite.Subdomain + '.force.com/' + DonorExperienceSite.UrlPathPrefix + '/apex/PdfTemplate?id=';

    MetadataAPIUtility.updateCustomLabel('Domain_Base','Domain URL for this org','en_US',baseURL,false);
    MetadataAPIUtility.updateCustomLabel('Domain_Base_DonorExperience','Domain URL for the Donor Experience site','en_US',donorExperienceURL,false);
    
    }
    }