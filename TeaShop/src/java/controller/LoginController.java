/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import entity.Accounts;
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
public class LoginController extends HttpServlet {

    private static final String LOGIN_JSP = "login.jsp";
    private static final String FAILED_ATTEMPTS = "failedAttempts";

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        request.getRequestDispatcher(LOGIN_JSP).forward(request, response);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        password = EncodePassword.toSHA1(password);

        HttpSession session = request.getSession();
        Integer failedAttempts = (Integer) session.getAttribute(FAILED_ATTEMPTS);
        if (failedAttempts == null) {
            failedAttempts = 0;
        }
        // xu ly yeu cau
        AccountDAO dao = new AccountDAO();
        Accounts a = dao.login(email, password);
        if (a == null) {
            failedAttempts++;
            session.setAttribute(FAILED_ATTEMPTS, failedAttempts);
            if (failedAttempts >= 1) {
                request.setAttribute("showForgotPassword", true);
            }
            request.setAttribute("email", email);
            request.setAttribute("mess", "Email hoac mat khau cua ban khong dung");
            request.getRequestDispatcher(LOGIN_JSP).forward(request, response);

        } else {
            if (a.getStatus_id() == 2) {
                request.setAttribute("mess", "Tai khoan cua ban da bi khoa");
                request.getRequestDispatcher(LOGIN_JSP).forward(request, response);
            } else {
                session.setAttribute(FAILED_ATTEMPTS, 0);
                session.setAttribute("acc", a);
                int accountId = dao.getAccountIdByEmail(email);
                session.setAttribute("accountId", accountId);
                int roleId = a.getRole_id();
                switch (roleId) {
                    case 1:
                        response.sendRedirect("chartorderday");
                        break;
                    case 3:
                        response.sendRedirect("customerManagement");
                        break;
                    case 2:
                        response.sendRedirect("home");
                        break;
                    case 4:
                        request.getRequestDispatcher("ship").forward(request, response);
                        break;
                    default:
                        break;
                }
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
