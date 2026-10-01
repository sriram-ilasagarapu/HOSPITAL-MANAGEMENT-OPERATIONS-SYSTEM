@EndUserText.label : 'TABLE FOR PATIENT DATA'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zpatient_4402 {

  key client     : abap.clnt not null;
  key patient_id : abap.char(10) not null;
  patient_name   : abap.char(40);
  gender         : abap.char(1);
  dob            : abap.dats;
  blood_group    : abap.char(3);
  phone          : abap.char(15);
  email          : abap.char(50);
  address        : abap.char(100);
  city           : abap.char(30);
  state          : abap.char(30);
  pincode        : abap.char(6);
  emerg_name     : abap.char(40);
  emerg_phone    : abap.char(15);
  insurance_id   : abap.char(20);
  ins_provider   : abap.char(50);
  reg_date       : abap.dats;
  pat_type       : abap.char(10);
  status         : abap.char(10);
  created_by     : abap.char(12);
  created_on     : abap.dats;

}