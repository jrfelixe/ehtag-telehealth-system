# ElectronicHealth Tag (EHTAG) - Comprehensive Telehealth System

## 🏥 Project Overview

EHTAG is a full-featured, HIPAA-compliant telehealth platform that connects patients with healthcare providers through a secure, accessible web and mobile application. The system enables comprehensive electronic health record management, emergency medical information access via QR codes, and seamless integration with healthcare institutions.

## 📊 Current Status: JWT Authentication Issue

**Critical Issue:** The system is experiencing persistent "Invalid JWT" errors (401) when fetching patient data after login. Authentication succeeds, but subsequent authenticated API calls fail during JWT verification in the Edge Functions server.

**Status:** Under investigation - requires checking Supabase Edge Functions dashboard logs to identify the exact verification step that's failing.

## 🎯 Core Features

### Patient Portal
- **Personal Health Records:** Secure storage of medical history, medications, allergies, and immunizations
- **QR Code Generation:** Emergency access to critical medical information
- **Vital Signs Tracking:** Monitor and log health metrics over time
- **Appointment Management:** Schedule and track medical appointments
- **Test Results Viewer:** Access lab results and diagnostic reports
- **Secure Messaging:** HIPAA-compliant communication with healthcare providers
- **Care Team Management:** View and manage healthcare provider network

### Doctor/Medical Professional Portal
- **Patient Details Viewer:** Access comprehensive patient medical records
- **Medical Record Upload:** Upload various medical documents and images (MRI, X-rays, etc.)
- **Test Results Management:** Upload and manage diagnostic test results
- **Secure Messaging:** Communicate securely with patients
- **Appointment Management:** View and manage patient appointments

### Guest Access System
- **Medical Record Number (MRN) Access:** Allows patients to view limited medical information using MRN and password
- **No Account Required:** Quick access for patients at clinics, hospitals, or doctor's offices
- **Limited Information View:** HIPAA-compliant restricted access to relevant medical data

### Ministry of Health (MOH) Integration
- **Bulk Import System:** Import medical professionals via secure API endpoint
- **Automatic Account Creation:** Generate secure credentials for all imported professionals
- **Audit Logging:** Track all MOH-related operations for compliance
- **CSV Upload Interface:** Easy bulk data management

## 🔒 Security & Compliance

### Regulatory Compliance
- **HIPAA (Health Insurance Portability and Accountability Act):** Full compliance with patient data privacy and security requirements
- **HITECH Act:** Enhanced security standards for electronic health records
- **21 CFR Part 11:** FDA electronic records compliance for medical data integrity

### Security Features
- **Multi-Factor Authentication (MFA):** TOTP-based 2FA for enhanced account security
- **End-to-End Encryption:** Secure data transmission and storage
- **Role-Based Access Control (RBAC):** Granular permissions for patients, doctors, and administrators
- **Audit Trails:** Comprehensive logging of all data access and modifications
- **Session Management:** Secure JWT-based authentication with refresh tokens
- **HIPAA Consent Forms:** Digital consent management with versioning

## 🎨 Accessibility

### Color Blindness Accessible Design
- **Teal-Purple-Orange Palette:** Carefully selected colors distinguishable by all types of color vision deficiency
- **High Contrast Ratios:** WCAG AAA compliant contrast levels
- **Multiple Visual Indicators:** Never relying solely on color to convey information
- **Tested Color Combinations:** Verified with colorblindness simulation tools

### Responsive Design
- **Mobile-First Approach:** Optimized for smartphones and tablets
- **Progressive Web App (PWA) Ready:** Works offline and can be installed
- **Cross-Browser Compatible:** Works on all modern browsers
- **Touch-Friendly Interface:** Large tap targets and gesture support

## 🏗️ Technical Architecture

### Frontend
- **React 18:** Modern component-based UI framework
- **TypeScript:** Type-safe development
- **Tailwind CSS v4:** Utility-first styling with custom design tokens
- **Lucide React:** Icon library
- **Recharts:** Data visualization for health metrics
- **React Hook Form:** Form validation and management
- **Sonner:** Toast notifications

### Backend
- **Supabase:** Complete backend-as-a-service
  - PostgreSQL database with Row Level Security (RLS)
  - Edge Functions (Deno runtime)
  - Authentication with JWT
  - Storage for medical images and documents
