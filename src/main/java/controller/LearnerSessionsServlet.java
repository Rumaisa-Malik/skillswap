package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/learnerSessions")
public class LearnerSessionsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int learnerId = (int) session.getAttribute("userId");
        List<Map<String,String>> sessions = new ArrayList<>();

        String sql =
            "SELECT s.session_id, s.teacher_id, u.name, s.skill_name, " +
            "s.status, s.created_at " +
            "FROM sessions s " +
            "JOIN users u ON u.user_id = s.teacher_id " +
            "WHERE s.learner_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, learnerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String,String> row = new HashMap<>();

                // REQUIRED FOR RATING
                row.put("session_id", rs.getString("session_id"));
                row.put("teacher_id", rs.getString("teacher_id"));

                // DISPLAY DATA
                row.put("teacher", rs.getString("name"));
                row.put("skill", rs.getString("skill_name"));
                row.put("status", rs.getString("status"));
                row.put("date", rs.getString("created_at"));

                sessions.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace(); // check server console if anything fails
        }

        request.setAttribute("sessions", sessions);
        request.getRequestDispatcher("learnerSessions.jsp")
               .forward(request, response);
    }
}
