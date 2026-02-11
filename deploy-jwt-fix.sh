#!/bin/bash

# EHTAG - Quick Fix Deployment Script
# This script deploys the JWT authentication fix to your Supabase project

echo "🚀 EHTAG JWT Fix Deployment"
echo "================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Your project reference
PROJECT_REF="kdyeygenflpakvlhxxeq"

echo "📋 Project: $PROJECT_REF"
echo ""

# Step 1: Check if Supabase CLI is installed
echo "🔍 Checking for Supabase CLI..."
if ! command -v supabase &> /dev/null; then
    echo -e "${RED}❌ Supabase CLI not found${NC}"
    echo ""
    echo "Install it with:"
    echo "  npm install -g supabase"
    echo ""
    exit 1
fi
echo -e "${GREEN}✅ Supabase CLI found${NC}"
echo ""

# Step 2: Check if logged in
echo "🔐 Checking authentication..."
if ! supabase projects list &> /dev/null; then
    echo -e "${YELLOW}⚠️  Not logged in to Supabase${NC}"
    echo ""
    echo "Logging in..."
    supabase login
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Login failed${NC}"
        exit 1
    fi
fi
echo -e "${GREEN}✅ Authenticated${NC}"
echo ""

# Step 3: Deploy Edge Function
echo "📦 Deploying Edge Function with JWT fix..."
echo ""
supabase functions deploy make-server-699d067f --project-ref $PROJECT_REF

if [ $? -ne 0 ]; then
    echo ""
    echo -e "${RED}❌ Deployment failed${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "1. Make sure you're in the project root directory"
    echo "2. Verify the function exists at: /supabase/functions/server/"
    echo "3. Check your internet connection"
    echo "4. Try: supabase link --project-ref $PROJECT_REF"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ Edge Function deployed successfully!${NC}"
echo ""

# Step 4: Verify secrets
echo "🔑 Verifying environment variables..."
supabase secrets list --project-ref $PROJECT_REF

echo ""
echo "================================"
echo -e "${GREEN}🎉 Deployment Complete!${NC}"
echo "================================"
echo ""
echo "Next steps:"
echo "1. Go to your EHTAG application"
echo "2. Try registering a new patient account"
echo "3. Or login with existing credentials"
echo "4. Check browser console for success messages"
echo ""
echo "Expected logs:"
echo "  ✅ User signed in"
echo "  ✅ Patient data received successfully"
echo "  ✅✅✅ PATIENT LOGIN COMPLETE!"
echo ""
echo "If you see 'Invalid login credentials':"
echo "  → Create a new account via registration"
echo "  → Or reset password for existing account"
echo ""
echo "Need help? Check: /JWT_FIX_COMPLETE_FINAL.md"
echo ""