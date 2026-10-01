REPORT zhm_hospital_system_2519

       NO STANDARD PAGE HEADING

       LINE-SIZE 160.

*---------------------------------------------------------------------*
* HOSPITAL MANAGEMENT & OPERATIONS SYSTEM
*---------------------------------------------------------------------*
* DOCTOR       -> Doctor ID -> Assigned Appointments
* RECEPTIONIST -> Receptionist ID -> All Appointments
* PATIENT      -> Appointment ID -> Appointment Details
*---------------------------------------------------------------------*


*---------------------------------------------------------------------*
* TYPES
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_doctor_appt,

         appoint_id   TYPE zappoint_2519-appoint_id,

         patient_id   TYPE zpatient_4402-patient_id,

         patient_name TYPE zpatient_4402-patient_name,

       END OF ty_doctor_appt.


TYPES: BEGIN OF ty_reception,

         appoint_id     TYPE zappoint_2519-appoint_id,

         patient_id     TYPE zpatient_4402-patient_id,

         patient_name   TYPE zpatient_4402-patient_name,

         doctor_id      TYPE zappoint_2519-doctor_id,

         doctor_name    TYPE zdoctor_4402-doctor_name,

         specialization TYPE zdoctor_4402-specialization,

         appoint_date   TYPE zappoint_2519-appoint_date,

         appoint_time   TYPE zappoint_2519-appoint_time,

         appoint_type   TYPE zappoint_2519-appoint_type,

         symptoms       TYPE zappoint_2519-symptoms,

         appt_status    TYPE zappoint_2519-appt_status,

       END OF ty_reception.


*---------------------------------------------------------------------*
* GLOBAL DATA
*---------------------------------------------------------------------*

DATA:

  gt_doctor TYPE STANDARD TABLE OF ty_doctor_appt,

  gs_doctor TYPE ty_doctor_appt.


DATA:

  gt_reception TYPE STANDARD TABLE OF ty_reception,

  gs_reception TYPE ty_reception.


DATA:

  go_alv TYPE REF TO cl_salv_table.


DATA:

  go_doc_events TYPE REF TO cl_salv_events_table,

  go_rec_events TYPE REF TO cl_salv_events_table.


*---------------------------------------------------------------------*
* FIRST LOGIN SCREEN
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 100.


*---------------------------------------------------------------------*
* PROJECT TITLE
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bt WITH FRAME.

SELECTION-SCREEN COMMENT /1(60) c_title.

SELECTION-SCREEN COMMENT /1(60) c_subtit.

SELECTION-SCREEN END OF BLOCK bt.


SELECTION-SCREEN SKIP 1.


*---------------------------------------------------------------------*
* DOCTOR
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 5(25) c_doc.

SELECTION-SCREEN POSITION 35.

PARAMETERS rb_doc AS CHECKBOX USER-COMMAND DOC.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN SKIP 1.


*---------------------------------------------------------------------*
* RECEPTIONIST
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 5(25) c_rec.

SELECTION-SCREEN POSITION 35.

PARAMETERS rb_rec AS CHECKBOX USER-COMMAND REC.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b2.


SELECTION-SCREEN SKIP 1.


*---------------------------------------------------------------------*
* PATIENT
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 5(25) c_pat.

SELECTION-SCREEN POSITION 35.

PARAMETERS rb_pat AS CHECKBOX USER-COMMAND PAT.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b3.


SELECTION-SCREEN END OF SCREEN 100.


*---------------------------------------------------------------------*
* DOCTOR LOGIN SCREEN
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 200.


SELECTION-SCREEN BEGIN OF BLOCK bd WITH FRAME.

SELECTION-SCREEN COMMENT /1(30) c_doc2.

PARAMETERS p_docid TYPE zdoctor_4402-doctor_id
           OBLIGATORY.

SELECTION-SCREEN END OF BLOCK bd.


SELECTION-SCREEN END OF SCREEN 200.


*---------------------------------------------------------------------*
* PATIENT LOGIN SCREEN
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 300.


SELECTION-SCREEN BEGIN OF BLOCK bp WITH FRAME.

SELECTION-SCREEN COMMENT /1(30) c_pat2.

PARAMETERS p_appid TYPE zappoint_2519-appoint_id
           OBLIGATORY.

SELECTION-SCREEN END OF BLOCK bp.


SELECTION-SCREEN END OF SCREEN 300.


