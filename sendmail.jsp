<%@ page import="java.util.Properties, javax.mail.*, javax.mail.internet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Retrieve form parameters
    String recipient = request.getParameter("recipient");
    String subject = request.getParameter("subject");
    String messageText = request.getParameter("message");

    // Sender email credentials
    final String senderEmail = "your-email@gmail.com"; // Replace with your Gmail ID
    final String senderPassword = "your-app-password"; // Use an App Password for security

    // SMTP Configuration
    Properties properties = new Properties();
    properties.put("mail.smtp.host", "smtp.gmail.com");
    properties.put("mail.smtp.port", "587");
    properties.put("mail.smtp.auth", "true");
    properties.put("mail.smtp.starttls.enable", "true");

    // ✅ Fix: Renamed session to mailSession to avoid conflict
    Session mailSession = Session.getInstance(properties, new Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(senderEmail, senderPassword);
        }
    });

    try {
        // Create and configure email
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(senderEmail));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        message.setSubject(subject);
        message.setText(messageText);

        // Send email
        Transport.send(message);
%>
        <h2 style="color:green;">✅ Email Sent Successfully!</h2>
        <p><a href="index.jsp">Send Another Email</a></p>
<%
    } catch (MessagingException e) {
%>
        <h2 style="color:red;">❌ Error Sending Email</h2>
        <p><%= e.getMessage() %></p>
        <p><a href="index.jsp">Try Again</a></p>
<%
    }
%>
