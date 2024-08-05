<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, java.util.Map, java.util.Set" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello World</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        .message {
            font-size: 24px;
            color: #4CAF50;
        }
        .table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 80%;
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        .table th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
    <div class="message">
        <h1>Hello, World!</h1>
        <p>Table Name: <%= request.getAttribute("tableName") %></p>

        <% 
            @SuppressWarnings("unchecked") 
            List<Map<String, Object>> columns = (List<Map<String, Object>>) request.getAttribute("columns");
            if (columns != null && !columns.isEmpty()) { 
                Map<String, Object> firstRow = columns.get(0);
                Set<String> headers = firstRow.keySet();
        %>
        <h2>Columns</h2>
        <table class="table">
            <thead>
                <tr>
                    <% 
                        // Print table headers
                        for (String header : headers) { 
                    %>
                        <th><%= header %></th>
                    <% 
                        } 
                    %>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Print table rows
                    for (Map<String, Object> row : columns) { 
                %>
                    <tr>
                        <% 
                            for (String header : headers) { 
                        %>
                            <td><%= row.get(header) %></td>
                        <% 
                            } 
                        %>
                    </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
        <% } else { %>
            <p>No columns found for this table.</p>
        <% } %>
    </div>
</body>
</html>
