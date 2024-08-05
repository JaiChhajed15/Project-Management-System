<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dues Table</title>
    <style>
        /* Dark Mode CSS Styling with Colors and Borders */
        body {
            background-color: #2e2e2e;
            color: #dcdcdc;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            color: #f0a500; /* Bright color for heading */
            padding: 20px;
            border-bottom: 2px solid #444;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #333;
            border: 1px solid #444;
            border-radius: 8px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #555;
        }
        th {
            background-color: #444;
            color: #f0f0f0; /* Light color for headers */
            border-top: 2px solid #555;
        }
        tr:nth-child(even) {
            background-color: #282828;
        }
        tr:hover {
            background-color: #444;
        }
        .dropdown {
            position: relative;
            display: inline-block;
        }
        .dropbtn {
            background-color: #555;
            color: #f0f0f0;
            border: 1px solid #666;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s, border-color 0.3s;
        }
        .dropbtn:hover {
            background-color: #666;
            border-color: #777;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #333;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 4px;
            border: 1px solid #444;
        }
        .dropdown-content a {
            color: #dcdcdc;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            text-align: center;
            border-bottom: 1px solid #444;
        }
        .dropdown-content a:hover {
            background-color: #575757;
        }
        .dropdown:hover .dropdown-content {
            display: block;
        }
        .dropdown .dropbtn:focus {
            outline: none;
        }
    </style>
</head>
<body>
    <h2>Dues Table</h2>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Unique ID</th>
                <th>Email</th>
                <th>Remaining Time</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="row" items="${rows}">
                <tr>
                    <td>${row.Name}</td>
                    <td>${row.Unique_id}</td>
                    <td>${row.email}</td>
                    <td>${row.Remaining_Time} minutes</td>
                    <td>
                        <div class="dropdown">
                            <button class="dropbtn" id="status-btn-${row.Unique_id}" data-status="${row.status}">
                                <span id="status-symbol-${row.Unique_id}">${row.status == 'tick' ? '&#10004;' : (row.status == 'cross' ? '&#10008;' : 'Select')}</span>
                            </button>
                            <div class="dropdown-content">
                                <a href="#" onclick="selectStatus('${row.Unique_id}', 'tick')"><span>&#10004;</span> Tick</a>
                                <a href="#" onclick="selectStatus('${row.Unique_id}', 'cross')"><span>&#10008;</span> Cross</a>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <script>
        function selectStatus(id, status) {
            const button = document.getElementById(`status-btn-${id}`);
            const symbol = document.getElementById(`status-symbol-${id}`);
            button.setAttribute('data-status', status);
            symbol.innerHTML = status === 'tick' ? '&#10004;' : '&#10008;';
            localStorage.setItem(`status-${id}`, status);
        }

        document.querySelectorAll('.dropdown').forEach(dropdown => {
            const button = dropdown.querySelector('.dropbtn');
            const id = button.id.split('-').pop();
            const savedStatus = localStorage.getItem(`status-${id}`);
            if (savedStatus) {
                const symbol = dropdown.querySelector('#status-symbol-' + id);
                symbol.innerHTML = savedStatus === 'tick' ? '&#10004;' : '&#10008;';
                button.setAttribute('data-status', savedStatus);
            }
        });
    </script>
</body>
</html>
