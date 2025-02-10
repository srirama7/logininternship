<%-- 
    Document   : savedetails
    Created on : 06-Feb-2025, 9:41:14 am
    Author     : manjuv
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Database connection details
    String dbURL = "jdbc:mysql://192.168.75.227/mydatabase"; // Replace with your database name
    String dbUser = "dotuser";
    String dbPass = "dot123";

    // Retrieve form data
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String college = request.getParameter("college");
    String rollNumber = request.getParameter("rollNumber");
    String department = request.getParameter("department");
    String year = request.getParameter("year");
    String cgpa = request.getParameter("cgpa");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Insert query
        String sql = "INSERT INTO studentdetails (fullName, email, address, phone, college, rollNumber, department, year, cgpa) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, fullName);
        stmt.setString(2, email);
        stmt.setString(3, address);
        stmt.setString(4, phone);
        stmt.setString(5, college);
        stmt.setString(6, rollNumber);
        stmt.setString(7, department);
        stmt.setInt(8, Integer.parseInt(year));
        stmt.setDouble(9, Double.parseDouble(cgpa));

        // Execute update
        int rows = stmt.executeUpdate();
        if (rows > 0) {
            out.println("<script>alert('Details saved successfully!'); window.location.href='displayDetails.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to save details!'); window.history.back();</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
