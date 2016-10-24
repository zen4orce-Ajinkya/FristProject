global class RemindSystemAdminShedular implements Schedulable {

     //global static String sched='0 55 23 20 10 ?';
     global static String sched='0 23 17 24 * ?';
     // 0 30 20 ? * MON-FRI
    							
   
   
  
    //we have to call RemindSystemAdmin.scheduleMe() from the  execute anonymous 
    
    global static String scheduleMe() {
    
        RemindSystemAdminShedular RSM = new RemindSystemAdminShedular(); 
        return System.schedule('DailyOpportunityAmountAggregator', sched, RSM);
    }

    global void execute(SchedulableContext sc) {
        //statements to execute batch
        DailyOpportunityAmountAggregator DOAA=new DailyOpportunityAmountAggregator();
        ID batchprocessid = Database.executeBatch(DOAA,10); 
       
    }
    
}