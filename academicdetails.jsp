<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display User Details</title>
    <link rel="stylesheet" type="text/css" href="displaydetails.css">
</head>
<body>
    <div class="details-container">
        <h2>User Details</h2>
        <p><strong>Username:</strong> ${param.Username}</p>
        <p><strong>Full Name:</strong> ${param.FullName}</p>
        <p><strong>Email:</strong> ${param.Email}</p>
        <p><strong>Address:</strong> ${param.Address}</p>
        <p><strong>Phone Number:</strong> ${param.Phone}</p>
    </div>
</body>
</html>