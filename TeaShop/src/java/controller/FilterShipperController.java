/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AdminDAO;
import entity.AccountStatus;
import entity.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Huyen Tranq
 */
@WebServlet(name = "FilterShipperController", urlPatterns = {"/filtershipper"})
public class FilterShipperController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
            if (!AuthorizationController.isAdmin((Accounts) session.getAttribute("acc"))) {
                AuthorizationController.redirectToHome(session, response);
            } else {
                AdminDAO dao = new AdminDAO();
            //Lấy thông tin gender, status
            List<AccountStatus> listas = dao.getAllStatus();
            request.setAttribute("listas", listas);

            String status = request.getParameter("status");
            String gender = request.getParameter("gender");

            request.setAttribute("status", status);
            request.setAttribute("gender", gender);

            if (gender == null || gender.equals("Gender")) {
                gender = "";
            }
            if (status == null || status.equals("Status")) {
                status = "";
            }

            // Xử lý lọc dựa trên gender và status
            if (gender.isEmpty() && status.isEmpty()) {
                response.sendRedirect("shippermanager");
            } else if (!gender.isEmpty() && status.isEmpty()) {
                List<Accounts> listByGender = gender.equals("Male") ? dao.getAllAccountMaleShipper() : dao.getAllAccountFemaleShipper();
                if (listByGender.isEmpty()) {
                    request.setAttribute("error", "Không tìm thấy kết quả");
                } else {
                    request.setAttribute("listShipper", listByGender);
                }
                request.getRequestDispatcher("./view/dashboard/admin/shipperManagement.jsp").forward(request, response);
            } else if (gender.isEmpty() && !status.isEmpty()) {
                List<Accounts> listByStatus = status.equals("1") ? dao.getAccountsActiveShipper() : dao.getAccountsInActiveShipper();
                if (listByStatus.isEmpty()) {
                    request.setAttribute("error", "Không tìm thấy kết quả");
                } else {
                    request.setAttribute("listShipper", listByStatus);
                }
                request.setAttribute("status", status);
                request.getRequestDispatcher("./view/dashboard/admin/shipperManagement.jsp").forward(request, response);
            } else {
                int status_id = Integer.parseInt(status);
                List<Accounts> listByGenderAndStatus = dao.getAccountByGenderAndStatusShipper(gender, status_id);
                if (listByGenderAndStatus.isEmpty()) {
                    request.setAttribute("error", "Không tìm thấy kết quả");
                } else {
                    request.setAttribute("listShipper", listByGenderAndStatus);
                }
                request.setAttribute("status", status_id);
                request.getRequestDispatcher("./view/dashboard/admin/shipperManagement.jsp").forward(request, response);
            }
    }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
