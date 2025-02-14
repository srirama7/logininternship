<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Form Navigation</title>
    <style>
        /* All existing styles remain exactly the same */
        html, body {
            min-height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background-image: url("https://4kwallpapers.com/images/walls/thumbs_3t/2910.jpg");
            background-attachment: fixed;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            position: relative;
            padding-bottom: 50px;
        }
        
        .content-wrapper {
            min-height: 100vh;
            position: relative;
            z-index: 1;
        }

        .tooltip {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .tooltip .tooltiptext {
            visibility: hidden;
            width: 200px;
            background-color: #555;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            transform: translateX(-50%);
            opacity: 0;
            transition: opacity 0.3s;
        }

        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
        }

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

        .white-heading {
            color: white;
            text-align: center;
            font-size: 2rem;
            margin: 0; /* Remove default margin */
        }

        .content-box {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            margin: 50px auto;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .top-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.7); /* Optional: Add a background for better visibility */
            padding: 10px 20px;
            z-index: 1000; /* Ensure it stays on top of other content */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Optional: Add a shadow */
        }
        
        .training-input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
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
        
        .button-container button.active {
            background-color: darkblue;
            color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }
        
        .button-container button.active-training {
            background-color: blue;
            color: white;
        }

        .button-container button:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }

        .form-container {
            display: none;
            margin: 20px auto;
            padding: 20px;
            background-color: rgba(173, 216, 230, 0.8);
            border: 1px solid #ccc;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 50%;
            margin-bottom: 30px;
        }

        .form-container.active {
            display: block;
        }

        form label {
            display: block;
            margin-bottom: 8px;
            text-align: left;
            font-size: 16px;
        }

        form input[type="text"],
        form input[type="email"],
        form input[type="number"],
        form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-container input[type="button"], 
        .form-container input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container input[type="button"]:hover, 
        .form-container input[type="submit"]:hover {
            background-color: #45a049;
        }

        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(50, 205, 50, 0.9);
            color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            z-index: 1000;
            text-align: center;
            animation: fadeIn 0.5s;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .popup.show {
            display: block;
        }
        
        .semester-input {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
               
                margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }
    </style>
    
