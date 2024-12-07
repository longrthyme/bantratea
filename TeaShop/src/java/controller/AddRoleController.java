/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AdminDAO;
import entity.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.regex.Pattern;

/**
 *
 * @author Huyen Tranq
 */
public class AddRoleController extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddRoleController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRoleController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/dashboard/admin/AddRole.jsp").forward(request, response);
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
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            if (!AuthorizationController.isAdmin((Accounts) session.getAttribute("acc"))) {
                AuthorizationController.redirectToHome(session, response);
            } else {
                //validation
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                String errorMessage = null;

                if (name == null || name.trim().isEmpty()) {
                    errorMessage = "Tên Role không được để trống hoặc chỉ có khoảng trắng";
                } else if (name.matches("\\d+")) {
                    errorMessage = "Tên Role không được chỉ chứa các số";
                } else {
                    try {
                        int roleId = Integer.parseInt(id);
                        // kiểm tra roleId phải là số nguyên dương
                        if (roleId <= 0) {
                            errorMessage = "ID Role phải là số nguyên dương";
                        } else {
                            AdminDAO dao = new AdminDAO();
                            if (dao.isRoleIdExists(roleId)) {
                                errorMessage = "ID Role đã tồn tại";
                            }
                        }
                    } catch (NumberFormatException e) {
                        errorMessage = "ID Role phải là số hợp lệ";
                    }
                }
                if (errorMessage != null) {
                    request.setAttribute("errorMessage", errorMessage);
                    request.setAttribute("id", id);
                    request.setAttribute("name", name);
                    request.getRequestDispatcher("view/dashboard/admin/AddRole.jsp").forward(request, response);
                    return;
                } else {
                    AdminDAO dao = new AdminDAO();
                    int roleId = Integer.parseInt(id);
                    System.out.println(name);
                    System.out.println(id);
                    dao.addRole(roleId, name);
                    response.sendRedirect("rolemanager");

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
