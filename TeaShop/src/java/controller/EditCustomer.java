/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AdminDAO;
import entity.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author Huyen Tranq
 */
@MultipartConfig
public class EditCustomer extends HttpServlet {

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
            AdminDAO dao = new AdminDAO();
            String id = request.getParameter("id");
            int account_id = Integer.parseInt(id);
            Accounts a = dao.getAccountById(account_id);
            request.setAttribute("acc", a);
            request.getRequestDispatcher("view/dashboard/staff1/EditCustomer.jsp").forward(request, response);
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
         AdminDAO dao = new AdminDAO();

        String user_name = request.getParameter("user_name");
        String email = request.getParameter("email");
        String phone_number = request.getParameter("phone_number");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        String img = request.getParameter("img");

        String imgUpload = null;
        try {
            Part filePart = request.getPart("img");
            if (filePart.getSize() > 0) {
                String fileName = getFileName(filePart);

                String savePath = getServletContext().getRealPath("/") + "images/";
                File fileSaveDir = new File(savePath);
                if (!fileSaveDir.exists()) {
                    fileSaveDir.mkdir();
                }

                File file = new File(savePath + fileName);
                filePart.write(file.getAbsolutePath());

                imgUpload = "images/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Accounts a = dao.getUserInfor(email);
        int role_id = Integer.parseInt(role);
        int status_id = Integer.parseInt(status);
        if (imgUpload == null) {
            imgUpload = dao.getProductImage1ById(a.getAccount_id()); // Lấy đường dẫn ảnh 1 cũ
        }
       dao.editUserById(role_id, status_id, a.getAccount_id());
        response.sendRedirect("customerManagement");
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
     private String getFileName(final Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

}
