<%-- 
    Document   : displayacademic
    Created on : 05-Feb-2025, 10:17:46 am
    Author     : manjuv
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Processing Academic Details...</title>
</head>
<body>
<%
    String dbURL = "jdbc:mysql://192.168.75.227/mydatabase";
    String dbUser = "dotuser";
    String dbPass = "dot123";

    String college = request.getParameter("college");
    String rollNumber = request.getParameter("rollNumber");
    String department = request.getParameter("department");
    int year = Integer.parseInt(request.getParameter("year"));
    float cgpa = Float.parseFloat(request.getParameter("cgpa"));

    Connection conn = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String sql = "UPDATE user_details SET college=?, rollNumber=?, department=?, year=?, cgpa=? WHERE email=?";
        pst = conn.prepareStatement(sql);
        pst.setString(1, college);
        pst.setString(2, rollNumber);
        pst.setString(3, department);
        pst.setInt(4, year);
        pst.setFloat(5, cgpa);
        pst.setString(6, request.getParameter("email"));  // Assuming email is stored in a session or form

        int rows = pst.executeUpdate();
        if (rows > 0) {
            out.println("<h3>Academic Details Stored Successfully!</h3>");
        } else {
            out.println("<h3>Failed to Store Academic Details.</h3>");
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
<a href="index.jsp">Go Back</a>
</body>
</html>

