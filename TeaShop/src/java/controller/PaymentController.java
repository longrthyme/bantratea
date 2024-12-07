/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import entity.Accounts;
import entity.CartDetails;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.Date;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author This PC
 */
@WebServlet(name = "Payment", urlPatterns = {"/Payment"})
public class PaymentController extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        boolean itemexist = false;
        List<CartDetails> cartInfo = new ArrayList<>();
        Enumeration<String> em = session.getAttributeNames();
        while (em.hasMoreElements()) {
            String key = em.nextElement();
            
            if (key.startsWith("cartItem")) {
                CartDetails cartItem = (CartDetails) session.getAttribute(key);
                cartInfo.add(cartItem);
                itemexist = true;
            }
        }
        
        if (!itemexist) {
            response.sendRedirect("CartDetails");
            return;
        }
        
        int totalCartAmount = 0;
        for (CartDetails item : cartInfo) {
            int price = item.product.getPrice();
            int quantity = item.getQuantity();
            totalCartAmount += price * quantity;
        }
        
        String service = request.getParameter("service");
        if (service.equals("pay-online")) {
            Accounts acc = (Accounts) session.getAttribute("acc");
            if (acc != null) {
                String phone_number = acc.getPhone_number();
                String fullname = acc.getFull_name();
                session.setAttribute("phone_number", phone_number);
                session.setAttribute("fullname", fullname);
            }
            request.setAttribute("totalCartAmount", totalCartAmount);
            request.getRequestDispatcher("view/cart/pay-via-online.jsp").forward(request, response);
        }
        if (service.equals("pay-on-delivery")) {
            Accounts acc = (Accounts) session.getAttribute("acc");
            if (acc != null) {
                String phone_number = acc.getPhone_number();
                String fullname = acc.getFull_name();
                session.setAttribute("phone_number", phone_number);
                session.setAttribute("fullname", fullname);
            }
            request.setAttribute("totalCartAmount", totalCartAmount);
            request.getRequestDispatcher("view/cart/pay-on-delivery.jsp").forward(request, response);
        }
        if (service.equals("COD")) {
            session.setAttribute("payment-flag", "on");
            String amount = String.valueOf(totalCartAmount);
            String fullname = request.getParameter("fullname");
            String address = request.getParameter("address");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String phone_number = request.getParameter("phone_number");
            request.setAttribute("amount", amount);
            request.setAttribute("fullname", fullname);
            request.setAttribute("address", address);
            request.setAttribute("district", district);
            request.setAttribute("ward", ward);
            request.setAttribute("phone_number", phone_number);
            request.getRequestDispatcher("view/cart/process-payment.jsp").forward(request, response);
        }
        if (service.equals("VNPay")) {
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String vnp_OrderInfo = "Thanh toan hoa don Dream Coffee. So tien: " + totalCartAmount + " dong";
            String orderType = "other";
            String vnp_TxnRef = Config.getRandomNumber(8);
            String vnp_IpAddr = Config.getIpAddress(request);
            String vnp_TmnCode = Config.vnp_TmnCode;
            
            String address = request.getParameter("address");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String phonenumber = request.getParameter("phone_number");
            
            session.setAttribute("address", address);
            session.setAttribute("district", district);
            session.setAttribute("ward", ward);
            session.setAttribute("phone_number", phonenumber);
            
            int amount = totalCartAmount * 100;
            Map vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");
            String bank_code = request.getParameter("bankcode");
            if (bank_code != null && !bank_code.isEmpty()) {
                vnp_Params.put("vnp_BankCode", bank_code);
            }
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.put("vnp_OrderType", orderType);
            
            String locate = request.getParameter("language");
            if (locate != null && !locate.isEmpty()) {
                vnp_Params.put("vnp_Locale", locate);
            } else {
                vnp_Params.put("vnp_Locale", "vn");
            }
            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            //Add Params of 2.1.0 Version
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
            //Billing
            vnp_Params.put("vnp_Bill_Mobile", request.getParameter("txt_billing_mobile"));
            vnp_Params.put("vnp_Bill_Email", request.getParameter("txt_billing_email"));
            String fullName = request.getParameter("fullname");
            if (fullName != null && !fullName.isEmpty()) {
                fullName.trim();
                int idx = fullName.indexOf(' ');
                String firstName = fullName.substring(0, idx);
                String lastName = fullName.substring(fullName.lastIndexOf(' ') + 1);
                vnp_Params.put("vnp_Bill_FirstName", firstName);
                vnp_Params.put("vnp_Bill_LastName", lastName);
                session.setAttribute("fullname", fullName);
            }
            vnp_Params.put("vnp_Bill_Address", request.getParameter("txt_inv_addr1"));
            vnp_Params.put("vnp_Bill_City", request.getParameter("txt_bill_city"));
            vnp_Params.put("vnp_Bill_Country", request.getParameter("txt_bill_country"));
            if (request.getParameter("txt_bill_state") != null && !request.getParameter("txt_bill_state").isEmpty()) {
                vnp_Params.put("vnp_Bill_State", request.getParameter("txt_bill_state"));
            }
            // Invoice
            vnp_Params.put("vnp_Inv_Phone", request.getParameter("txt_inv_mobile"));
            vnp_Params.put("vnp_Inv_Email", request.getParameter("txt_inv_email"));
            vnp_Params.put("vnp_Inv_Customer", request.getParameter("txt_inv_customer"));
            vnp_Params.put("vnp_Inv_Address", request.getParameter("txt_inv_addr1"));
            vnp_Params.put("vnp_Inv_Company", request.getParameter("txt_inv_company"));
            vnp_Params.put("vnp_Inv_Taxcode", request.getParameter("txt_inv_taxcode"));
            vnp_Params.put("vnp_Inv_Type", request.getParameter("cbo_inv_type"));
            //Build data to hash and querystring
            List fieldNames = new ArrayList(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = (String) itr.next();
                String fieldValue = (String) vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    //Build hash data
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    //Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            String queryUrl = query.toString();
            String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
            com.google.gson.JsonObject job = new JsonObject();
            job.addProperty("code", "00");
            job.addProperty("message", "success");
            job.addProperty("data", paymentUrl);
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(job));
            response.sendRedirect(paymentUrl);
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
