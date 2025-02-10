<%-- 
    Document   : sql2
    Created on : 05-Feb-2025, 9:56:01 am
    Author     : manjuv
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Processing...</title>
</head>
<body>
<%
    // Database connection details
    String dbURL = "jdbc:mysql://192.168.75.227/mydatabase"; // Your MySQL IP and database
    String dbUser = "dotuser"; // Your MySQL username
    String dbPass = "dot123";  // Your MySQL password

    // Retrieve form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pst = null;

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Prepare SQL Insert Statement
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        pst = conn.prepareStatement(sql);
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, password);

        // Execute update
        int rows = pst.executeUpdate();
        if (rows > 0) {
            out.println("<h3>User Registered Successfully!</h3>");
        } else {
            out.println("<h3>Registration Failed!</h3>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
