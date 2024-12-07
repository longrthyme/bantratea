/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Category;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HoangNX
 */
public class CategoryDAO extends DBContext {

    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "select * from Category";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Category category = new Category();

                int Category_id = resultSet.getInt("Category_id");
                String Category_name = resultSet.getString("Category_name");

                category.setCategory_id(Category_id);
                category.setCategory_name(Category_name);
                //add to collections
                list.add(category);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage() + "at DBContext method: findAll");

        }
        return list;
    }

    public Category getCategoryById(int categoryId) {
        connection = getConnection();
        //co cau lenh de goi xuong database
        Category category = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String sql = "select * from [Category] where category_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryId);
            rs = stm.executeQuery();
            while (rs.next()) {
                category = new Category();
                int category_id = rs.getInt("category_id");
                String category_name = rs.getString("category_name");
                category.setCategory_id(category_id);
                category.setCategory_name(category_name);
                return category;
            }

        } catch (SQLException ex) {
//            
        }
        return null;
    }

    public int insertCategory(Category c) {
        connection = getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        int generatedId = -1;
        String sql = "INSERT INTO [dbo].[Category]\n"
                + "           ([category_name])\n"
                + "     VALUES\n"
                + "           (?)";
        try {
            stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setString(1, c.getCategory_name());
            stm.executeUpdate();

            //get generatedId
            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }

        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CategoryDAO.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return generatedId;
    }

    public void updateCategory(Category c, int cid) {
        connection = getConnection();
        PreparedStatement stm = null;

        String sql = "UPDATE [dbo].[Category]\n"
                + "   SET [category_name] = ?\n"
                + " WHERE category_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, c.getCategory_name());
            stm.setInt(2, cid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CategoryDAO.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
    }

    public int deleteCategory(int id) {
        connection = getConnection();
        int n = 0;
        PreparedStatement stm = null;

        String sql = "DELETE FROM [dbo].[Category]\n"
                + "      WHERE category_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            n = stm.executeUpdate();
        } catch (SQLException ex) {
            n = -1;
            Logger.getLogger(CategoryDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public List<Category> getCategoryByKeyWords(String keyword) {
        List<Category> categories = new ArrayList<>();
        connection = getConnection();
        String sql = "SELECT * FROM [dbo].[Category] WHERE category_name LIKE ?\n";

        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters
            statement.setString(1, "%" + keyword + "%");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int category_id = resultSet.getInt("category_id");
                String category_name = resultSet.getString("category_name");

                //add to collections
                categories.add(new Category(category_id, category_name));
            }
            return categories;
        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return null;
    }

    public static void main(String[] args) {
//      
        CategoryDAO categoryDAO = new CategoryDAO();
        String keyword = "Syphon"; // Thay thế bằng từ khóa bạn muốn kiểm tra
        List<Category> categories = categoryDAO.getCategoryByKeyWords(keyword);

        // In kết quả ra console
        if (categories != null) {
            for (Category category : categories) {
                System.out.println("Category ID: " + category.getCategory_id() + ", Category Name: " + category.getCategory_name());
            }
        } else {
            System.out.println("No categories found or an error occurred.");
        }
    }

}
