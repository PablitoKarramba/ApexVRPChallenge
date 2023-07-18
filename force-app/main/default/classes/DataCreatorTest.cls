@isTest
private class DataCreatorTest {
    @IsTest
    static void testInsertDataAsUserWithoutPermissions() {
        List<Book__c> preInsertBookList = new List<Book__c>([SELECT Id FROM Book__c]);
        List<Warehouse__c> preInsertWarehouseList = new List<Warehouse__c>([SELECT Id FROM Warehouse__c]);
        String uniqueUserName = 'newuser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Test Profile'];
        User u = new User(
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = uniqueUserName
        );
        Test.startTest();
        System.runAs(u) {
            System.debug('Running test as user: ' + UserInfo.getUserName());
            System.debug('preInsertBookList size: ' + preInsertBookList.size());
            System.debug('preInsertWarehouseList size: ' + preInsertWarehouseList.size());
            DataCreator dc = new DataCreator();
            dc.createData(10);
        }
        Test.stopTest();
        List<Book__c> postInsertBookList = new List<Book__c>([SELECT Id FROM Book__c]);
        List<Warehouse__c> psotInsertWarehouseList = new List<Warehouse__c>([SELECT Id FROM Warehouse__c]);
        System.debug('postInsertBookList size: ' + postInsertBookList.size());
        System.debug('postInsertWarehouseList size: ' + psotInsertWarehouseList.size());
        System.assertEquals(preInsertBookList.size(), postInsertBookList.size(), 'Books records shouldn`t be created');
        System.assertEquals(
            preInsertWarehouseList.size(),
            psotInsertWarehouseList.size(),
            'Warehouses records shouldn`t be created'
        );
    }
}
