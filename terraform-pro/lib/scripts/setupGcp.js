const {
    execute,
    tableStringToArray
} = require('../Script')

const USER = `cate95`
const ORG_ID = 0
const SERVICE_ACCOUNT_NM = `Terraform admin account`
const TF_ADMIN = `${USER}-tf`

const GET_ACCOUNT_IDS = `gcloud beta billing accounts list --filter open=true`
const GET_PROJECT_IDS = `gcloud projects list`

module.exports = async () => `
    export TF_VAR_org_id=${ORG_ID}
    export TF_VAR_billing_account=${await (async function() { 
        const data = tableStringToArray( await execute(GET_ACCOUNT_IDS, `bash`) )
        return data[1][0]
    })()}
    export TF_ADMIN=${TF_ADMIN}
    export TF_CREDS=~/.config/gcloud/${TF_ADMIN}.json

    ${await (async function() { 
        /* if project id of TF_ADMIN already exists don't execute create command */
        const res = await execute(GET_PROJECT_IDS, `bash`)
        var projectIds = tableStringToArray(res)[0]
        return projectIds.findIndex((el) => el == TF_ADMIN) >= 0 ?
        `` : 
        `
        gcloud projects create \${TF_ADMIN} \\
            --set-as-default 
        ` 
    })()}

    gcloud config set project \${TF_ADMIN}

    gcloud beta billing projects link \${TF_ADMIN} \\
        --billing-account="\${TF_VAR_billing_account}" 

    gcloud iam service-accounts create terraform \\
        --display-name="${SERVICE_ACCOUNT_NM}" 

    gcloud iam service-accounts keys create \${TF_CREDS} \\
        --iam-account="terraform@\${TF_ADMIN}.iam.gserviceaccount.com"

    gcloud projects add-iam-policy-binding \${TF_ADMIN} \\
        --member="serviceAccount:terraform@\${TF_ADMIN}.iam.gserviceaccount.com" \\
        --role="roles/viewer"

    gcloud projects add-iam-policy-binding \${TF_ADMIN} \\
        --member="serviceAccount:terraform@\${TF_ADMIN}.iam.gserviceaccount.com" \\
        --role="roles/storage.admin"
        
    gcloud services enable cloudresourcemanager.googleapis.com
    gcloud services enable cloudbilling.googleapis.com
    gcloud services enable iam.googleapis.com
    gcloud services enable compute.googleapis.com
    gcloud services enable serviceusage.googleapis.com
`