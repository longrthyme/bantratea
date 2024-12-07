/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.FeedbackDAO;
import entity.Feedback;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author HoangPC
 */
public class FeedBackController extends HttpServlet {
   
    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int accountId = Integer.parseInt(request.getParameter("account_id"));
        int order_details_id = Integer.parseInt(request.getParameter("order_details_id"));
        String comment = request.getParameter("feedback");
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        feedbackDAO.saveFeedback(productId, accountId, comment, rating);
        feedbackDAO.updateOrderStatusFeedback(order_details_id);
        request.getRequestDispatcher("orderCompelete").forward(request, response);
    } 

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

   
}
