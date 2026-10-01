@EndUserText.label : 'TABLE FOR DOCTOR DATA'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdoctor_4402 {

  key client     : abap.clnt not null;
  key doctor_id  : abap.char(10) not null;
  doctor_name    : abap.char(40);
  specialization : abap.char(40);
  qualification  : abap.char(40);
  experience     : abap.int4;
  gender         : abap.char(1);
  phone          : abap.char(15);
  email          : abap.char(50);
  department     : abap.char(30);
  room_no        : abap.char(10);
  shift          : abap.char(15);
  join_date      : abap.dats;
  @Semantics.amount.currencyCode : 'zdoctor_4402.currency'
  cons_fee       : abap.curr(11,2);
  currency       : abap.cuky;
  status         : abap.char(10);
  created_on     : abap.dats;

}