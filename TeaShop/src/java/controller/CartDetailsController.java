/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Service.CalculateDiscount;
import dal.CartDetailsDAO;
import dal.CouponDAO;
import dal.OrderDetailsDAO;
import dal.PointDAO;
import entity.Accounts;
import entity.CartDetails;
import entity.Coupon;
import entity.Product;
import entity.Topping;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author This PC
 */
@WebServlet(name = "CartDetails", urlPatterns = {"/CartDetails"})
public class CartDetailsController extends HttpServlet {

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
        HttpSession session = request.getSession(true);
        CartDetailsDAO cartDetailsDAO = new CartDetailsDAO();

        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            if (service == null || service.isEmpty()) {
                service = "showcart";
            }
            double totalCartAmount = 0;
            if (service.equals("add2cart")) {
                String order_id = request.getParameter("order_id");
                String product_id = request.getParameter("product_id");
                String quantity = request.getParameter("quantity");
                String[] topping_names = request.getParameterValues("topping_names");
                String link_id = request.getParameter("link_id");
                String link = null;

                CartDetails cartItem = (CartDetails) session.getAttribute("cartItem" + product_id);
                if (cartItem == null) {
                    cartItem = new CartDetails();
                    cartItem.product = new Product();
                    cartItem.topping = new ArrayList<>();
                    CartDetails cartInfo = cartDetailsDAO.getInfo(Integer.parseInt(product_id));
                    cartItem.product.setProduct_id(cartInfo.product.getProduct_id());
                    cartItem.product.setProduct_name(cartInfo.product.getProduct_name());
                    cartItem.product.setImage(cartInfo.product.getImage());
                    int price = (int) (cartInfo.product.price - (cartInfo.product.price * (cartInfo.product.discount) / 100));

                    int intQuantity = 1;
                    if (!(quantity == null || quantity.isEmpty())) {
                        intQuantity = Integer.parseInt(quantity);
                    }
                    cartItem.setQuantity(intQuantity);

                    if (topping_names != null) {
                        for (String topping_name : topping_names) {
                            Topping topping = new Topping();
                            topping.setTopping_name(topping_name);
                            cartItem.topping.add(topping);
                        }
                        price += 6000;
                    }
                    cartItem.product.setPrice(price);
                    session.setAttribute("cartItem" + product_id, cartItem);
                }

                switch (link_id) {
                    case "1" ->
                        link = "shop";
                    case "2" ->
                        link = "OrderInformation?order_id=" + order_id;
                    case "3" ->
                        link = "home";
                    case "4" ->
                        link = "product-details?id=" + product_id;
                    default ->
                        link = "login.jsp";
                }
                response.sendRedirect(link);
            }

