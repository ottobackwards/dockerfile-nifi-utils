#!/bin/sh -ex

echo '!!! Updating login providers file...'

login_providers_file=${NIFI_HOME}/conf/login-identity-providers.xml
property_xpath='//loginIdentityProviders/provider/property'

edit_property() {
  property_name=$1
  property_value=$2

  xmlstarlet ed --inplace -u "${property_xpath}[@name='${property_name}']" -v "${property_value}" "${login_providers_file}"
}


# Remove comments to enable the ldap-provider
sed -i.bak -e '66d;96d' "${login_providers_file}"

edit_property 'Authentication Strategy'     "${LDAP_AUTHENTICATION_STRATEGY}"
edit_property 'Manager DN'                  "${LDAP_MANAGER_DN}"
edit_property 'Manager Password'            "${LDAP_MANAGER_PASSWORD}"
edit_property 'TLS - Keystore'              "${LDAP_TLS_KEYSTORE}"
edit_property 'TLS - Keystore Password'     "${LDAP_TLS_KEYSTORE_PASSWORD}"
edit_property 'TLS - Keystore Type'         "${LDAP_TLS_KEYSTORE_TYPE}"
edit_property 'TLS - Truststore'            "${LDAP_TLS_TRUSTSTORE}"
edit_property 'TLS - Truststore Password'   "${LDAP_TLS_TRUSTSTORE_PASSWORD}"
edit_property 'TLS - Truststore Type'       "${LDAP_TLS_TRUSTSTORE_TYPE}"
edit_property 'TLS - Client Auth'           'clientauth'
edit_property 'TLS - Protocol'              'protocol'
edit_property 'Url'                         "${LDAP_URL}"
edit_property 'User Search Base'            "${LDAP_USER_SEARCH_BASE}"
edit_property 'User Search Filter'          "${LDAP_USER_SEARCH_FILTER}"
edit_property 'Identity Strategy'           "${LDAP_IDENTITY_STRATEGY}"
edit_property 'Authentication Expiration'   '12 days'
