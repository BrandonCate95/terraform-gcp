const {
    execute,
    tableStringToArray
} = require('../Script')

const USER = `cate95`
const ORG_ID = 0
const SERVICE_ACCOUNT_NM = `Terraform admin account`
const TF_ADMIN = `${USER}-tf`

module.exports = async () => `
    export TF_VAR_org_id=${ORG_ID}
    export TF_VAR_billing_account=${await (async function() { 
        const data = tableStringToArray( await execute(GET_ACCOUNT_IDS, `bash`) )
        return data[1][0]
    })()}


`