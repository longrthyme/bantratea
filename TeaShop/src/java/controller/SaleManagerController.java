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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Pham Toan
 */
public class SaleManagerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String service = req.getParameter("service");
        req.setAttribute("saleManager", "Yes");
        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            ProductDAO productDAO = new ProductDAO();
            List<Product> listAllProduct = productDAO.findAll();
            req.setAttribute("listAllProduct", listAllProduct);
            req.setAttribute("showSearchProduct", "Yes");
            req.getRequestDispatcher("view/dashboard/admin/SaleManager.jsp").forward(req, resp);
        }

        if (service.equals("searchByKeywords")) {
            String keywords = req.getParameter("keywords");

            List<Product> products = (new ProductDAO()).getProductByKeyWords(keywords);

            if (products == null || products.isEmpty()) {
                req.setAttribute("notFoundProduct", "Từ khóa bạn tìm kiếm không khớp với tên sản phẩm nào");
                products = (new ProductDAO()).findAll();
            }
            req.setAttribute("listAllProduct", products);
            req.setAttribute("keywords", keywords);
            req.setAttribute("showSearchProduct", "Yes");
            req.getRequestDispatcher("view/dashboard/admin/SaleManager.jsp").forward(req, resp);
        }

        if (service.equals("searchByPriceRange")) {
            try {
                int priceFrom = Integer.parseInt(req.getParameter("priceFrom"));
                int priceTo = Integer.parseInt(req.getParameter("priceTo"));

                
                if (priceFrom <= 0 || priceTo <= 0 || priceFrom >= priceTo) {
                    String errorMessage = "Khoảng giá không hợp lệ. Đảm bảo rằng 'khoảng giá bắt đầu' nhỏ hơn 'khoảng giá kết thúc' và cả hai đều lớn hơn 0.";
                    req.setAttribute("errorMessageFilter", errorMessage);
                } else {
                    List<Product> products = (new ProductDAO()).getProductByPriceRange(priceFrom, priceTo);

                 
                    if (products == null || products.isEmpty()) {
                        req.setAttribute("errorMessageFilter", "Không có sản phẩm nào trong khoảng giá.");
                    } else {
                        req.setAttribute("listAllProduct", products); 
                    }
                }

                req.setAttribute("priceFrom", priceFrom);
                req.setAttribute("priceTo", priceTo);
                req.setAttribute("showSearchProduct", "Yes");
            } catch (NumberFormatException e) {
                req.setAttribute("errorMessageFilter", "Giá trị không hợp lệ. Vui lòng nhập số nguyên dương cho khoảng giá.");
            }
            req.setAttribute("showSearchProduct", "Yes");
            req.getRequestDispatcher("view/dashboard/admin/SaleManager.jsp").forward(req, resp);
        }

        if (service.equals("requestUpdate")) {
            List<Category> listCategorys = (new CategoryDAO().findAll());
            int productId = Integer.parseInt(req.getParameter("productId"));
            Product product = (new ProductDAO()).getProductsById(productId);
            req.setAttribute("allCategorys", listCategorys);
            req.setAttribute("productUpdate", product);
            req.getRequestDispatcher("view/dashboard/admin/SaleManager.jsp").forward(req, resp);
        }

        if (service.equals("sendUpdateDetail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            String discountStr = req.getParameter("discount");
            String errorMessage = null;
            float discount = 0;
            try {
                discount = Float.parseFloat(discountStr);
                if (discount < 0 || discount > 100) {
                    errorMessage = "Giảm giá của một sản phẩm phải > 0% và < 100%";
                }
            } catch (NumberFormatException e) {
                errorMessage = "Định dạng giảm giá không hợp lệ. Vui lòng nhập một số hợp lệ.";
            }

            if (errorMessage != null) {
                List<Category> listCategorys = (new CategoryDAO().findAll());
                Product product = (new ProductDAO()).getProductsById(id);
                req.setAttribute("allCategorys", listCategorys);
                req.setAttribute("productUpdate", product);
                req.setAttribute("errorMessage", errorMessage);
                req.getRequestDispatcher("view/dashboard/admin/SaleManager.jsp").forward(req, resp);
                return;
            }

            Product product = (new ProductDAO()).getProductsById(id);
            product.setDiscount(discount);
            (new ProductDAO()).updateDiscount(product, id);
            req.setAttribute("UpdateDone", "Chỉnh sửa giảm giá cho sản phẩm (ID = " + id + ") thành công!\nClick quản lý Sale để xem những thay đổi mới nhất");
            req.getRequestDispatcher("view/dashboard/admin/SaleManager.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

}
