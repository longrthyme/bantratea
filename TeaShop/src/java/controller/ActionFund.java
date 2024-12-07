/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HisFundDAO;
import entity.Accounts;
import entity.HistoryFund;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ActionFund", urlPatterns = {"/actionFund"})
public class ActionFund extends HttpServlet {

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
            out.println("<title>Servlet ListHisFund</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListHisFund at " + request.getContextPath() + "</h1>");
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
        HisFundDAO hisfund = new HisFundDAO();

        String addToFundStr = request.getParameter("addToFund");
        String subtractFundStr = request.getParameter("subtractFund");
        String content = request.getParameter("content");
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

        HttpSession session = request.getSession();
        Accounts account = (Accounts) session.getAttribute("acc");
int subtractFund = 0;
        int addToFund = 0;
        
// Xử lý subtractFund
if (subtractFundStr != null && !subtractFundStr.isEmpty()) {
    subtractFund = parseAmount(subtractFundStr);
}

        if (addToFundStr != null && !addToFundStr.isEmpty()) {
    addToFund = parseAmount(addToFundStr);
}


hisfund.insertHistory(92, currentTimestamp, addToFund, subtractFund, content);
 response.sendRedirect("fund");}

// Phương thức xử lý chuỗi đầu vào và chuyển đổi thành số nguyên
private int parseAmount(String amountStr) {
    String sanitizedAmountStr = amountStr.replaceAll("[^0-9]", "");
    try {
        return Integer.parseInt(sanitizedAmountStr);
    } catch (NumberFormatException e) {
        return 0;
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
