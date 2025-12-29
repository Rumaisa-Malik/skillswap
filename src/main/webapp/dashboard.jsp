<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>SkillSwap Dashboard</title>

    <!-- FONT AWESOME -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            display: flex;
            height: 100vh;
            overflow: hidden;
            background: #f4f6fb;
        }

        /* SIDEBAR */
        .sidebar {
            width: 230px;
            background: linear-gradient(180deg, #4c1d95, #6d28d9);
            color: white;
            padding: 20px;
            flex-shrink: 0;
        }

        .profile {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        .profile img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
            background: white;
        }

        .settings-btn {
            position: absolute;
            top: 0;
            right: 0;
            cursor: pointer;
        }

        .settings-btn i {
            color: white;
            font-size: 18px;
        }

        .profile h3 {
            margin-top: 10px;
            font-size: 16px;
        }

        .menu a {
            display: block;
            padding: 12px;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-bottom: 8px;
        }

        .menu a i {
            width: 22px;
            margin-right: 10px;
        }

        .menu a:hover,
        .menu a.active {
            background: rgba(255,255,255,0.25);
            font-weight: bold;
        }

        /* MAIN */
        .main {
            flex: 1;
            height: 100vh;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        /* MODAL */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 25px;
            border-radius: 10px;
            width: 300px;
            text-align: center;
        }

        .close {
            float: right;
            cursor: pointer;
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">

    <div class="profile">
        <span class="settings-btn" onclick="openSettings()">
            <i class="fa-solid fa-gear"></i>
        </span>

        <%
            String profileImage = (String) session.getAttribute("profileImage");
            String imgPath = (profileImage != null && !profileImage.isEmpty())
                    ? "uploads/" + profileImage
                    : "images/default-user.jpg";
        %>

        <img src="<%= imgPath %>" onerror="this.src='images/default-user.jpg'">
        <h3>${sessionScope.userName}</h3>
    </div>

    <div class="menu">

        <!-- DASHBOARD -->
        <a href="dashboard" target="contentFrame" class="active" onclick="setActive(this)">
            <i class="fa-solid fa-house"></i> Dashboard
        </a>

        <a href="skills" target="contentFrame" onclick="setActive(this)">
            <i class="fa-solid fa-book"></i> My Skills
        </a>

        <a href="findMatches" target="contentFrame" onclick="setActive(this)">
            <i class="fa-solid fa-magnifying-glass"></i> Find Matches
        </a>

        <a href="mySessions" target="contentFrame" onclick="setActive(this)">
            <i class="fa-solid fa-calendar-days"></i> Sessions
        </a>

        <a href="learnerSessions" target="contentFrame" onclick="setActive(this)">
            <i class="fa-solid fa-clock"></i> My Learning
        </a>
        <a href="teacherSessions" target="contentFrame" onclick="setActive(this)">
                <i class="fa-solid fa-chalkboard-user"></i> Teaching
            </a>


        <a href="messages.jsp" target="contentFrame" onclick="setActive(this)">
            <i class="fa-solid fa-envelope"></i> Messages
        </a>

        <a href="feedback.jsp" target="contentFrame" onclick="setActive(this)">
            <i class="fa-solid fa-star"></i> Feedback
        </a>

        <a href="logout">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>

    </div>
</div>

<!-- RIGHT PANEL -->
<div class="main">
    <!-- ? IMPORTANT: LOAD SERVLET, NOT JSP -->
    <iframe name="contentFrame" src="dashboard"></iframe>
</div>

<!-- SETTINGS MODAL -->
<div class="modal" id="settingsModal">
    <div class="modal-content">
        <span class="close" onclick="closeSettings()">×</span>
        <h3>Edit Profile Picture</h3>

        <form action="uploadProfile" method="post" enctype="multipart/form-data">
            <input type="file" name="profilePic" required>
            <button type="submit">Save</button>
        </form>
    </div>
</div>

<script>
    function openSettings() {
        document.getElementById("settingsModal").style.display = "flex";
    }
    function closeSettings() {
        document.getElementById("settingsModal").style.display = "none";
    }
    function setActive(el) {
        document.querySelectorAll('.menu a').forEach(a => a.classList.remove('active'));
        el.classList.add('active');
    }
</script>

</body>
</html>
