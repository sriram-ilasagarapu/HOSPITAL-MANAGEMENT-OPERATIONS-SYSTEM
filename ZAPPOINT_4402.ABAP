@EndUserText.label : 'TABLE FOR APPOINTMENT DATA'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zappoint_2519 {

  key client     : abap.clnt not null;
  key appoint_id : abap.char(12) not null;
  patient_id     : abap.char(10);
  doctor_id      : abap.char(10);
  appoint_date   : abap.dats;
  appoint_time   : abap.tims;
  appoint_type   : abap.char(20);
  symptoms       : abap.char(150);
  diagnosis      : abap.char(150);
  prescription   : abap.char(200);
  test_required  : abap.char(50);
  test_result    : abap.char(150);
  cons_fee       : abap.dec(11,2);
  currency       : abap.cuky;
  pay_status     : abap.char(15);
  appt_status    : abap.char(15);
  follow_date    : abap.dats;
  remarks        : abap.char(200);
  created_by     : abap.char(12);
  created_on     : abap.dats;
  updated_on     : abap.dats;

}