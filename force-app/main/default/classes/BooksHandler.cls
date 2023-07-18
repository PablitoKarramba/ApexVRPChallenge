public with sharing class BooksHandler {
    private List<Book__c> getAllBooks() {
        List<Book__c> bookList = new List<Book__c>([SELECT Id, Name, Serial_number__c, Warehouse__c FROM Book__c]);
        return bookList;
    }

    private List<Warehouse__c> getAllWarehouses() {
        List<Warehouse__c> warehouseList = new List<Warehouse__c>(
            [SELECT Id, Name, Number_of_books__c FROM Warehouse__c]
        );
        return warehouseList;
    }

    public void createBookSerialNumber() {
        List<Book__c> allBooks = getAllBooks();
        Integer iterator = 0;
        for (Book__c book : allBooks) {
            book.Serial_number__c = 'AA-0-A-' + iterator;
            System.debug(book.Serial_number__c);
            iterator++;
        }
        if (Book__c.getSObjectType().getDescribe().isUpdateable()) {
            update allBooks;
        }
    }
}
