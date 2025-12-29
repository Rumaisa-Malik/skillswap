package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/teacherSessions")
public class TeacherSessionsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int teacherId = (int) session.getAttribute("userId");
        List<Map<String,String>> sessions = new ArrayList<>();

        String sql =
            "SELECT s.session_id, u.name, s.skill_name, s.status, s.created_at " +
            "FROM sessions s " +
            "JOIN users u ON u.user_id = s.learner_id " +
            "WHERE s.teacher_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String,String> row = new HashMap<>();
                row.put("id", rs.getString("session_id"));
                row.put("learner", rs.getString("name"));
                row.put("skill", rs.getString("skill_name"));
                row.put("status", rs.getString("status"));
                row.put("date", rs.getString("created_at"));
                sessions.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("sessions", sessions);
        request.getRequestDispatcher("teacherSessions.jsp").forward(request, response);
    }
}
