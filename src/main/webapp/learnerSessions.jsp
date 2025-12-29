<%@ page import="java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Learning - SkillSwap</title>

    <!-- FONT AWESOME -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #f4f6fb;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.12);
        }

        h2 {
            color: #4c1d95;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #ede9fe;
            color: #4c1d95;
        }

        tr:hover {
            background: #f3e8ff;
        }

        .no-data {
            text-align: center;
            color: #666;
            padding: 20px;
        }
    </style>
</head>

<body>

<div class="container">
    <h2><i class="fa-solid fa-clock"></i> My Learning</h2>

    <table>
        
        <tr>
            <th>Teacher</th>
            <th>Skill</th>
            <th>Status</th>
            <th>Date</th>
        </tr>

        <%
            List<Map<String,String>> sessions =
                    (List<Map<String,String>>) request.getAttribute("sessions");

            if (sessions != null && !sessions.isEmpty()) {
                for (Map<String,String> s : sessions) {
        %>
        <tr>
            <td><%= s.get("teacher") %></td>
            <td><%= s.get("skill") %></td>
            <td><%= s.get("status") %></td>
            <td><%= s.get("date") %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4" class="no-data">
                No learning sessions yet.
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>
