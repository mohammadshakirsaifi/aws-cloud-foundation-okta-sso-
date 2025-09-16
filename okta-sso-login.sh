#!/bin/bash
# okta-sso-login.sh
# Requires: saml2aws installed & configured

PROFILE="okta"

echo "🔐 Logging in to Okta via SAML..."
saml2aws login --profile $PROFILE

echo "📋 Available roles:"
saml2aws list-roles --profile $PROFILE

echo "👉 Enter the number of the role you want to assume:"
read ROLE_INDEX

echo "⏳ Assuming role..."
saml2aws exec --role-index "$ROLE_INDEX" --profile $PROFILE -- aws sts get-caller-identity

echo "✅ Done. You're now using profile: $PROFILE, role index: $ROLE_INDEX"
