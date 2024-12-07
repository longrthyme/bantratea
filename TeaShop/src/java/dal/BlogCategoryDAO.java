/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Acer
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import entity.BlogCategory;
import java.util.ArrayList;
import java.util.List;

//huy
public class BlogCategoryDAO extends DBContext  {
    public List<BlogCategory> getAll() {
        String sql = "SELECT * FROM BlogCategory";
        connection = getConnection();
        List<BlogCategory> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                BlogCategory bc = new BlogCategory();
                bc.setCategoryID(rs.getInt("categoryID"));
                bc.setCategoryName(rs.getString("categoryName"));
                list.add(bc);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
       return list;
    }
    
    public List<BlogCategory> getCategoryByID(int categoryID) {
        String sql = "SELECT * FROM Blog WHERE categoryID = ?";
        connection = getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, categoryID);
            ResultSet rs = st.executeQuery();
            List<BlogCategory> list = new ArrayList<>();
            while (rs.next()) {
                BlogCategory bc = new BlogCategory();
                bc.setCategoryID(rs.getInt("categoryID"));
                bc.setCategoryName(rs.getString("categoryName"));
                list.add(bc);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static void main(String[] args) {
        BlogCategoryDAO dao = new BlogCategoryDAO();

        // Test getAll method
        List<BlogCategory> allCategories = dao.getAll();
        System.out.println("All Categories:");
        for (BlogCategory bc : allCategories) {
            System.out.println("ID: " + bc.getCategoryID() + ", Name: " + bc.getCategoryName());
        }

        // Test getCategoryByID method
        int testID = 1; // replace with a valid ID
        List<BlogCategory> categoryByID = dao.getCategoryByID(testID);
        System.out.println("Category with ID " + testID + ":");
        for (BlogCategory bc : categoryByID) {
            System.out.println("ID: " + bc.getCategoryID() + ", Name: " + bc.getCategoryName());
        }
    }
}