*---------------------------------------------------------------------*
* RECEPTIONIST LOGIN SCREEN
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 400.


SELECTION-SCREEN BEGIN OF BLOCK br WITH FRAME.

SELECTION-SCREEN COMMENT /1(30) c_rec2.

PARAMETERS p_recid TYPE char12
           DEFAULT 'REC1001'.

SELECTION-SCREEN END OF BLOCK br.


SELECTION-SCREEN END OF SCREEN 400.


*---------------------------------------------------------------------*
* INITIALIZATION
*---------------------------------------------------------------------*

INITIALIZATION.

  c_title  = 'HOSPITAL MANAGEMENT & OPERATIONS SYSTEM'.

  c_subtit = 'Select a portal to continue'.

  c_doc    = 'DOCTOR'.

  c_rec    = 'RECEPTIONIST'.

  c_pat    = 'PATIENT'.

  c_doc2   = 'DOCTOR'.

  c_rec2   = 'RECEPTIONIST'.

  c_pat2   = 'PATIENT'.

  rb_doc   = 'X'.


*---------------------------------------------------------------------*
* EVENT CLASS
*---------------------------------------------------------------------*

CLASS lcl_events DEFINITION.

  PUBLIC SECTION.

    METHODS on_doctor_link

      FOR EVENT link_click OF cl_salv_events_table

      IMPORTING

        row

        column.


    METHODS on_reception_link

      FOR EVENT link_click OF cl_salv_events_table

      IMPORTING

        row

        column.

ENDCLASS.


*---------------------------------------------------------------------*
* EVENT HANDLER OBJECTS
*---------------------------------------------------------------------*

DATA:

  go_doc_handler TYPE REF TO lcl_events,

  go_rec_handler TYPE REF TO lcl_events.


*---------------------------------------------------------------------*
* EVENT CLASS IMPLEMENTATION
*---------------------------------------------------------------------*

CLASS lcl_events IMPLEMENTATION.


*---------------------------------------------------------------------*
* DOCTOR APPOINTMENT LINK
*---------------------------------------------------------------------*

  METHOD on_doctor_link.

    READ TABLE gt_doctor

      INTO gs_doctor

      INDEX row.

    IF sy-subrc = 0.

      SUBMIT zhm_appt_detail_2519

        WITH p_appid = gs_doctor-appoint_id

        WITH p_mode = 'D'

        AND RETURN.

    ENDIF.

  ENDMETHOD.


*---------------------------------------------------------------------*
* RECEPTIONIST APPOINTMENT LINK
*---------------------------------------------------------------------*

  METHOD on_reception_link.

    READ TABLE gt_reception

      INTO gs_reception

      INDEX row.

    IF sy-subrc = 0.

      SUBMIT zhm_appt_detail_2519

        WITH p_appid = gs_reception-appoint_id

        WITH p_mode = 'R'

        AND RETURN.

    ENDIF.

  ENDMETHOD.

ENDCLASS.


*---------------------------------------------------------------------*
* F3 / BACK / CANCEL / EXIT
*---------------------------------------------------------------------*

AT SELECTION-SCREEN ON EXIT-COMMAND.

  IF sy-dynnr = '0100'.

    LEAVE PROGRAM.

  ELSEIF sy-dynnr = '0200'.

    LEAVE TO SCREEN 100.

  ELSEIF sy-dynnr = '0300'.

    LEAVE TO SCREEN 100.

  ELSEIF sy-dynnr = '0400'.

    LEAVE TO SCREEN 100.

  ENDIF.


*---------------------------------------------------------------------*
* SELECTION-SCREEN PROCESSING
*---------------------------------------------------------------------*

AT SELECTION-SCREEN.


*---------------------------------------------------------------------*
* LOGIN SELECTION
*---------------------------------------------------------------------*

  IF sy-dynnr = '0100'.

    CASE sy-ucomm.

      WHEN 'DOC'.

        rb_doc = 'X'.

        rb_rec = space.

        rb_pat = space.


      WHEN 'REC'.

        rb_doc = space.

        rb_rec = 'X'.

        rb_pat = space.


      WHEN 'PAT'.

        rb_doc = space.

        rb_rec = space.

        rb_pat = 'X'.

    ENDCASE.

  ENDIF.


