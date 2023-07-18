public with sharing class WarehouseHandler {
    private List<Warehouse__c> getAllWarehouses() {
        List<Warehouse__c> warehouseList = new List<Warehouse__c>(
            [SELECT Id, Name, Number_of_books__c FROM Warehouse__c]
        );
        return warehouseList;
    }
}
