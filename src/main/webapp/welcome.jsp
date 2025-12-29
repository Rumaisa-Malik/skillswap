<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int uid = (int) session.getAttribute("userId");

    int credits = 0;
    int skills = 0;
    int sessions = 0;
    double rating = 0.0;

    try (Connection con = util.DBConnection.getConnection()) {

        PreparedStatement ps1 =
            con.prepareStatement("SELECT credits FROM users WHERE user_id=?");
        ps1.setInt(1, uid);
        ResultSet rs1 = ps1.executeQuery();
        if (rs1.next()) credits = rs1.getInt(1);

        PreparedStatement ps2 =
            con.prepareStatement("SELECT COUNT(*) FROM skills WHERE user_id=?");
        ps2.setInt(1, uid);
        ResultSet rs2 = ps2.executeQuery();
        if (rs2.next()) skills = rs2.getInt(1);

        PreparedStatement ps3 =
            con.prepareStatement(
                "SELECT COUNT(*) FROM sessions WHERE learner_id=? OR teacher_id=?");
        ps3.setInt(1, uid);
        ps3.setInt(2, uid);
        ResultSet rs3 = ps3.executeQuery();
        if (rs3.next()) sessions = rs3.getInt(1);

        PreparedStatement ps4 =
            con.prepareStatement(
                "SELECT AVG(rating) FROM ratings WHERE teacher_id=?");
        ps4.setInt(1, uid);
        ResultSet rs4 = ps4.executeQuery();
        if (rs4.next()) rating = rs4.getDouble(1);
    }
%>

<div style="padding:30px;">

    <h2 style="color:#4c1d95;">Dashboard</h2>
    <p>Mode: <strong>${sessionScope.mode}</strong></p>

    <br>

    <div style="
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
        gap:20px;
        margin-bottom:30px;
    ">
        <div style="background:white;padding:20px;border-radius:10px;">
            Credits<br><b><%= credits %></b>
        </div>

        <div style="background:white;padding:20px;border-radius:10px;">
            Skills<br><b><%= skills %></b>
        </div>

        <div style="background:white;padding:20px;border-radius:10px;">
            Sessions<br><b><%= sessions %></b>
        </div>

        <div style="background:white;padding:20px;border-radius:10px;">
            Rating<br><b><%= String.format("%.1f", rating) %></b>
        </div>
    </div>

    <div style="
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
        gap:20px;
    ">

        <div style="background:white;padding:25px;border-radius:12px;">
            <h3>Add Skills</h3>
            <p>List the skills you can teach or want to learn.</p>
            <a href="skills" target="contentFrame">Go →</a>
        </div>

        <div style="background:white;padding:25px;border-radius:12px;">
            <h3>Find Matches</h3>
            <p>Get matched with users based on skill interests.</p>
            <a href="findMatches" target="contentFrame">Go →</a>
        </div>

        <div style="background:white;padding:25px;border-radius:12px;">
            <h3>My Learning</h3>
            <p>View your learning sessions.</p>
            <a href="learnerSessions" target="contentFrame">Go →</a>
        </div>

        <div style="background:white;padding:25px;border-radius:12px;">
            <h3>Feedback</h3>
            <p>View feedback and improve your rating.</p>
            <a href="feedback.jsp" target="contentFrame">Go →</a>
        </div>
    </div>
</div>
