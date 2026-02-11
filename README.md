# EHTAG - Electronic Health Tag System

## 🏥 Comprehensive Telehealth Platform - MyChart-Inspired Patient Portal

**EHTAG** is a HIPAA-compliant, enterprise-grade Electronic Health Records (EHR) system built with React, TypeScript, Tailwind CSS, and Supabase. This full-featured telehealth platform mirrors leading patient portals like MyChart, providing comprehensive healthcare management for both patients and medical professionals.

---

## 🌟 Complete Feature Set

### **Patient Portal Features** (MyChart-Equivalent)

#### 📅 **Appointments Management**
- Schedule new appointments (in-person, video, phone)
- View upcoming and past appointments
- Cancel or reschedule appointments
- Appointment reminders and notifications
- Video call integration for telehealth visits
- Appointment history tracking

#### 💬 **Secure HIPAA-Compliant Messaging**
- Direct messaging with healthcare providers
- Message categories (general, test results, prescriptions, billing)
- Read/unread status tracking
- Message attachments support
- Conversation threading
- Non-urgent communication channel

#### 🧪 **Test Results & Lab Reports**
- View all test results and lab reports
- Detailed test values with reference ranges
- Result status indicators (normal, high, low, critical)
- Filter by test category (blood tests, imaging, etc.)
- Download test reports
- Provider notes and interpretations
- Test result history tracking

#### 💉 **Immunizations & Vaccines**
- Complete vaccination history
- Upcoming dose reminders
- Vaccine details (manufacturer, lot number, location)
- Downloadable immunization records
- Multi-dose series tracking
- Add new immunization records

#### 📋 **Medical Records & History**
- Comprehensive medical history
- Visit summaries and after-visit notes
- Diagnoses and treatment plans
- Clinical notes from providers
- Medical imaging (MRI, X-rays, CT scans)
- Document upload and sharing

#### 💊 **Medication Management**
- Current and past medications
- Dosage and frequency tracking
- Medication adherence monitoring
- Refill management
- Side effects tracking
- Medication interactions alerts

#### ❤️ **Vital Signs Tracking**
- Blood pressure monitoring
- Heart rate tracking
- Temperature logging
- Weight and BMI tracking
- Blood glucose levels
- Respiratory rate
- Oxygen saturation (SpO2)
- Visual charts and trend analysis

#### 👤 **Personal Health Profile**
- Demographic information
- Emergency contacts
- Insurance information
- Allergy tracking
- Medical conditions
- Family medical history
- Preferred pharmacy

#### 🔐 **Security & Privacy**
- Multi-Factor Authentication (MFA/2FA)
- Biometric authentication support
- Session management
- Password reset functionality
- HIPAA-compliant audit logging
- Access logs for all PHI access
- Secure data encryption

#### 📱 **QR Code & Emergency Access**
- Generate QR codes for emergency access
- Guest access with MRN and password
- Limited information for emergency responders
- Quick access to critical medical data

---

### **Doctor/Provider Portal Features**

#### 🔍 **Patient Management**
- Search and view all patients
- Access complete patient records
- Add medical records and diagnoses
- Upload medical images and reports
- Add test results
- Prescribe medications
- Document visit notes

#### 📊 **Clinical Tools**
- Patient dashboard overview
- Medical history review
- Vital signs analysis
- Medication review
- Test result interpretation
- Clinical decision support

#### 💼 **Administrative Features**
- Patient search and filtering
- Record creation and updates
- Secure messaging with patients
- Appointment management
- Documentation and reporting

---

## 🔒 HIPAA & Regulatory Compliance

### **Compliance Features**

✅ **HIPAA (Health Insurance Portability and Accountability Act)**
- End-to-end data encryption
- Secure authentication and authorization
- Audit logging of all PHI access
- Patient consent management
- Data breach notification procedures
- Business Associate Agreements (BAA) ready

✅ **HITECH Act (Health Information Technology for Economic and Clinical Health)**
- Electronic health records standards
- Meaningful use compliance
- Security breach notification
- Audit controls and monitoring

✅ **21 CFR Part 11 (FDA Electronic Records)**
- Electronic signature validation
- Audit trail requirements
- System access controls
- Data integrity verification

---

## 🏗️ Technical Architecture

### **Frontend**
- **Framework**: React 18 with TypeScript
- **Styling**: Tailwind CSS v4
- **UI Components**: Custom component library (Shadcn/ui)
- **State Management**: React Hooks
- **Icons**: Lucide React
- **Charts**: Recharts
- **QR Codes**: react-qr-code
- **Barcode**: react-barcode