<body>
    <script src="threebuttonss.js"></script>
    <button class="logout-button" onclick="window.location.href='otplogin.jsp'">Logout</button>

    <div class="content-box">
        <h1>Student Internship Form</h1>
        <div class="button-container">
            <button onclick="showForm('userDetails')">Student Details</button>
            <button onclick="showForm('academicDetails')">Academic Details</button>
            <button onclick="showForm('trainingDetails')">Training Details</button>
            <button onclick="window.location.href='displayDetails.jsp'">View Stored Data</button>
        </div>
    </div>

    <div id="userDetails" class="form-container active">
        <h2>Student Details</h2>
        <form>
            <label>Type of Internship:</label>
            <select name="internship" required>
                <option value="">select</option>
                <option value="paid">Paid Internship</option>
                <option value="normal">Normal Internship</option>
            </select>
            
            <label>Full Name:</label>
            <input type="text" id="fullName" required>

            <label>Email:</label>
            <input type="email" id="email" required oninput="validateEmail(this)">
            <small class="error-message" id="emailError" style="color: red;"></small>
            
            <label>Address:</label>
            <div class="tooltip">
                <input type="text" id="address" required oninput="validateAddress(this)">
                <span class="tooltiptext">Please enter your complete address including city, state, and PIN code and u can add #,-,* if u wish along with the address which u provided and remaining special classes are not allowed</span>
                <span id="addressError" style="color: red;"></span>
            </div>
            
            <label>Relationship with Employee</label>
            <select name="relationwithemployee" required>
                <option value="">Select</option>
                <option value="child">Child</option>
                <option value="relative">Relative</option>
                <option value="known">known</option>
            </select>

            <label>Phone Number:</label>
            <input type="text" id="phone" placeholder="Enter Phone Number" oninput="validatePhoneNumber(this)">
            <span id="phoneError" style="color: red;"></span><br>

            <input type="button" value="Next" onclick="validateAndProceed()">
        </form>
    </div>

    <div id="academicDetails" class="form-container">
        <h2>Academic Details</h2>
        <form action="saveDetails.jsp" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="fullName" id="hiddenFullName">
            <input type="hidden" name="email" id="hiddenEmail">
            <input type="hidden" name="address" id="hiddenAddress">
            <input type="hidden" name="phone" id="hiddenPhone">
            
                        

            <label>Course Undergoing</label>
            <select name="Select" required>
                <option value="">Select</option>
                <option value="Bachelor">Bachelor</option>
                <option value="Masters">Masters</option>
                <option value="Integrated">Integrated</option>
                <option value="Diploma">Diploma</option>
            </select>
            
                <label>Stream:</label>
                <select name="department" id="department" required onchange="toggleOtherField()">
                <option value="">Select</option>
              <%
                String url = "jdbc:mysql://192.168.75.227/mydatabase";
                String dbUser = "dotuser";
                String dbPassword = "dot123";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    String query = "SELECT streamname FROM stream";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);
                    
                    while (rs.next()) {
                        String stream = rs.getString("streamname");
                        %>
                        <option value="<%= stream %>"><%= stream %></option>
                        <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            %>
            <option value="OTHER">Other</option>
        </select>
                
       
            <div id="otherDepartmentDiv" style="display: none; margin-top: 10px;">
            <label>Specify Other:</label>
            <input type="text" id="otherDepartment" name="otherDepartment" placeholder="Enter Department">
            </div>


            <label>Name of the Course</label>
            <input type="text" name="course" required>
            
            <label>University:</label>
            <input type="text" name="university" required>

            <label>College:</label>
            <input type="text" name="college" required>
              
            <label>Duration:</label>
            <select name="duration" required>
                <option value="">Select</option>
                <option value="year">yearly based</option>
                <option value="sem">semester based</option>
            </select>

            <div style="display: flex; align-items: center; gap: 10px;">
                <label for="year">Year:</label>
                <input type="number" id="year" name="year" min="1" max="4" required style="width: 80px;">
                
                <label for="sem">Current Semester:</label>
                <input type="number" id="sem" name="sem" oninput="validateSem()" min="1" max="8" required>
                <span id="error-msg" style="color: red; display: none;">Semester must be between 1 and 8.</span>
            </div>

            <div id="semesterMarks">
                <div id="sem1" style="display: none;" class="semester-input">
                    <label>Semester 1 Marks(in %):</label>
                    <input type="number" name="sem1_marks" step="0.1" min="0" max="100">
                </div>
                <div id="sem2" style="display: none;" class="semester-input">
                    <label>Semester 2 Marks(in %):</label>
                    <input type="number" name="sem2_marks" step="0.1" min="0" max="100">
                </div>
                <div id="sem3" style="display: none;" class="semester-input">
                    <label>Semester 3 Marks(in %):</label>
                    <input type="number" name="sem3_marks" step="0.1" min="0" max="100">
                </div>
                <div id="sem4" style="display: none;" class="semester-input">
                    <label>Semester 4 Marks(in %):</label>
                    <input type="number" name="sem4_marks" step="0.1" min="0" max="100">
                </div>
                <div id="sem5" style="display: none;" class="semester-input">
                    <label>Semester 5 Marks(in %):</label>
                    <input type="number" name="sem5_marks" step="0.1" min="0" max="100">
                </div>
                <div id="sem6" style="display: none;" class="semester-input">
                    <label>Semester 6 Marks(in %):</label>
                    <input type="number" name="sem6_marks" step="0.1" min="0" max="100">
                </div>
                <div id="sem7" style="display: none;" class="semester-input">
                    <label>Semester 7 Marks(in %):</label>
                    <input type="number" name="sem7_marks" step="0.1" min="0" max="100">
                </div>
                <div id="sem8" style="display: none;" class="semester-input">
                    <label>Semester 8 Marks(in %):</label>
                    <input type="number" name="sem8_marks" step="0.1" min="0" max="100">
                </div>
            </div>
            
             <label>CGPA:</label>
        <input type="text" id="cgpaInput" oninput="validateCGPA(this)" onblur="checkCGPA()"
            placeholder="0.0 - 10.0" required style="width: 80px; text-align: center;">
        <span id="cgpaError" style="color: red; display: inline-block; margin-left: 10px;"></span>
        <br><!-- comment -->
        <br>


            <input type="button" value="Back" onclick="showForm('userDetails')">
            <input type="button" value="Next" onclick="showTrainingForm()">
        </form>
    </div>

    <div id="trainingDetails" class="form-container">
        <h2>Training Details</h2>
        <form action="saveDetails.jsp" method="post" onsubmit="return validateTrainingForm()">
            <input type="hidden" name="fullName" id="trainingHiddenFullName">
            <input type="hidden" name="email" id="trainingHiddenEmail">
            <input type="hidden" name="address" id="trainingHiddenAddress">
            <input type="hidden" name="phone" id="trainingHiddenPhone">
    
            <label>Group Name:</label>
            <select name="groupName" class="training-input" required>
                <option value="">Select</option>
                <option value="nms">NMS</option>
            </select>
    
            <label>Group Staff Number:</label>
             <select name="groupstaff" class="training-input" required>
                <option value="">Select</option>
                <option value="nms">5085</option>
            </select>
    
            <label>Guide Name:</label>
            <input type="text" name="guideName" class="training-input" required>
    
            <label>Training Duration (in months):</label>
            <input type="number" name="trainingDuration" class="training-input" min="1" max="24" required>
    
            <input type="button" value="Back" onclick="showForm('academicDetails')">
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>