*---------------------------------------------------------------------*
* DOCTOR VALIDATION
*---------------------------------------------------------------------*

  IF sy-dynnr = '0200'.

    SELECT SINGLE doctor_id

      FROM zdoctor_4402

      WHERE doctor_id = @p_docid

      INTO @DATA(lv_doctor_id).

    IF sy-subrc <> 0.

      MESSAGE 'Invalid Doctor ID' TYPE 'E'.

    ENDIF.

  ENDIF.


*---------------------------------------------------------------------*
* PATIENT VALIDATION
*---------------------------------------------------------------------*

  IF sy-dynnr = '0300'.

    SELECT SINGLE appoint_id

      FROM zappoint_2519

      WHERE appoint_id = @p_appid

      INTO @DATA(lv_appoint_check).

    IF sy-subrc <> 0.

      MESSAGE 'Invalid Appointment ID' TYPE 'E'.

    ENDIF.

  ENDIF.


*---------------------------------------------------------------------*
* RECEPTIONIST VALIDATION
*---------------------------------------------------------------------*

  IF sy-dynnr = '0400'.

    IF p_recid IS INITIAL.

      MESSAGE 'Enter Receptionist ID' TYPE 'E'.

    ENDIF.

  ENDIF.


*---------------------------------------------------------------------*
* MAIN PROGRAM
*---------------------------------------------------------------------*

START-OF-SELECTION.

  DO.

*---------------------------------------------------------------------*
* MAIN LOGIN MENU
*---------------------------------------------------------------------*

    CALL SELECTION-SCREEN 100.

    IF sy-subrc <> 0.

      RETURN.

    ENDIF.


*---------------------------------------------------------------------*
* DOCTOR
*---------------------------------------------------------------------*

    IF rb_doc = 'X'.

      CALL SELECTION-SCREEN 200.

      IF sy-subrc = 0.

        PERFORM doctor_report.

      ENDIF.


*---------------------------------------------------------------------*
* RECEPTIONIST
*---------------------------------------------------------------------*

    ELSEIF rb_rec = 'X'.

      CALL SELECTION-SCREEN 400.

      IF sy-subrc = 0.

        PERFORM receptionist_report.

      ENDIF.


*---------------------------------------------------------------------*
* PATIENT
*---------------------------------------------------------------------*

    ELSEIF rb_pat = 'X'.

      CALL SELECTION-SCREEN 300.

      IF sy-subrc = 0.

        SUBMIT zhm_appt_detail_2519

          WITH p_appid = p_appid

          WITH p_mode = 'D'

          AND RETURN.

      ENDIF.


*---------------------------------------------------------------------*
* NO LOGIN SELECTED
*---------------------------------------------------------------------*

    ELSE.

      MESSAGE 'Please select a login option' TYPE 'I'.

    ENDIF.

  ENDDO.


*---------------------------------------------------------------------*
* DOCTOR REPORT
*---------------------------------------------------------------------*

FORM doctor_report.

  CLEAR gt_doctor.

*---------------------------------------------------------------------*
* GET DOCTOR APPOINTMENTS
*---------------------------------------------------------------------*

  SELECT

    a~appoint_id,

    a~patient_id,

    p~patient_name

    FROM zappoint_2519 AS a

    LEFT OUTER JOIN zpatient_4402 AS p

      ON p~patient_id = a~patient_id

    WHERE a~doctor_id = @p_docid

    ORDER BY a~appoint_date,

             a~appoint_time

    INTO CORRESPONDING FIELDS OF TABLE @gt_doctor.


*---------------------------------------------------------------------*
* NO APPOINTMENTS
*---------------------------------------------------------------------*

  IF gt_doctor IS INITIAL.

    MESSAGE 'No appointments assigned to this doctor'

      TYPE 'I'.

    RETURN.

  ENDIF.


*---------------------------------------------------------------------*
* CREATE DOCTOR ALV
*---------------------------------------------------------------------*

  TRY.

      CLEAR go_alv.

      cl_salv_table=>factory(

        IMPORTING

          r_salv_table = go_alv

        CHANGING

          t_table = gt_doctor ).


*---------------------------------------------------------------------*
* GENERAL ALV SETTINGS
*---------------------------------------------------------------------*

      go_alv->get_functions( )->set_all(

        abap_true ).


      go_alv->get_columns( )->set_optimize(

        abap_true ).


      go_alv->get_display_settings( )->set_list_header(

        'DOCTOR PORTAL - MY APPOINTMENTS' ).


      go_alv->get_display_settings( )->set_striped_pattern(

        abap_true ).


