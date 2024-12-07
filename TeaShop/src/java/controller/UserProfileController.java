/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import dal.AdminDAO;
import dal.CouponDAO;
import dal.PointDAO;
import entity.Accounts;
import entity.Coupon;
import entity.DiscountType;
import entity.EncodePassword;
import entity.RedeemedCoupon;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.mail.Session;

/**
 *
 * @author Huyen Tranq
 */
@MultipartConfig
public class UserProfileController extends HttpServlet {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final SecureRandom RANDOM = new SecureRandom();

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
            String service = request.getParameter("service");
            PointDAO pointDAO = new PointDAO();
            CouponDAO couponDAO = new CouponDAO();
            HttpSession session = request.getSession();
            if (service == null) {
                service = "ViewProfile";
            }
            switch (service) {
                case "ViewProfile": {
                    AdminDAO dao = new AdminDAO();
                    String email = request.getParameter("email");
                    Accounts a = dao.getUserInfor(email);
                    request.setAttribute("a", a);
                    List<RedeemedCoupon> cp = couponDAO.getCouponByAccountID(a.getAccount_id());
                    request.setAttribute("redeemedCoupons", cp);
                    if (a != null) {
                        int points = pointDAO.getUserPoints(a.getAccount_id());
                        request.setAttribute("points", points);
                    }
                    List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                    request.setAttribute("discountsType", discountsType);

                    request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);

                }
                break;
                case "UpdateProfile": {
                    AccountDAO accountDAO = new AccountDAO();
                    String user_name = request.getParameter("user_name");
                    String phoneNumber = request.getParameter("phoneNumber");
                    String email = request.getParameter("email");
                    String address = request.getParameter("address");
                    String errorMessage = null;
                    if (user_name == null || user_name.trim().isEmpty()) {
                        errorMessage = "Tên người dùng không được để trống hoặc chỉ có khoảng trắng";
                    } else if (user_name.matches("\\d+")) {
                        errorMessage = "Tên người dùng không được chỉ chứa các số";
                    } else if (phoneNumber == null || phoneNumber.trim().isEmpty() || !phoneNumber.matches("0\\d{9}")) {
                        errorMessage = "Số điện thoại phải bắt đầu bằng 0 và bao gồm 10 số";
                    }
                    if (errorMessage != null) {
                        AdminDAO dao = new AdminDAO();
                        Accounts a = dao.getUserInfor(email);
                        int points = pointDAO.getUserPoints(a.getAccount_id());
                        request.setAttribute("points", points);
                        request.setAttribute("a", a);
                        request.setAttribute("errorMessage", errorMessage);
                        request.setAttribute("user_name", user_name);
                        request.setAttribute("phoneNumber", phoneNumber);
                        request.setAttribute("address", address);
                        request.setAttribute("email", email);
                        List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                        request.setAttribute("discountsType", discountsType);
                        request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);
                        return;
                    } else {
                        int check = accountDAO.updateProfile(user_name, phoneNumber, email, address);
                        if (check > 0) {
                            AdminDAO dao = new AdminDAO();
                            Accounts a = dao.getUserInfor(email);
                            if (a != null) {
                                int points = pointDAO.getUserPoints(a.getAccount_id());
                                request.setAttribute("points", points);
                            }
                            request.setAttribute("a", a);
                            request.setAttribute("errorMessage", "Cập nhật thành công");
                            request.setAttribute("user_name", user_name);
                            request.setAttribute("phoneNumber", phoneNumber);
                            request.setAttribute("address", address);
                            request.setAttribute("email", email);
                            List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                            request.setAttribute("discountsType", discountsType);
                            request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);

                        } else {
                            AdminDAO dao = new AdminDAO();
                            Accounts a = dao.getUserInfor(email);
                            request.setAttribute("a", a);
                            request.setAttribute("errorMessage", "Cập nhật thất bại");
                            request.setAttribute("user_name", user_name);
                            request.setAttribute("phoneNumber", phoneNumber);
                            request.setAttribute("address", address);
                            request.setAttribute("email", email);
                            List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                            request.setAttribute("discountsType", discountsType);
                            request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);

                        }
                    }
                }
                break;

                case "UpdateAvatar": {

                    AdminDAO dao = new AdminDAO();
                    String email = request.getParameter("email");
                    Accounts a = dao.getUserInfor(email);
                    int points = pointDAO.getUserPoints(a.getAccount_id());
                    request.setAttribute("points", points);
                    List<RedeemedCoupon> cp = couponDAO.getCouponByAccountID(a.getAccount_id());
                    request.setAttribute("redeemedCoupons", cp);
                    String uploadedFilePath = null;

                    try {
                        Part filePart = request.getPart("img");
                        if (filePart != null && filePart.getSize() > 0) {
                            String fileName = getFileName(filePart);
                            if (!fileName.equals("unknown.jpg") && !fileName.isEmpty()) {

                                String fileType = filePart.getContentType();
                                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

                                List<String> allowedExtensions = Arrays.asList("jpg", "jpeg", "png", "gif", "bmp");
                                List<String> allowedMimeTypes = Arrays.asList("image/jpeg", "image/png", "image/gif", "image/bmp");

                                if (allowedExtensions.contains(fileExtension) && allowedMimeTypes.contains(fileType)) {
                                    String savePath = getServletContext().getRealPath("/") + "img/";
                                    File fileSaveDir = new File(savePath);
                                    if (!fileSaveDir.exists()) {
                                        fileSaveDir.mkdirs();
                                    }
                                    File file = new File(savePath + fileName);
                                    try (InputStream fileContent = filePart.getInputStream()) {
                                        Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                                        uploadedFilePath = "/img/" + fileName;
                                        AccountDAO accountDAO = new AccountDAO();
                                        int rowsUpdated = accountDAO.updateAvatar(uploadedFilePath, email);
                                        if (rowsUpdated > 0) {
                                            request.setAttribute("a", a);
                                            List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                                            request.setAttribute("discountsType", discountsType);
                                            request.setAttribute("updateAvtSuccess", "Cập nhật avatar thành công");
                                        } else {
                                            request.setAttribute("a", a);
                                            List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                                            request.setAttribute("discountsType", discountsType);
                                            request.setAttribute("updateAvtFailed", "Cập nhật avatar thất bại");
                                        }
                                    } catch (IOException ex) {
                                        ex.printStackTrace();
                                        request.setAttribute("a", a);
                                        List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                                        request.setAttribute("discountsType", discountsType);
                                        request.setAttribute("updateAvtFailed", "Cập nhật avatar thất bại do lỗi");
                                    }
                                } else {
                                    request.setAttribute("a", a);
                                    List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                                    request.setAttribute("discountsType", discountsType);
                                    request.setAttribute("updateAvtFailed", "File tải lên phải là ảnh (jpg, jpeg, png, gif, bmp)");
                                }
                            } else {
                                request.setAttribute("a", a);
                                List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                                request.setAttribute("discountsType", discountsType);
                                request.setAttribute("updateAvtFailed", "Tên tệp không hợp lệ");
                            }
                        } else {
                            request.setAttribute("a", a);
                            List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                            request.setAttribute("discountsType", discountsType);
                            request.setAttribute("updateAvtFailed", "Không có tệp nào được tải lên");
                        }
                    } catch (IOException | ServletException ex) {
                        ex.printStackTrace();
                        request.setAttribute("a", a);
                        List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                        request.setAttribute("discountsType", discountsType);
                        request.setAttribute("updateAvtFailed", "Cập nhật avatar thất bại do lỗi");
                    }
                    List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                    request.setAttribute("discountsType", discountsType);
                    request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);

                }
                break;

                case "UpdatePassword": {

                    HashMap<String, String> errorsList = new HashMap<>();
                    AdminDAO dao = new AdminDAO();
                    AccountDAO accountDAO = new AccountDAO();
                    String email = request.getParameter("email");
                    Accounts a = dao.getUserInfor(email);
                    List<RedeemedCoupon> cp = couponDAO.getCouponByAccountID(a.getAccount_id());
                    request.setAttribute("redeemedCoupons", cp);
                    if (a != null) {
                        int points = pointDAO.getUserPoints(a.getAccount_id());
                        request.setAttribute("points", points);
                    }
                    if (a == null) {
                        errorsList.put("userNotFound", "Không tìm thấy tài khoản với email: " + email);
                        request.setAttribute("errorsList", errorsList);
                        request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);
                        return;
                    }
                    String oldPassword = request.getParameter("oldpass");
                    String newPassword = request.getParameter("newpass");
                    String reNewPassword = request.getParameter("re_newpass");

                    // Mã hóa mật khẩu cũ để so sánh
                    String encodedOldPassword = EncodePassword.toSHA1(oldPassword);

                    if (!encodedOldPassword.equals(a.getPass_word())) {
                        errorsList.put("wrongOldPass", "Bạn đã nhập sai mật khẩu cũ");
                    }
                    if (newPassword == null || newPassword.trim().isEmpty() || newPassword.length() < 8 || newPassword.length() > 32) {
                        errorsList.put("wrongFormatPass", "Mật khẩu cần 8-32 ký tự");
                    }
                    if (!newPassword.equals(reNewPassword)) {
                        errorsList.put("wrongNewPass", "Mật khẩu mới của bạn phải khớp với mật khẩu nhắc lại bên dưới");
                    }
                    if (!errorsList.isEmpty()) {
                        request.setAttribute("errorsList", errorsList);
                        request.setAttribute("a", a);
                        request.setAttribute("oldpass", oldPassword);
                        request.setAttribute("newpass", newPassword);
                        request.setAttribute("re_newpass", reNewPassword);
                        List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                        request.setAttribute("discountsType", discountsType);
                        request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);
                        return;
                    } else {
                        // Mã hóa mật khẩu mới trước khi cập nhật
                        String encodedNewPassword = EncodePassword.toSHA1(newPassword);
                        int check = accountDAO.updatePassword(encodedNewPassword, email);
                        System.out.println(check);
                        if (check > 0) {
                            request.setAttribute("updateSuccess", "Cập nhật mật khẩu mới thành công");
                            request.setAttribute("a", a);
                            request.setAttribute("oldpass", oldPassword);
                            request.setAttribute("newpass", newPassword);
                            request.setAttribute("re_newpass", reNewPassword);
                            List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                            request.setAttribute("discountsType", discountsType);
                            request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);
                        } else {
                            request.setAttribute("updateFailed", "Cập nhật mật khẩu mới thất bại");
                            request.setAttribute("a", a);
                            request.setAttribute("oldpass", oldPassword);
                            request.setAttribute("newpass", newPassword);
                            request.setAttribute("re_newpass", reNewPassword);
                            List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                            request.setAttribute("discountsType", discountsType);
                            request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);
                        }
                    }
                }
                break;
                case "RedeemPoints": {
                    String buttonSubmit = request.getParameter("buttonSubmit");
                    AdminDAO dao = new AdminDAO();
                    String email = request.getParameter("email");
                    Accounts a = dao.getUserInfor(email);
                    List<RedeemedCoupon> cp = couponDAO.getCouponByAccountID(a.getAccount_id());
                    request.setAttribute("redeemedCoupons", cp);

                    if (a != null) {
                        int points = pointDAO.getUserPoints(a.getAccount_id());
                        request.setAttribute("points", points);
                        request.setAttribute("a", a);
                    }

                    List<DiscountType> discountsType = couponDAO.getAllDiscountType();
                    request.setAttribute("discountsType", discountsType);

                    if (buttonSubmit != null) {
                        int points = pointDAO.getUserPoints(a.getAccount_id());
                        if (points < 5) {
                            String message = "Bạn không đủ điểm để đổi voucher";
                            session.setAttribute("pointsMessage", message);
                        } else {
                            int discountType = Integer.valueOf(request.getParameter("discountType"));
                            String couponCode = generateCouponCode();
                            Date createdAt = new Date();
                            Calendar cal = Calendar.getInstance();
                            cal.setTime(createdAt);
                            cal.add(Calendar.DAY_OF_MONTH, 3);
                            Date validUltil = cal.getTime();
                            Coupon coupon = new Coupon();
                            coupon.setCouponCode(couponCode);
                            coupon.setDiscountType(discountType);
                            coupon.setCreatedAt(createdAt);
                            coupon.setValidUltil(validUltil);
                            int check = couponDAO.addCoupon(coupon);
                            if (check > 0) {
                                String message = "Đổi voucher thành công";
                                session.setAttribute("couponMessage", message);
                                couponDAO.addToRedeemedCoupons(a.getAccount_id(), couponCode);
                                pointDAO.minusPointsAfterRedeemed(a.getAccount_id());
                                response.sendRedirect("userprofile?email=" + email);
                                return;
                            }

                        }
                    }

                    request.getRequestDispatcher("view/homepage/UserProfile.jsp").forward(request, response);
                }

                break;

            }
        }

    }

    public static String generateCouponCode() {
        StringBuilder couponCode = new StringBuilder(8);
        for (int i = 0; i < 8; i++) {
            couponCode.append(CHARACTERS.charAt(RANDOM.nextInt(CHARACTERS.length())));
        }
        return couponCode.toString();
    }

    private String getFileName(final Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
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
