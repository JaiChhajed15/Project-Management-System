<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Entities Management</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #1e1e1e;
        color: #ffffff;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .container {
        text-align: center;
        background-color: #2c2c2c;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        max-width: 600px;
        width: 80%;
    }
    h1 {
        color: #ffffff;
        margin-bottom: 20px;
        font-size: 32px;
        letter-spacing: 1px;
    }
    p {
        color: #b3b3b3;
        margin-bottom: 20px;
        font-size: 18px;
    }
    .input-field {
        width: calc(100% - 24px);
        padding: 12px;
        margin-bottom: 20px;
        border: 1px solid #444;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 16px;
        background-color: #3c3c3c;
        color: #ffffff;
        outline: none;
    }
    .button-container {
        margin-top: 20px;
    }
    .button {
        background-color: #4CAF50;
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 18px;
        margin: 10px;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.2s ease-out;
    }
    .button:hover {
        background-color: #45a049;
    }
    .button:focus {
        outline: none;
    }
    .button:active {
        transform: translateY(2px);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
    }
    .error-message {
        color: #f00;
        font-weight: bold;
        margin-top: 20px;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Entities Management</h1>
        
        <%-- Display Table Name --%>
        <% if (request.getAttribute("tableName") != null) { %>
            <p>Created Table: <strong>${tableName}</strong></p>
        <% } %>
        
        <%-- Display Error Message if Present --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <%-- Form for Adding Columns --%>
        <form id="columnForm" action="" method="post">
            <input class="input-field" type="text" id="columnName" name="columnName" placeholder="Enter Column Name" required>
            
            <label for="columnType" style="display:block; margin-bottom: 10px; color: #b3b3b3;">Select Column Type</label>
            <select id="columnType" name="columnType" class="input-field">
                <option value="DATETIME">Date and Time</option>
                <option value="NUMBER">Number</option>
                <option value="TEXT">Text</option>
                <option value="DESCRIPTION">Description</option>
                <option value="BIGINT">Big Integer</option>
                <option value="BOOLEAN">Boolean</option>
            </select>
            
            <label for="isPrimaryKey" style="display:block; margin-bottom: 10px; color: #b3b3b3;">Is Primary Key?</label>
            <select id="isPrimaryKey" name="isPrimaryKey" class="input-field">
                <option value="">No</option>
                <option value="yes">Yes</option>
            </select>
            
            <div class="button-container">
                <button class="button" type="submit">Submit</button>
            </div>
        </form>

        <%-- Show Table Button --%>
        <form id="showTable" action="show" method="get" style="margin-top: 20px;">
            <div class="button-container">
                <button class="button" type="submit">Show Tables</button>
            </div>
        </form>
    </div>

    <script>
        document.getElementById('columnForm').addEventListener('submit', function(event) {
            var isPrimaryKey = document.getElementById('isPrimaryKey').value;
            var formAction = '';

            if (isPrimaryKey === 'yes') {
                formAction = '/isPrimaryKey'; // Route to the primary key handler
            } else {
                formAction = '/addColumn'; // Route to the add column handler
            }

            this.action = formAction;
        });
    </script>
</body>
</html>
