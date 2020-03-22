//const Script = require('./Script')
const { printMsg } = require('@qball/execute-scripts')
const {
    spawn
} = require('child_process')

const COMMAND = `
    dir
`

printMsg()

var listener = spawn('sh', ['temp.sh'])

listener.stdout.on('data', function (data) {
    console.log('stdout: ' + data.toString());
    //this.response += data.toString();
});

listener.stderr.on('data', function (data) {
    console.log('stderr: ' + data.toString());
    //this.error += data.toString();
});

listener.on('exit', function (code) {
    console.log('child process exited with code ' + code.toString());
    //if (this.error) reject(this.error)
    //lse resolve(this.response)
});

//var script = new Script()

// script.execute(COMMAND)