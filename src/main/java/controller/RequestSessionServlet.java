package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/requestSession")
public class RequestSessionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int learnerId = (int) session.getAttribute("userId");
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        String skill = request.getParameter("skill");

        String sql =
            "INSERT INTO sessions (learner_id, teacher_id, skill_name) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, learnerId);
            ps.setInt(2, teacherId);
            ps.setString(3, skill);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("findMatches");
    }
}
