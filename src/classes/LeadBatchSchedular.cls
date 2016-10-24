global class LeadBatchSchedular implements Schedulable {

    
    
    global static String sched='0 23 17 24 * ?';
    
//   global static  String sched='0 58 23 20 10 ?';
// Time zone 10/20/2016 11:55 PM
// 10/21/2016 04.34 pm
   
   
  
    //we have to call RemindSystemAdmin.scheduleMe() from the  execute anonymous 
    
    global  static String scheduleMe() {
    
        LeadBatchSchedular LB = new LeadBatchSchedular(); 
        return System.schedule('LeadBatch', sched,LB);
    }

    global void execute(SchedulableContext sc) {
        //statements to execute batch
       
        LeadBatch LB=new LeadBatch();
        id batchid =Database.executeBatch(LB,10);
    }
    
}