const {
    execute,
    tableStringToArray
} = require('./lib/Script')
const GCP_TERRAFORM_SETUP = require('./lib/scripts/setupGcp')

async function main() {

    const res = await execute(await GCP_TERRAFORM_SETUP(), `bash`)
    console.log(`
        =========================
        FINISHED EXECUTION
        =========================
    `)
    console.log(res)

}
main()