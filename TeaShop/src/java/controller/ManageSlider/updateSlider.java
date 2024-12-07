package controller.ManageSlider;

import dal.SliderDAO;
import entity.Slider;
import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;



@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 50,      // 50MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class updateSlider extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieves form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String url = request.getParameter("url");
        String status = request.getParameter("status");
        String id = request.getParameter("id");
        int sid = Integer.parseInt(id);

        // Retrieves the file part
        Part filePart = request.getPart("image");

        // Check if a new image is uploaded
        String fileName = "";
        if (filePart != null && filePart.getSize() > 0) {
            // Obtains the file name
            fileName = extractFileName(filePart);

            // Refines the file name
            fileName = new File(fileName).getName();

            // Writes the file to disk
            String uploadPath = getFolderUpload().getAbsolutePath();
            filePart.write(uploadPath + File.separator + fileName);
        } else {
            // If no new image is uploaded, retain the original image file name
            fileName = request.getParameter("original_image");
        }

        // Update slider data in the database
        SliderDAO sd = new SliderDAO();
        sd.updateSlider(name, description, url, fileName, status, sid);

        request.setAttribute("updateMessage", "Update Successfully!");
        // Forward the request and response to the EditSlider.jsp page
        request.getRequestDispatcher("updatesliderdetail?id=" + id).forward(request, response);
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
    
    // Extracts file name from HTTP header content-disposition
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
    
    // Defines the upload directory
    public File getFolderUpload() {
        File folderUpload = new File("F:\\Swp\\git clone\\SE1847_G6_SWP391_TeaShop\\TeaShop2\\web\\img");
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
    }
}
