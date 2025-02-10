<%-- 
    Document   : textmail
    Created on : 29-Jan-2025, 4:14:46 pm
    Author     : manjuv
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Email</title>
</head>
<body>
    <h2>Send Email</h2>
    <form action="sendmail.jsp" method="post">
        <label for="recipient">Recipient:</label>
        <input type="email" id="recipient" name="recipient" required><br><br>

        <label for="subject">Subject:</label>
        <input type="text" id="subject" name="subject" required><br><br>

        <label for="message">Message:</label>
        <textarea id="message" name="message" required></textarea><br><br>

        <button type="submit">Send Email</button>
    </form>
</body>
</html>
