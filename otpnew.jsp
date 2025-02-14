<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GFG OTP Verification</title>
    <link rel="stylesheet" href="styless.css">
</head>

<body>
    <div class="card">
        <div class="header">
            <h1 style="color:green">LOGIN PAGE</h1>
            <h2 style="color:black">OTP Verification</h2>
        </div>
        <div class="content" id="content">
            <form>
                
                
                
                <!-- Dropdown to select role -->
                <select id="roleSelect" name="role" required>
                    <option value="">Select</option>
                    <option value="student.jsp">Student</option>
                    <option value="threebuttons.jsp">Staff</option>
                    <option value="kmghead.jsp">Kmg Head</option>
                </select>

                <!-- Email input field -->
                <div class="form-group">
                    <input type="text" id="username" name="username" placeholder="Enter your email" required>
                    <span id="emailError" style="color: red; display: none;">Invalid Email Format</span>
                </div>

                <!-- Generate OTP button -->
                <div class="form-group">
                    <button id="generateBtn" onclick="OTPFn()" type="button">
                        Generate OTP
                    </button>
                </div>

                <!-- OTP input and verification -->
                <div id="otpForm" class="otp-form" style="display: none;">
                    <input type="text" id="userOTP" placeholder="Enter OTP">
                    <button onclick="OTPVerifyFn()" type="button">
                        Verify
                    </button>
                </div>
            </form>

            <div id="successMessage" class="success-message" style="display: none;">
                <i class="fas fa-check"></i>
                <p>OTP is Verified Successfully! Redirecting...</p>
            </div>
            <div id="errorMessage" class="error-message" style="display: none;"></div>
            <div id="timer" class="timer" style="display: none;"></div>
        </div>
    </div>

    <script>
        // Email validation
        document.getElementById("username").addEventListener("input", function () {
            const emailInput = this.value;
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const errorMessage = document.getElementById("emailError");

            if (!emailPattern.test(emailInput)) {
                errorMessage.style.display = "block";
            } else {
                errorMessage.style.display = "none";
            }
        });

        function OTPFn() {
            let email = document.getElementById("username").value;
            let role = document.getElementById("roleSelect").value;
            if (!email || !role) {
                alert("Please select a role and enter your email first.");
                return;
            }
            alert("OTP sent to " + email); // Simulate OTP sending
            document.getElementById("otpForm").style.display = "block";
        }

        function OTPVerifyFn() {
            let enteredOTP = document.getElementById("userOTP").value;
            let role = document.getElementById("roleSelect").value;

            if (!enteredOTP) {
                alert("Please enter the OTP.");
                return;
            }

            if (enteredOTP === "1234") { // Simulating correct OTP
                document.getElementById("successMessage").style.display = "block";

                // Redirect to the selected role page after 2 seconds
                setTimeout(() => {
                    window.location.href = role;
                }, 2000);
            } else {
                alert("Incorrect OTP, please try again.");
            }
        }
    </script>

    <script src="script.js"></script>
</body>

</html>
