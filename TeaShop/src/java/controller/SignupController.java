/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import entity.Accounts;
import entity.Email;
import entity.EncodePassword;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Huyen Tranq
 */
public class SignupController extends HttpServlet {

    private static final String SIGNUP_JSP = "Signup.jsp";
    private static final String LOGIN_JSP = "login.jsp";

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignupController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        AccountDAO dao = new AccountDAO();

        if (request.getParameter("mode") != null && request.getParameter("mode").equals("1")) {

            request.getRequestDispatcher(SIGNUP_JSP).forward(request, response);
        }
        request.getRequestDispatcher(LOGIN_JSP).forward(request, response);
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
        String email = request.getParameter("email");
        String pass_word = request.getParameter("pass");
        String re_pass = request.getParameter("re_pass");
        String user_name = request.getParameter("user");
        String phone_number = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String errorMessage = null;

        if (user_name == null || user_name.trim().isEmpty()) {
            errorMessage = "Ten nguoi dung khong duoc de chi khoảng trang";
        } else if (user_name.matches("\\d+")) {
            errorMessage = "Ten nguoi dung khong duoc chi chua cac so";
        } else if (phone_number == null || phone_number.trim().isEmpty() || !phone_number.matches("0\\d{9}")) {
            errorMessage = "So dien thoai phai bat dau bang 0 va bao gom 10 so";
        } else if (pass_word == null || pass_word.trim().isEmpty() || pass_word.length() < 8 || pass_word.length() > 32) {
            errorMessage = "Mat khau phai chua 8-32 ky tu";
        } else if (pass_word != null && !(pass_word.equals(re_pass))) {
            errorMessage = "Mat khau phai khop voi mat khau duoc nhap lai";
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("email", email);
            request.setAttribute("pass", pass_word);
            request.setAttribute("user", user_name);
            request.setAttribute("phone_number", phone_number);
            request.setAttribute("address", address);
            request.setAttribute("gender", gender);
            request.getRequestDispatcher(SIGNUP_JSP).forward(request, response);
            return;
        } else {
            pass_word = EncodePassword.toSHA1(pass_word);
            AccountDAO dao = new AccountDAO();
            Accounts a = dao.checkAccountExist(email);
            if (a == null) {
                Accounts a1 = dao.checkAccountName(user_name);
                if (a1 == null) {
                    HttpSession session = request.getSession();                 
                    session.setAttribute("user", user_name);
                    session.setAttribute("pass", pass_word);
                    session.setAttribute("phone_number", phone_number);
                    session.setAttribute("email", email);
                    session.setAttribute("address", address);
                    session.setAttribute("gender", gender);
                    System.out.println("Genderabc: " + gender);
                    Email e = new Email();
                    String verifyLink = "http://localhost:8080/TeaShop/verifyaccount"; // Thay đổi URL theo link xác nhận 

                    String emailContent = "<!DOCTYPE html>\n"
                            + "<html>\n"
                            + "<head>\n"
                            + "</head>\n"
                            + "<body>\n"
                            + "<p>Hãy click vào link dưới đây để xác nhận email và trở thành một thành viên của Dreamy Coffee nhé!</p>\n"
                            + "<a href=\"" + verifyLink + "\">Verify Email</a>\n"
                            + "\n"
                            + "</body>\n"
                            + "</html>";

                    e.sendEmail(email, "Verify your email", emailContent);
                    request.setAttribute("Notification", "Ban can xac nhan email de dang nhap");
                    request.getRequestDispatcher(LOGIN_JSP).forward(request, response);
                } else {
                    request.setAttribute("error", "Tai khoan nay da ton tai");
                    request.getRequestDispatcher(SIGNUP_JSP).forward(request, response);
                }

            } else {

                request.setAttribute("errorMessage", "Email nay da duoc dang ky, hay thu mot email khac"); 
                request.getRequestDispatcher(SIGNUP_JSP).forward(request, response);
            }
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
    // Hàm kiểm tra khoảng trắng

    private boolean containsSpace(String input) {
        return input != null && input.contains(" ");
    }

}
