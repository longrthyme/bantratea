/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import entity.Category;
import entity.PageControl;
import entity.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author HoangNX
 */
public class ShopController extends HttpServlet {

    ProductDAO productDAO = new ProductDAO();
    CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PageControl pageControl = new PageControl();

        List<Product> listProduct = findProductDoGet(request, pageControl);

        List<Product> listProduct1 = productDAO.findAll();
        List<Category> listCategory = categoryDAO.findAll();

        List<Product> listSpecialProduct = productDAO.specialProduct();

        HttpSession session = request.getSession();
        request.setAttribute("pageControl", pageControl);
        session.setAttribute("listProduct", listProduct);
        session.setAttribute("listCategory", listCategory);
        session.setAttribute("listSpecialProduct", listSpecialProduct);
        request.getRequestDispatcher("view/homepage/shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    private List<Product> findProductDoGet(HttpServletRequest request, PageControl pageControl) {
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

        //get ve search
        String actionSearch = request.getParameter("search") == null
                ? "default"
                : request.getParameter("search");
        //get sort
        String sort = request.getParameter("sort") == null
                ? "product_id"
                : request.getParameter("sort");
        //get list product dao
        List<Product> listProduct;
        //get request URL
        String requestURL = request.getRequestURI().toString();

        int totalRecord = 0;

        switch (actionSearch) {
            case "category":
                String categoryId = request.getParameter("category_id");
                totalRecord = productDAO.findTotalRecordByCategoryId(categoryId);
                listProduct = productDAO.findProductByCategoryId(categoryId, page, sort);
                pageControl.setUrlPattern(requestURL + "?search=category&category_id=" + categoryId + "&sort=" + sort + "&");
                break;
            case "searchByName":
                String keyword = request.getParameter("keyword").trim();
                totalRecord = productDAO.findTotalRecordByName(keyword);
                listProduct = productDAO.findProductByName(keyword, page, sort);
                pageControl.setUrlPattern(requestURL + "?search=searchByName&keyword=" + keyword + "&sort=" + sort + "&");
                break;
            case "searchByPriceRange":
                try {
                    // Get price range from request
                    String priceFromStr = request.getParameter("priceFrom");
                    String priceToStr = request.getParameter("priceTo");

                    // Set default values
                    int priceFrom = 0;
                    int priceTo = 500000;

                    // Check and set values for priceFrom
                    if (priceFromStr != null && !priceFromStr.isEmpty()) {
                        priceFrom = Integer.parseInt(priceFromStr);
                    }

                    // Check and set values for priceTo
                    if (priceToStr != null && !priceToStr.isEmpty()) {
                        priceTo = Integer.parseInt(priceToStr);
                    }

                    // Handle cases where both values are null
                    if (priceFromStr == null && priceToStr == null) {
                        request.setAttribute("priceErrorMessage", "Vui lòng nhập khoảng giá.");
                        totalRecord = productDAO.findTotalRecord();
                        listProduct = productDAO.findByPage(page, sort);
                        pageControl.setUrlPattern(requestURL + "?sort=" + sort + "&");
                    } else if (priceFrom < 0 || priceTo < 0 || priceFrom > priceTo) {
                        request.setAttribute("priceErrorMessage", "Vui lòng điền khoảng giá phù hợp.");
                        totalRecord = productDAO.findTotalRecord();
                        listProduct = productDAO.findByPage(page, sort);
                        pageControl.setUrlPattern(requestURL + "?sort=" + sort + "&");
                    } else {
                        totalRecord = productDAO.findTotalRecordByPriceRange(priceFrom, priceTo);
                        listProduct = productDAO.findProductByPriceRange(priceFrom, priceTo, page, sort);
                        pageControl.setUrlPattern(requestURL + "?search=searchByPriceRange&priceFrom=" + priceFrom + "&priceTo=" + priceTo + "&sort=" + sort + "&");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("priceErrorMessage", "Vui lòng điền khoảng giá phù hợp.");
                    totalRecord = productDAO.findTotalRecord();
                    listProduct = productDAO.findByPage(page, sort);
                    pageControl.setUrlPattern(requestURL + "?sort=" + sort + "&");
                }
                break;
            default:
                totalRecord = productDAO.findTotalRecord();
                listProduct = productDAO.findByPage(page, sort);
                pageControl.setUrlPattern(requestURL + "?sort=" + sort + "&");
        }

        // Calculate total pages
        int totalPage = (totalRecord % 6) == 0 ? (totalRecord / 6) : (totalRecord / 6) + 1;
        pageControl.setPage(page);
        pageControl.setTotalPage(totalPage);
        pageControl.setTotalRecord(totalRecord);

        return listProduct;
    }
}
