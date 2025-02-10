
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Send Email</title>
    <style>
        .form-container {
            width: 500px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 4px;
        }
        .success {
            background-color: #dff0d8;
            color: #3c763d;
        }
        .error {
            background-color: #f2dede;
            color: #a94442;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Send Email</h2>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <form action="sendEmail.jsp" method="post">
            <div class="form-group">
                <label for="sender">Sender:</label>
                <input type="email" id="sender" name="sender" required>
            </div>
            
            <div class="form-group">
                <label for="recipients">Recipients (comma-separated):</label>
                <input type="text" id="recipients" name="recipients" required>
            </div>
            
            <div class="form-group">
                <label for="subject">Subject:</label>
                <input type="text" id="subject" name="subject" required>
            </div>
            
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="5" required></textarea>
            </div>
            
            <button type="submit" class="btn">Send Email</button>
        </form>
    </div>
</body>
</html>