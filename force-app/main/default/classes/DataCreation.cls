public with sharing class DataCreation {
    List<Book__c> bookList = new List<Book__c>();
    List<Warehouse__c> warehouseList = new List<Warehouse__c>();

    public void createData() {
        // Populate lists
        for (Integer i = 0; i < 100; i++) {
            // Create new book with random name
            Book__c book = new Book__c(Name = generateRandomString(8));
            bookList.add(book);
            // Create new warehouse with random name
            Warehouse__c warehouse = new Warehouse__c(Name = generateRandomString(8));
            warehouseList.add(warehouse);
        }
        // Insert records
        if (
            Book__c.getSObjectType().getDescribe().isCreateable() &&
            Warehouse__c.getSObjectType().getDescribe().isCreateable()
        ) {
            insert bookList;
            insert warehouseList;
        } else {
            throw new DmlException('No permission to create');
        }
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
