<%-- 
    Document   : sql1
    Created on : 05-Feb-2025, 9:55:38 am
    Author     : manjuv
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>User Registration</title>
</head>
<body>
    <h2>Register User</h2>
    <form action="sql2.jsp" method="post">
        Name: <input type="text" name="name" required><br>
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Register">
    </form>
</body>
</html>