### **Backend**
- **Platform**: Supabase (PostgreSQL + Edge Functions)
- **Runtime**: Deno
- **API Framework**: Hono
- **Database**: PostgreSQL with KV store
- **Storage**: Supabase Storage (private buckets)
- **Authentication**: Supabase Auth with MFA

### **Infrastructure**
- **Hosting**: Supabase (fully managed)
- **Database**: PostgreSQL 15+
- **Storage**: S3-compatible object storage
- **CDN**: Global edge network
- **SSL**: Automatic HTTPS

---

## 🚀 Quick Start

### **Prerequisites**
1. Supabase account (free tier available)
2. Node.js 18+ installed
3. Git installed

### **Installation**

```bash
# Clone the repository
git clone https://github.com/jrfelixe/ehtag-telehealth-system.git
cd ehtag-telehealth-system

# Install dependencies
npm install

# Configure environment variables
cp .env.example .env
# Edit .env with your Supabase credentials

# Run development server
npm run dev
```

---

## 📚 Documentation

- **[Project Summary](PROJECT_SUMMARY.md)** - Comprehensive project overview
- **[Getting Started](GETTING_STARTED.md)** - Setup and installation guide
- **[System Architecture](SYSTEM_ARCHITECTURE.md)** - Detailed architecture documentation
- **[API Documentation](MOH_API_DOCUMENTATION.md)** - API reference
- **[Accessibility Guide](ACCESSIBILITY.md)** - Accessibility features

---

## 🎯 Feature Comparison: EHTAG vs MyChart

| Feature | MyChart | EHTAG | Status |
|---------|---------|-------|--------|
| Appointments | ✅ | ✅ | Complete |
| Secure Messaging | ✅ | ✅ | Complete |
| Test Results | ✅ | ✅ | Complete |
| Medications | ✅ | ✅ | Complete |
| Immunizations | ✅ | ✅ | Complete |
| Vital Signs | ✅ | ✅ | Complete |
| Medical History | ✅ | ✅ | Complete |
| Billing | ✅ | 🚧 | Planned |
| Insurance | ✅ | 🚧 | Planned |
| Video Visits | ✅ | ✅ | Complete |
| QR Code Access | ❌ | ✅ | Enhanced |
| Guest Access | ❌ | ✅ | Enhanced |
| MFA | ✅ | ✅ | Complete |
| Mobile App | ✅ | 📱 | Responsive Web |

---

## 🔑 Key Security Features

### **Authentication**
- ✅ Secure password hashing (bcrypt)
- ✅ Multi-Factor Authentication (TOTP)
- ✅ Session management
- ✅ Password reset via email
- ✅ Account lockout after failed attempts

### **Authorization**
- ✅ Role-based access control
- ✅ Patient can only access own data
- ✅ Doctor can access all patients
- ✅ Guest access with limited permissions

### **Data Protection**
- ✅ Encryption at rest (AES-256)
- ✅ Encryption in transit (TLS 1.3)
- ✅ Secure file storage
- ✅ Private storage buckets

### **Audit & Compliance**
- ✅ Complete audit trail
- ✅ User activity logging
- ✅ PHI access tracking
- ✅ HIPAA compliance reports

---

## ⚠️ Known Issues

### **Critical: JWT Authentication Error**
The system is experiencing persistent "Invalid JWT" errors (401) when fetching patient data after login. Investigation ongoing. See [JWT_TROUBLESHOOTING.md](JWT_TROUBLESHOOTING.md) for details.

---

## 📞 Support

For issues and questions, please open a GitHub issue or contact the development team.

---

## 📄 License

This is a proprietary healthcare application. All rights reserved.

---

## ⚠️ Important Legal Notice

This system handles Protected Health Information (PHI) and must be used in compliance with:
- HIPAA Privacy Rule
- HIPAA Security Rule
- HITECH Act
- 21 CFR Part 11
- State-specific healthcare regulations

**Before deploying to production:**
1. Complete HIPAA risk assessment
2. Sign Business Associate Agreement (BAA) with Supabase
3. Implement additional security controls as needed
4. Consult with legal counsel
5. Obtain appropriate certifications
6. Train all users on HIPAA compliance

---

**Built with ❤️ for better healthcare**

**Repository**: https://github.com/jrfelixe/ehtag-telehealth-system