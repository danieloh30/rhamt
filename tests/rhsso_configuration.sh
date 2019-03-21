
#!/bin/bash
# Get the acces token 
export TKN=$(curl -k -X POST 'https://secure-rhamt-web-console-labs-infra.apps.seoul-250a.openshiftworkshop.com/auth/realms/master/protocol/openid-connect/token' \
 -H "Content-Type: application/x-www-form-urlencoded" \
 -d "username=admin" \
 -d 'password=password' \
 -d 'grant_type=password' \
 -d 'client_id=admin-cli' | jq -r '.access_token')

 # Update a master realm with RH-SSO theme
curl -k -X PUT 'https://secure-rhamt-web-console-labs-infra.apps.seoul-250a.openshiftworkshop.com/auth/admin/realms/master/' \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer $TKN" \
 -d '{ "displayName": "rh-sso", "displayNameHtml": "<strong>Red Hat</strong><sup>®</sup> Single Sign On", "loginTheme": "rh-sso", "adminTheme": "rh-sso", "accountTheme": "rh-sso", "emailTheme": "rh-sso", "accessTokenLifespan": 100 }'  | jq .


# Create a new user
curl -k -X POST 'https://secure-rhamt-web-console-labs-infra.apps.seoul-250a.openshiftworkshop.com/auth/admin/realms/rhamt/users' \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer $TKN" \
 -d '{ "username": "user1", "enabled": true, "disableableCredentialTypes": [ "password" ] }'  | jq .

# Reset a password
curl -k -X PUT 'https://secure-rhamt-web-console-labs-infra.apps.seoul-250a.openshiftworkshop.com/auth/admin/realms/rhamt/users/a740ca07-81d3-4192-b755-f10ff5198089/reset-password' \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer $TKN" \
 -d '{ "type": "password", "value": "openshift", "temporary": true}'  | jq .

# Get user ID lists
curl -k -X GET 'https://secure-rhamt-web-console-labs-infra.apps.seoul-250a.openshiftworkshop.com/auth/admin/realms/rhamt/users/' \
-H "Accept: application/json" \
-H "Authorization: Bearer $TKN" | jq -r '.[].id'

 # Update a master realm with RH-SSO theme
curl -k -X PUT 'https://secure-rhamt-web-console-labs-infra.apps.seoul-250a.openshiftworkshop.com/auth/admin/realms/master/' \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer $TKN" \
 -d '{ "displayName": "rh-sso", "displayNameHtml": "<strong>Red Hat</strong><sup>®</sup> Single Sign On", "loginTheme": "rh-sso", "adminTheme": "rh-sso", "accountTheme": "rh-sso", "emailTheme": "rh-sso" }'  | jq .

curl -k -X GET 'https://secure-rhamt-web-console-labs-infra.apps.seoul-250a.openshiftworkshop.com/auth/admin/realms/master' \
-H "Accept: application/json" \
-H "Authorization: Bearer $TKN" | jq .