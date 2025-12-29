<%@ page import="java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Sessions</title>

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
        }

        th {
            background: #ede9fe;
            color: #4c1d95;
        }

        button {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 5px;
        }

        .accept {
            background: #22c55e;
            color: white;
        }

        .reject {
            background: #ef4444;
            color: white;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Incoming Session Requests</h2>

    <table>
        <tr>
            <th>Learner</th>
            <th>Email</th>
            <th>Skill</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <%
            List<Map<String, String>> sessions =
                (List<Map<String, String>>) request.getAttribute("sessions");

            if (sessions != null && !sessions.isEmpty()) {
                for (Map<String, String> s : sessions) {
        %>
        <tr>
            <td><%= s.get("name") %></td>
            <td><%= s.get("email") %></td>
            <td><%= s.get("skill") %></td>
            <td><%= s.get("status") %></td>
            <td>
                <% if ("PENDING".equals(s.get("status"))) { %>
                <form action="updateSession" method="post" style="display:inline;">
                    <input type="hidden" name="sessionId" value="<%= s.get("id") %>">
                    <input type="hidden" name="action" value="ACCEPTED">
                    <button class="accept">Accept</button>
                </form>

                <form action="updateSession" method="post" style="display:inline;">
                    <input type="hidden" name="sessionId" value="<%= s.get("id") %>">
                    <input type="hidden" name="action" value="REJECTED">
                    <button class="reject">Reject</button>
                </form>
                <% } %>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">No session requests yet.</td>
        </tr>
        <%
            }
        %>
    </table>

</div>

</body>
</html>
