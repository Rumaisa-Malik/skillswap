package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/findMatches")
public class FindMatchesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        List<Map<String, String>> matches = new ArrayList<>();

           String sql =
    "SELECT u.user_id, u.name, u.email, s1.skill_name " +
    "FROM skills s1 " +
    "JOIN users u ON u.user_id = s1.user_id " +
    "WHERE s1.skill_type = 'TEACH' " +
    "AND s1.skill_name IN ( " +
    "   SELECT skill_name FROM skills " +
    "   WHERE user_id = ? AND skill_type = 'LEARN' " +
    ") " +
    "AND s1.user_id <> ?";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("name", rs.getString("name"));
                row.put("email", rs.getString("email"));
                row.put("skill", rs.getString("skill_name"));
                row.put("user_id", rs.getString("user_id"));
                matches.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace(); // IMPORTANT: see error in console
        }

        request.setAttribute("matches", matches);
        request.getRequestDispatcher("findMatches.jsp").forward(request, response);
    }
}
