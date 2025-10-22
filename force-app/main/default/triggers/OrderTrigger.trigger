trigger OrderTrigger on Order (after insert) {
    List<EventLog__c> logs = new List<EventLog__c>();
    
    for (Order o : Trigger.new) {
        logs.add(
            new EventLog__c(
                Name = 'NewOrder-' + (o.Id == null ? '' : o.Id),
                OrderId__c = o.Id
            )
        );
    }
    
    if (!logs.isEmpty()) {
        insert logs;
    }
}