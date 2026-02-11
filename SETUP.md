# EHTAG Setup & Deployment Guide

## 🛠️ Complete Setup Instructions

### Important Note

This repository was created from your Figma Make project. To push your complete project code to GitHub, follow these instructions.

---

## Step 1: Export Your Figma Make Project

### Option A: Using Git (Recommended)

If you have access to the file system where your Figma Make project is stored:

1. **Locate your project files**
   - Your project is currently in the Figma Make environment
   - You'll need to copy all project files to your local machine

2. **Clone this repository**
   ```bash
   git clone https://github.com/jrfelixe/ehtag-telehealth-system.git
   cd ehtag-telehealth-system
   ```

3. **Copy your project files**
   - Copy all files from your Figma Make project to this directory
   - Make sure to include:
     - `/App.tsx`
     - `/components/` (all component files)
     - `/supabase/functions/server/` (server files)
     - `/lib/`
     - `/utils/`
     - `/styles/`
     - All documentation files (*.md)
     - `package.json`
     - All configuration files

4. **Commit and push**
   ```bash
   git add .
   git commit -m "Add complete EHTAG project files"
   git push origin main
   ```

### Option B: Manual File Upload via GitHub Web Interface

1. Go to https://github.com/jrfelixe/ehtag-telehealth-system
2. Click "Add file" > "Upload files"
3. Drag and drop all your project files
4. Commit the changes

---

## Step 2: Supabase Configuration

### Create Supabase Project

