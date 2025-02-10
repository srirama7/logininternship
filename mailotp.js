const nodemailer = require('nodemailer');

const generateOTP = () => Math.floor(100000 + Math.random() * 900000).toString();

async function sendOTP(email) {
    const otp = generateOTP(); // Generate OTP

    let transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 587,
        secure: false,
        auth: {
            user: 'amoghabhat7403@gmail.com',
            pass: 'eilb qect afje yekk'  // Use App Password if 2FA is enabled
        },
        tls: {
            rejectUnauthorized: false
        },
        connectionTimeout: 60000,   // Increased timeout
        greetingTimeout: 60000,     // Increased timeout
        socketTimeout: 60000        // Increased timeout
    });

    let mailOptions = {
        from: 'amoghabhat7403@gmail.com',
        to: email,
        subject: 'Your OTP Code',
        text: `Hello, this is Amogha Bhat and your OTP code is: ${otp}` 
    };

    try {
        await transporter.sendMail(mailOptions);
        console.log('OTP Sent Successfully to', email);
        return otp;
    } catch (error) {
        console.error('Error sending OTP:', error);
    }
}

// Example Usage
sendOTP('softspring777@gmail.com');
