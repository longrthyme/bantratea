/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import entity.Category;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.regex.Pattern;

/**
 *
 * @author Pham Toan
 */
@MultipartConfig
public class UpdateProductController extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String service = req.getParameter("service");
        //Send list Category and RequestUpdate
        if (service == null) {
            service = "requestUpdate";
        }
        if (service.equals("requestUpdate")) {
            List<Category> listCategorys = (new CategoryDAO().findAll());
            int productId = Integer.parseInt(req.getParameter("productId"));
            Product product = (new ProductDAO()).getProductsById(productId);
            req.setAttribute("allCategorys", listCategorys);
            req.setAttribute("productUpdate", product);
            req.getRequestDispatcher("view/dashboard/admin/UpdateProduct.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String service = req.getParameter("service");

        if (service == null) {
            service = "sendUpdateDetail";
        }

        if (service.equals("sendUpdateDetail")) {
            List<Category> listCategorys = (new CategoryDAO()).findAll();
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String categoryIdStr = req.getParameter("category");
            String priceStr = req.getParameter("price");
            String createAtStr = req.getParameter("create_at");
            String description = req.getParameter("description");
            Part filePart = req.getPart("image_url");

            // Validation
            String errorMessage = null;
            if (name == null || name.trim().isEmpty()) {
                errorMessage = "Tên sản phẩm không được để trống hoặc chỉ có khoảng trắng";
            } else if (name.startsWith(" ")) {
                errorMessage = "Tên sản phẩm không được bắt đầu bằng khoảng trắng";
            } else if (priceStr == null || !Pattern.matches("\\d+", priceStr) || priceStr.startsWith("0") && priceStr.length() > 1) {
                errorMessage = "Giá sản phẩm phải là số nguyên dương và không được bắt đầu bằng số 0";
            } else if (createAtStr == null || !createAtStr.equals(LocalDate.now().toString())) {
                errorMessage = "Ngày chỉnh sửa sản phẩm phải là ngày hiện tại";
            } else if (description == null || description.trim().isEmpty()) {
                errorMessage = "Mô tả sản phẩm không được để trống";
            } else if (description.startsWith(" ")) {
                errorMessage = "Mô tả sản phẩm không được bắt đầu bằng khoảng trắng";
            } else if (filePart == null || filePart.getSubmittedFileName().isEmpty()) {
                errorMessage = "Hình ảnh không được để trống";
            } else {
                String fileType = filePart.getContentType();
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

                // Các loại file ảnh hợp lệ
                List<String> allowedExtensions = Arrays.asList("jpg", "jpeg", "png", "gif", "bmp");
                List<String> allowedMimeTypes = Arrays.asList("image/jpeg", "image/png", "image/gif", "image/bmp");

                if (!allowedExtensions.contains(fileExtension) || !allowedMimeTypes.contains(fileType)) {
                    errorMessage = "File tải lên phải là ảnh (jpg, jpeg, png, gif, bmp)";
                }
            }

            if (errorMessage != null) {
                req.setAttribute("errorMessage", errorMessage);
                req.setAttribute("allCategorys", listCategorys);
                req.setAttribute("productUpdate", new ProductDAO().getProductsById(id));
                req.getRequestDispatcher("view/dashboard/admin/UpdateProduct.jsp").forward(req, resp);
                return;
            }

            // Continue with processing if validation passed
            Category category = (new CategoryDAO()).getCategoryById(Integer.parseInt(categoryIdStr));
            int price = Integer.parseInt(priceStr);
            Date create_at = java.sql.Date.valueOf(LocalDate.parse(createAtStr, DateTimeFormatter.ofPattern("yyyy-MM-dd")));

            // Handle file upload
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            Files.copy(filePart.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);

            // Construct the URL for the uploaded image
            String image_url = "uploads" + "/" + fileName;

            Product product = (new ProductDAO()).getProductsById(id);
            product.setProduct_name(name);
            product.setCategory(category);
            product.setImage(image_url);
            product.setPrice(price);
            product.setCreate_at(create_at);
            product.setDescription(description);

            // Update the product
            (new ProductDAO()).updateProduct(product, id);
            req.setAttribute("allCategorys", listCategorys);
            req.setAttribute("UpdateDone", "Cập nhật thông tin sản phẩm (ID = " + id + ") thành công!\nClick 'Quản lý Sản phẩm' để xem những thay đổi mới nhất");
            req.getRequestDispatcher("view/dashboard/admin/UpdateProduct.jsp").forward(req, resp);
        }
    }
}
