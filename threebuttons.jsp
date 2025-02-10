<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Form Navigation</title>
    <style>
        /* Previous styles remain unchanged */
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

        /* Tooltip style */
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

        /* Rest of your existing styles */
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
            margin-top: 20px;
        }

        .content-box {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            margin: 50px auto;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
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
        
    </style>
    <script>
        function validateAndProceed() {
            const emailInput = document.getElementById("email");
            const emailError = document.getElementById("emailError");
            const phoneInput = document.getElementById("phone");
            const phoneError = document.getElementById("phoneError");

            const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/; // Strict Gmail format
            const phoneRegex = /^\d{10}$/; // Exactly 10 digits

            // Trim input values
            const emailValue = emailInput.value.trim();
            const phoneValue = phoneInput.value.trim();

            let isValid = true;

            // Validate Email
            if (!emailRegex.test(emailValue)) {
                emailError.textContent = "Please enter a valid email in the format abc@gmail.com";
                emailInput.focus();
                isValid = false;
            } else {
                emailError.textContent = "";
            }

            // Validate Phone
            if (!phoneRegex.test(phoneValue)) {
                phoneError.textContent = "Please enter a valid 10-digit phone number.";
                phoneInput.focus();
                isValid = false;
            } else {
                phoneError.textContent = "";
            }

            // Proceed only if both are valid
            if (isValid) {
                showForm('academicDetails');
            }
            return isValid;
        }


        function validatePhone(input) {
            const phoneError = document.getElementById("phoneError");
            const phoneRegex = /^\d{10}$/; // Ensures only 10 digits

            if (!phoneRegex.test(input.value)) {
                phoneError.textContent = "Please enter a valid 10-digit phone number.";
            } else {
                phoneError.textContent = "";
            }
        }
        
        
        function validateEmail(input) {
            const emailError = document.getElementById("emailError");
            const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/; // Allows only emails ending in '@gmail.com'

            if (!emailRegex.test(input.value)) {
                emailError.textContent = "Please enter a valid email in the format abc@gmail.com";
            } else {
                emailError.textContent = "";
            }
        }



        function showForm(formId) {
            document.querySelectorAll('.form-container').forEach(f => f.classList.remove('active'));
            document.getElementById(formId).classList.add('active');
        }

        function validateSem() {
            let semInput = document.getElementById("sem");
            let errorMsg = document.getElementById("error-msg");

            if (parseInt(semInput.value) > 8) {
                errorMsg.style.textContent = ""; // Show error message
            } else {
                errorMsg.style.display = "none"; // Hide error message
            }
        }

        function validatePhoneNumber(input) {
            input.value = input.value.replace(/\D/g, ''); // Remove non-numeric characters
            const phoneError = document.getElementById("phoneError");

            if (input.value.length !== 10) {
                phoneError.textContent = "Phone number must be exactly 10 digits.";
            } else {
                phoneError.textContent = "";
            }
        }       

        function validateForm() {
            let phone = document.getElementById("phone").value;
            let phoneError = document.getElementById("phoneError");
            let sem = document.getElementById("sem").value;
            let errorMsg = document.getElementById("error-msg");

            if (phone.length !== 10) {
                phoneError.textContent = "Phone number must be exactly 10 digits.";
                return false; // Prevent submission
            }

            if (parseInt(sem) > 8) {
                errorMsg.style.display = "inline";
                return false; // Prevent submission
            }

            phoneError.textContent = "";
            errorMsg.style.display = "none";
            return true; // Allow submission
        }

//        var logoutTimer = setTimeout(function() {
//            alert("Session expired! Logging out.");
//            window.location.href = 'otplogin.jsp';
//        }, 10000);

        window.onload = function() {
            document.body.addEventListener('mousemove', resetTimer);
            document.body.addEventListener('keypress', resetTimer);
            setActiveButton('userDetails');
        };

//        function resetTimer() {
//            clearTimeout(logoutTimer);
//            logoutTimer = setTimeout(function() {
//                alert("Session expired! Logging out.");
//                window.location.href = 'otplogin.jsp';
//            }, 10000);
//        }

        function setActiveButton(formId) {
            document.querySelectorAll('.button-container button').forEach(button => {
                button.classList.remove('active');
            });

            if (formId === 'userDetails') {
                document.querySelector('button[onclick="showForm(\'userDetails\')"]').classList.add('active');
            } else if (formId === 'academicDetails') {
                document.querySelector('button[onclick="showForm(\'academicDetails\')"]').classList.add('active');
            } else if (formId === 'viewDetails') {
                document.querySelector('button[onclick="window.location.href=\'displayDetails.jsp\'"]').classList.add('active');
            }
        }

        function showForm(formId) {
            document.querySelectorAll('.form-container').forEach(f => f.classList.remove('active'));
            document.getElementById(formId).classList.add('active');
            setActiveButton(formId);
        }

        function showPopup() {
            const popup = document.createElement('div');
            popup.className = 'popup';
            popup.innerHTML = 'Details Saved Successfully!';
            document.body.appendChild(popup);

            setTimeout(() => popup.classList.add('show'), 100);

            setTimeout(() => {
                popup.classList.remove('show');
                setTimeout(() => {
                    document.body.removeChild(popup);
                    window.location.href = 'displayDetails.jsp';
                }, 500);
            }, 2000);
        }

        document.addEventListener("DOMContentLoaded", function() {
            document.querySelector("#academicDetails form").addEventListener("submit", function(e) {
                e.preventDefault();
                
                document.getElementById("hiddenFullName").value = document.getElementById("fullName").value;
                document.getElementById("hiddenEmail").value = document.getElementById("email").value;
                document.getElementById("hiddenAddress").value = document.getElementById("address").value;
                document.getElementById("hiddenPhone").value = document.getElementById("phone").value;
                
                setActiveButton('viewDetails');
                showPopup();
                
                setTimeout(() => {
                    this.submit();
                }, 2500);
            });
        });
    </script>
</head>

<body>
    <button class="logout-button" onclick="window.location.href='otplogin.jsp'">Logout</button>

    <div class="content-box">
        <h1>Click a Button to Fill Details</h1>
        <div class="button-container">
            <button onclick="showForm('userDetails')">User Details</button>
            <button onclick="showForm('academicDetails')">Academic Details</button>
            <button onclick="window.location.href='displayDetails.jsp'">View Stored Data</button>
        </div>
    </div>

    <div id="userDetails" class="form-container active">
        <h2>User Details</h2>
        <form>
            <label>Full Name:</label>
            <input type="text" id="fullName" required>

            <label>Email:</label>
                <input type="email" id="email" required oninput="validateEmail(this)">
            <small class="error-message" id="emailError" style="color: red;"></small>
            
            <label>Address:</label>
            <div class="tooltip">
                <input type="text" id="address" required>
                <span class="tooltiptext">Please enter your complete address including city, state, and PIN code and u can add #,-,* if u wish along with the address which u provided and remaining special classes are not allowed</span>
            </div>

            <label>Phone Number:</label>
                <input type="text" id="phone" placeholder="Enter Phone Number" oninput="validateAndProceed()">
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

    <label>College:</label>
    <input type="text" name="college" required>

    <label>Roll Number:</label>
    <input type="text" name="rollNumber" required>

    <label>Department:</label>
    <select name="department" required>
        <option value="">Select your department</option>
        <option value="CSE">Computer Science</option>
        <option value="ECE">Electronics</option>
        <option value="EEE">Electrical</option>
        <option value="MECH">Mechanical</option>
        <option value="CIVIL">Civil</option>
    </select>

    <div style="display: flex; align-items: center; gap: 10px;">
        <label for="year">Year:</label>
        <input type="number" id="year" name="year" min="1" max="4" required style="width: 80px;">
        
        <label for="sem">Sem:</label>
        <input type="number" id="sem" name="sem" style="width: 80px;" oninput="validateSem()">
        <span id="error-msg" style="color: red; display: none;">Wrong! Value must be ≤ 8</span>
    </div>

    <label>CGPA:</label>
    <input type="text" name="cgpa" required>

    <input type="button" value="Back" onclick="showForm('userDetails')">
    <input type="submit" value="Submit">
</form>
    </div>
</body>
</html>