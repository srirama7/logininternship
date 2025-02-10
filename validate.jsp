<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve form data
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Hardcoded valid credentials (for initial check)
    String validUsername = "dotuser";
    String validPassword = "dot123";

    boolean loginSuccess = false;

    if (username != null && password != null) {
        if (username.equals(validUsername) && password.equals(validPassword)) {
            // Database connection details
            String url = "jdbc:mysql://192.168.75.227/login"; // Database name: 'login'
            String dbUsername = "dotuser";
            String dbPassword = "dot123";

            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);

                if (connection != null) {
                    loginSuccess = true;
                    connection.close();  // Close connection after checking
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Database connection failed: " + e.getMessage() + "</p>");
            }
        }
    }

    if (loginSuccess) {
        // Redirect to threebuttons.jsp after successful login
        response.sendRedirect("threebuttons.jsp");
    } else {
%>
        <html>
        <head>
            <title>Login Failed</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    text-align: center;
                    margin-top: 100px;
                }
                .error {
                    color: red;
                }
            </style>
        </head>
        <body>
            <h2 class="error">Login Failed</h2>
            <p>Invalid username or password. Please try again.</p>
            <a href="login.jsp">Go back to login</a>
        </body>
        </html>
<%
    }
%>
