@isTest
public class TestForDailyOppAmountAggregator {

    public static testmethod void tesOpp()
    {
         List <Opportunity> opps = new List<Opportunity>();
 		  for(integer i = 0; i<10; i++){
             Opportunity a = new Opportunity(Name='testOpportunity'+'i',Amount=100,IsAggregated__c=false,StageName='Closed Won',CloseDate=System.today()+10); 
             opps.add(a);
          }
   		  insert opps;
       
        String CRON_EXP = '0 55 7 ? * MON-FRI';
        test.startTest();
        RemindSystemAdmin.scheduleMe();
        RemindSystemAdmin rsa = new RemindSystemAdmin();
        String jobId = System.schedule('My batch', CRON_EXP, rsa);
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered,NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        RemindSystemAdminShedular.scheduleMe();
        RemindSystemAdminShedular rsas =new RemindSystemAdminShedular();
        String jbId = System.schedule('My AdminForMonitor', CRON_EXP, rsas);
        CronTrigger ctt = [SELECT Id, CronExpression, TimesTriggered,NextFireTime FROM CronTrigger WHERE id = :jbId];
        
 	 // Verify the expressions are the same
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(CRON_EXP, ctt.CronExpression);
        
        
          // Verify the job has not run
          System.assertEquals(0, ct.TimesTriggered);
          System.assertEquals(0, ctt.TimesTriggered);      
          // Verify the next time the job will run
          //System.assertEquals('2016-10-10 07:55:00',String.valueOf(ct.NextFireTime));
          // Verify the scheduled job hasn't run yet.
        List<Opportunity> opLst =[Select id from Opportunity];
        System.assertEquals(10,opps.size());
        test.stopTest();
        
       /* 
        
        
          Test.StartTest();
	
         DailyOpportunityAmountAggregator DOAA=new DailyOpportunityAmountAggregator();
         ID batchprocessid = Database.executeBatch(DOAA);  
         Test.stopTest();
        
         System.AssertEquals([SELECT count() FROM Opportunity WHERE IsAggregated__c = true],10);  
        */
        
    }
    
     public static testmethod void tesLeadBatch()
     {
          List <Lead> Leads = new List<Lead>();
 		  for(integer i = 0; i<10; i++){
             Lead l = new Lead(Company='testLead'+i,LastName='LN'+i,Status='Working - Contacted'); 
             Leads.add(l);
          }
   		  insert Leads;
         
         
         
        String CRON_EXP = '0 55 7 ? * MON-FRI';
        test.startTest();
        LeadBatchSchedular.scheduleMe();
        LeadBatchSchedular lbs = new LeadBatchSchedular();
        String j = System.schedule('My', CRON_EXP, lbs);
        CronTrigger c = [SELECT Id, CronExpression, TimesTriggered,NextFireTime FROM CronTrigger WHERE id =:j];
     
        // Verify the expressions are the same
         System.assertEquals(CRON_EXP, c.CronExpression);
        // Verify the job has not run
         System.assertEquals(0, c.TimesTriggered);
              
        // Verify the next time the job will run
        //System.assertEquals('2016-10-10 07:55:00',String.valueOf(ct.NextFireTime));
         
        List<Lead> Llist =[Select id from Lead];
        System.assertEquals(10,Llist.size());
        test.stopTest();

     }
    
}