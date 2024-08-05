<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Management Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #222;
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background-color: #333;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            width: 80%;
        }
        h1 {
            color: #fff;
            margin-bottom: 20px;
            font-size: 28px;
            letter-spacing: 2px;
        }
        .quote {
            font-style: italic;
            color: #bbb;
            margin-bottom: 30px;
        }
        .input-field {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: none;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            background-color: #444;
            color: #fff;
            outline: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2) inset;
        }
        .button-container {
            margin-top: 20px;
        }
        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 18px;
            margin: 10px;
            cursor: pointer;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4);
            transition: background-color 0.3s ease, transform 0.2s ease-out;
        }
        .button:hover {
            background-color: #45a049;
            transform: translateY(-2px);
        }
        .button:focus {
            outline: none;
        }
        .button:active {
            transform: translateY(2px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the ProjectManagement Application</h1>
        <div class="quote">"Manage your projects efficiently with our application."</div>
        
        <!-- Submit Existing Database Form -->
        <form action="/submit" method="post">
            <input class="input-field" type="text" id="databaseName" name="databaseName" placeholder="Enter Database Name" required>
            <div class="button-container">
                <button class="button" type="submit">Submit</button>
            </div>
        </form>
        
        <!-- Create New Database Form -->
        <form action="/new" method="post">
            <input class="input-field" type="text" id="newDatabaseName" name="newDatabaseName" placeholder="Enter New Database Name" required>
            <div class="button-container">
                <button class="button" type="submit">Create New Database</button>
            </div>
        </form>
    </div>
</body>
</html>
