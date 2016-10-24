global class DailyOpportunityAmountAggregator implements  Database.Batchable<sObject>, Database.Stateful
{
   
global Boolean Completed;    
global String [] email = new String[] {'ajinkya.kasabe76@gmail.com'};
global Decimal opportunityAmtsum=0.0;
global integer recordsProcessed=0;    
      global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Amount,CreatedDate,IsAggregated__c FROM Opportunity WHERE CreatedDate=TODAY AND StageName='closed won' AND Amount!=null]);
      }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> scope){
        // process each batch of records
        List<Opportunity> opplist=new List<Opportunity>();
        
        for (Opportunity opp : scope) {
          opp.IsAggregated__c=true;
          System.debug('opp'+opp);
          opportunityAmtsum=opportunityAmtsum+opp.Amount;
          opplist.add(opp);
          recordsProcessed+=1;
            
        }
        
        update opplist;
         
                
                }	
    
    
  global void finish(Database.BatchableContext BC){

      
        AsyncApexJob a = [Select a.TotalJobItems, a.Status, a.NumberOfErrors, a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,a.CompletedDate,a.CreatedDate From AsyncApexJob a WHERE id = :BC.getJobId()];//get the job Id
       
      if(a.Status == 'Completed' && a.Status!='Processing') {
        
        }

      
      
      /*  			  
              Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   
              Profile p = [SELECT id FROM Profile WHERE name = 'System Administrator']; 
              User[] u_to_send = [SELECT Id, Email,name FROM User WHERE ProfileId = :p.Id]; 
              String[] toAddresses = new String[] {u_to_send.get(0).Email};   
      
              //Below code will fetch the job Id
              AsyncApexJob a = [Select a.TotalJobItems, a.Status, a.NumberOfErrors, a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,a.CompletedDate,a.CreatedDate From AsyncApexJob a WHERE id = :BC.getJobId()];//get the job Id
              System.debug('$$$ Jobid is'+BC.getJobId());
              
         	  Decimal houres =(((a.CompletedDate.getTime())/1000/60) - ((a.CreatedDate.getTime())/1000/60))/60;
            
              //below code will send an email to User about the status
              mail.setToAddresses(toAddresses);
              mail.setReplyTo('ajinkya.kasabe76@gmail.com');//Add here your email address
              mail.setSenderDisplayName('Ajinkya Zen4orce');
              mail.setSubject('Daily Opportunity Amount Aggregator Job Complete');
              mail.setPlainTextBody('The Batch Apex job processed  '+a.TotalJobItems+
                                    'batches with  '+a.NumberOfErrors+'failures'+
                                    'Job Item processed are'+a.JobItemsProcessed+
                                    'Start DateTime'+a.CreatedDate+
                                    'End DateTime '+a.CompletedDate+
                                    'Total Duration (in Hours)'+houres+
                                    'Total Opportunity Amount for today'+opportunityAmtsum+
                                    'Number of Opportunities Closed Won Today'+recordsProcessed);
              Messaging.sendEmail(new Messaging.Singleemailmessage [] {mail});
              }
    */
 }
}