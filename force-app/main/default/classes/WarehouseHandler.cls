public with sharing class WarehouseHandler {
    private List<Warehouse__c> getAllWarehouses() {
        List<Warehouse__c> warehouses = new List<Warehouse__c>([SELECT Id, Name, Number_of_books__c FROM Warehouse__c]);
        return warehouses;
    }

    //FIX this crap
    public void calculateBookAmount() {
        AggregateResult[] groupedResults = [
            SELECT COUNT(Id), Warehouse__c
            FROM Book__c
            GROUP BY Warehouse__c
            ORDER BY COUNT(Id) DESC
        ];
        // Map<Id, Integer> warehouseIds2BookAmount = new Map<Id, Integer>();
        // for (AggregateResult ar : groupedResults) {
        //     warehouseIds2BookAmount.put(String.valueOf(ar.get('Warehouse__c')), Integer.valueOf(ar.get('expr0')));
        // }

        // Map<Id, Warehouse__c> w2b = new Map<Id, Warehouse__c>([SELECT Id, Number_of_books__c FROM Warehouse__c]);
        // for (Warehouse__c warehouse : w2b.values()) {
        //     warehouse.Number_of_books__c = groupedResults.
        // }
    }
}
