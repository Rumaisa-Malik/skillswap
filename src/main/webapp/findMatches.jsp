<%@ page import="java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Find Matches - SkillSwap</title>

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
    <h2><i class="fa-solid fa-handshake"></i> Find Matches</h2>

    <table>
        <tr>
    <th>User Name</th>
    <th>Email</th>
    <th>Skill</th>
    <th>Action</th>
</tr>

<%
    List<Map<String, String>> matches =
        (List<Map<String, String>>) request.getAttribute("matches");

    if (matches != null && !matches.isEmpty()) {
        for (Map<String, String> m : matches) {
%>
<tr>
    <td><%= m.get("name") %></td>
    <td><%= m.get("email") %></td>
    <td><%= m.get("skill") %></td>
    <td>
        <form action="requestSession" method="post">
            <input type="hidden" name="teacherId" value="<%= m.get("user_id") %>">
            <input type="hidden" name="skill" value="<%= m.get("skill") %>">
            <button type="submit">Request</button>
        </form>
    </td>
</tr>
<%
        }
    } else {
%>
<tr>
    <td colspan="4" class="no-data">
        No matches found yet.
    </td>
</tr>
<%
    }
%>

    </table>

</div>

</body>
</html>
