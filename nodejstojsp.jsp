<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,javax.mail.*,javax.mail.internet.*" %>
<%!
// Function to generate a random OTP
public String generateOTP() {
    return Integer.toString(100000 + (int) (Math.random() * 900000));
}

// Function to send OTP via email
public boolean sendOTP(String email) {
    String otp = generateOTP(); // Generate OTP

    // Email configuration
    String host = "smtp.gmail.com"; // Gmail SMTP server
    String port = "587"; // Gmail SMTP port
    String username = "amoghabhat7403@gmail.com"; // Your Gmail
    String password = "eilb qect afje yekk"; // Your Gmail password

    // Setup mail server properties
    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS

    try {
        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        // Create the email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Your OTP Code");
        message.setText("Hello, this is Amogha Bhat and your OTP code is: " + otp);

        // Send the email
        Transport.send(message);
        System.out.println("OTP Sent Successfully to " + email);
        return true;
    } catch (Exception e) {
        e.printStackTrace();
        System.err.println("Error sending OTP: " + e.getMessage());
        return false;
    }
}
%>

<%
// Example usage
String email = "softspring777@gmail.com"; // Replace with the recipient's email
boolean isSent = sendOTP(email);

if (isSent) {
    out.println("OTP sent successfully to " + email);
} else {
    out.println("Failed to send OTP. Please try again.");
}
%>