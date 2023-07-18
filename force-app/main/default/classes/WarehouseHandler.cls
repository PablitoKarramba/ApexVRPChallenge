public with sharing class WarehouseHandler {
    private List<Warehouse__c> getAllWarehouses() {
        List<Warehouse__c> warehouses = new List<Warehouse__c>([SELECT Id, Name, Number_of_books__c FROM Warehouse__c]);
        return warehouses;
    }

    // Calculate number of books for each warehouse
    public void calculateBookAmount() {
        List<Warehouse__c> warehouses = getAllWarehouses();
        Set<Id> bookIds = new Set<Id>();

        AggregateResult[] groupedResults = [
            SELECT COUNT(Id), Warehouse__c
            FROM Book__c
            GROUP BY Warehouse__c
            ORDER BY COUNT(Id) DESC
        ];
        for (AggregateResult ar : groupedResults) {
            System.debug('Warehouse: ' + ar.get('Warehouse__c'));
            System.debug('Books: ' + ar.get('expr0'));
        }
    }
}
