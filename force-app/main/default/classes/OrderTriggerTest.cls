@isTest
private class OrderTriggerTest {
    @isTest
    static void testInsert() {
        Account a = new Account(Name = 'TestAcct');
        insert a;

        Order o = new Order(
            AccountId = a.Id,
            Status = 'Draft',
            EffectiveDate = Date.today()
        );

        Test.startTest();
        insert o;
        Test.stopTest();

        Order inserted = [
            SELECT Id, Status, EffectiveDate
            FROM Order
            WHERE Id = :o.Id
        ];
        
        System.assertEquals(
            'Draft',
            inserted.Status,
            'Order should have Draft status'
        );
        
        System.assertNotEquals(
            null,
            inserted.EffectiveDate,
            'EffectiveDate should be set'
        );

        // Subscriber should have written an EventLog__c
        List<EventLog__c> logs = [
            SELECT Id, OrderId__c
            FROM EventLog__c
            WHERE OrderId__c = :o.Id
        ];
        
        System.assertEquals(
            1,
            logs.size(),
            'Subscriber should create one EventLog record'
        );
    }
}
