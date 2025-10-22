trigger OrderTrigger on Order (after insert) {
    List<EventLog__c> logs = new List<EventLog__c>();
    
    for (Order o : Trigger.new) {
        logs.add(
            new EventLog__c(
                Name = 'NewOrder-' + (o.OrderId == null ? '' : o.OrderId),
                OrderId__c = o.OrderId
            )
        );
    }
    
    if (!logs.isEmpty()) {
        insert logs;
    }
}