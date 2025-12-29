package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;

@WebServlet("/updateSession")
public class UpdateSessionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int sessionId = Integer.parseInt(request.getParameter("sessionId"));
        String action = request.getParameter("action"); // ACCEPTED / REJECTED

        String getIdsSQL =
            "SELECT learner_id, teacher_id FROM sessions WHERE session_id = ?";

        String updateSessionSQL =
            "UPDATE sessions SET status = ? WHERE session_id = ?";

        String deductCreditSQL =
            "UPDATE users SET credits = credits - 1 WHERE user_id = ?";

        String addCreditSQL =
            "UPDATE users SET credits = credits + 1 WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false); // start transaction

            int learnerId = 0;
            int teacherId = 0;

            // 1️⃣ Get learner & teacher
            try (PreparedStatement ps = con.prepareStatement(getIdsSQL)) {
                ps.setInt(1, sessionId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    learnerId = rs.getInt("learner_id");
                    teacherId = rs.getInt("teacher_id");
                }
            }

            // 2️⃣ Update session status
            try (PreparedStatement ps = con.prepareStatement(updateSessionSQL)) {
                ps.setString(1, action);
                ps.setInt(2, sessionId);
                ps.executeUpdate();
            }

            // 3️⃣ Transfer credits ONLY if accepted
            if ("ACCEPTED".equals(action)) {

                try (PreparedStatement ps = con.prepareStatement(deductCreditSQL)) {
                    ps.setInt(1, learnerId);
                    ps.executeUpdate();
                }

                try (PreparedStatement ps = con.prepareStatement(addCreditSQL)) {
                    ps.setInt(1, teacherId);
                    ps.executeUpdate();
                }
            }

            con.commit(); // end transaction

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("mySessions");
    }
}
