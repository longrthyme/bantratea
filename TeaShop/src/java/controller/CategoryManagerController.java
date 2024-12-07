/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import entity.Category;
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
public class CategoryManagerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String service = req.getParameter("service");
        req.setAttribute("categorymanager", "Yes");
        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            List<Category> listCategory = (new CategoryDAO().findAll());
            req.setAttribute("listAllCategory", listCategory);
            req.setAttribute("showSearchCategory", "Yes");
            req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
        }

        if (service.equals("searchByKeywords")) {
            String keywords = req.getParameter("keywords");

            List<Category> categorys = (new CategoryDAO()).getCategoryByKeyWords(keywords);

            if (categorys == null || categorys.isEmpty()) {
                req.setAttribute("notFoundProduct", "Từ khóa bạn tìm kiếm không khớp với tên danh mục nào");
                categorys = (new CategoryDAO()).findAll();
            }

            req.setAttribute("listAllCategory", categorys);
            req.setAttribute("keywords", keywords);
            req.setAttribute("showSearchCategory", "Yes");
            req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
        }

        if (service.equals("sendRequestInsert")) {
            req.setAttribute("insertCategory", "insertCategory");
            req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
        }

        if (service.equals("sendInsertDetail")) {
            String name = req.getParameter("name");

            // Validation
            String errorMessage = null;
            if (name == null || name.trim().isEmpty()) {
                errorMessage = "Tên Danh mục không được để trống hoặc chỉ có khoảng trắng";
            }

            if (errorMessage != null) {
                req.setAttribute("errorMessage", errorMessage);
                req.setAttribute("insertCategory", "insertCategory");
                req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
                return;
            }

            Category category = new Category(name);
            int generatedCategoryId = (new CategoryDAO().insertCategory(category));
            req.setAttribute("InsertDone", "Thêm Danh mục mới (ID =" + generatedCategoryId + ") thành công!\n click 'Quản lý Danh mục' để xem những thay đổi mới nhất");
            req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
        }

        if (service.equals("sendRequestUpdate")) {
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            Category category = (new CategoryDAO().getCategoryById(categoryId));
            req.setAttribute("categoryUpdate", category);
            req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
        }

        if (service.equals("sendUpdateDetail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");

            // Validation
            String errorMessage = null;
            if (name == null || name.trim().isEmpty()) {
                errorMessage = "Tên Danh mục không được để trống hoặc chỉ có khoảng trắng";
            }

            if (errorMessage != null) {
                req.setAttribute("errorMessage", errorMessage);
                req.setAttribute("categoryUpdate", new CategoryDAO().getCategoryById(id));
                req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
                return;
            }

            Category category = (new CategoryDAO().getCategoryById(id));
            category.setCategory_name(name);
            (new CategoryDAO()).updateCategory(category, id);
            req.setAttribute("UpdateDone", "Cập nhật thông tin Danh mục (ID = " + id + ") thành công!\nClick 'Quản lý Danh mục' để xem những thay đổi mới nhất");
            req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);
        }

        if (service.equals("sendRequestDelete")) {
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            int n = (new CategoryDAO().deleteCategory(categoryId));
            if (n == 1) {
                req.setAttribute("deleteDone", "Xóa Danh mục (Id = " + categoryId + ") thành công!");
            } else {
                req.setAttribute("deleteDone", "Xóa Danh mục thất bại (Id  = " + categoryId + ") vì Danh mục này được liên kết với một đơn hàng.");
            }
        }

        List<Category> listCategory = (new CategoryDAO().findAll());
        req.setAttribute("listAllcategory", listCategory);
        req.getRequestDispatcher("view/dashboard/admin/categoryManagement.jsp").forward(req, resp);

    }

}
