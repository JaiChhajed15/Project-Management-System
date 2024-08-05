<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Table Data</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #1e1e1e;
            color: #e0e0e0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #2c2c2c;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.5);
            max-width: 90%;
            width: 90%;
            overflow-x: auto; /* Added to enable horizontal scrolling */
        }
        h1 {
            color: #4CAF50;
            font-size: 28px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            table-layout: auto; /* Added to allow dynamic column resizing */
        }
        th, td {
            border: 1px solid #444;
            padding: 10px;
            text-align: left;
            white-space: nowrap; /* Prevent text wrapping to allow horizontal scrolling */
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #333;
        }
        tr:nth-child(odd) {
            background-color: #2c2c2c;
        }
        input, select, textarea {
            background-color: #333;
            color: #ddd;
            border: 1px solid #555;
            padding: 8px;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }
        .form-row > div {
            flex: 1;
            margin-right: 10px;
        }
        .form-row > div:last-child {
            margin-right: 0;
        }
        .form-row button {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            padding: 8px 16px;
        }
        .current-time {
            font-weight: bold;
        }
    </style>
    <script>
        function updateCurrentTime() {
            const timeCells = document.querySelectorAll('.current-time');
            const now = new Date();
            const timeString = now.toLocaleString();
            timeCells.forEach(cell => {
                cell.textContent = timeString;
            });
        }

        setInterval(updateCurrentTime, 1000);
    </script>
</head>
<body>
    <div class="container">
        <h1>Table: <c:out value="${tableName}"/></h1>
        <div class="error-message">
            <c:if test="${not empty errorMessage}">
                <p><c:out value="${errorMessage}"/></p>
            </c:if>
        </div>
        <form action="/addRow" method="post">
            <table>
                <thead>
                    <tr>
                        <c:forEach var="fieldName" items="${fieldNames}">
                            <th><c:out value="${fieldName}"/></th>
                        </c:forEach>
                        <th>Current Time</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Display Existing Rows -->
                    <c:forEach var="row" items="${rows}">
                        <tr>
                            <c:forEach var="field" items="${fieldNames}">
                                <td><c:out value="${row[field]}"/></td>
                            </c:forEach>
                            <td class="current-time"></td>
                        </tr>
                    </c:forEach>
                    <!-- Form for Adding New Row -->
                    <tr>
                        <c:forEach var="fieldName" items="${fieldNames}">
                            <td>
                                <c:choose>
                                    <c:when test="${fieldName == 'unique_id'}">
                                        <input type="number" id="${fieldName}" name="${fieldName}" required>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" id="${fieldName}" name="${fieldName}" list="${fieldName}List">
                                        <datalist id="${fieldName}List">
                                            <option value="null">null</option>
                                            <option value=""></option>
                                        </datalist>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </c:forEach>
                        <td class="current-time"></td>
                        <td>
                            <button type="submit" title="Add Row">&#x2714;</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <form action="/remainingTime" method="get">
            <button type="submit" title="Show Dues">Show Dues</button>
        </form>
    </div>
</body>
</html>
