#!/bin/bash
env="prod"
team_name="demothingdasij"

namespace="all_consumers"
github_token="adskjladsf"
owner_email="foo@goo.com"
charge_back="daslfk"

TFC_WORKSPACE=${env}-${team_name}

ORG_NAME="mustafa-lab"
MODULE_ID="nocode-SypBAATpRaVpMvgv"

if [ "$env" == "dev" ]; then
    PROJECT_ID="prj-1KLUcsmXaKU9t8LF"
else
    PROJECT_ID="prj-j3DgBDScxErxtiXn"
fi

# Workspace parameters
EXECUTION_MODE="remote"  # or "agent"

# API endpoint
ENDPOINT="https://app.terraform.io/api/v2/no-code-modules/${MODULE_ID}/workspaces"

# Create the workspace with the specified variables
curl -s \
  --header "Authorization: Bearer $TFC_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data '{
    "data": {
      "type": "workspaces",
      "attributes": {
        "name": "'"${TFC_WORKSPACE}"'",
        "execution-mode": "'"${EXECUTION_MODE}"'",
        "auto_apply" : "true"
      },
      "relationships": {
        "project": {
          "data": {
            "id": "'"${PROJECT_ID}"'",
            "type": "project"
          }
        },
        "vars": {
          "data": [
            {
              "type": "vars",
              "attributes": {
                "key": "namespace",
                "value": "'"${namespace}"'",
                "category": "terraform"
              }
            },
            {
              "type": "vars",
              "attributes": {
                "key": "team_name",
                "value": "'"${team_name}"'",
                "category": "terraform"
              }
            },
            {
              "type": "vars",
              "attributes": {
                "key": "github_token",
                "value": "'"${github_token}"'",
                "category": "terraform"
              }
            },
            {
              "type": "vars",
              "attributes": {
                "key": "owner_email",
                "value": "'"${owner_email}"'",
                "category": "terraform"
              }
            },
            {
              "type": "vars",
              "attributes": {
                "key": "charge_back",
                "value": "'"${charge_back}"'",
                "category": "terraform"
              }
            }
          ]
        }
      }
    }
  }' \
  $ENDPOINT
