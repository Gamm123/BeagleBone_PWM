# PWM Control on BeagleBone Black via Web Interface

Developed by **Mohamed Amine Gam** and **Houssem Guesmi**, this project enables real-time control of a DC motor using PWM on the BeagleBone Black through a web interface. Users can adjust the motor speed by modifying the duty cycle.

## Features
- **Web Interface**: Adjust PWM values (0-100%) to control motor speed.
- **Real-Time Communication**: Uses Socket.IO for seamless communication.
- **Input Validation**: Ensures PWM values are within the valid range.

## Prerequisites
- **Node.js** and **npm** for running the server.
- **Socket.IO** for WebSocket communication.
- **Bash** and permissions to manage PWM on the BeagleBone Black.
- **Real-Time Kernel** for accurate PWM control.

## Setup Instructions

1. **SSH into BeagleBone Black**  
   ```bash
   ssh debian@192.168.6.2
   
2. **Clone the Repository**
   ```bash
   git clone https://github.com/Gamm123/BeagleBone_PWM.git
   cd BeagleBone_PWM
3. **Install Dependencies**
   ```bash
   sudo apt update
   sudo apt install nodejs npm 
4. **Run the Server**
   ```bash
   node server.js
5. **Access the Web Interface**
   Open your browser and navigate to: http://192.168.6.2:3000
