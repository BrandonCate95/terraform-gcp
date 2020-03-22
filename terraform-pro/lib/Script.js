const {
    spawn
} = require('child_process')
const fs = require('fs')
const Schema = require('validate')
const {
    schemaValidator
} = require('./schemaValidator')

const TYPES = {
    BASH: `bash`,
    WINDOWS: `windows`,
    LINUX: `linux`,
    UNIX: `unix`
}

const executeValidator = new Schema({
    command: {
        type: String,
        required: true
    },
    type: {
        type: String,
        enum: Object.values(TYPES)
    }
})

class Script {
    constructor() {}

    execute(command, type) {
        schemaValidator({
            command,
            type
        }, executeValidator)

        var response = ``
        var error = ``

        return new Promise(async resolve => {

            var listener

            switch (type) {
                case TYPES.BASH:
                    listener = await this.bashExecution(command)
                    break
                case TYPES.WINDOWS:
                    listener = await this.windowsExecution(command)
                    break
            }

            // listen to output of script then return response
            listener.stdout.on('data', function (data) {
                console.log('stdout: ' + data.toString());
                response += data.toString();
            });

            listener.stderr.on('data', function (data) {
                console.log('stderr: ' + data.toString());
                error += data.toString();
            });

            listener.on('exit', function (code) {
                console.log('child process exited with code ' + code.toString());
                if (error) resolve(error)
                else resolve(response)
            });
        })
    }

    async bashExecution(command) {
        const filename = await this.createBashScriptWithCommand(command)
        return spawn(`sh`, [filename])
    }

    windowsExecution(command) {
        return spawn(command)
    }

    createBashScriptWithCommand(command) {
        var filename = `temp`

        return new Promise((resolve, reject) => {
            filename = filename.endsWith('.sh') ? filename : filename + '.sh'

            fs.writeFile(filename, command, function (err) {
                if (err) reject(err)
                return resolve(filename)
            });
        })
    }

    formatCommand(str) {
        return str.trim().replace(/\s\s+/g, " ")
    }

    tableStringToArray(str) {
        var data = []
        str.split('\n').filter(row => {
            const filteredRow = row.split('  ').filter(col => {
                return col != ''
            })

            if (filteredRow.length > 0) data.push(filteredRow)
        })
        return data
    }
}

exports.Script = Script

exports.execute = async function (command, type) {
    const script = new Script()
    return await script.execute(command, type)
}

exports.tableStringToArray = function (str) {
    const script = new Script()
    return script.tableStringToArray(str)
}