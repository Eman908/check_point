🏢 Check Point

A Flutter-based B2B Attendance Management System powered entirely by Firebase.
The system enables organizations to manage employees and verify real attendance using secure, rotating QR codes.

Built to remove manual tracking, reduce fraud, and give management full visibility over staff presence.

📱 About The System

Check Point is designed for workplaces where employees attend physically but management needs digital verification.

Managers control the workspace.
Staff join through invitations and confirm presence by scanning a time-limited QR code generated automatically by the system.

No signatures.
No shared devices.
No fake check-ins.

✨ Core Features
👨‍💼 Manager Panel

Secure login & password recovery

Add / remove employees

Send invitations to staff

Track invitation acceptance

Dynamic attendance QR code

Regenerates automatically every 3 minutes

Real-time attendance monitoring

Export attendance history as PDF

👩‍💻 Staff Panel

Login & reset password

Accept organization invitation

Scan QR code to confirm attendance

Attendance proof saved in database

Personal attendance history

🔐 Security Logic

QR codes expire automatically

Old codes cannot be reused

Each scan linked to authenticated user

Company data isolated per workspace

Firebase rules enforce access control

📄 Attendance Reports (PDF)

Managers can generate downloadable reports containing:

Employee name

Check-in time

Check-out time

Attendance status

Date

Reports are generated locally on device using a custom PDF builder.

🧠 Architecture

The project follows a scalable and testable architecture:

Clean Architecture Layers

Data Layer → Firebase & Models

Domain Layer → Use Cases & Business Rules

Presentation Layer → UI & State

State Management

Cubit (flutter_bloc)

MVI Pattern (Model-View-Intent)
Ensures predictable UI state and one-direction data flow.

Dependency Injection

get_it

injectable

This structure keeps features isolated and easy to extend.

🔥 Backend

Fully serverless backend powered by Firebase:

Firebase Authentication

Cloud Firestore (real-time attendance tracking)

Secure multi-company structure

No traditional backend server required.

🛠️ Tech Stack

Flutter & Dart

Firebase Auth & Firestore

Clean Architecture

MVI Pattern

Cubit State Management

QR Scanner & Generator

Local PDF Reporting

Dependency Injection

📦 Packages Used

firebase_core

firebase_auth

cloud_firestore

flutter_bloc

get_it

injectable

go_router

mobile_scanner

qr_flutter

pdf

path_provider

open_filex

intl

shared_preferences

uuid

📸 Screenshots

<table> <tr> <td><img src="https://github.com/user-attachments/assets/ca302e76-af2d-41d0-b13f-15eb4ebdf291" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/686c3a84-9409-4bce-bbdc-87d25c27edcb" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/0dd75f9d-dc83-46db-a9c4-58b95456de4b" width="200" /></td> .</tr> <tr> <td><img src="https://github.com/user-attachments/assets/22be74b4-2642-4c2d-9329-233ebe0e0764" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/9e101c0f-fc12-4550-b11d-316ff41e0ba5" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/466ab2ff-577d-4d91-852d-df2c8648abc9" width="200" /></td> </tr> <tr> .<td><img src="https://github.com/user-attachments/assets/c5e0df03-f056-4d1e-a56b-4743bf4dd681" width="200" /></td> </table>

🚀 Workflow

Manager creates workspace

Manager invites employees

Employee accepts invitation

System generates rotating QR code

Employee scans QR → attendance recorded

Manager downloads PDF report

🎯 Use Cases

Offices

Agencies

Clinics

Warehouses

Training centers

Schools

Co-working spaces

🚀 Getting Started
git clone <repo>
flutter pub get
flutter run

🧩 Concept

Attendance is no longer a manual claim —
it becomes a verified event based on identity and time.
