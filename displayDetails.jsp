<%-- 
    Document   : displayDetails
    Created on : 06-Feb-2025, 9:43:29 am
    Author     : manjuv
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stored User & Academic Details</title>
    <style>
        /* General Styles */
        html, body {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background-image: url("https://img.freepik.com/free-vector/gradient-technology-futuristic-background_23-2149115239.jpg?t=st=1738666900~exp=1738670500~hmac=c12ee20e1019d237214e09753c314eb6783bf7694b059037d35857a12f50f4ed&w=1380");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        .button-container button {
            padding: 15px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            flex: 1;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-align: center;
        }

        /* Logout Button */
        .logout-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: red;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: darkred;
        }

        /* Heading */
        .white-heading {
            color: white;
            text-align: center;
            font-size: 2rem;
            margin-top: 20px;
        }

        /* Content Box */
        .content-box {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            margin: 50px auto;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        /* Button Container */
        .button-container {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin: 20px 0;
            width: 100%;
            padding: 0 20px;
        }

        .button-container button {
            padding: 15px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            flex: 1;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-align: center;
        }

        .button-container button:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }

        /* Highlight Active Button */
        .button-container button.active {
            background-color: darkblue !important;
            color: white !important;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        h2 {
            margin-top: 20px;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.9);
            color: black;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background: #f2f2f2;
        }

        .back-button {
            background-color: #ff5722;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            margin-top: 20px;
            transition: 0.3s;
            display: block;
            margin: 20px auto;
        }

        .back-button:hover {
            background-color: #e64a19;
        }
    </style>
</head>
<body>
    <button class="logout-button" onclick="window.location.href='otplogin.jsp'">Logout</button>

    <div class="content-box">
        <h1>Click a Button to Fill Details</h1>
        <div class="button-container">
            <button onclick="redirectToForm('user')">User Details</button>
            <button onclick="redirectToForm('academic')">Academic Details</button>
            <button id="storedDataBtn" onclick="highlightButton(this); window.location.href='displayDetails.jsp';">View Stored Data</button>
        </div>
    </div>

    <h2>Stored User & Academic Details</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Address</th>
            <th>Phone</th>
            <th>College</th>
            <th>Roll Number</th>
            <th>Department</th>
            <th>Year</th>
            <th>CGPA</th>
        </tr>

        <%
            // Database connection details
            String dbURL = "jdbc:mysql://192.168.75.227/mydatabase"; // Replace with your database name
            String dbUser = "dotuser";
            String dbPass = "dot123";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load MySQL Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Connect to MySQL
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                stmt = conn.createStatement();

                // Fetch all stored records
                String sql = "SELECT * FROM studentdetails";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("fullName") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("address") %></td>
                        <td><%= rs.getString("phone") %></td>
                        <td><%= rs.getString("college") %></td>
                        <td><%= rs.getString("rollNumber") %></td>
                        <td><%= rs.getString("department") %></td>
                        <td><%= rs.getInt("year") %></td>
                        <td><%= rs.getDouble("cgpa") %></td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>

    <button class="back-button" onclick="window.location.href='threebuttons.jsp'">Go Back</button>

    <script>
        function redirectToForm(formType) {
            window.location.href = `threebuttons.jsp?open=${formType}`;
        }

        function highlightButton(button) {
        // Remove 'active' class from all buttons
        document.querySelectorAll('.button-container button').forEach(btn => {
            btn.classList.remove('active');
        });

        // Add 'active' class to the clicked button
        button.classList.add('active');
    }

    // Check if we are on the "displayDetails.jsp" page
    window.onload = function() {
        if (window.location.href.includes("displayDetails.jsp")) {
            document.getElementById("storedDataBtn").classList.add("active");
        }
    };
    </script>
</body>
</html>
