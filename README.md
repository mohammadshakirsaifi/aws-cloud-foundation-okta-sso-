# AWS Cloud Foundation Okta-SSO
# Okta SSO Bundle for AWS (CloudFormation + CLI)

## 📂 Files in this bundle
- `okta-metadata.xml` → Okta IdP metadata (downloaded from Okta Admin Console).
- `okta-multi-role-sso.yml` → CloudFormation template (creates SAML provider + IAM roles).
- `okta-sso-login.sh` → Helper script to log in and assume AWS roles via Okta (using saml2aws).
- `README.md` → This guide.

## 📂 Project Structure

```bash
okta-sso-bundle/
  ├── okta-metadata.xml
  ├── okta-multi-role-sso.yml
  ├── okta-sso-login.sh
  └── README.md

```
---

## 🚀 Integration Steps

### 1. Download Okta Metadata
- In Okta Admin Console → **Applications → Your AWS SAML App → Sign On tab → Identity Provider metadata**  
- Download the metadata XML and replace the placeholder inside `okta-metadata.xml`.

---

### 2. Deploy CloudFormation Template
Run:
```bash
aws cloudformation deploy \
  --template-file okta-multi-role-sso.yml \
  --stack-name OktaSSOMultiRole \
  --capabilities CAPABILITY_NAMED_IAM
```
This deploys:

IAM SAML Provider → OktaSAML

IAM Roles → OktaAdmin, OktaDev, OktaReadOnly
---

### 3. Configure CLI with saml2aws

Install saml2aws:
```bash
brew install saml2aws     # macOS
choco install saml2aws    # Windows
```
Configure:
```bash
saml2aws configure
```
- Choose Okta as provider
- Enter Okta app URL
- Save profile as `okta`
---
### 4. Log in with Helper Script
```bash
chmod +x okta-sso-login.sh
./okta-sso-login.sh
```
- Prompts you to authenticate with Okta
- Lists available AWS roles (Admin, Dev, ReadOnly)
- After selection → credentials stored in ~/.aws/credentials

  ### Result
- You now have Okta SSO → AWS (Console + CLI) with multiple role options.
