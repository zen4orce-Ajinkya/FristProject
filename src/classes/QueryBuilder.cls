public class QueryBuilder 
{
    
    public Boolean disabled{get;set;}
    public List<SelectOption> selectedFields{get;set;}
    public List<SelectOption> fieldNames{get;set;}
    public List<SelectOption> allObjects{get;set;}
    public string choosenObject {get; set;}
    public List<String> fieldsss{get;set;}
    public List<String> deSelectedfieldsss{get;set;}
    public String fld{get;set;}
    public String selectedRadio{get;set;}
    public String strQuery{get;set;}
    public List<SObject> s{get;set;}
    public List<String> tableFields{get;set;}
    public String Limits{get;set;}
   
    
    public  QueryBuilder()
    {   
        Limits='500';
        disabled=false;
        tableFields=new List<String>();
        fieldsss=new List<String>();
        deSelectedfieldsss=new List<String>();
        choosenObject='ABC__C';  
        fld='Name';
        selectedRadio='ASC';        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        selectedFields=new List<SelectOption>();
        allObjects=new List<SelectOption>();
        List<String> objectList = new List<String>();
        objectList.addAll(gd.keyset());
        fieldNames=new List<SelectOption>(); 
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(objectList ); 
        
        for(Schema.DescribeSobjectResult res : results) {
        	allObjects.add(new selectOption(res.getName(),res.getLabel()));
        	allObjects.sort();   
         }
        
    }
   
    public void getListOfFields()
    {
        fieldNames.clear();
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();//FETCH ALL OBJECTS AND STORE IT INTO schemaMap
           
        Schema.SObjectType ObjectSchema = schemaMap.get(choosenObject);//ObjectSchema IS TOKEN. SELECTED OBJECTS ADDS INTO ObjectSchema

        
        Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();//GET ALL FIELDS OF SELECTED OBJECT AND STORE IT INTO fieldMap
        System.debug('fieldMap' +fieldMap);
   
       
        for (String fieldName: fieldMap.keySet()) 
          {    
               fieldNames.add(new SelectOption(fieldName,fieldName));
        
          }
            fieldNames.sort();
            
    }
    
    
    public void add()
    {
        if(fieldsss!=null)
        {
             for(String toSelect: fieldsss) {
                  Integer i = 0;
                  While(i<fieldNames.size()) {
                            if(fieldNames[i].getvalue()==toSelect) {
                            selectedFields.add(new SelectOption(toSelect,toSelect));
                            tableFields.add(toSelect);  
                            fieldNames.remove(i);
                 			 }                    
                     	   i++;
                  }
            	 System.debug('fieldNames'+fieldNames);
 			  }
                selectedFields.sort();
                fieldNames.sort();
                 if(selectedFields.size()!=0)
                {
                    disabled=false;
                }
            
            
            
		 	strQuery = 'Select ' +  String.join( tableFields, ',' )  + ' from ' + choosenObject +' ORDER BY '+ ' id ' + selectedRadio +' LIMIT '+Limits ;
            
		}
	}
    
   
      
    public void remove()
    {
      
        if(deSelectedfieldsss!=null)
        {
           
          
 for(String toDeselect: deSelectedfieldsss) {
  Integer i = 0;
  While(i<selectedFields.size()) {
  if(selectedFields[i].getvalue()==toDeselect) {
   fieldNames.add(new SelectOption(toDeselect,toDeselect));
   selectedFields.remove(i);
   tableFields.remove(i);   
      
  }  
  i++;
  }
    
 }
            if(selectedFields.size()==0)
            {
                disabled=true;
            }
           
            
            
      strQuery = 'Select ' +  String.join( tableFields, ',' )  + ' from ' + choosenObject +' ORDER BY '+ ' id ' + selectedRadio +' LIMIT '+Limits ;
                System.debug('strQuery'+strQuery);
}
       
            
           
        
        }
    
       public List<SelectOption> getRadioValues() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('ASC','Ascending')); 
        options.add(new SelectOption('DESC','Desending')); 
        return options; 
    }
    
    
    public List<SelectOption> getREcordsToDispaly() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('500','500')); 
        options.add(new SelectOption('1000','1000')); 
        options.add(new SelectOption('5000','5000')); 
        options.add(new SelectOption('50000','50000')); 
        return options; 
    }
    
    
    public void ExecuteQuery()
    {
        try
        {
            System.debug('fieldsss'+fieldsss);
            s=Database.query(strQuery);
            System.debug('s'+s);
        }
        catch(Exception e)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select correct fields and objects'));
            
        }
    }
    
    
    public void Clear()
    {
        strQuery=' ';
        selectedFields.clear();
        tableFields.clear();
        fieldNames.clear();
         Limits='500';
        disabled=false;
        selectedRadio='ASC';  
        choosenObject='ABC__C';
        
    }
    
    
    
    
    
        

}