# set   TF_VAR_ variables: $ source env.sh
# unset TF_VAR_ variables: $ unset ${!TF_VAR_@}
# inspect TF_VAR_ variables: env | grep TF_VAR_
export TF_VAR_user_ocid=USER_OCID
export TF_VAR_fingerprint=FINGERPRINT
export TF_VAR_compartment_ocid=COMPARTMENT_OCID
export TF_VAR_tenancy_ocid=TENANCY_OCID
export TF_VAR_region=us-ashburn-1
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem

export TF_VAR_subnet_ocid=SUBNET_OCID