- **Hono:** Fast web framework for Edge Functions
- **Key-Value Store:** Custom KV implementation for flexible data storage

### Server Architecture (Three-Tier)
```
Frontend (React) 
    ↓ HTTPS + JWT
Server (Hono on Supabase Edge Functions) 
    ↓ Service Role Key
Database (PostgreSQL with RLS)
```

### API Structure
- **Base URL:** `https://${projectId}.supabase.co/functions/v1/make-server-699d067f/`
- **Authentication:** Bearer token in Authorization header
- **Endpoints:**
  - `/auth/signup` - User registration
  - `/patient/:id` - Patient data operations
  - `/upload-image` - Medical document uploads
  - `/guest-access` - MRN-based access
  - `/moh/*` - Ministry of Health integration
  - `/audit-logs/:userId` - Audit log retrieval

## 📁 Project Structure

```
/
├── App.tsx                          # Main application entry point
├── components/
│   ├── AuthScreen.tsx               # Authentication wrapper
│   ├── Login.tsx                    # Login component
│   ├── PatientDashboard.tsx         # Patient portal main view
│   ├── DoctorDashboard.tsx          # Doctor portal main view
│   ├── GuestAccess.tsx              # MRN-based guest access
│   ├── PatientProfile.tsx           # Patient information management
│   ├── MedicalHistory.tsx           # Medical history viewer/editor
│   ├── MedicationTracker.tsx        # Medication management
│   ├── ImmunizationsTracker.tsx     # Immunization records
│   ├── VitalSignsTracker.tsx        # Vital signs logging and charts
│   ├── AppointmentsManager.tsx      # Appointment scheduling
│   ├── TestResultsViewer.tsx        # Lab results and diagnostics
│   ├── SecureMessaging.tsx          # HIPAA-compliant messaging
│   ├── CareTeam.tsx                 # Healthcare provider network
│   ├── BarcodeGenerator.tsx         # QR code generation
│   ├── MFASetup.tsx                 # Multi-factor auth setup
│   ├── MFAVerification.tsx          # 2FA verification
│   ├── HIPAAConsent.tsx             # Digital consent forms
│   ├── PatientDetails.tsx           # Doctor view of patient records
│   └── ui/                          # Shadcn UI components
├── supabase/functions/server/
│   ├── index.tsx                    # Main server with all routes
│   └── kv_store.tsx                 # Key-value store utility
├── lib/
│   └── supabase.ts                  # Supabase client initialization
├── utils/supabase/
│   └── info.tsx                     # Supabase configuration
└── styles/
    └── globals.css                  # Global styles and design tokens
```

## 🗄️ Database Schema

