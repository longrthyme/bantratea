/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.FeedbackDAO;
import dal.ProductDAO;
import entity.Category;
import entity.Feedback;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Pham Toan
 */
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        
        HttpSession session = req.getSession();
       
        List<Category> listCategory = categoryDAO.findAll();
        
        List<Product> listSpecialProduct = productDAO.specialProduct();
        session.setAttribute("listSpecialProduct", listSpecialProduct);
        session.setAttribute("listCategory", listCategory);
        
        
        int productId = Integer.parseInt(req.getParameter("id"));
        List<Feedback> feedbackList = feedbackDAO.getFeedbackList(productId);
        Product product = productDAO.getProductsById(productId);
        session.setAttribute("feedbackList", feedbackList);
        req.setAttribute("product", product);
        
        req.getRequestDispatcher("view/homepage/product-detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    
    

}
