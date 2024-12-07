/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import entity.Accounts;
import entity.Email;
import entity.EncodePassword;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Huyen Tranq
 */
public class ResetPasswordController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String emailc = request.getParameter("emailc");
        AccountDAO dao = new AccountDAO();
        Accounts a = dao.checkAccountExist(emailc);
        HttpSession session = request.getSession();
        if (a != null) {

            Email e = new Email();
            long expirationTimeMillis = System.currentTimeMillis() + (1 * 60 * 1000);
            String verifyLink = "http://localhost:8080/TeaShop/newresetpass?expires=" + expirationTimeMillis; // Thay đổi URL theo link xác nhận của bạn

            String emailContent = "<!DOCTYPE html>\n"
                    + "<html>\n"
                    + "<head>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "<p>Hãy nhấn vào link dưới đây để reset mật khẩu của bạn nhé!</p>\n"
                    + "<a href=\"" + verifyLink + "\">Reset Password</a>\n"
                    + "\n"
                    + "</body>\n"
                    + "</html>";

            e.sendEmail(emailc, "Reset Passworf", emailContent);
            request.setAttribute("Notification", "Ban can xac minh tai khoan!");
            session.setAttribute("emailReset", emailc);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Email khong ton tai");
            request.getRequestDispatcher("resetpass.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String newpass = request.getParameter("newpass");
        String re_newpass = request.getParameter("re_newpass");
        String emailc = (String) session.getAttribute("emailReset"); // Retrieve email from request
        System.out.println(newpass);
        System.out.println(re_newpass);
        System.out.println(emailc);

      if (newpass == null || newpass.trim().isEmpty()) {
            request.setAttribute("error", "Mat khau khong duoc de trang");
            request.getRequestDispatcher("newpass.jsp").forward(request, response);
        }else if (newpass == null || newpass.trim().isEmpty() || newpass.length() < 8 || newpass.length() > 32) {
            request.setAttribute("error", "Mat khau phai chua 8-32 ky tu");
             request.getRequestDispatcher("newpass.jsp").forward(request, response);
        }
        if (!newpass.equals(re_newpass)) {
            request.setAttribute("error", "Mat khau va mat khau nhap lai phai giong nhau");
            request.getRequestDispatcher("newpass.jsp").forward(request, response);
        } else {
            // Mã hóa mật khẩu mới trước khi lưu vào database
            String encodedNewPass = EncodePassword.toSHA1(newpass);
            AccountDAO dao = new AccountDAO();
            boolean isUpdated = dao.changePass(emailc, encodedNewPass);
            if (isUpdated) {
                request.setAttribute("Notification", "Reset mat khau thanh cong");
                session.removeAttribute("emailReset");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Reset mat khau that bai, hay thu lai");
                request.getRequestDispatcher("newpass.jsp").forward(request, response);
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
