/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDetailsDAO;
import dal.OrdersDAO;
import dal.ProductDAO;
import dal.StatusDAO;
import entity.Accounts;
import entity.OrderDetails;
import entity.Orders;
import entity.PageControl;
import entity.Status;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author HoangPC
 */
public class ShippingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        StatusDAO statusDAO = new StatusDAO();
        PageControl pageControl = new PageControl();

        String statusOrderParam = request.getParameter("statusOrder");
        int statusOrder = (statusOrderParam != null) ? Integer.parseInt(statusOrderParam) : 3;

        List<Orders> listOrders = findOrdersDoGet(request, pageControl);
        List<Status> listStatus = statusDAO.statusShipper();
        HttpSession session = request.getSession();
        request.setAttribute("statusOrder", statusOrder);
        request.setAttribute("pageControl", pageControl);
        session.setAttribute("listOrders", listOrders);
        session.setAttribute("listStatus", listStatus);
        request.getRequestDispatcher("view/dashboard/shipper/order-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrdersDAO orderDAO = new OrdersDAO();
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        ProductDAO productDAO = new ProductDAO();

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));

            // Kiểm tra xem trạng thái là "Hoàn thành" (giả sử statusId = 4 là "Hoàn thành")
            if (statusId == 4) {
                List<OrderDetails> listOrderDetails = orderDetailsDAO.findByOrderId(orderId);
                boolean imageMissing = false;
                for (OrderDetails od : listOrderDetails) {
                    if (od.getImage_after_ship() == null || od.getImage_after_ship().isEmpty()) {
                        imageMissing = true;
                        break;
                    }
                }
                if (imageMissing) {
                    // Nếu không có ảnh sau khi giao hàng, hiển thị thông báo lỗi
                    request.setAttribute("errorMessage", "Vui lòng tải lên ảnh sau khi giao hàng trước khi hoàn thành đơn hàng #" + orderId);
                    doGet(request, response); // Hiển thị lại danh sách đơn hàng với thông báo lỗi
                    return;
                }
            } else if (statusId == 5) { // Giả sử 5 là id của trạng thái "Đơn hàng bị hủy"
                Orders order = orderDAO.findByOrderId(orderId);
                if (order.getShipper_note() == null || order.getShipper_note().isEmpty()) {
                    request.setAttribute("errorMessage", "Vui lòng thêm ghi chú cho đơn hàng #"+ orderId +" trước khi hủy.");
                    doGet(request, response); // Hiển thị lại danh sách đơn hàng với thông báo lỗi
                    return;
                }
            }

            // Cập nhật trạng thái và thời gian giao hàng của shipper
            orderDAO.updateOrderStatus(orderId, statusId);
            if (statusId == 4) { // Nếu trạng thái là "Hoàn thành"
                Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                List<OrderDetails> listOrderDetails = orderDetailsDAO.findByOrderId(orderId);
                // Cập nhật sales_number cho từng sản phẩm trong đơn hàng
                for (OrderDetails od : listOrderDetails) {
                   
                    productDAO.updateSalesNumber(od.product.product_id, od.quantity);
                }
                orderDAO.updateShipperDeliveryTime(orderId, currentTime);
            }

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Cập nhật trạng thái đơn hàng #"+ orderId +" thành công.");
            response.sendRedirect("ship"); // Redirect lại trang danh sách đơn hàng
        } else {
            doGet(request, response); // Chuyển lại doGet cho các hành động khác
        }
    }

    private List<Orders> findOrdersDoGet(HttpServletRequest request, PageControl pageControl) {
       HttpSession session = request.getSession(true);
        Accounts acc = (Accounts) session.getAttribute("acc");
        int shiper_id = acc.getAccount_id();
        
        String statusOrderParam = request.getParameter("statusOrder");
        int statusOrder = (statusOrderParam != null) ? Integer.parseInt(statusOrderParam) : 3;
        //get ve page
        String pageRaw = request.getParameter("page");
        int page;
        try {
            page = Integer.parseInt(pageRaw);
            if (page <= 0) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        String searchType = request.getParameter("searchType") == null
                ? "default"
                : request.getParameter("searchType");

        OrdersDAO orderDAO = new OrdersDAO();
        int totalRecord = 0;
        String requestURL = request.getRequestURI().toString();
        List<Orders> listOrders;
        String key_word = request.getParameter("keyword");
        switch (searchType) {
            case "searchByOrderId":

                listOrders = orderDAO.findOrdersOrderId(key_word, shiper_id);

                totalRecord = 1;
                pageControl.setUrlPattern(requestURL + "?search=searchByOrderId&orderId=" + key_word + "&");
                break;

            case "searchByUsername":

                listOrders = orderDAO.findOrdersUserName(key_word, page, shiper_id);
                totalRecord = orderDAO.findTotalRecordByUserName(key_word);
                pageControl.setUrlPattern(requestURL + "?search=searchByUsername&userName=" + key_word + "&");
                break;

            default:
                listOrders = orderDAO.findOrdersStatusId(statusOrder, page, shiper_id);
                totalRecord = orderDAO.findTotalRecordByStatusId(statusOrder);
                pageControl.setUrlPattern(requestURL + "?statusOrder=" + statusOrder + "&");
        }

        //total page
        //6 is total record/page
        int totalPage = (totalRecord % 6) == 0
                ? (totalRecord / 6)
                : (totalRecord / 6) + 1;
        pageControl.setPage(page);
        pageControl.setTotalPage(totalPage);
        pageControl.setTotalRecord(totalRecord);
        return listOrders;
    }

}
