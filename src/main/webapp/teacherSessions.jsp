<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teaching Sessions</title>

    <style>
        body { font-family: Arial; padding: 30px; background: #f4f6fb; }
        .box { background: white; padding: 25px; border-radius: 12px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; }
        th { background: #ede9fe; color: #4c1d95; }
        a.btn {
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            font-size: 13px;
        }
        .accept { background: green; }
        .reject { background: red; }
    </style>
</head>

<body>

<div class="box">
    <h2>My Teaching Sessions</h2>

    <table>
        <tr>
            <th>Learner</th>
            <th>Skill</th>
            <th>Status</th>
            <th>Date</th>
            <th>Action</th>
        </tr>

        <%
            List<Map<String,String>> sessions =
                (List<Map<String,String>>) request.getAttribute("sessions");

            if (sessions != null && !sessions.isEmpty()) {
                for (Map<String,String> s : sessions) {
        %>
        <tr>
            <td><%= s.get("learner") %></td>
            <td><%= s.get("skill") %></td>
            <td><%= s.get("status") %></td>
            <td><%= s.get("date") %></td>
            <td>
                <% if ("PENDING".equals(s.get("status"))) { %>
                    <a class="btn accept" href="updateSession?id=<%= s.get("id") %>&status=ACCEPTED">Accept</a>
                    <a class="btn reject" href="updateSession?id=<%= s.get("id") %>&status=REJECTED">Reject</a>
                <% } else { %>
                    ?
                <% } %>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">No teaching sessions yet.</td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