            if (service.equals("updateQuantity")) {
                String quantity = request.getParameter("quantity");
                int intQuantity = 1;
                if (quantity != null && !quantity.isEmpty()) {
                    try {
                        intQuantity = Integer.parseInt(quantity);
                    } catch (NumberFormatException e) {
                        intQuantity = 1;
                    }
                }
                String product_id = request.getParameter("product_id");
                CartDetails cartItem = (CartDetails) session.getAttribute("cartItem" + product_id);
                if (intQuantity > 0 && intQuantity < 1000) {
                    cartItem.setQuantity(intQuantity);
                } else if (intQuantity >= 1000) {
                    cartItem.setQuantity(999);
                } else {
                    cartItem.setQuantity(1);
                }

                List<CartDetails> cartInfo = new ArrayList<>();
                Enumeration<String> em = session.getAttributeNames();
                while (em.hasMoreElements()) {
                    String key = em.nextElement();

                    if (key.startsWith("cartItem")) {
                        CartDetails cartItems = (CartDetails) session.getAttribute(key);
                        cartInfo.add(cartItems);
                    }
                }
                List<String> toppingList = cartDetailsDAO.getTopping();

                // Calculate total cart amount
                for (CartDetails item : cartInfo) {
                    int price = item.product.getPrice();
                    int quantities = item.getQuantity();
                    totalCartAmount += price * quantities;
                }

                // Prepare JSON response manually
                String jsonResponse = "{";
                jsonResponse += "\"totalPrice\": " + (cartItem.product.getPrice() * cartItem.getQuantity()) + ",";
                jsonResponse += "\"totalCartAmount\": " + totalCartAmount;
                jsonResponse += "}";

                // Return JSON response
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse);
            }
            if (service.equals("updateTopping")) {
                String[] topping_names = request.getParameterValues("topping_names");
                String product_id = request.getParameter("product_id");
                CartDetails cartItem = (CartDetails) session.getAttribute("cartItem" + product_id);
                int price = cartItem.product.price - (6000 * cartItem.topping.size());

                cartItem.topping = new ArrayList<>();
                if (topping_names != null) {
                    for (String topping_name : topping_names) {
                        Topping topping = new Topping();
                        topping.setTopping_id(new OrderDetailsDAO().retrieveToppingIdByName(topping_name));
                        topping.setTopping_name(topping_name);
                        cartItem.topping.add(topping);
                        price += 6000;
                    }
                }
                cartItem.product.setPrice(price);

                // Calculate total cart amount
                List<CartDetails> cartInfo = new ArrayList<>();
                Enumeration<String> em = session.getAttributeNames();
                while (em.hasMoreElements()) {
                    String key = em.nextElement();
                    if (key.startsWith("cartItem")) {
                        CartDetails cartItems = (CartDetails) session.getAttribute(key);
                        cartInfo.add(cartItems);
                    }
                }
                for (CartDetails item : cartInfo) {
                    int itemPrice = item.product.getPrice();
                    int quantities = item.getQuantity();
                    totalCartAmount += itemPrice * quantities;
                }

                // Prepare JSON response manually
                String jsonResponse = "{";
                jsonResponse += "\"totalPrice\": " + (cartItem.product.getPrice() * cartItem.getQuantity()) + ",";
                jsonResponse += "\"totalCartAmount\": " + totalCartAmount + ",";
                jsonResponse += "\"pricePerProduct\": " + cartItem.product.getPrice() + ",";
                jsonResponse += "\"toppingCount\": " + cartItem.topping.size();
                jsonResponse += "}";

                // Return JSON response
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse);
            }
            if (service.equals("delete")) {
                String product_id = request.getParameter("product_id");
                session.removeAttribute("cartItem" + product_id);
                response.sendRedirect("CartDetails?service=showcart");
            }
            if (service.equals("showcart")) {
                // Show cart details
                PointDAO pointDAO = new PointDAO();
                Accounts acc = (Accounts) session.getAttribute("acc");
                if (acc != null) {
                    int points = pointDAO.getUserPoints(acc.getAccount_id());
                    request.setAttribute("points", points);
                }
                // Retrieve cart information and topping list
                List<CartDetails> cartInfo = new ArrayList<>();
                Enumeration<String> em = session.getAttributeNames();
                while (em.hasMoreElements()) {
                    String key = em.nextElement();

                    if (key.startsWith("cartItem")) {
                        CartDetails cartItem = (CartDetails) session.getAttribute(key);
                        cartInfo.add(cartItem);
                    }
                }
                List<String> toppingList = cartDetailsDAO.getTopping();

                // Calculate total cart amount
                for (CartDetails item : cartInfo) {
                    int price = item.product.getPrice();
                    int quantity = item.getQuantity();
                    totalCartAmount += price * quantity;
                }
                System.out.println("TotalCartShowCart: " + totalCartAmount);
                // Set attributes for access in the JSP page
                request.setAttribute("totalCartAmount", totalCartAmount);
                request.setAttribute("toppingList", toppingList);
                request.setAttribute("cartInfo", cartInfo);

                // Forward the request to the "cart-details.jsp" page for rendering
                request.getRequestDispatcher("view/cart/cart-details.jsp").forward(request, response);
            }
            if (service.equals("ApplyCoupon")) {
                PointDAO pointDAO = new PointDAO();
                Accounts acc = (Accounts) session.getAttribute("acc");
                if (acc != null) {
                    int points = pointDAO.getUserPoints(acc.getAccount_id());
                    request.setAttribute("points", points);
                }
                List<String> toppingList = cartDetailsDAO.getTopping();
                String couponMessage = null;
                CouponDAO couponDAO = new CouponDAO();
                String couponCode = request.getParameter("coupon");
                List<CartDetails> cartInfo = new ArrayList<>();

                // Lấy thông tin giỏ hàng từ session
                Enumeration<String> em = session.getAttributeNames();
                while (em.hasMoreElements()) {
                    String key = em.nextElement();
                    if (key.startsWith("cartItem")) {
                        CartDetails cartItem = (CartDetails) session.getAttribute(key);
                        cartInfo.add(cartItem);
                    }
                }

                CalculateDiscount calculateDiscount = new CalculateDiscount();
                Coupon couponDetails = couponDAO.getCouponDetails(couponCode);
                if (couponCode == null || couponCode.isEmpty()) {
                    totalCartAmount = calculateDiscount.calculateTotalCartAmount(cartInfo);
                } else {
                    totalCartAmount = calculateDiscount.processDiscount(couponDetails, couponCode, cartInfo);
                    session.setAttribute("couponCodeAppied", couponCode);
                    List<String> errors = calculateDiscount.getErrorMessages();
                    if (!errors.isEmpty()) {
                        couponMessage = String.join(", ", errors);
                    } else {
                        couponMessage = "Mã giảm giá đã được áp dụng";
                    }
                }

                System.out.println("TotalCartApplyCoupon: " + totalCartAmount);
                session.setAttribute("totalCartAmountWithCoupon", totalCartAmount);

                request.setAttribute("cartInfo", cartInfo);
                request.setAttribute("totalCartAmount", totalCartAmount);
                request.setAttribute("couponMessage", couponMessage);
                request.setAttribute("toppingList", toppingList);
                request.getRequestDispatcher("view/cart/cart-details.jsp").forward(request, response);
            }

            if (service.equals("selectpayment")) {
                // Show cart details
                String note = request.getParameter("note");
                session.setAttribute("note", note);

                Double totalCart = (Double) session.getAttribute("totalCartAmountWithCoupon");
                if (totalCart == null) {
                    totalCart = 0.0;
                }
                System.out.println("TotalCartabcabc: " + totalCart);
                // Retrieve cart information
                List<CartDetails> cartInfo = new ArrayList<>();
                Enumeration<String> em = session.getAttributeNames();
                while (em.hasMoreElements()) {
                    String key = em.nextElement();
                    if (key.startsWith("cartItem")) {
                        CartDetails cartItem = (CartDetails) session.getAttribute(key);
                        cartInfo.add(cartItem);
                    }
                }

                // Set attributes for access in the JSP page
                request.setAttribute("totalCartAmount", totalCart);
                request.setAttribute("cartInfo", cartInfo);

                // Forward the request to the "select-payment.jsp" page for rendering
                request.getRequestDispatcher("view/cart/select-payment.jsp").forward(request, response);
            }

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
        processRequest(request, response);
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
        processRequest(request, response);
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
