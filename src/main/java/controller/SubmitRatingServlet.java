package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/submitRating")
public class SubmitRatingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int learnerId = (int) session.getAttribute("userId");
        int sessionId = Integer.parseInt(request.getParameter("sessionId"));
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        int rating = Integer.parseInt(request.getParameter("rating"));

        String sql =
            "INSERT INTO ratings (session_id, teacher_id, learner_id, rating) " +
            "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sessionId);
            ps.setInt(2, teacherId);
            ps.setInt(3, learnerId);
            ps.setInt(4, rating);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // duplicate rating blocked here
        } catch (Exception ex) {
            Logger.getLogger(SubmitRatingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.sendRedirect("learnerSessions");
    }
}
