<!DOCTYPE html>
<html>
<head>
    <title>Register - SkillSwap</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f3e8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-box {
            background: white;
            padding: 30px;
            width: 350px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .register-box h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .register-box input,
        .register-box select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
        }

        .register-box button {
            width: 100%;
            padding: 12px;
            background: #7c3aed;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
        }
    </style>
</head>

<body>

<div class="register-box">
    <h2>Create Account</h2>

    <form action="register" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <select name="mode">
            <option value="TEACH_LEARN">Teach & Learn</option>
            <option value="LEARN_ONLY">Learn Only</option>
        </select>

        <button type="submit">Register</button>
    </form>
</div>

</body>
</html>
