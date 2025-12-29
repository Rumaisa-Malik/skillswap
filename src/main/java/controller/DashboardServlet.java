package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        int credits = 0;
        int skills = 0;
        int sessions = 0;

        try (Connection con = DBConnection.getConnection()) {

            // Credits
            try (PreparedStatement ps =
                         con.prepareStatement("SELECT credits FROM users WHERE user_id=?")) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) credits = rs.getInt("credits");
            }

            // Skills count
            try (PreparedStatement ps =
                         con.prepareStatement("SELECT COUNT(*) FROM skills WHERE user_id=?")) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) skills = rs.getInt(1);
            }

            // Learning sessions count
            try (PreparedStatement ps =
                         con.prepareStatement("SELECT COUNT(*) FROM sessions WHERE learner_id=?")) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) sessions = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("credits", credits);
        request.setAttribute("skills", skills);
        request.setAttribute("sessions", sessions);

        request.getRequestDispatcher("dashboardContent.jsp").forward(request, response);
    }
}
