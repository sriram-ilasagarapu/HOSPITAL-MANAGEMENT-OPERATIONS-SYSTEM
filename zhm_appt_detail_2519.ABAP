REPORT zhm_appt_detail_2519
       NO STANDARD PAGE HEADING
       LINE-SIZE 160.

*---------------------------------------------------------------------*
* HOSPITAL APPOINTMENT DETAIL REPORT
*---------------------------------------------------------------------*

PARAMETERS:

  p_appid TYPE zappoint_2519-appoint_id
          OBLIGATORY,

  p_mode  TYPE char1
          DEFAULT 'D'
          NO-DISPLAY.

*---------------------------------------------------------------------*
* DATA
*---------------------------------------------------------------------*

DATA:

  ls_appointment TYPE zappoint_2519,
  ls_patient     TYPE zpatient_4402,
  ls_doctor      TYPE zdoctor_4402,

  lv_dob         TYPE char10,
  lv_app_date    TYPE char10,
  lv_app_time    TYPE char8,
  lv_join_date   TYPE char10,
  lv_follow_date TYPE char10,
  lv_reg_date    TYPE char10,
  lv_updated_on  TYPE char10.

*---------------------------------------------------------------------*
* START-OF-SELECTION
*---------------------------------------------------------------------*

START-OF-SELECTION.

*---------------------------------------------------------------------*
* GET APPOINTMENT
*---------------------------------------------------------------------*

  SELECT SINGLE *
    FROM zappoint_2519
    WHERE appoint_id = @p_appid
    INTO @ls_appointment.

  IF sy-subrc <> 0.

    MESSAGE 'Appointment record not found' TYPE 'I'.

    RETURN.

  ENDIF.

*---------------------------------------------------------------------*
* GET PATIENT
*---------------------------------------------------------------------*

  SELECT SINGLE *
    FROM zpatient_4402
    WHERE patient_id = @ls_appointment-patient_id
    INTO @ls_patient.

  IF sy-subrc <> 0.

    MESSAGE 'Patient record not found' TYPE 'I'.

    RETURN.

  ENDIF.

*---------------------------------------------------------------------*
* GET DOCTOR
*---------------------------------------------------------------------*

  SELECT SINGLE *
    FROM zdoctor_4402
    WHERE doctor_id = @ls_appointment-doctor_id
    INTO @ls_doctor.

*---------------------------------------------------------------------*
* FORMAT VALUES
*---------------------------------------------------------------------*

  WRITE ls_patient-dob
    TO lv_dob.

  WRITE ls_appointment-appoint_date
    TO lv_app_date.

  WRITE ls_appointment-appoint_time
    TO lv_app_time.

  WRITE ls_doctor-join_date
    TO lv_join_date.

  WRITE ls_patient-reg_date
    TO lv_reg_date.

  WRITE ls_appointment-follow_date
    TO lv_follow_date.

  WRITE ls_appointment-updated_on
    TO lv_updated_on.

*---------------------------------------------------------------------*
* RECEPTIONIST - COMPLETE INFORMATION
*---------------------------------------------------------------------*

  IF p_mode = 'R'.

    NEW-PAGE NO-TITLE.

*---------------------------------------------------------------------*
* PROFESSIONAL RECEPTIONIST HEADER
*---------------------------------------------------------------------*

    WRITE:
      / '====================================================================',
      / '                    HOSPITAL OPERATIONS PORTAL',
      / '                   APPOINTMENT & CLINICAL RECORDS',
      / '===================================================================='.

    SKIP 1.

*---------------------------------------------------------------------*
* APPOINTMENT INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'APPOINTMENT INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Appointment ID     : ', ls_appointment-appoint_id,
      / 'Appointment Type   : ', ls_appointment-appoint_type,
      / 'Appointment Date   : ', lv_app_date,
      / 'Appointment Time   : ', lv_app_time,
      / 'Appointment Status : ', ls_appointment-appt_status,
      / 'Symptoms           : ', ls_appointment-symptoms,
      / 'Diagnosis          : ', ls_appointment-diagnosis,
      / 'Prescription       : ', ls_appointment-prescription,
      / 'Test Required      : ', ls_appointment-test_required,
      / 'Test Result        : ', ls_appointment-test_result.

    SKIP 1.

*---------------------------------------------------------------------*
* PATIENT INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'PATIENT INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Patient ID         : ', ls_patient-patient_id,
      / 'Patient Name       : ', ls_patient-patient_name,
      / 'Gender             : ', ls_patient-gender,
      / 'Blood Group        : ', ls_patient-blood_group,
      / 'Date of Birth      : ', lv_dob,
      / 'Phone              : ', ls_patient-phone,
      / 'Email              : ', ls_patient-email,
      / 'Address            : ', ls_patient-address,
      / 'City               : ', ls_patient-city,
      / 'State              : ', ls_patient-state,
      / 'Pincode            : ', ls_patient-pincode.

    SKIP 1.

*---------------------------------------------------------------------*
* EMERGENCY CONTACT
*---------------------------------------------------------------------*

    WRITE:
      / 'EMERGENCY CONTACT',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Contact Name       : ', ls_patient-emerg_name,
      / 'Contact Phone      : ', ls_patient-emerg_phone.

    SKIP 1.

