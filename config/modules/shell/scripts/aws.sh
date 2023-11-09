# Use a digitalocean endpoint
# Note: a `region` needs to be configured for the given profile
aws-do() {
  REGION=$(aws configure get region || printf "nyc3")
  aws --endpoint="https://${REGION}.digitaloceanspaces.com" $@
}

# Use a cloudflare endpoint
# Note: an `account_id` needs to be configured for the given profile
aws-cf() {
  ACCOUNT=$(aws configure get account_id || printf "nyc3")
  aws --endpoint="https://${ACCOUNT}.r2.cloudflarestorage.com" $@
}

# Update the currently active AWS profile
aws-profile() {
  export AWS_PROFILE="${1}"
}

