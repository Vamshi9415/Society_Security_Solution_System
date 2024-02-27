<!DOCTYPE html>
<html>
<head>
    <title>Bachu Homes</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

    <style>


        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
        }


        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px 0;
            height:100px;
        }

        h1 {
            margin: 0;
            font-size: 32px;
        }


        main {
            margin: 80px auto;
            max-width: 600px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border:5px solid black;
        }


        form {
            text-align: center;
        }

        .form-group {
            margin-top: 20px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 10px 20px;
            margin-top: 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #555;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }

        /* Footer styles */
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .login{
        border: 2px solid black;
        border-radius:2px;
        }

    </style>
</head>
<body>
    <header>
        <h1 >Bachu Homes</h1>
    </header>
    <main  style="width:600px; height:330px;"class="container animate__animated animate__fadeIn">
        <div class="login">
        <h2 style="margin-left:250px;">Login</h2></div>
        <form action="LoginServlet" method="post" id="loginForm">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" style="width:400px; height:30px;margin-left:100px;" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password"style="width:400px; height:30px;margin-left:100px" class="form-control" id="password" name="password" required>
            </div>
            <div class="error-message">
                <c:if test="${not empty errorMessage}">
                    ${errorMessage}
                </c:if>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
    </main>
    <footer class="animate__animated animate__slideInUp">
        &copy; 2023 Bachu Homes
    </footer>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function validateLoginForm() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;

            if (username.trim() === "") {
                alert("Please enter a username.");
                return false;
            }

            if (password.trim() === "") {
                alert("Please enter a password.");
                return false;
            }

            return true;
        }

        // Attach the validation function to the form's onsubmit event
        document.getElementById("loginForm").onsubmit = validateLoginForm;
    </script>
</body>
</html>