### Key-Value Store Table: `kv_store_699d067f`
```sql
CREATE TABLE kv_store_699d067f (
  key TEXT PRIMARY KEY,
  value JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Data Organization (Key Prefixes)
- `user:<userId>` - User profile and settings
- `patient:<userId>` - Patient medical records
- `doctor:<userId>` - Doctor profiles and credentials
- `medical_history:<userId>` - Medical history records
- `medications:<userId>` - Medication lists
- `immunizations:<userId>` - Immunization records
- `vital_signs:<userId>` - Vital sign measurements
- `appointments:<userId>` - Appointment data
- `test_results:<userId>` - Lab results
- `messages:<conversationId>` - Secure messages
- `guest_access:<mrn>` - Guest access credentials
- `moh_professional:<licenseNumber>` - MOH imported professionals
- `audit_log:<timestamp>:<action>` - Audit trail entries

## 🔐 Authentication Flow

### Patient/Doctor Login
1. User submits email and password
2. Frontend calls Supabase Auth `signInWithPassword()`
3. Supabase returns access token and session
4. Frontend stores access token
5. Subsequent API calls include token in Authorization header
6. Server verifies JWT using Supabase Auth `getUser()`
7. **Current Issue:** JWT verification failing at step 6

### Guest Access (MRN-based)
1. Patient receives MRN and password from healthcare facility
2. User enters MRN and password on guest access page
3. Server validates credentials against `guest_access:<mrn>` record
4. Limited medical information returned (no account creation)

### MOH Professional Import
1. Administrator uploads CSV with professional data
2. Server processes bulk import via `/moh/import` endpoint
3. For each professional:
   - Create Supabase Auth account
   - Generate secure random password
   - Store professional details in KV store
   - Create audit log entry
4. Return summary with credentials for distribution

## 🚀 Deployment & Configuration

### Environment Variables
- `SUPABASE_URL` - Supabase project URL
- `SUPABASE_ANON_KEY` - Public anonymous key (frontend)
- `SUPABASE_SERVICE_ROLE_KEY` - Service role key (backend only)
- `SUPABASE_DB_URL` - Direct database connection string
- `MOH_API_KEY` - Ministry of Health API authentication key

### Security Notes
- **NEVER** expose `SUPABASE_SERVICE_ROLE_KEY` to frontend
- All server routes use service role for elevated permissions
- Frontend uses anon key with Row Level Security policies
- API keys stored in Supabase Edge Functions environment

## 🐛 Known Issues & Troubleshooting

### Critical: Invalid JWT Error (401)
**Problem:** After successful login, authenticated API calls fail with "Invalid JWT" error.

**Symptoms:**
- Login succeeds and returns access token
- First API call to `/patient/:id` returns 401
- Server logs indicate JWT verification failure

**Investigation Steps:**
1. Check Supabase Edge Functions dashboard logs
2. Verify JWT token format and claims
3. Confirm SUPABASE_URL and keys are correct
4. Test JWT verification with different approaches
5. Add detailed logging at each verification step

**Attempted Fixes:**
- Added comprehensive error logging
- Implemented configuration checks on startup
- Tried multiple JWT verification methods
- Validated environment variable presence
- Checked JWT structure and expiration

**Next Steps:**
- Review detailed server logs in Supabase dashboard
- Identify exact JWT verification failure point
- Consider alternative authentication approaches if needed

### Documentation Files for Troubleshooting
- `/JWT_ERROR_FIX.md` - Initial troubleshooting steps
- `/JWT_TROUBLESHOOTING.md` - Comprehensive debugging guide
- `/AUTH_VERIFICATION_CHECKLIST.md` - Verification checklist
- `/DEBUGGING_AUTH_DISABLED.md` - Debugging authentication
- `/AUTH_FIX_COMPLETE.md` - Completed fixes documentation

## 📚 Additional Documentation

- `/README.md` - Main project readme
- `/GETTING_STARTED.md` - Setup and installation guide
- `/SYSTEM_ARCHITECTURE.md` - Detailed architecture documentation
- `/ACCESSIBILITY.md` - Accessibility features and testing
- `/DASHBOARD_GUIDE.md` - User interface guide
- `/INTERFACE_GUIDE.md` - UI component documentation
- `/QUICK_REFERENCE.md` - Quick reference guide
- `/MOH_API_DOCUMENTATION.md` - MOH integration API docs
- `/MOH_QUICK_REFERENCE.md` - MOH system quick reference
- `/IMPLEMENTATION_SUMMARY.md` - Implementation notes

## 🛠️ Development

### Prerequisites
- Node.js 18+
- npm or yarn
- Supabase account and project
- Modern web browser

### Local Setup
1. Clone repository
2. Install dependencies: `npm install`
3. Configure Supabase environment variables
4. Deploy Edge Functions to Supabase
5. Run development server: `npm run dev`

### Testing
- Manual testing in development environment
- MOH import testing: `/moh_test_interface.html`
- Sample data: `/sample_professionals.csv`
- Test script: `/moh_import_script.py`

## 🎯 Future Enhancements

- Video consultation integration
- Prescription management system
- Insurance claim processing
- Healthcare provider directory
- Appointment reminder notifications
- Lab integration for automatic result imports
- Wearable device integration
- AI-powered symptom checker
- Multi-language support
- Advanced analytics dashboard

## 📄 License

This is a proprietary healthcare application. All rights reserved.

## 👥 Contributors

[Add contributor information]

## 📞 Support

For issues, questions, or contributions, please open a GitHub issue.

---

**Last Updated:** February 11, 2026  
**Version:** 1.0.0 (Beta - Authentication Issue Under Investigation)  
**Status:** Active Development - Critical JWT Issue Blocking Production Deployment

**Repository:** https://github.com/jrfelixe/ehtag-telehealth-system