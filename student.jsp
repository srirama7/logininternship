<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Information</title>
    <style>
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
            padding: 20px;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            margin: 50px auto;
        }

        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }

        h2 {
            color: #2c3e50;
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #34495e;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.9);
        }

        textarea {
            height: 100px;
            resize: vertical;
        }

        .optional-label {
            color: #7f8c8d;
            font-size: 0.9em;
            font-weight: normal;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 15px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: #45a049;
            transform: scale(1.02);
        }

        .section {
            border-bottom: 1px solid rgba(238, 238, 238, 0.5);
            padding-bottom: 20px;
            margin-bottom: 20px;
        }

        input[type="tel"]::-webkit-inner-spin-button,
        input[type="tel"]::-webkit-outer-spin-button {
            margin: 0;
        }

        .form-container {
            margin: 20px auto;
            padding: 20px;
            background-color: rgba(173, 216, 230, 0.8);
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .logout-button {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #dc3545;
            color: white;
            padding: 8px 15px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .logout-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
      <button class="logout-button" onclick="window.location.href='login.jsp'">Logout</button>

    <div class="container">
        <h1>Project Information Form</h1>
        
        <!-- Correct form action and field names to match database columns -->
        <form id="projectForm" action="savestudent.jsp" method="post">
            <div class="section">
                <div class="form-group">
                    <label for="projectName">Project Name*</label>
                    <input type="text" id="projectName" name="project_name" required>
                </div>

                <div class="form-group">
                    <label for="projectDescription">Project Description*</label>
                    <textarea id="projectDescription" name="project_description" required></textarea>
                </div>
            </div>

            <div class="section">
                <h2>College Guide Information</h2>
                <div class="form-group">
                    <label for="guideName">Guide Name*</label>
                    <input type="text" id="guideName" name="guide_name" required>
                </div>

                <div class="form-group">
                    <label for="guideEmail">Guide Email*</label>
                    <input type="email" id="guideEmail" name="guide_email" required>
                </div>

                <div class="form-group">
                    <label for="guidePhone">Guide Phone Number*</label>
                    <input type="tel" id="guidePhone" name="guide_phone" pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number" required>
                </div>
            </div>

            <div class="section">
                <h2>Head of Department Information</h2>
                <div class="form-group">
                    <label for="hodName">HoD Name <span class="optional-label">(Optional)</span></label>
                    <input type="text" id="hodName" name="hod_name">
                </div>

                <div class="form-group">
                    <label for="hodEmail">HoD Email <span class="optional-label">(Optional)</span></label>
                    <input type="email" id="hodEmail" name="hod_email">
                </div>

                <div class="form-group">
                    <label for="hodPhone">HoD Phone Number <span class="optional-label">(Optional)</span></label>
                    <input type="tel" id="hodPhone" name="hod_phone" pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number">
                </div>
            </div>

            <button type="submit">Submit</button>
        </form>
    </div>

    <script>
        // Remove preventDefault to allow form submission to server
        document.getElementById('projectForm').addEventListener('submit', function(e) {
            // Basic form validation
            const phoneInputs = document.querySelectorAll('input[type="tel"]');
            let isValid = true;

            phoneInputs.forEach(input => {
                if (input.value && !input.value.match(/^[0-9]{10}$/)) {
                    isValid = false;
                    alert('Please enter a valid 10-digit phone number');
                    e.preventDefault();
                }
            });

            if (isValid) {
                // Form will submit to server
                return true;
            }
        });
    </script>
</body>
</html>