<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,javax.mail.*,javax.mail.internet.*,java.text.SimpleDateFormat" %>
<%!
public class EmailSender {
    private Session session;
    
    public boolean sendEmail(String sender, String subject, String[] recipientList, String msgBody) {
        try {
            // Email configuration
            String host = "smtp.gmail.com";  // Replace with your SMTP server
            String port = "587";
            String username = "amoghabhat7403@gmail.com";      // Replace with your username
            String password = "eilb qect afje yekk";  // Replace with your password
            
            // Setup mail server properties
            Properties props = new Properties();
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS
            
            // Get the Session object
            session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            
            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender));
            message.setSubject(subject);
            message.setSentDate(new Date());
            
            // Set recipients
            for (String recipient : recipientList) {
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            }
            
            // Create HTML content
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String currentDate = dateFormat.format(new Date());
            
            String htmlContent = String.format(
                "<html><body>" +
                "<table border='1'>" +
                "<tr><td><b>From</b></td><td><b>C-DOT PH Portal Team</b></td></tr>" +
                "<tr><td><b>Sender</b></td><td><b>%s</b></td></tr>" +
                "<tr><td><b>NOTE</b></td><td><b>Auto-Generated Mail. Don't Reply back to this.</b></td></tr>" +
                "<tr><td><b>Dated</b></td><td><b>%s</b></td></tr>" +
                "</table><br><br>" +
                "<h4>%s</h4>" +
                "</body></html>",
                sender, currentDate, msgBody
            );
            
            message.setContent(htmlContent, "text/html");
            
            // Send message
            Transport.send(message);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
%>

<%
// Process the form submission
if ("POST".equalsIgnoreCase(request.getMethod())) {
    try {
        String sender = request.getParameter("sender");
        String recipients = request.getParameter("recipients");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Split recipients
        String[] recipientList = recipients.split(",");
        for (int i = 0; i < recipientList.length; i++) {
            recipientList[i] = recipientList[i].trim();
        }
        
        // Send email
        EmailSender emailSender = new EmailSender();
        boolean result = emailSender.sendEmail(sender, subject, recipientList, message);
        
        if (result) {
            request.setAttribute("message", "Email sent successfully!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Failed to send email. Please try again.");
            request.setAttribute("messageType", "error");
        }
        
    } catch (Exception e) {
        request.setAttribute("message", "Error: " + e.getMessage());
        request.setAttribute("messageType", "error");
    }
    
    // Forward back to the form page
    request.getRequestDispatcher("emailForm.jsp").forward(request, response);
}
%>