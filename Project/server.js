// Loading necessary modules
var app = require('http').createServer(handler);
const io = require('socket.io')(app);
var fs = require('fs');
const exec = require("child_process").exec;

// HTML file used for the interface
var htmlPage = 'index.html';

// Initialize the server on port 3000
app.listen(3000, () => {
    console.log("Server running at http://localhost:3000/");
});

// Function to handle HTTP requests
function handler(req, res) {
    fs.readFile(htmlPage, function (err, data) {
        if (err) {
            res.writeHead(404);
            return res.end('Error loading file: ' + htmlPage);
        }
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end(data);
    });
}

// WebSocket connection management
io.on('connection', (socket) => {
    console.log("Client connected.");

    // Receiving command to update PWM
    socket.on('change-pwm', (data) => {
        const pwmValue = parseInt(data);

        if (pwmValue >= 0 && pwmValue <= 100) {
            console.log(`New PWM value received: ${pwmValue}`);

            // Calling the Bash script to update PWM
            const command = `./change_pwm.sh ${pwmValue}`;
            exec(command, (err, stdout, stderr) => {
                if (err) {
                    console.error("Error executing script: ", err);
                    socket.emit('error', 'Error updating PWM.');
                } else {
                    console.log("PWM updated successfully:", stdout);
                    socket.emit('success', `PWM updated to ${pwmValue}.`);
                }
            });
        } else {
            console.error("Invalid PWM value:", pwmValue);
            socket.emit('error', "Invalid value. Must be between 0 and 100.");
        }
    });

    socket.on('disconnect', () => {
        console.log("Client disconnected.");
    });
});

