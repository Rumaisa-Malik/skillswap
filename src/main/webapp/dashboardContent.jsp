<%@ page contentType="text/html;charset=UTF-8" %>

<div style="padding:30px;">

    <h2 style="color:#4c1d95;">Dashboard</h2>
    <p>Mode: <strong>${sessionScope.mode}</strong></p>

    <br>

    <!-- STATS -->
    <div style="
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
        gap:20px;
        margin-bottom:30px;
    ">
        <div style="background:white;padding:20px;border-radius:10px;">
            Credits<br><b>${credits}</b>
        </div>

        <div style="background:white;padding:20px;border-radius:10px;">
            Skills<br><b>${skillsCount}</b>
        </div>

        <div style="background:white;padding:20px;border-radius:10px;">
            Sessions<br><b>${sessionsCount}</b>
        </div>

        <div style="background:white;padding:20px;border-radius:10px;">
            Rating<br><b>${rating}</b>
        </div>
    </div>

    <!-- FEATURE CARDS -->
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
