package controller;

import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/skills")
public class SkillServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        /* ===== DELETE SKILL LOGIC ===== */
        String deleteId = request.getParameter("delete");
        if (deleteId != null) {
            try (Connection con = DBConnection.getConnection()) {
                String sql = "DELETE FROM skills WHERE skill_id=? AND user_id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(deleteId));
                ps.setInt(2, userId);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("skills");
            return;
        }

        /* ===== FETCH SKILLS ===== */
        List<Map<String, String>> skills = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT skill_id, skill_name, skill_type FROM skills WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> skill = new HashMap<>();
                skill.put("id", rs.getString("skill_id"));
                skill.put("name", rs.getString("skill_name"));
                skill.put("type", rs.getString("skill_type"));
                skills.add(skill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("skills", skills);
        request.getRequestDispatcher("mySkills.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String skillName = request.getParameter("skillName");
        String skillType = request.getParameter("skillType");

        if (skillName == null || skillName.isEmpty() || skillType == null) {
            response.sendRedirect("skills");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO skills (user_id, skill_name, skill_type) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, skillName);
            ps.setString(3, skillType);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("skills");
    }
}
