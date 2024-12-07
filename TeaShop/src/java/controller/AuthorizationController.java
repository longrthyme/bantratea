/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import entity.Accounts;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Huyen Tranq
 */
public class AuthorizationController extends HttpServlet {
   
  //cac ham check role

    public static boolean isAdmin(Accounts acc) {
        return acc != null && acc.getRole_id() == 1;
    }

    public static boolean isCustomer(Accounts acc) {
        return acc != null && acc.getRole_id() == 2;
    }
    
    public static boolean isStaff (Accounts acc) {
        return acc != null && acc.getRole_id() == 3;
    }
    
    public static boolean isShipper (Accounts acc) {
        return acc != null && acc.getRole_id() == 4;
    }
    
    public static void redirectToHome(HttpSession session, HttpServletResponse response)
            throws ServletException, IOException {
        //day ve trang home va thong bao
        session.setAttribute("message", "Bạn không có quyền truy cập!");
        response.sendRedirect("home");
    }

}
