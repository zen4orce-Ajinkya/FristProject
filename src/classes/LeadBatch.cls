global class LeadBatch implements Database.Batchable<sObject> {
    global Boolean JCompleted {get;set;}
     global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT CreatedDate,Status FROM Lead WHERE Status='Working - Contacted']); //AND  CreatedDate !=LAST_N_DAYS:30
      }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
      
        List<Lead> LeadList=new List<Lead>();
        
        for (Lead l : scope) {
          l.Status='Closed - Converted';
          LeadList.add(l);
        }
        
        update LeadList;
      }	
    
    global void finish(Database.BatchableContext bc)
    {
        AsyncApexJob a = [Select a.TotalJobItems, a.Status, a.NumberOfErrors, a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,a.CompletedDate
                          ,a.CreatedDate From AsyncApexJob a WHERE id = :BC.getJobId()];//get the job Id
       
        if(a.Status == 'Completed' && a.Status!='Processing') {
           JCompleted=true;
        }
    }
    
}