*---------------------------------------------------------------------*
* DOCTOR COLUMN - APPOINTMENT ID
*---------------------------------------------------------------------*

      DATA lo_doc_col TYPE REF TO cl_salv_column_table.


      lo_doc_col ?=

        go_alv->get_columns( )->get_column(

          'APPOINT_ID' ).


      lo_doc_col->set_short_text(

        'Appt. ID' ).


      lo_doc_col->set_medium_text(

        'Appointment ID' ).


      lo_doc_col->set_long_text(

        'Appointment ID' ).


      lo_doc_col->set_cell_type(

        if_salv_c_cell_type=>hotspot ).


*---------------------------------------------------------------------*
* DOCTOR COLUMN - PATIENT ID
*---------------------------------------------------------------------*

      lo_doc_col ?=

        go_alv->get_columns( )->get_column(

          'PATIENT_ID' ).


      lo_doc_col->set_short_text(

        'Patient ID' ).


      lo_doc_col->set_medium_text(

        'Patient ID' ).


      lo_doc_col->set_long_text(

        'Patient ID' ).


*---------------------------------------------------------------------*
* DOCTOR COLUMN - PATIENT NAME
*---------------------------------------------------------------------*

      lo_doc_col ?=

        go_alv->get_columns( )->get_column(

          'PATIENT_NAME' ).


      lo_doc_col->set_short_text(

        'Patient' ).


      lo_doc_col->set_medium_text(

        'Patient Name' ).


      lo_doc_col->set_long_text(

        'Patient Name' ).


*---------------------------------------------------------------------*
* DOCTOR LINK EVENT
*---------------------------------------------------------------------*

      go_doc_events = go_alv->get_event( ).

      CREATE OBJECT go_doc_handler.

      SET HANDLER go_doc_handler->on_doctor_link

        FOR go_doc_events.


*---------------------------------------------------------------------*
* DISPLAY
*---------------------------------------------------------------------*

      go_alv->display( ).


    CATCH cx_salv_msg INTO DATA(lx_doc).

      MESSAGE lx_doc->get_text( )

        TYPE 'I'.

  ENDTRY.

ENDFORM.


*---------------------------------------------------------------------*
* RECEPTIONIST REPORT
*---------------------------------------------------------------------*

FORM receptionist_report.

  CLEAR gt_reception.


*---------------------------------------------------------------------*
* GET ALL APPOINTMENTS
*---------------------------------------------------------------------*

  SELECT

    a~appoint_id,

    a~patient_id,

    p~patient_name,

    a~doctor_id,

    d~doctor_name,

    d~specialization,

    a~appoint_date,

    a~appoint_time,

    a~appoint_type,

    a~symptoms,

    a~appt_status

    FROM zappoint_2519 AS a

    LEFT OUTER JOIN zpatient_4402 AS p

      ON p~patient_id = a~patient_id

    LEFT OUTER JOIN zdoctor_4402 AS d

      ON d~doctor_id = a~doctor_id

    ORDER BY a~appoint_date,

             a~appoint_time

    INTO CORRESPONDING FIELDS OF TABLE @gt_reception.


*---------------------------------------------------------------------*
* NO DATA
*---------------------------------------------------------------------*

  IF gt_reception IS INITIAL.

    MESSAGE 'No appointment records found'

      TYPE 'I'.

    RETURN.

  ENDIF.


*---------------------------------------------------------------------*
* CREATE RECEPTIONIST ALV
*---------------------------------------------------------------------*

  TRY.

      DATA lo_rec_alv TYPE REF TO cl_salv_table.

      CLEAR lo_rec_alv.

      cl_salv_table=>factory(

        IMPORTING

          r_salv_table = lo_rec_alv

        CHANGING

          t_table = gt_reception ).


*---------------------------------------------------------------------*
* GENERAL ALV SETTINGS
*---------------------------------------------------------------------*

      lo_rec_alv->get_functions( )->set_all(

        abap_true ).


      lo_rec_alv->get_columns( )->set_optimize(

        abap_true ).


      lo_rec_alv->get_display_settings( )->set_list_header(

        'RECEPTIONIST PORTAL - HOSPITAL APPOINTMENTS' ).


      lo_rec_alv->get_display_settings( )->set_striped_pattern(

        abap_true ).


