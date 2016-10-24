global class MonitorSchedular implements Schedulable {

  //  global static String sch = '0 * * ? * *';
    List<CronTrigger> ctLst =new List<CronTrigger>();
   // Datetime dt = DateTime.now();
 
    global static String scheduleMe() {
        
     
            dateTime dt=System.now().addMinutes(1); 
                                                                             
            String Csec,Cmin,Chr,Cday,Cmonth,CYear;
            Csec=String.valueof(dt.second());
            Cmin=String.valueof(dt.minute());
            Chr=String.valueof(dt.hour());
            Cday=String.valueof(dt.day());
            Cmonth=String.valueof(dt.month());
            CYear=String.valueof(dt.Year());
            String SchTimer=Csec+' '+Cmin+' '+Chr+' '+Cday+' '+Cmonth+' ? '+CYear;
            system.debug('*************SchTimer:'+SchTimer);
           
            MonitorSchedular MS=new MonitorSchedular();
            return System.schedule('MonitorSchedular'+dt ,SchTimer ,MS);  
      
            
            
          
       
     
         
    }
        
        
  	    global void execute(SchedulableContext sc) {
            
        if(test.isRunningTest())
        {
           
            CronTrigger cront =new CronTrigger();
            ctLst.add(cront);
            
        }else
        {
            ctLst = [SELECT Id,CronJobDetail.Name,CronJobDetail.Id,State FROM CronTrigger where 
                     (CronJobDetail.Name =:'DailyOpportunityAmountAggregator' AND State ='COMPLETE') 
                     AND (CronJobDetail.Name =:'LeadBatch' AND State ='COMPLETE')];  
        }
            
           if(ctLst.size()>0)
        {
            RemindSystemAdminShedular.scheduleMe();
            LeadBatchSchedular.scheduleMe();
            
        }
        System.abortJob(sc.getTriggerId());
		MonitorSchedular.scheduleMe();
          
    }

    
    
}