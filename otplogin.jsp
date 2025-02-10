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
                <div class="form-group">
                    <input type="text" id="username" name="username" placeholder="Enter your email" required>
                    <span id="emailError" style="color: red; display: none;">Invalid Email Format</span>
                </div>

                <div class="form-group">
                    <button id="generateBtn" onclick="OTPFn()" type="button">
                        Generate OTP
                    </button>
                </div>

                <div id="otpForm" class="otp-form" style="display: none;">
                    <input type="text" id="userOTP" placeholder="Enter OTP">
                    <button onclick="OTPVerifyFn()" type="button">
                        Verify
                    </button>
                </div>
            </form>

            <div id="successMessage" class="success-message" style="display: none;">
                <i class="fas fa-check"></i>
                <p>OTP is Verified Successfully!</p>
            </div>
            <div id="errorMessage" class="error-message" style="display: none;"></div>
            <div id="timer" class="timer" style="display: none;"></div>
        </div>
    </div>

    <script>
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
    </script>

    <script src="scriptsss.js"></script>
</body>

</html>