*---------------------------------------------------------------------*
* RECEPTIONIST COLUMN - APPOINTMENT ID
*---------------------------------------------------------------------*

      DATA lo_rec_col TYPE REF TO cl_salv_column_table.


      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'APPOINT_ID' ).


      lo_rec_col->set_short_text(

        'Appt. ID' ).


      lo_rec_col->set_medium_text(

        'Appointment ID' ).


      lo_rec_col->set_long_text(

        'Appointment ID' ).


      lo_rec_col->set_cell_type(

        if_salv_c_cell_type=>hotspot ).


*---------------------------------------------------------------------*
* PATIENT ID
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'PATIENT_ID' ).


      lo_rec_col->set_short_text(

        'Patient ID' ).


      lo_rec_col->set_medium_text(

        'Patient ID' ).


      lo_rec_col->set_long_text(

        'Patient ID' ).


*---------------------------------------------------------------------*
* PATIENT NAME
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'PATIENT_NAME' ).


      lo_rec_col->set_short_text(

        'Patient' ).


      lo_rec_col->set_medium_text(

        'Patient Name' ).


      lo_rec_col->set_long_text(

        'Patient Name' ).


*---------------------------------------------------------------------*
* DOCTOR ID
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'DOCTOR_ID' ).


      lo_rec_col->set_short_text(

        'Doctor ID' ).


      lo_rec_col->set_medium_text(

        'Doctor ID' ).


      lo_rec_col->set_long_text(

        'Doctor ID' ).


*---------------------------------------------------------------------*
* DOCTOR NAME
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'DOCTOR_NAME' ).


      lo_rec_col->set_short_text(

        'Doctor' ).


      lo_rec_col->set_medium_text(

        'Doctor Name' ).


      lo_rec_col->set_long_text(

        'Doctor Name' ).


*---------------------------------------------------------------------*
* SPECIALIZATION
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'SPECIALIZATION' ).


      lo_rec_col->set_short_text(

        'Spec.' ).


      lo_rec_col->set_medium_text(

        'Specialization' ).


      lo_rec_col->set_long_text(

        'Doctor Specialization' ).


*---------------------------------------------------------------------*
* APPOINTMENT DATE
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'APPOINT_DATE' ).


      lo_rec_col->set_short_text(

        'Date' ).


      lo_rec_col->set_medium_text(

        'Appointment Date' ).


      lo_rec_col->set_long_text(

        'Appointment Date' ).


*---------------------------------------------------------------------*
* APPOINTMENT TIME
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'APPOINT_TIME' ).


      lo_rec_col->set_short_text(

        'Time' ).


      lo_rec_col->set_medium_text(

        'Appointment Time' ).


      lo_rec_col->set_long_text(

        'Appointment Time' ).


*---------------------------------------------------------------------*
* APPOINTMENT TYPE
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'APPOINT_TYPE' ).


      lo_rec_col->set_short_text(

        'Type' ).


      lo_rec_col->set_medium_text(

        'Appointment Type' ).


      lo_rec_col->set_long_text(

        'Appointment Type' ).


*---------------------------------------------------------------------*
* SYMPTOMS
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'SYMPTOMS' ).


      lo_rec_col->set_short_text(

        'Symptoms' ).


      lo_rec_col->set_medium_text(

        'Symptoms' ).


      lo_rec_col->set_long_text(

        'Patient Symptoms' ).


*---------------------------------------------------------------------*
* APPOINTMENT STATUS
*---------------------------------------------------------------------*

      lo_rec_col ?=

        lo_rec_alv->get_columns( )->get_column(

          'APPT_STATUS' ).


      lo_rec_col->set_short_text(

        'Status' ).


      lo_rec_col->set_medium_text(

        'Appointment Status' ).


      lo_rec_col->set_long_text(

        'Appointment Status' ).


*---------------------------------------------------------------------*
* RECEPTIONIST LINK EVENT
*---------------------------------------------------------------------*

      go_rec_events = lo_rec_alv->get_event( ).

      CREATE OBJECT go_rec_handler.

      SET HANDLER go_rec_handler->on_reception_link

        FOR go_rec_events.


*---------------------------------------------------------------------*
* DISPLAY
*---------------------------------------------------------------------*

      lo_rec_alv->display( ).


    CATCH cx_salv_msg INTO DATA(lx_rec).

      MESSAGE lx_rec->get_text( )

        TYPE 'I'.

  ENDTRY.

ENDFORM.