<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Tables</title>
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
</style>
</head>
<body>
    <div class="container">
        <h1>Tables</h1>

        <%
            // Retrieve and cast the list of table names
            @SuppressWarnings("unchecked")
            List<String> tables = (List<String>) request.getAttribute("tables");
            
            if (tables != null && !tables.isEmpty()) {
        %>
            <div class="button-container">
                <% for (String table : tables) { %>
                    <form action="/showTableData" method="get" style="display:inline;">
                        <input type="hidden" name="tableName" value="<%= table %>">
                        <button type="submit" class="button"><%= table %></button>
                    </form>
                <% } %>
            </div>
        <% } else { %>
            <p>No tables found in the database.</p>
        <% } %>
    </div>
</body>
</html>
