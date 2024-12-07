package controller;

import dal.CouponDAO;
import dal.OrderDetailsDAO;
import dal.OrdersDAO;
import dal.PointDAO;
import entity.CartDetails;
import entity.Topping;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author This PC
 */
@WebServlet(name = "PaymentResult", urlPatterns = {"/PaymentResult"})
public class PaymentResultController extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(true);
            OrdersDAO orderDAO = new OrdersDAO();
            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
            PointDAO pointDAO = new PointDAO();
            boolean itemexist = false;
            Enumeration<String> check = session.getAttributeNames();
            while (check.hasMoreElements()) {
                String key = check.nextElement();

                if (key.startsWith("cartItem")) {
                    itemexist = true;
                    break;
                }
            }

            int order_id = 0;
            String service = request.getParameter("service");
            Integer accoundId = (Integer) session.getAttribute("accountId");
            if (service == null || service.isEmpty()) {
                service = "pay-online";
            }
            if (service.equals("cash-on-delivery")) {

                String amount = request.getParameter("amount");
                String fullname = request.getParameter("fullname");
                String address = request.getParameter("address");
                String district = request.getParameter("district");
                String ward = request.getParameter("ward");
                String phonenumber = request.getParameter("phone_number");
                String status = "Giao dịch thành công";
                String OrderInfo = "Thanh toan hoa don Dream Coffee. So tien: " + amount + " dong";

                String fullAddress = address + ", Phường " + ward + ", " + district;
                session.setAttribute("fullAddress", fullAddress);
                String note = (String) session.getAttribute("note");
                List<CartDetails> billInfo = new ArrayList<>();

                if (session.getAttribute("payment-flag") != null && itemexist == true) {
                    String sqlDateTime = "";

                    Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));

                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                    String vnp_CreateDate = formatter.format(cld.getTime());
                    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                    SimpleDateFormat sqlformatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                    Date date;
                    try {
                        date = inputFormat.parse(vnp_CreateDate);
                        String formattedDate = dateFormat.format(date);
                        String formattedTime = timeFormat.format(date);
                        sqlDateTime = sqlformatter.format(date);
                        session.setAttribute("formattedDate", formattedDate);
                        session.setAttribute("formattedTime", formattedTime);
                    } catch (ParseException ex) {
                        Logger.getLogger(PaymentController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    if (accoundId == null) {
                        order_id = orderDAO.insertOrder(null, sqlDateTime, null, Integer.parseInt(amount), 1, note, "COD", phonenumber, fullname, fullAddress, null);
                    } else {
                        order_id = orderDAO.insertOrder(accoundId, sqlDateTime, null, Integer.parseInt(amount), 1, note, "COD", phonenumber, fullname, fullAddress, null);
                    }
                    Enumeration<String> bill = session.getAttributeNames();
                    while (bill.hasMoreElements()) {
                        String key = bill.nextElement();

                        if (key.startsWith("billItem")) {
                            session.removeAttribute(key);
                        }
                    }
                    Enumeration<String> em = session.getAttributeNames();
                    while (em.hasMoreElements()) {
                        String key = em.nextElement();

                        if (key.startsWith("cartItem")) {
                            CartDetails cartItem = (CartDetails) session.getAttribute(key);

                            int product_id = cartItem.product.product_id;
                            int order_details_id = orderDetailsDAO.insertOrderDetails(product_id, order_id, cartItem.quantity);
                            List<Topping> toppings = cartItem.topping;
                            for (Topping topping : toppings) {
                                int toppingId = topping.topping_id;
                                orderDetailsDAO.insertToppingDetails(order_details_id, toppingId);
                            }
                            session.setAttribute("billItem" + product_id, cartItem);

                            session.removeAttribute(key);
                        }
                    }
                    session.removeAttribute("payment-flag");
                }

                Enumeration<String> em = session.getAttributeNames();
                while (em.hasMoreElements()) {
                    String key = em.nextElement();

                    if (key.startsWith("billItem")) {
                        CartDetails billItem = (CartDetails) session.getAttribute(key);
                        billInfo.add(billItem);
                    }
                }
                request.setAttribute("billInfo", billInfo);
                request.setAttribute("amount", amount);
                request.setAttribute("status", status);
                request.setAttribute("OrderInfo", OrderInfo);
                session.setAttribute("fullname", fullname);
                session.setAttribute("address", address);
                session.setAttribute("district", district);
                session.setAttribute("ward", ward);
                session.setAttribute("phone_number", phonenumber);

                request.getRequestDispatcher("view/cart/payment-result.jsp").forward(request, response);
            } else if (service.equals("pay-online")) {
                String sqlDateTime = "";
                String address = (String) session.getAttribute("address");
                String district = (String) session.getAttribute("district");
                String ward = (String) session.getAttribute("ward");
                String fullAddress = address + ", Phường " + ward + ", " + district;
                session.setAttribute("fullAddress", fullAddress);
                String fullname = (String) session.getAttribute("fullname");
                String phonenumber = (String) session.getAttribute("phone_number");
                String note = (String) session.getAttribute("note");
                Map fields = new HashMap();
                for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                    String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                    String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                    if ((fieldValue != null) && (fieldValue.length() > 0)) {
                        fields.put(fieldName, fieldValue);
                    }
                }

                String vnp_SecureHash = request.getParameter("vnp_SecureHash");
                if (fields.containsKey("vnp_SecureHashType")) {
                    fields.remove("vnp_SecureHashType");
                }
                if (fields.containsKey("vnp_SecureHash")) {
                    fields.remove("vnp_SecureHash");
                }
                String signValue = Config.hashAllFields(fields);

                int amount = Integer.parseInt(request.getParameter("vnp_Amount")) / 100;
                request.setAttribute("amount", amount);

                String OrderInfo = request.getParameter("vnp_OrderInfo");
                request.setAttribute("OrderInfo", OrderInfo);

                String status;
                if (signValue.equals(vnp_SecureHash)) {
                    if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                        status = "Giao dịch thành công";
                        List<CartDetails> billInfo = new ArrayList<>();
                        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
                        boolean flag = orderDAO.checkDuplicatevnp_TxnRef(vnp_TxnRef);
                        if (!flag) {
                            String vnp_PayDate = request.getParameter("vnp_PayDate");
                            try {

                                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                                SimpleDateFormat sqlformatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                Date date = inputFormat.parse(vnp_PayDate);
                                sqlDateTime = sqlformatter.format(date);
                                String formattedDate = dateFormat.format(date);
                                String formattedTime = timeFormat.format(date);

                                session.setAttribute("formattedDate", formattedDate);
                                session.setAttribute("formattedTime", formattedTime);
                            } catch (ParseException e) {
                                e.printStackTrace();
                            }
                            if (accoundId == null) {
                                order_id = orderDAO.insertOrder(null, sqlDateTime, null, amount, 1, note, "VNPay", phonenumber, fullname, fullAddress, vnp_TxnRef);
                            } else {
                                order_id = orderDAO.insertOrder(accoundId, sqlDateTime, null, amount, 1, note, "VNPay", phonenumber, fullname, fullAddress, vnp_TxnRef);
                                if (amount >= 100) {
                                    String couponApplied = (String) session.getAttribute("couponCodeApplied");
                                    System.out.println("Code Applied: " + couponApplied);
                                    if (pointDAO.getUserPoints(accoundId) == 0) {
                                        pointDAO.addPointsForUser(accoundId);
                                        pointDAO.BonusPointsAfterBuy(accoundId);
                                    } else {
                                        pointDAO.BonusPointsAfterBuy(accoundId);
                                    }
                                }
                            }
                            Enumeration<String> bill = session.getAttributeNames();
                            while (bill.hasMoreElements()) {
                                String key = bill.nextElement();

                                if (key.startsWith("billItem")) {
                                    session.removeAttribute(key);
                                }
                            }
                            Enumeration<String> em = session.getAttributeNames();
                            while (em.hasMoreElements()) {
                                String key = em.nextElement();

                                if (key.startsWith("cartItem")) {
                                    CartDetails cartItem = (CartDetails) session.getAttribute(key);

                                    int product_id = cartItem.product.product_id;
                                    int order_details_id = orderDetailsDAO.insertOrderDetails(product_id, order_id, cartItem.quantity);
                                    List<Topping> toppings = cartItem.topping;
                                    for (Topping topping : toppings) {
                                        int toppingId = topping.topping_id;
                                        orderDetailsDAO.insertToppingDetails(order_details_id, toppingId);
                                    }
                                    session.setAttribute("billItem" + product_id, cartItem);
                                    session.removeAttribute(key);
                                }
                            }
                        }
                        Enumeration<String> em = session.getAttributeNames();
                        while (em.hasMoreElements()) {
                            String key = em.nextElement();

                            if (key.startsWith("billItem")) {
                                CartDetails billItem = (CartDetails) session.getAttribute(key);
                                billInfo.add(billItem);
                            }
                        }
                        request.setAttribute("billInfo", billInfo);
                    } else {
                        status = "Giao dịch thất bại";
                    }

                } else {
                    status = "Giao dịch thất bại";
                }
                request.setAttribute("status", status);
                request.getRequestDispatcher("view/cart/payment-result.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(PaymentResultController.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(PaymentResultController.class.getName()).log(Level.SEVERE, null, ex);
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
