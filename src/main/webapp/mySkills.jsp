<%@ page import="java.util.*" %>
<%@ page session="true" %>

<!-- 
    CONTENT-ONLY JSP
    Loaded inside dashboard iframe
-->

<style>
    .content-card {
        background: white;
        padding: 25px;
        border-radius: 14px;
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        max-width: 1000px;
    }

    h2 {
        color: #4c1d95;
        margin-bottom: 20px;
    }

    form {
        display: flex;
        gap: 10px;
        margin-bottom: 25px;
    }

    input, select, button {
        padding: 10px;
        font-size: 14px;
    }

    input, select {
        flex: 1;
    }

    button {
        background: #6d28d9;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
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

    .remove-btn {
        color: red;
        text-decoration: none;
        font-weight: bold;
    }
</style>

<div class="content-card">

    <h2>My Skills</h2>

    <!-- ADD SKILL -->
    <form action="skills" method="post">
        <input type="text" name="skillName" placeholder="Skill name" required>

        <select name="skillType" required>
            <option value="">Select Type</option>
            <option value="TEACH">Teach</option>
            <option value="LEARN">Learn</option>
        </select>

        <button type="submit">Add Skill</button>
    </form>

    <!-- SKILLS TABLE -->
    <table>
        <tr>
            <th>Skill</th>
            <th>Type</th>
            <th>Action</th>
        </tr>

        <%
            List<Map<String, String>> skills =
                    (List<Map<String, String>>) request.getAttribute("skills");

            if (skills != null && !skills.isEmpty()) {
                for (Map<String, String> s : skills) {
        %>
        <tr>
            <td><%= s.get("name") %></td>
            <td><%= s.get("type") %></td>
            <td>
                <a class="remove-btn"
                    href="skills?delete=<%= s.get("id") %>"
                    onclick="return confirm('Remove this skill?');">
                     <i class="fa-solid fa-trash"></i> Remove
                </a>

            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3">No skills added yet.</td>
        </tr>
        <%
            }
        %>
    </table>

</div>
