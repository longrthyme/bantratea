/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CouponDAO;
import entity.Coupon;
import entity.DiscountType;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Huyen Tranq
 */
@WebServlet(name = "CouponManagement", urlPatterns = {"/CouponManagement"})
public class CouponManagement extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            CouponDAO couponDAO = new CouponDAO();
            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            if (service == null) {
                service = "ShowCoupon";
            }
            switch (service) {
                case "ShowCoupon": {
                    List<Coupon> coupons = couponDAO.getAllCoupons();
                    request.setAttribute("coupons", coupons);
                    request.getRequestDispatcher("./view/dashboard/staff1/CouponManagement.jsp").forward(request, response);
                }
                break;
                case "EditCoupon": {
                    String button = request.getParameter("singlebutton");
                    String message = null;
                    if (button == null) {
                        String couponCode = request.getParameter("couponCode");
                        Coupon couponDetail = couponDAO.getCouponDetails(couponCode);
                        List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                        request.setAttribute("couponDetail", couponDetail);
                        request.setAttribute("discountsType", discountsType);
                    } else {
                        String couponCode = request.getParameter("couponCode");
                        String description = request.getParameter("description");
                        String discountType = request.getParameter("discountType");
                        String validFromString = request.getParameter("validFrom");
                        String validUntilString = request.getParameter("validUntil");
                        String status = request.getParameter("status");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Adjust the date format as needed
                        Date validFrom = null;
                        Date validUntil = null;
                        try {
                            validFrom = dateFormat.parse(validFromString);
                            validUntil = dateFormat.parse(validUntilString);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        Coupon coupon = new Coupon();
                        coupon.setCouponCode(couponCode);
                        coupon.setDiscountType(Integer.valueOf(discountType));
                        coupon.setDescription(description);
                        coupon.setValidFrom(validFrom);
                        coupon.setValidUltil(validUntil);
                        coupon.setCouponStatus(status);
                        int check = couponDAO.updateCoupon(coupon);
                        if (check > 0) {
                            message = "Update thành công";
                            session.setAttribute("message", message);
                            response.sendRedirect("CouponManagement?service=EditCoupon&couponCode=" + couponCode);
                            return;
                        }
                    }
                    request.getRequestDispatcher("./view/dashboard/staff1/EditCoupon.jsp").forward(request, response);
                }
                break;
                case "AddCoupon": {
                    String button = request.getParameter("singlebutton");
                    String message = null;
                    if (button == null) {
                        List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                        request.setAttribute("discountsType", discountsType);
                    } else {
                        String couponCode = request.getParameter("couponCode");
                        String description = request.getParameter("description");
                        String discountType = request.getParameter("discountType");
                        String validFromString = request.getParameter("validFrom");
                        String validUntilString = request.getParameter("validUntil");
                        String status = request.getParameter("status");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Adjust the date format as needed
                        Date validFrom = null;
                        Date validUntil = null;
                        try {
                            validFrom = dateFormat.parse(validFromString);
                            validUntil = dateFormat.parse(validUntilString);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        Coupon coupon = new Coupon();
                        coupon.setCouponCode(couponCode);
                        coupon.setDiscountType(Integer.valueOf(discountType));
                        coupon.setDescription(description);
                        coupon.setValidFrom(validFrom);
                        coupon.setValidUltil(validUntil);
                        coupon.setCouponStatus(status);
                        int check = couponDAO.addCoupon(coupon);
                        if (check > 0) {
                            message = "Add thành công";
                            session.setAttribute("messageAdd", message);
                            response.sendRedirect("CouponManagement?service=ShowCoupon");
                            return;
                        }
                    }
                    request.getRequestDispatcher("./view/dashboard/staff1/AddCoupon.jsp").forward(request, response);
                }
                break;
                case "DeleteCoupon": {
                    String message = null;
                    String couponCode = request.getParameter("couponCode");
                    couponDAO.deleteRedeemedCoupon(couponCode);
                    int check = couponDAO.deleteCoupon(couponCode);
                    if (check > 0) {
                        message = "Xóa thành công";
                        session.setAttribute("messageDelete", message);
                        response.sendRedirect("CouponManagement?service=ShowCoupon");
                        return;
                    }
                }
                break;
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
            Logger.getLogger(CouponManagement.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CouponManagement.class.getName()).log(Level.SEVERE, null, ex);
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
