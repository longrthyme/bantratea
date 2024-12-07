/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.OrderDetailsDAO;
import dal.OrdersDAO;
import entity.Accounts;
import entity.OrderDetails;
import entity.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author HoangPC
 */
public class OrderCompeleteController extends HttpServlet {
   
    

    
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

        HttpSession session = request.getSession();

        // Truy xuất attribute "account" từ session
        Accounts account = (Accounts) session.getAttribute("acc");

        // Kiểm tra nếu account không tồn tại hoặc null
        if (account == null) {
            request.getRequestDispatcher("shop").forward(request, response);
        } else {
            String statusFeedbackParam = request.getParameter("statusFeedback");
            int statusFeedback = (statusFeedbackParam != null) ? Integer.parseInt(statusFeedbackParam) : 1; // Default to "1" (Đã đánh giá)

            List<OrderDetails> orderDetailsList = orderDetailsDAO.getOrderDetailByAccountIDAndStatusFeedbackID(account.getAccount_id(), statusFeedback);
            request.setAttribute("statusFeedback", statusFeedback);
            session.setAttribute("orderDetailsList", orderDetailsList);
            request.getRequestDispatcher("view/orders/order-compelete.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

    
}
