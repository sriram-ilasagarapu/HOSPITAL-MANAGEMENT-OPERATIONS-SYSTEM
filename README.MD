# Hospital Management & Operations System

A SAP ABAP-based Hospital Management & Operations System for managing doctors, patients, and appointments through dedicated portals and ALV reports.

## Project Overview

This project provides three user portals:

- Doctor Portal
- Receptionist Portal
- Patient Portal

The system uses SAP ABAP, Open SQL, selection screens, database joins, ALV reporting, and event handling.

## Features

- Doctor-based appointment management
- Receptionist appointment management
- Patient appointment information
- Doctor-wise appointment display
- Appointment ID hotspot navigation
- Detailed appointment information
- ALV-based reporting
- Interactive selection screens

## System Workflow

```text
Main Screen
    |
    +-- Doctor Portal
    |      |
    |      +-- Doctor ID
    |      +-- Assigned Appointments
    |      +-- Appointment Details
    |
    +-- Receptionist Portal
    |      |
    |      +-- Receptionist ID
    |      +-- Full Appointment ALV
    |      +-- Clinical / Operational Details
    |
    +-- Patient Portal
           |
           +-- Appointment ID
           +-- Appointment Information

## Technology Used

- SAP ABAP
- Open SQL
- ALV
- Selection Screens
- Internal Tables
- Database Joins
- Event Handling
- SAP GUI / ABAP Development Tools

## Database Tables

### ZPATIENT_4402

Patient master and personal information.

### ZDOCTOR_4402

Doctor master and professional information.

### ZAPPOINT_2519

Appointment, clinical, payment, and appointment-status information.

## ABAP Programs

### ZHM_HOSPITAL_SYSTEM_2519

Main executable program containing the Doctor, Receptionist, and Patient portals.

### ZHM_APPT_DETAIL_2519

Displays detailed appointment and patient information.

## Screenshots

The repository contains screenshots of:

- Main Screen
- Doctor Portal
- Doctor Assigned Appointments
- Doctor Appointment Details
- Receptionist Portal
- Full Appointment ALV
- Clinical / Operational Information
- Patient Portal
- Appointment Information
## Demo Video

**WORKFLOW OF HM-OS.mp4**

The video demonstrates the complete working flow of the Hospital Management & Operations System.
