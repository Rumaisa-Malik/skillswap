package controller;

import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

@MultipartConfig
public class ProfileUploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        Part filePart = request.getPart("profilePic");
        String fileName = "user_" + userId + ".jpg";

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE users SET profile_image=? WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fileName);
            ps.setInt(2, userId);
            ps.executeUpdate();

            session.setAttribute("profileImage", fileName);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("dashboard.jsp");
    }
}
