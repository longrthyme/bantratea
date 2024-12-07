/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManageSlider;

import dal.SliderDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;



@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 50,      // 50MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class addSlider extends HttpServlet {
    private static final String UPLOAD_DIR = "uploadslide";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieves form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String url = request.getParameter("url");
        String status = request.getParameter("status");
        
        // Retrieves the file part
        Part filePart = request.getPart("image");
        

        // Handle file upload
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            Files.copy(filePart.getInputStream(), Paths.get(filePath));

            // Construct the URL for the uploaded image
            String image = UPLOAD_DIR + "/" + fileName;
         // Saves slider data to the database
        SliderDAO sd = new SliderDAO();
        sd.insertSlider(name, description, url, image, status);
        request.setAttribute("updateMessage", "Add Successfully!");
        // Redirects to the management page
        //response.sendRedirect("manageSlider");  
        request.getRequestDispatcher("AddSlider.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
 

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
