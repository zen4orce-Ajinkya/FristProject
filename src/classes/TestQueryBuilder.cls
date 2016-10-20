@isTest
public class TestQueryBuilder {
     
    public static testmethod void testConstructor()
    {
        QueryBuilder QB=new QueryBuilder();
        System.assertEquals('ABC__C',QB.choosenObject);
        System.assertEquals(false,QB.disabled);
        System.assertEquals('Name',QB.fld);
        System.assertEquals('ASC',QB.selectedRadio);
        System.assertEquals('500',QB.Limits);
    
        
    }
    public static testmethod void getListOfFields()
    {
        
        QueryBuilder QB=new QueryBuilder();
        QB.getListOfFields();
        QB.fieldsss.add('id');
        QB.fieldsss.add('Name');
        QB.getRadioValues();
        QB.getREcordsToDispaly();
        QB.add();
        QB.deSelectedfieldsss.add('Name');
        QB.remove();
        QB.ExecuteQuery();
        QB.Clear();
        

        
    }
    
    
    public static testmethod void CheckForButtonDeselect()
    {
        
        QueryBuilder QB=new QueryBuilder();
        QB.getListOfFields();
        QB.remove();
       

        
    }
    
    
    
}