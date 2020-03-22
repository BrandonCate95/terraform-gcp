var {
    Script
} = require('./lib/Script')

const COMMAND = `
    gcloud beta billing accounts list --filter open=true
`

module.exports = async function getAccountIds() {

    var script = new Script()

    const val = await script.execute(COMMAND, true)

    const data = script.tableStringToArray(val)

    const ids = getAccountIdFromFilteredTableString(data)

    return ids
}

function getAccountIdFromFilteredTableString(strArray) {
    var accountIds = []
    strArray.forEach((row, index) => {
        if (index > 0) accountIds.push(row[0])
    })
    return accountIds
}