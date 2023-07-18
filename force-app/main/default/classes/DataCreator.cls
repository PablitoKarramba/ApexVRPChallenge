public with sharing class DataCreator {
    List<Book__c> books = new List<Book__c>();
    List<Warehouse__c> warehouses = new List<Warehouse__c>();

    public void createData(Integer recordsAmount) {
        for (Integer i = 0; i < recordsAmount; i++) {
            Book__c book = new Book__c(Name = generateRandomString(8));
            books.add(book);
            Warehouse__c warehouse = new Warehouse__c(Name = generateRandomString(8));
            warehouses.add(warehouse);
        }

        if (!books.isEmpty() && !warehouses.isEmpty()) {
            insert books;
            insert warehouses;
            assignBookToWarehouse();
        }
    }

    private void assignBookToWarehouse() {
        List<Book__c> booksWithoutWarehouses = new List<Book__c>([SELECT Id FROM Book__c WHERE Warehouse__c = NULL]);
        List<Warehouse__c> warehouses = new List<Warehouse__c>([SELECT Id FROM Warehouse__c]);
        for (Book__c book : booksWithoutWarehouses) {
            book.Warehouse__c = warehouses[generateRandomIndex(warehouses)].Id;
        }
        if (!booksWithoutWarehouses.isEmpty()) {
            update booksWithoutWarehouses;
        }
    }

    private Integer generateRandomIndex(List<SObject> collection) {
        Double randomNumber = Math.random();
        Integer randomIndex = (randomNumber * (collection.size() - 1)).intValue();
        return randomIndex;
    }

    private String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx + 1);
        }
        return randStr;
    }
}
