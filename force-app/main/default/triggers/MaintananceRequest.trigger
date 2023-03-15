trigger MaintenanceRequest on Case (before update, after update) {
    // call MaintenanceRequestHelper.updateWorkOrders
    if ( Trigger.isAfter && Trigger.isUpdate )  { MaintenanceRequestHelper.updateWorkOrders(Trigger.newMap); } 
}
