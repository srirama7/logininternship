/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function validateAndProceed() {
    const emailInput = document.getElementById("email");
    const emailError = document.getElementById("emailError");
    const phoneInput = document.getElementById("phone");
    const phoneError = document.getElementById("phoneError");
    const addressInput = document.getElementById("address");
    const addressError = document.getElementById("addressError");
    const fullNameInput = document.getElementById("fullName");
    const internshipSelect = document.querySelector('select[name="internship"]');
    const relationSelect = document.querySelector('select[name="relationwithemployee"]');

    const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail|cdot|outlook|yahoo|hotmail)\.(com|in|net|org|ai|gov|mil|int|edu)$/;
    const phoneRegex = /^\d{10}$/;
    const addressRegex = /^[a-zA-Z0-9\s#$@]+$/;

    const emailValue = emailInput.value.trim();
    const phoneValue = phoneInput.value.trim();
    const addressValue = addressInput.value.trim();

    let isValid = true;

    // Check if all required fields are filled
    if (!fullNameInput.value.trim()) {
        alert("Please enter your full name");
        fullNameInput.focus();
        return false;
    }

    if (!internshipSelect.value) {
        alert("Please select type of internship");
        internshipSelect.focus();
        return false;
    }

    if (!relationSelect.value) {
        alert("Please select relationship with employee");
        relationSelect.focus();
        return false;
    }

    if (!emailRegex.test(emailValue)) {
        emailError.textContent = "Please enter a valid email in the format abc@gmail.com";
        emailInput.focus();
        isValid = false;
    } else {
        emailError.textContent = "";
    }

    if (!phoneRegex.test(phoneValue)) {
        phoneError.textContent = "Please enter a valid 10-digit phone number.";
        phoneInput.focus();
        isValid = false;
    } else {
        phoneError.textContent = "";
    }
    
    if (!addressRegex.test(addressValue)) {
        addressError.textContent = "Address can only contain letters, numbers, spaces, #, $, and @.";
        addressError.style.display = "block";
        isValid = false;
    } else {
        addressError.textContent = "";
        addressError.style.display = "none";
    }

    if (isValid) {
        showForm('academicDetails');
    }
    return isValid;
}

        function validateEmail(input) {
            const emailError = document.getElementById("emailError");
            const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail|cdot|outlook|yahoo|hotmail)\.(com|in|org|net|gov|ai|mil|int|edu)$/;

            if (!emailRegex.test(input.value)) {
                emailError.textContent = "Please enter a valid email in the format abc@gmail.com";
            } else {
                emailError.textContent = "";
            }
        }
        
        function toggleOtherField() {
             var departmentSelect = document.getElementById("department");
            var otherDepartmentDiv = document.getElementById("otherDepartmentDiv");

            if (departmentSelect.value === "OTHER") {
                otherDepartmentDiv.style.display = "block";
            } else {
                otherDepartmentDiv.style.display = "none";
                document.getElementById("otherDepartment").value = ""; // Clear input when hidden
            }
        }
        function validateAddress(input) {
            const addressError = document.getElementById("addressError");
            const addressRegex = /^[a-zA-Z0-9\s#$@]+$/;

            if (!addressRegex.test(input.value)) {
                addressError.textContent = "Address can only contain letters, numbers, spaces, #, $, and @.";
            } else {
                addressError.textContent = "";
            }
        }

        function validateSem() {
            let semInput = document.getElementById("sem");
            let errorMsg = document.getElementById("error-msg");
            let semValue = parseInt(semInput.value);

            if (isNaN(semValue) || semValue < 1 || semValue > 8) {
                errorMsg.style.display = "inline";
                semInput.value = "";
                hideAllSemesters();
            } else {
                errorMsg.style.display = "none";
                showSemesters(semValue);
            }
        }

        function hideAllSemesters() {
            for (let i = 1; i <= 8; i++) {
                let semField = document.getElementById("sem" + i);
                if (semField) {
                    semField.style.display = "none";
                    let semInput = semField.querySelector('input');
                    if (semInput) {
                        semInput.required = false;
                    }
                }
            }
        }

        function showSemesters(currentSem) {
            hideAllSemesters();
            
            for (let i = 1; i < currentSem; i++) {
                let semField = document.getElementById("sem" + i);
                if (semField) {
                    semField.style.display = "inline-block";
                    let semInput = semField.querySelector('input');
                    if (semInput) {
                        semInput.required = true;
                    }
                }
            }
        }

        function validatePhoneNumber(input) {
            input.value = input.value.replace(/\D/g, '');
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
                return false;
            }

            if (parseInt(sem) > 8) {
                errorMsg.style.display = "inline";
                return false;
            }

            let currentSem = parseInt(sem);
            for (let i = 1; i < currentSem; i++) {
                let semInput = document.querySelector(`input[name="sem${i}_marks"]`);
                if (semInput && semInput.style.display !== "none" && !semInput.value) {
                    alert(`Please enter marks for Semester ${i}`);
                    return false;
                }
            }

            phoneError.textContent = "";
            errorMsg.style.display = "none";
            return true;
        }

        

        function setActiveButton(formId) {
            document.querySelectorAll('.button-container button').forEach(button => {
                button.classList.remove('active');
            });
        
            const buttonMap = {
                'userDetails': 'button[onclick="showForm(\'userDetails\')"]',
                'academicDetails': 'button[onclick="showForm(\'academicDetails\')"]',
                'trainingDetails': 'button[onclick="showForm(\'trainingDetails\')"]',
                'viewDetails': 'button[onclick="window.location.href=\'displayDetails.jsp\'"]'
            };
        
            if (buttonMap[formId]) {
                document.querySelector(buttonMap[formId]).classList.add('active');
            }
        }
        
        function validateCGPA(input) {
        let cgpa = parseFloat(input.value);
        if (cgpa > 10) {
            alert("CGPA cannot be greater than 10. Please enter a valid value.");
            input.value = ""; // Clear the input field
            input.focus(); // Focus back on the input field
        }
    }

    function checkCGPA() {
        let cgpaInput = document.getElementById('cgpaInput');
        let cgpaError = document.getElementById('cgpaError');
        let value = parseFloat(cgpaInput.value);

        if (isNaN(value) || value < 0 || value > 10) {
            cgpaError.textContent = 'Please enter a valid CGPA between 0.0 and 10.0';
        } else {
            cgpaError.textContent = '';
        }
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

        window.onload = function() {
            document.body.addEventListener('mousemove', resetTimer);
            document.body.addEventListener('keypress', resetTimer);
            setActiveButton('userDetails');
        };
        
        function showTrainingForm() {
            document.querySelectorAll('.form-container').forEach(f => f.classList.remove('active'));
            document.getElementById('trainingDetails').classList.add('active');
            setActiveButton('trainingDetails');
            
            document.getElementById('trainingHiddenFullName').value = document.getElementById('fullName').value;
            document.getElementById('trainingHiddenEmail').value = document.getElementById('email').value;
            document.getElementById('trainingHiddenAddress').value = document.getElementById('address').value;
            document.getElementById('trainingHiddenPhone').value = document.getElementById('phone').value;
        }

        function validateTrainingForm() {
            const guideName = document.querySelector('input[name="guideName"]').value;
            const duration = document.querySelector('input[name="trainingDuration"]').value;
            
            if (!guideName.trim()) {
                alert('Please enter a guide name');
                return false;
            }
            
            if (!duration || duration < 1 || duration > 12) {
                alert('Please enter a valid training duration between 1 and 12 months');
                return false;
            }
            
            showPopup();
            return true;
        }
        
        
        function validateUserDetails() {
    const requiredFields = {
        'internship': document.querySelector('select[name="internship"]'),
        'fullName': document.getElementById('fullName'),
        'email': document.getElementById('email'),
        'address': document.getElementById('address'),
        'relationwithemployee': document.querySelector('select[name="relationwithemployee"]'),
        'phone': document.getElementById('phone')
    };

    let isValid = true;
    
    // Check if all fields are filled
    for (let field in requiredFields) {
        const element = requiredFields[field];
        if (!element.value.trim()) {
            element.style.borderColor = 'red';
            isValid = false;
        } else {
            element.style.borderColor = '';
        }
    }

    // Additional validations
    if (!validateEmail(document.getElementById('email'))) {
        isValid = false;
    }
    
    if (!validatePhoneNumber(document.getElementById('phone'))) {
        isValid = false;
    }
    
    if (!validateAddress(document.getElementById('address'))) {
        isValid = false;
    }

    if (!isValid) {
        alert('Please fill in all required fields correctly before proceeding.');
        return false;
    }

    return true;
}


function validateAcademicDetails() {
    const requiredFields = {
        'course_select': document.querySelector('select[name="Select"]'),
        'department': document.getElementById('department'),
        'course_name': document.querySelector('input[name="course"]'),
        'university': document.querySelector('input[name="university"]'),
        'college': document.querySelector('input[name="college"]'),
        'duration': document.querySelector('select[name="duration"]'),
        'year': document.getElementById('year'),
        'sem': document.getElementById('sem'),
        'cgpa': document.getElementById('cgpaInput')
    };

    let isValid = true;

    // Check if all fields are filled
    for (let field in requiredFields) {
        const element = requiredFields[field];
        if (!element.value.trim()) {
            element.style.borderColor = 'red';
            isValid = false;
        } else {
            element.style.borderColor = '';
        }
    }

    // Validate semester marks if they're visible
    const currentSem = parseInt(document.getElementById('sem').value);
    for (let i = 1; i < currentSem; i++) {
        const semField = document.querySelector(`input[name="sem${i}_marks"]`);
        if (semField && semField.style.display !== 'none' && !semField.value.trim()) {
            semField.style.borderColor = 'red';
            isValid = false;
        }
    }

    if (!isValid) {
        alert('Please fill in all required fields before proceeding.');
        return false;
    }

    return true;
}

function validateTrainingDetails() {
    const requiredFields = {
        'groupName': document.querySelector('select[name="groupName"]'),
        'groupstaff': document.querySelector('select[name="groupstaff"]'),
        'guideName': document.querySelector('input[name="guideName"]'),
        'trainingDuration': document.querySelector('input[name="trainingDuration"]')
    };

    let isValid = true;

    for (let field in requiredFields) {
        const element = requiredFields[field];
        if (!element.value.trim()) {
            element.style.borderColor = 'red';
            isValid = false;
        } else {
            element.style.borderColor = '';
        }
    }

    if (!isValid) {
        alert('Please fill in all required fields before proceeding.');
        return false;
    }

    return true;
}



function showTrainingForm() {
    if (validateAcademicDetails()) {
        document.querySelectorAll('.form-container').forEach(f => f.classList.remove('active'));
        document.getElementById('trainingDetails').classList.add('active');
        setActiveButton('trainingDetails');
        
        // Transfer hidden fields
        document.getElementById('trainingHiddenFullName').value = document.getElementById('fullName').value;
        document.getElementById('trainingHiddenEmail').value = document.getElementById('email').value;
        document.getElementById('trainingHiddenAddress').value = document.getElementById('address').value;
        document.getElementById('trainingHiddenPhone').value = document.getElementById('phone').value;
    }
}

// Update the back button functionality
function goBack(currentForm, previousForm) {
    showForm(previousForm);
}

function isStudentDetailsFilled() {
    const fullName = document.getElementById("fullName").value.trim();
    const email = document.getElementById("email").value.trim();
    const address = document.getElementById("address").value.trim();
    const phone = document.getElementById("phone").value.trim();
    const internship = document.querySelector('select[name="internship"]').value;
    const relation = document.querySelector('select[name="relationwithemployee"]').value;

    return fullName && email && address && phone && internship && relation;
}

// Function to check if academic details are filled
function isAcademicDetailsFilled() {
    const course = document.querySelector('select[name="Select"]').value;
    const department = document.getElementById("department").value;
    const courseName = document.querySelector('input[name="course"]').value.trim();
    const university = document.querySelector('input[name="university"]').value.trim();
    const college = document.querySelector('input[name="college"]').value.trim();
    const duration = document.querySelector('select[name="duration"]').value;
    const year = document.getElementById("year").value;
    const sem = document.getElementById("sem").value;

    return course && department && courseName && university && college && duration && year && sem;
}

function showForm(formId) {
    // Check if trying to access academic details without filling student details
    if (formId === 'academicDetails' && !isStudentDetailsFilled()) {
        alert("Please fill all Student Details first!");
        showForm('userDetails');
        return;
    }

    // Check if trying to access training details without filling academic details
    if (formId === 'trainingDetails') {
        if (!isStudentDetailsFilled()) {
            alert("Please fill Student Details first!");
            showForm('userDetails');
            return;
        }
        if (!isAcademicDetailsFilled()) {
            alert("Please fill Academic Details first!");
            showForm('academicDetails');
            return;
        }
    }

    document.querySelectorAll('.form-container').forEach(f => f.classList.remove('active'));
    document.getElementById(formId).classList.add('active');
    setActiveButton(formId);
}
