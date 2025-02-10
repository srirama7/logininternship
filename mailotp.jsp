// File: EmailSender.java (Place in src/main/java/com/mycompany/project3)
package com.mycompany.project3;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailSender {
    private static final String SENDER_EMAIL = "amoghabhat7403@gmail.com";
    private static final String APP_PASSWORD = "eilb qect afje yekk";
    
    public static String generateOTP() {
        Random random = new Random();
        int otp = random.nextInt(900000) + 100000;
        return String.valueOf(otp);
    }
    
    public static boolean sendOTPEmail(String recipientEmail, String otp) {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
        properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject("Your OTP Code");
            
            String htmlContent = "<html><body>"
                + "<h2>Your OTP Verification Code</h2>"
                + "<p>Your OTP code is: <b>" + otp + "</b></p>"
                + "<p>This code will expire in 10 minutes.</p>"
                + "<p>If you didn't request this code, please ignore this email.</p>"
                + "</body></html>";
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}

// File: index.jsp (Place in src/main/webapp)
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OTP Verification</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
            }
            .container {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="email"] {
                width: 100%;
                padding: 8px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Email Verification</h2>
            <form action="sendOTP.jsp" method="POST">
                <label for="email">Enter your email:</label>
                <input type="email" id="email" name="email" required>
                <button type="submit">Send OTP</button>
            </form>
        </div>
    </body>
</html>

// File: sendOTP.jsp (Place in src/main/webapp)
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.project3.EmailSender" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OTP Sent</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
            }
            .container {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .message {
                padding: 10px;
                margin: 10px 0;
                border-radius: 4px;
            }
            .success {
                background-color: #dff0d8;
                border: 1px solid #d6e9c6;
                color: #3c763d;
            }
            .error {
                background-color: #f2dede;
                border: 1px solid #ebccd1;
                color: #a94442;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <%
                String email = request.getParameter("email");
                if (email != null && !email.trim().isEmpty()) {
                    String otp = EmailSender.generateOTP();
                    boolean sent = EmailSender.sendOTPEmail(email, otp);
                    
                    if (sent) {
                        // Store OTP in session for verification
                        session.setAttribute("otp", otp);
                        session.setAttribute("email", email);
            %>
                        <div class="message success">
                            <h3>OTP Sent Successfully!</h3>
                            <p>An OTP has been sent to <%= email %>. Please check your email.</p>
                        </div>
                        <form action="verifyOTP.jsp" method="POST">
                            <label for="otp">Enter OTP:</label>
                            <input type="text" id="otp" name="otp" required>
                            <button type="submit">Verify OTP</button>
                        </form>
            <%
                    } else {
            %>
                        <div class="message error">
                            <h3>Error!</h3>
                            <p>Failed to send OTP. Please try again.</p>
                        </div>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>

// File: verifyOTP.jsp (Place in src/main/webapp)
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify OTP</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
            }
            .container {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .message {
                padding: 10px;
                margin: 10px 0;
                border-radius: 4px;
            }
            .success {
                background-color: #dff0d8;
                border: 1px solid #d6e9c6;
                color: #3c763d;
            }
            .error {
                background-color: #f2dede;
                border: 1px solid #ebccd1;
                color: #a94442;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <%
                String userOTP = request.getParameter("otp");
                String storedOTP = (String) session.getAttribute("otp");
                String email = (String) session.getAttribute("email");
                
                if (userOTP != null && storedOTP != null && userOTP.equals(storedOTP)) {
            %>
                    <div class="message success">
                        <h3>Success!</h3>
                        <p>Email <%= email %> has been verified successfully.</p>
                    </div>
            <%
                    // Clear the session
                    session.removeAttribute("otp");
                    session.removeAttribute("email");
                } else {
            %>
                    <div class="message error">
                        <h3>Error!</h3>
                        <p>Invalid OTP. Please try again.</p>
                        <a href="index.jsp">Back to Home</a>
                    </div>
            <%
                }
            %>
        </div>
    </body>
</html>