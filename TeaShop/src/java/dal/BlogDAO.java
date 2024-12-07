/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Blog;
import entity.BlogCategory;
import entity.Product;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author HoangPC
 */
public class BlogDAO extends DBContext {

    // tìm tất cả thuộc tính 
    public List<Blog> findAll() {

        List<Blog> listblog = new ArrayList<>();
        connection = getConnection();
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Blog]\n"
        +" WHERE is_deleted = 0 \n" ;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet resultSet = pre.executeQuery();

            while (resultSet.next()) {

                int id = resultSet.getInt(1);
                int role_id = resultSet.getInt(2);
                String content = resultSet.getString(3);
                String img = resultSet.getString(4);
                String blog_name = resultSet.getString(5);
                String created_at = resultSet.getString(6);
                int categoryID = resultSet.getInt(7);
                int status = resultSet.getInt(8);
                Blog pr = new Blog(id, role_id, content, img, blog_name, created_at, categoryID, status);

                listblog.add(pr);
            }

        } catch (SQLException e) {
            System.out.println(e);

        }

        return listblog;
    }
   public List<Blog> getCategoryByID(int categoryID) {
    List<Blog> blogs = new ArrayList<>();
    String sql = "SELECT * FROM Blog WHERE categoryID = ?";
    connection = getConnection();
    try {
        PreparedStatement pre = connection.prepareStatement(sql);
        pre.setInt(1, categoryID);  // Đặt giá trị cho tham số đầu tiên
        ResultSet resultSet = pre.executeQuery();
        while (resultSet.next()) {
            int id = resultSet.getInt(1);
            int role_id = resultSet.getInt(2);
            String content = resultSet.getString(3);
            String img = resultSet.getString(4);
            String blog_name = resultSet.getString(5);
            String created_at = resultSet.getString(6);
            int categoryid = resultSet.getInt(7);
            int status = resultSet.getInt(8);

            Blog blog = new Blog(id, role_id, content, img, blog_name, created_at, categoryid, status);
            blogs.add(blog);
        }
    } catch (SQLException e) {
        System.out.println(e);
    } finally {
        // Đóng kết nối và các tài nguyên khác ở đây nếu cần
    }
    return blogs;
}

    // tìm tất cả thuộc tính for Admin
    public List<Blog> getForList() {

        List<Blog> listblog = new ArrayList<>();
        connection = getConnection();
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Blog]\n"
         + "WHERE is_deleted = 0\n";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet resultSet = pre.executeQuery();

            while (resultSet.next()) {

                int id = resultSet.getInt(1);
                int role_id = resultSet.getInt(2);
                String content = resultSet.getString(3);
                String img = resultSet.getString(4);
                String blog_name = resultSet.getString(5);
                String created_at = resultSet.getString(6);
                int categoryID = resultSet.getInt(7);
                int status = resultSet.getInt(8);
                Blog pr = new Blog(id, role_id, content, img, blog_name, created_at, categoryID, status);

                listblog.add(pr);
            }

        } catch (SQLException e) {
            System.out.println(e);

        }

        return listblog;
    }

    // tìm từng blog theo id
    public Blog getBlogById(int bid) {
        Blog blog = null;
        String sql = """
                     SELECT *
                       FROM [dbo].[Blog]
                       WHERE is_deleted = 0 
                      And id= ?
                     """;
        connection = getConnection();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, bid);
            ResultSet resultSet = pre.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt(1);
                int role_id = resultSet.getInt(2);
                String content = resultSet.getString(3);
                String img = resultSet.getString(4);
                String blog_name = resultSet.getString(5);
                String created_at = resultSet.getString(6);
                int categoryID = resultSet.getInt(7);
 int status = resultSet.getInt(8);
                
                blog = new Blog(id, role_id, content, img, blog_name, created_at, categoryID ,status);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return blog;
    }
    //Method used to set a blog's status to active
    public void setActive(String id) {
        connection = getConnection();
        String query = "UPDATE Blog "
                + "SET  is_deleted = 0 "
                + "WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
//Method used to add new blog 
    public void addNewBlog(int role_id, String content, String image, String title, int categoryID) {
        connection = getConnection();
        String sql = "INSERT INTO Blog "
                + "           ([role_id], [content], [img], [blog_name], [categoryID]) "
                + "     VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, role_id);
            st.setString(2, content);
            st.setString(3, image);
            st.setString(4, title);
            
            st.setInt(5, categoryID);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
// Method used to Hide  blog by its ID
public void hideByID(int id) {
    connection = getConnection();
    String sql = "UPDATE Blog SET is_deleted = 1 WHERE id = ?";
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        st.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}    
//Method used to delete blog by its ID
    public void deleteByID(int id) {
        connection = getConnection();
        String sql = "UPDATE Blog "
                + "SET  is_deleted = 2 "
                + "WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    //find blog folow with name of blog or content of blog
    public List<Blog> getBlogBySearch(String search) {
        List<Blog> blog = new ArrayList<>();
       String sql = "SELECT * FROM Blog WHERE (blog_name LIKE ? OR content LIKE ?) AND is_deleted = 0";

        PreparedStatement pre;
        connection = getConnection();
        if (sql.isEmpty()) {
            return blog;
        } else {
            try {
                pre = connection.prepareStatement(sql);
                pre.setString(1, "%" + search + "%");
                pre.setString(2, "%" + search + "%");
                ResultSet resultSet = pre.executeQuery();
                while (resultSet.next()) {
                    //public int id, role_id;
                    //public String  content, img , blog_name ,created_at;
                    int id = resultSet.getInt("id");
                    int role_id = resultSet.getInt("role_id");
                    String content = resultSet.getString("content");
                    String img = resultSet.getString("img");
                    String blog_name = resultSet.getString("blog_name");
                    String created_at = resultSet.getString("created_at");
                    int categoryID = resultSet.getInt(7);
                     int status = resultSet.getInt(8);
                    Blog pr = new Blog(id, role_id, content, img, blog_name, created_at, categoryID ,status);
                    blog.add(pr);

                }
            } catch (SQLException ex) {
                System.out.println(ex);
            }

        }
        return blog;
    }
    //Method used to get top 3 blog by posted date
    public List<Blog> getTop3Newest() {
        String sql = "SELECT TOP 3 *\n"
                + "FROM Blog\n"
                + "WHERE is_deleted = 0\n"
                + "ORDER BY created_at DESC, id DESC;";
        PreparedStatement pre;
        connection = getConnection();
        List<Blog> blog = new ArrayList<>();
        try {
            pre = connection.prepareStatement(sql);

            ResultSet resultSet = pre.executeQuery();
            while (resultSet.next()) {

                int id = resultSet.getInt("id");
                int role_id = resultSet.getInt("role_id");
                String content = resultSet.getString("content");
                String img = resultSet.getString("img");
                String blog_name = resultSet.getString("blog_name");
                String created_at = resultSet.getString("created_at");
                int categoryID = resultSet.getInt("categoryID");
                 int status = resultSet.getInt(8);
                Blog pr = new Blog(id, role_id, content, img, blog_name, created_at, categoryID  ,status);
                blog.add(pr);
            }
           
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }

// chỉnh sửa định dạng date sang String
    private String convertDateToString(Date dateValue) {
        SimpleDateFormat newFormatter = new SimpleDateFormat("dd/MM/yyyy");
        return newFormatter.format(dateValue);
    }
// chỉnh sửa định dạng String sang Date
    public static Date convertStringToDate(String dateString) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return formatter.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
    public static void main(String[] args) {
//
        String name = "";
        BlogDAO dao = new BlogDAO();
        ProductDAO daa = new ProductDAO();
        List<Blog> allblog = dao.findAll();
////        List<Product> allpro = daa.findAll();
////        List<Object> parameters = new ArrayList<>();
//        List<Blog> topblog = dao.getTop3Newest();       
//            String bid = "1";    
//            int id=Integer.parseInt(bid);
//            Blog blog = dao.getBlogById(id);
//           
List<Blog> search= dao.getBlogBySearch("bừng");
// List<Blog> blogs=  dao.addNewBlog(1, "Test content", "test.jpg", "Test Title", "2023-06-20", 2);
////    protected List<T> queryGenericDAO(Class<T> clazz, String sql, Map<String, Object> parameterHashmap) {
////  Define the SQL query to fetch products by name
////    
        System.out.println(allblog);
//        
////     Create a HashMap to store parameters
////    Map<String, Object> parameterMap = new HashMap<>();
////    parameterMap.put("name", name);
//// Truy xuất danh mục để cập nhật (thay thế bằng ID thực tế)
////        int categoryIdToUpdate = 1; // Thay thế bằng ID của danh mục bạn muốn cập nhật
////        String sql = "SELECT * FROM products WHERE id = " + categoryIdToUpdate;
//////        Blog categoryToUpdate = (Blog) dao.queryGenericDAO(Blog.class,sql, parameterMap);
//
////        if (categoryToUpdate != null) {
////            // Cập nhật thuộc tính danh mục
////            
////
////            System.out.println("Danh mục được cập nhật thành công!");
////        } else {
////            System.out.println("Không tìm thấy danh mục có ID " + categoryIdToUpdate + "!");
////        }
////
////        for (Blog category1 : allblog) {
////            System.out.println(category1);
////        }
    }
}
