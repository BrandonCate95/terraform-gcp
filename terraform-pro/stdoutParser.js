var execute = require('./Script')

const COMMAND = `
    gcloud beta billing accounts list --filter open=true
`

module.exports = async function getColFromExecute(command){
    const val = await execute(command)

    const data = filterTableString(val)

    const ids = getColFromFilteredTableString(data, 0)

    return ids
}

function getColFromFilteredTableString(strArray,colNum){
    var accountIds = []
    strArray.forEach((row,index) => {
        if(index > 0) accountIds.push(row[colNum])
    })
    return accountIds
}

function filterTableString(str){
    var data = []
    str.split('\n').filter(row => {
        const filteredRow = row.split('  ').filter(col => {
            return col != ''
        })

        if(filteredRow.length > 0) data.push(filteredRow)
    })
    return data
}