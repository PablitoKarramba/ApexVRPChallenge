public with sharing class WarehouseHandler {
    private List<Warehouse__c> getAllWarehouses() {
        List<Warehouse__c> warehouses = new List<Warehouse__c>([SELECT Id, Name, Number_of_books__c FROM Warehouse__c]);
        return warehouses;
    }

    public void calculateBookAmount() {
        List<AggregateResult> groupedResults = [
            SELECT COUNT(Id) bookCount, Warehouse__c whId
            FROM Book__c
            GROUP BY Warehouse__c
            ORDER BY COUNT(Id) DESC
        ];

        List<Warehouse__c> warehouses = new List<Warehouse__c>();
        for (AggregateResult ar : groupedResults) {
            Id warehouseId = (Id) ar.get('whId');
            Integer booksCount = (Integer) ar.get('bookCount');
            Warehouse__c wh = new Warehouse__c(Id = warehouseId, Number_of_books__c = booksCount);
            warehouses.add(wh);
        }

        update warehouses;
    }
}
