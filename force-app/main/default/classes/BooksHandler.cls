public with sharing class BooksHandler {
    private List<Book__c> getAllBooks() {
        List<Book__c> bookList = new List<Book__c>([SELECT Id, Name, Serial_number__c, Warehouse__c FROM Book__c]);
        return bookList;
    }

    public void assignBookSerialNumber() {
        List<Book__c> allBooks = getAllBooks();
        for (Integer i = 0, j = allBooks.size(); i < j; i++) {
            allBooks[i].Serial_number__c = 'AA-0-A-' + i;
            System.debug(allBooks[i].Serial_number__c);
        }
        if (!allBooks.isEmpty()) {
            update allBooks;
        }
    }
}
