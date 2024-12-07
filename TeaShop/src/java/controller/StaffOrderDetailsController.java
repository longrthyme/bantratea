/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.OrderDetailsDAO;
import dal.OrdersDAO;
import entity.OrderDetails;
import entity.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author HoangPC
 */
public class StaffOrderDetailsController extends HttpServlet {
   
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        OrdersDAO orderDAO = new OrdersDAO();
    OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

    int order_id = Integer.parseInt(request.getParameter("order_id"));
    List<OrderDetails> listOrderDetails = orderDetailsDAO.findByOrderId(order_id);
    Orders orders = orderDAO.findByOrderId(order_id);

    HttpSession session = request.getSession();
    session.setAttribute("listOrderDetails", listOrderDetails);
    session.setAttribute("orders", orders);

    // Chuyển đổi Timestamp sang chuỗi định dạng
    String orderTimeFormatted = orders.getOrder_date().toLocalDateTime().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
    request.setAttribute("orderTimeFormatted", orderTimeFormatted);

    request.getRequestDispatcher("view/dashboard/staff1/orderdetail-manage.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

         // Lấy các thông tin từ form
    int orderID = Integer.parseInt(request.getParameter("orderID"));
    String deliveryTimeStr = request.getParameter("deliveryTime");
    String staffNote = request.getParameter("staffNote");

   
        // Lấy thông tin đơn hàng từ database
        OrdersDAO ordersDAO = new OrdersDAO();
        Orders order = ordersDAO.findByOrderId(orderID);
        Timestamp orderDate = order.getOrder_date();

        // Kiểm tra thời gian giao hàng (nếu có)
        if (deliveryTimeStr != null && !deliveryTimeStr.isEmpty()) {
            Timestamp deliveryTime = Timestamp.valueOf(deliveryTimeStr.replace("T", " ") + ":00");

            if (deliveryTime.before(orderDate)) {
                request.setAttribute("errorMessage", "Thời gian giao hàng phải sau thời gian tạo đơn hàng.");
                request.getRequestDispatcher("view/dashboard/staff1/orderdetail-manage.jsp").forward(request, response);
                return;
            } else {
                ordersDAO.updateDeliveryTime(orderID, deliveryTime);
            }
        }

        // Cập nhật note của Shipper (nếu có)
        if (staffNote != null && !staffNote.isEmpty()) {
            ordersDAO.updateStaffNote(orderID, staffNote);
        }

        // Xử lý upload file (nếu có)
        String appPath = request.getServletContext().getRealPath("");
        String savePath = appPath + File.separator + "uploadImages";

        File uploadDir = new File(savePath);
        if (!uploadDir.exists()) {
            System.out.print("Create dir upload image");
            uploadDir.mkdirs(); // Create the directory if it doesn't exist
        }


        for (Part part : request.getParts()) {
            if (part.getName().startsWith("fileUpload")) {
                int orderDetailsId = Integer.parseInt(part.getName().substring(10));
                String fileName = extractFileName(part);
                String filePath = savePath + File.separator + fileName;
                System.out.print("FIle path image upload before " + filePath);
                try {
                    System.out.print("In upload image before shipping");
                    part.write(filePath);
                } catch (IOException e) {
                    System.out.print("Err upload image before shipping");
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error uploading file: " + e.getMessage());
                    request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                    return;
                }
                String dbFilePath = "uploadImages/" + fileName;

                OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
                orderDetailsDAO.updateImageBeforePath(orderDetailsId, dbFilePath);
            }
        }

        // Lưu thời gian giao hàng vào session (nếu có)
        HttpSession session = request.getSession();
        session.setAttribute("savedTime", deliveryTimeStr);

        // Redirect về trang chi tiết đơn hàng
        response.sendRedirect("stafforderdetails?order_id=" + orderID);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }


}
