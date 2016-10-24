@isTest
public class testMonitorSchedular {
    
   
    public static testmethod void testMonitor()
    {
        //List<CronTrigger> ctLst =new List<CronTrigger>();
        test.startTest();
        String jobid= MonitorSchedular.scheduleMe();
        System.assert(jobid!=null);
        
        
        
        //ctLst = [SELECT Id,CronJobDetail.Name,CronJobDetail.Id,State FROM CronTrigger where (CronJobDetail.Name =:'DailyOpportunityAmountAggregator' ) AND (CronJobDetail.Name =:'LeadBatch')];  
        //System.assertEquals(ctLst.size(),2);
        //test.stopTest();
    }	

}