1. **Sign up for Supabase**
   - Go to [https://supabase.com](https://supabase.com)
   - Create a new account or sign in
   - Click "New Project"

2. **Configure your project**
   - Organization: Select or create
   - Project name: `ehtag-production` (or your preferred name)
   - Database password: Generate a strong password (save this!)
   - Region: Choose closest to your users
   - Pricing plan: Start with Free tier

3. **Get your API credentials**
   - Go to Project Settings > API
   - Copy these values:
     - Project URL
     - anon/public key
     - service_role key (KEEP THIS SECRET!)

### Update Configuration Files

1. **Update `/utils/supabase/info.tsx`**
   ```typescript
   export const projectId = 'YOUR_PROJECT_ID'; // From your Supabase URL
   export const publicAnonKey = 'YOUR_ANON_KEY';
   ```

2. **Create `.env` file (locally)**
   ```bash
   cp .env.example .env
   # Edit .env with your actual Supabase credentials
   ```

### Deploy Edge Functions

1. **Install Supabase CLI**
   ```bash
   npm install -g supabase
   ```

2. **Login to Supabase**
   ```bash
   supabase login
   ```

3. **Link your project**
   ```bash
   supabase link --project-ref YOUR_PROJECT_REF
   ```

4. **Deploy the server function**
   ```bash
   supabase functions deploy make-server-699d067f
   ```

5. **Set environment variables in Supabase**
   ```bash
   supabase secrets set SUPABASE_URL=your_url
   supabase secrets set SUPABASE_ANON_KEY=your_anon_key
   supabase secrets set SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
   supabase secrets set MOH_API_KEY=your_moh_key
   ```

---

## Step 3: Database Setup

The application uses a Key-Value store for flexible data storage.

### Create KV Store Table

1. **Go to Supabase Dashboard > SQL Editor**
2. **Run this SQL**:
   ```sql
   CREATE TABLE kv_store_699d067f (
     key TEXT PRIMARY KEY,
     value JSONB NOT NULL,
     created_at TIMESTAMP DEFAULT NOW(),
     updated_at TIMESTAMP DEFAULT NOW()
   );

   -- Create index for prefix queries
   CREATE INDEX idx_kv_prefix ON kv_store_699d067f (key text_pattern_ops);

   -- Create updated_at trigger
   CREATE OR REPLACE FUNCTION update_updated_at_column()
   RETURNS TRIGGER AS $$
   BEGIN
     NEW.updated_at = NOW();
     RETURN NEW;
   END;
   $$ language 'plpgsql';

   CREATE TRIGGER update_kv_updated_at
   BEFORE UPDATE ON kv_store_699d067f
   FOR EACH ROW
   EXECUTE FUNCTION update_updated_at_column();
   ```

### Configure Row Level Security (Optional but Recommended)

```sql
-- Enable RLS
ALTER TABLE kv_store_699d067f ENABLE ROW LEVEL SECURITY;

-- Allow service role to do anything
CREATE POLICY "Service role has full access"
ON kv_store_699d067f
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);
```

---

## Step 4: Authentication Setup

### Enable Email Authentication

1. **Go to Supabase Dashboard > Authentication > Providers**
2. **Enable Email provider**
   - Toggle "Enable Email provider"
   - Configure email templates (optional)
   - Save changes

### Setup Multi-Factor Authentication (MFA)

1. **Go to Authentication > Settings**
2. **Enable MFA**
   - Toggle "Enable Multi-Factor Authentication"
   - Choose TOTP (Time-based One-Time Password)
   - Save changes

### Configure Email Settings (Optional)

1. **Go to Project Settings > Auth**
2. **Setup SMTP** (for custom email domain)
   - Or use Supabase's default email service
   - Configure:
     - SMTP Host
     - SMTP Port
     - SMTP Username
     - SMTP Password
     - Sender email
     - Sender name

---

## Step 5: Storage Configuration

The application automatically creates storage buckets on first run, but you can verify:

1. **Go to Supabase Dashboard > Storage**
2. **Verify bucket exists**: `make-699d067f-medical-images`
3. **If not, create manually**:
   - Click "New Bucket"
   - Name: `make-699d067f-medical-images`
   - Public: **OFF** (private bucket)
   - Create

---

## Step 6: Frontend Deployment

### Option A: Deploy to Vercel (Recommended)

1. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **Login to Vercel**
   ```bash
   vercel login
   ```

3. **Deploy**
   ```bash
   vercel --prod
   ```

4. **Configure environment variables in Vercel**
   - Go to your Vercel project settings
   - Add environment variables (if needed for build)

### Option B: Deploy to Netlify

1. **Install Netlify CLI**
   ```bash
   npm install -g netlify-cli
   ```

2. **Build your project**
   ```bash
   npm run build
   ```

3. **Deploy**
   ```bash
   netlify deploy --prod
   ```

### Option C: Other Hosting Providers

- **AWS Amplify**: Connect GitHub repo
- **Firebase Hosting**: Use Firebase CLI
- **Custom Server**: Host the `/dist` folder with Nginx/Apache

---

## Step 7: Post-Deployment Configuration

### Update Redirect URLs

1. **In Supabase Dashboard > Authentication > URL Configuration**
2. **Add your production URL**
   - Site URL: `https://your-domain.com`
   - Redirect URLs: Add all allowed callback URLs

### Test Your Deployment

1. **Create test accounts**
   - Register as a patient
   - Register as a doctor (via MOH import)

2. **Test all features**
   - ✅ Patient registration
   - ✅ Doctor access
   - ✅ Medical record creation
   - ✅ File uploads
   - ✅ Guest access
   - ✅ MFA setup
   - ✅ Secure messaging
   - ✅ Appointments
   - ✅ Vital signs

### Monitor Your Application

1. **Supabase Dashboard**
   - Monitor database usage
   - Check API requests
   - Review auth users
   - Monitor storage

2. **Edge Functions Logs**
   - Go to Edge Functions > make-server-699d067f > Logs
   - Monitor for errors
   - Check JWT verification logs

---

## 🚨 Known Issues & Fixes

### JWT Authentication Error (401)

**If you encounter "Invalid JWT" errors after login:**

1. **Check Environment Variables**
   ```bash
   supabase secrets list
   ```
   Verify all secrets are set correctly

2. **Check Edge Function Logs**
   - Go to Supabase Dashboard > Edge Functions
   - Click on `make-server-699d067f`
   - View Logs tab
   - Look for JWT verification errors

3. **Common fixes**:
   - Ensure `SUPABASE_SERVICE_ROLE_KEY` is correct
   - Verify `SUPABASE_URL` matches your project
   - Check token expiration settings
   - Redeploy edge functions

4. **Debug steps**:
   ```bash
   # Test the debug endpoint
   curl -X POST https://YOUR_PROJECT.supabase.co/functions/v1/make-server-699d067f/debug/verify-token \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
     -H "Content-Type: application/json"
   ```

---

## 🔒 Security Checklist

Before going to production:

- [ ] All environment variables are secured
- [ ] `.env` file is in `.gitignore`
- [ ] Service role key is never exposed to frontend
- [ ] HTTPS is enabled (automatic with Vercel/Netlify)
- [ ] MFA is enabled for admin accounts
- [ ] Audit logging is functional
- [ ] Password policies are enforced
- [ ] CORS is properly configured
- [ ] Rate limiting is enabled (Supabase does this automatically)
- [ ] Regular backups are scheduled
- [ ] HIPAA Business Associate Agreement signed with Supabase
- [ ] Security audit completed
- [ ] Incident response plan in place

---

## 📚 Additional Resources

- **Supabase Documentation**: https://supabase.com/docs
- **React Documentation**: https://react.dev
- **Tailwind CSS**: https://tailwindcss.com
- **HIPAA Guidelines**: https://www.hhs.gov/hipaa

---

## 👥 Need Help?

If you encounter any issues:

1. Check the documentation files in this repo
2. Review Supabase Edge Function logs
3. Open a GitHub issue with detailed error information
4. Include:
   - Error messages
   - Steps to reproduce
   - Browser console logs
   - Edge function logs

---

**Ready to deploy your HIPAA-compliant telehealth platform!** 🚀

Follow these steps carefully and you'll have a production-ready system.