let generatedOTP = null;
let timerInterval;
let timeLeft;
let isTimerExpired = false;
let selectedPage = ""; // Store selected page

function OTPFn() {
    // Get selected role
    selectedPage = document.getElementById("roleSelect").value;
    if (!selectedPage) {
        alert("Please select a role first!");
        return;
    }

    // Disable the Generate OTP button for 30 seconds
    const generateBtn = document.getElementById("generateBtn");
    generateBtn.disabled = true;
    generateBtn.style.cursor = "not-allowed";
    generateBtn.style.opacity = "0.5";

    setTimeout(() => {
        generateBtn.disabled = false;
        generateBtn.style.cursor = "pointer";
        generateBtn.style.opacity = "1";
    }, 30000); // Re-enable after 30 seconds

    // Reset timer state
    isTimerExpired = false;

    // Clear any existing timer
    clearInterval(timerInterval);

    // Generate new OTP
    generatedOTP = Math.floor(100000 + Math.random() * 900000);
    alert("Your OTP is: " + generatedOTP); // For testing (Remove in production)

    // Show OTP input form
    document.getElementById("otpForm").style.display = "block";

    // Reset messages
    document.getElementById("errorMessage").textContent = "";
    document.getElementById("errorMessage").style.display = "none";
    document.getElementById("successMessage").style.display = "none";

    // Start timer for 30 seconds
    timeLeft = 30;
    startTimer();
}

function startTimer() {
    const timerDisplay = document.getElementById("timer");
    timerDisplay.style.display = "block";

    timerInterval = setInterval(() => {
        if (timeLeft <= 0) {
            clearInterval(timerInterval);
            timerDisplay.textContent = "OTP Expired! Please generate a new OTP.";
            isTimerExpired = true;
            generatedOTP = null; // Invalidate OTP after expiry
            return;
        }
        timerDisplay.textContent = `Time remaining: ${timeLeft} seconds`;
        timeLeft--;
    }, 1000);
}

function OTPVerifyFn() {
    const userOTP = document.getElementById("userOTP").value;
    const successMessage = document.getElementById("successMessage");
    const errorMessage = document.getElementById("errorMessage");

    // Reset messages
    errorMessage.textContent = "";
    errorMessage.style.display = "none";
    successMessage.style.display = "none";

    // Validate OTP Entry
    if (!userOTP) {
        errorMessage.textContent = "Please enter OTP!";
        errorMessage.style.display = "block";
        return;
    }
    if (userOTP.length !== 6) {
        errorMessage.textContent = "OTP must be 6 digits!";
        errorMessage.style.display = "block";
        return;
    }
    if (isTimerExpired || generatedOTP === null) {
        errorMessage.textContent = "OTP has expired! Please generate a new OTP.";
        errorMessage.style.display = "block";
        return;
    }

    // Verify OTP
    if (parseInt(userOTP) === generatedOTP) {
        clearInterval(timerInterval);
        document.getElementById("timer").style.display = "none";

        // Show success message
        successMessage.style.display = "block";

        // Reset OTP input
        document.getElementById("userOTP").value = "";

        // Invalidate OTP after success
        generatedOTP = null;
        isTimerExpired = true;

        // Redirect after 2 seconds to the selected page
        setTimeout(() => {
            if (selectedPage) {
                window.location.href = selectedPage;
            } else {
                alert("Error: No role selected for redirection!");
            }
        }, 2000);
    } else {
        errorMessage.textContent = "Invalid OTP! Please try again.";
        errorMessage.style.display = "block";
    }
}

// Allow only numbers and limit input to 6 digits
document.getElementById("userOTP").addEventListener("input", function () {
    this.value = this.value.replace(/[^0-9]/g, '').slice(0, 6);
});
