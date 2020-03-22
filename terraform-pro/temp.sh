
    export TF_VAR_org_id=0
    export TF_VAR_billing_account=01DA1E-2FB8F6-1B4AD4
    export TF_ADMIN=cate95-tf
    export TF_CREDS=~/.config/gcloud/cate95-tf.json

    
        gcloud projects create ${TF_ADMIN} \
            --set-as-default 
        

    gcloud config set project ${TF_ADMIN}

    gcloud beta billing projects link ${TF_ADMIN} \
        --billing-account="${TF_VAR_billing_account}" 

    gcloud iam service-accounts create terraform \
        --display-name="Terraform admin account" 

    gcloud iam service-accounts keys create ${TF_CREDS} \
        --iam-account="terraform@${TF_ADMIN}.iam.gserviceaccount.com"

    gcloud projects add-iam-policy-binding ${TF_ADMIN} \
        --member="serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com" \
        --role="roles/viewer"

    gcloud projects add-iam-policy-binding ${TF_ADMIN} \
        --member="serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com" \
        --role="roles/storage.admin"
        
    gcloud services enable cloudresourcemanager.googleapis.com
    gcloud services enable cloudbilling.googleapis.com
    gcloud services enable iam.googleapis.com
    gcloud services enable compute.googleapis.com
    gcloud services enable serviceusage.googleapis.com