*---------------------------------------------------------------------*
* INSURANCE INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'INSURANCE INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Insurance ID       : ', ls_patient-insurance_id,
      / 'Provider           : ', ls_patient-ins_provider.

    SKIP 1.

*---------------------------------------------------------------------*
* REGISTRATION INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'REGISTRATION INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Registration Date  : ', lv_reg_date,
      / 'Patient Type       : ', ls_patient-pat_type,
      / 'Patient Status     : ', ls_patient-status.

    SKIP 1.

*---------------------------------------------------------------------*
* DOCTOR INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'DOCTOR INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Doctor ID          : ', ls_doctor-doctor_id,
      / 'Doctor Name        : ', ls_doctor-doctor_name,
      / 'Specialization     : ', ls_doctor-specialization,
      / 'Qualification      : ', ls_doctor-qualification,
      / 'Experience         : ', ls_doctor-experience,
      / 'Gender             : ', ls_doctor-gender,
      / 'Phone              : ', ls_doctor-phone,
      / 'Email              : ', ls_doctor-email,
      / 'Department         : ', ls_doctor-department,
      / 'Room Number        : ', ls_doctor-room_no,
      / 'Shift              : ', ls_doctor-shift,
      / 'Join Date          : ', lv_join_date,
      / 'Consultation Fee   : ', ls_doctor-cons_fee,
      / 'Currency           : ', ls_doctor-currency,
      / 'Doctor Status      : ', ls_doctor-status.

    SKIP 1.

*---------------------------------------------------------------------*
* PAYMENT INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'PAYMENT INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Consultation Fee   : ', ls_appointment-cons_fee,
      / 'Currency           : ', ls_appointment-currency,
      / 'Payment Status     : ', ls_appointment-pay_status.

    SKIP 1.

*---------------------------------------------------------------------*
* FOLLOW-UP INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'FOLLOW-UP & ADDITIONAL INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Follow-up Date     : ', lv_follow_date,
      / 'Remarks            : ', ls_appointment-remarks.

    SKIP 1.

*---------------------------------------------------------------------*
* SYSTEM INFORMATION
*---------------------------------------------------------------------*

    WRITE:
      / 'SYSTEM INFORMATION',
      / '--------------------------------------------------------------------'.

    WRITE:
      / 'Created By         : ', ls_appointment-created_by,
      / 'Created On         : ', ls_appointment-created_on,
      / 'Updated On         : ', lv_updated_on.

    RETURN.

  ENDIF.

*---------------------------------------------------------------------*
* DOCTOR / PATIENT APPOINTMENT INFORMATION
*---------------------------------------------------------------------*

  NEW-PAGE NO-TITLE.

*---------------------------------------------------------------------*
* TOP HEADING
*---------------------------------------------------------------------*

  WRITE:
    / '====================================================================',
    / '                      APPOINTMENT INFORMATION',
    / '===================================================================='.

  SKIP 1.

*---------------------------------------------------------------------*
* APPOINTMENT INFORMATION
*---------------------------------------------------------------------*

  WRITE:
    / 'APPOINTMENT INFORMATION',
    / '--------------------------------------------------------------------'.

  WRITE:
    / 'Appointment ID     : ', ls_appointment-appoint_id,
    / 'Patient ID         : ', ls_patient-patient_id.

  SKIP 1.

*---------------------------------------------------------------------*
* PATIENT INFORMATION
*---------------------------------------------------------------------*

  WRITE:
    / 'PATIENT INFORMATION',
    / '--------------------------------------------------------------------'.

  WRITE:
    / 'Patient Name       : ', ls_patient-patient_name,
    / 'Gender             : ', ls_patient-gender,
    / 'Blood Group        : ', ls_patient-blood_group,
    / 'Date of Birth      : ', lv_dob,
    / 'Phone              : ', ls_patient-phone,
    / 'Email              : ', ls_patient-email,
    / 'Address            : ', ls_patient-address,
    / 'City               : ', ls_patient-city.

  SKIP 1.

*---------------------------------------------------------------------*
* APPOINTMENT SCHEDULE
*---------------------------------------------------------------------*

  WRITE:
    / 'APPOINTMENT SCHEDULE',
    / '--------------------------------------------------------------------'.

  WRITE:
    / 'Appointment Date   : ', lv_app_date,
    / 'Appointment Time   : ', lv_app_time.

  SKIP 1.

*---------------------------------------------------------------------*
* MEDICAL REASON
*---------------------------------------------------------------------*

  WRITE:
    / 'MEDICAL REASON',
    / '--------------------------------------------------------------------'.

  WRITE:
    / 'Cause / Symptoms   : ', ls_appointment-symptoms.

  SKIP 1.

*---------------------------------------------------------------------*
* DOCTOR INFORMATION
*---------------------------------------------------------------------*

  WRITE:
    / 'DOCTOR INFORMATION',
    / '--------------------------------------------------------------------'.

  WRITE:
    / 'Doctor ID          : ', ls_appointment-doctor_id.