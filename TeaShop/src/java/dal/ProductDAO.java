/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Category;
import entity.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HoangNX
 */
public class ProductDAO extends DBContext {

    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        Category category = null;
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "select * from Product";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(resultSet.getInt("category_id")));
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setCategory(category);
                product.setImage(image);
                product.setPrice(price);
                product.setDiscount(discount);
                product.setCreate_at(create_at);
                //add to collections
                list.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return list;
    }

    private String getSortQuery(String sort) {
        switch (sort) {
            case "create_at":
                return " ORDER BY create_at DESC";
            case "product_id":
                return " ORDER BY product_id";
            case "reduced_price":
                return "ORDER BY price DESC";
            case "increase_price":
                return "ORDER BY price ASC";
            default:
                return " ORDER BY product_id";
        }
    }

    public List<Product> findProductByCategoryId(String categoryId, int page, String sort) {
        List<Product> list = new ArrayList<>();
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Product]\n"
                + "  Where category_id = ?\n"
                + getSortQuery(sort)
                + "  OFFSET ? ROWS \n" //(Page - 1) * numberRecord/page
                + "  FETCH NEXT ? ROWS ONLY\n"; //numberRecord/page
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters
            statement.setString(1, categoryId);
            statement.setInt(2, (page - 1) * 6);
            statement.setInt(3, 6);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();

                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                int category_id = resultSet.getInt("category_id");
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setCategory((new CategoryDAO()).getCategoryById(category_id));
                product.setImage(image);
                product.setPrice(price);
                product.setDiscount(discount);
                product.setCreate_at(create_at);
                //add to collections
                list.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return list;
    }

    public void updateSalesNumber(int productId, int quantity) {
        connection = getConnection();
        PreparedStatement stm = null;
        String sql = "UPDATE Product SET sales_numbers = sales_numbers + ? WHERE product_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, quantity);
            stm.setInt(2, productId);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> findProductByName(String keyword, int page, String sort) {
        List<Product> list = new ArrayList<>();
        Category category = null;
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Product]\n"
                + "  Where product_name like ?\n"
                + getSortQuery(sort)
                + "  OFFSET ? ROWS \n" //(Page - 1) * numberRecord/page
                + "  FETCH NEXT ? ROWS ONLY\n"; //numberRecord/page;
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters
            statement.setString(1, "%" + keyword + "%");
            statement.setInt(2, (page - 1) * 6);
            statement.setInt(3, 6);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();

                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(resultSet.getInt("category_id")));
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setCategory(category);
                product.setImage(image);
                product.setPrice(price);
                product.setDiscount(discount);
                product.setCreate_at(create_at);
                //add to collections
                list.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return list;

    }

    public List<Product> getProductByKeyWords(String keyword) {
        List<Product> products = new ArrayList<>();
        Category category = null;
        connection = getConnection();
        String sql = "SELECT * FROM [dbo].[Product] WHERE product_name LIKE ?\n";

        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters
            statement.setString(1, "%" + keyword + "%");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(resultSet.getInt("category_id")));
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");

                //add to collections
                products.add(new Product(product_id, product_name, category, image, price, discount, create_at, image));
            }
            return products;
        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return null;
    }

    public List<Product> findProductByPriceRange(int priceFrom, int priceTo, int page, String sort) {
        List<Product> list = new ArrayList<>();
        connection = getConnection();
        Category category = null;
        String sql = "SELECT *\n"
                + "FROM [TeaShop].[dbo].[Product]\n"
                + "WHERE price - (discount / 100.0 * price) >= ? AND price - (discount / 100.0 * price) <= ?\n"
                + getSortQuery(sort)
                + "  OFFSET ? ROWS \n"
                + "  FETCH NEXT ? ROWS ONLY\n"; //numberRecord/page;
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, priceFrom);
            statement.setInt(2, priceTo);
            statement.setInt(3, (page - 1) * 6);
            statement.setInt(4, 6);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();

                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(resultSet.getInt("category_id")));
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setCategory(category);
                product.setImage(image);
                product.setPrice(price);
                product.setDiscount(discount);
                product.setCreate_at(create_at);
                //add to collections
                list.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());
        }

        return list;
    }

    public List<Product> getProductByPriceRange(int priceFrom, int priceTo) {
        List<Product> list = new ArrayList<>();
        connection = getConnection();
        Category category = null;
        String sql = "SELECT  *\n"
                + "  FROM [TeaShop].[dbo].[Product]\n"
                + "  Where price >= ? AND price <= ?";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, priceFrom);
            statement.setInt(2, priceTo);

            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();

                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(resultSet.getInt("category_id")));
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setCategory(category);
                product.setImage(image);
                product.setPrice(price);
                product.setDiscount(discount);
                product.setCreate_at(create_at);
                //add to collections
                list.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());
        }

        return list;
    }

    public List<Product> findByPage(int page, String sort) {
        List<Product> list = new ArrayList<>();
        connection = getConnection();
        Category category = null;
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Product]\n"
                + getSortQuery(sort)
                + "  OFFSET ? ROWS \n"
                + "  FETCH NEXT ? ROWS ONLY\n";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (page - 1) * 6);
            statement.setInt(2, 6);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();

                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(resultSet.getInt("category_id")));
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setCategory(category);
                product.setImage(image);
                product.setPrice(price);
                product.setDiscount(discount);
                product.setCreate_at(create_at);
                //add to collections
                list.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return list;

    }

    public int findTotalRecordByCategoryId(String categoryId) {
        int total = 0;
        connection = getConnection();
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Product]\n"
                + "  where category_id = ?";
        try {

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, categoryId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }

        return total;
    }

    public int findTotalRecordByName(String keyword) {
        int total = 0;
        connection = getConnection();
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Product]\n"
                + "  where product_name like ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());
        }
        return total;
    }

    public int findTotalRecordByPriceRange(int priceFrom, int priceTo) {
        int total = 0;
        connection = getConnection();
        String sql = "SELECT  count(*)\n"
                + "  FROM [TeaShop].[dbo].[Product]\n"
                + "WHERE price - (discount / 100.0 * price) >= ? AND price - (discount / 100.0 * price) <= ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, priceFrom);
            statement.setInt(2, priceTo);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return total;
    }

    public int findTotalRecord() {
        int total = 0;
        connection = getConnection();
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Product]";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());
        }
        return total;
    }

    public List<Product> specialProduct() {
        List<Product> list = new ArrayList<>();
        //ket noi duoc voi database
        connection = getConnection();
        Category category = null;
        //co cau lenh de goi xuong database
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Product]\n"
                + "  WHERE product_id IN (21, 13, 1);";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();

                int product_id = resultSet.getInt("product_id");
                String product_name = resultSet.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(resultSet.getInt("category_id")));
                String image = resultSet.getString("image");
                int price = resultSet.getInt("price");
                float discount = resultSet.getFloat("discount");
                Date create_at = resultSet.getDate("create_at");
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setCategory(category);
                product.setImage(image);
                product.setPrice(price);
                product.setDiscount(discount);
                product.setCreate_at(create_at);
                //add to collections
                list.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());
        }

        return list;
    }

    public Product getProductsById(int productId) {
        connection = getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        Product product = null;
        Category category = null;
        String sql = "select * from [Product] where product_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, productId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String product_name = rs.getString("product_name");
                category = ((new CategoryDAO()).getCategoryById(rs.getInt("category_id")));
                String image = rs.getString("image");
                int price = rs.getInt("price");
                Date create_at = rs.getDate("create_at");
                float discount = rs.getFloat("discount");
                String description = rs.getString("description");

                product = new Product(product_id, product_name, category, image, price, discount, create_at, description);
            }
            return product;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int insertProduct(Product p) {
        connection = getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        int generatedId = -1;
        String sql = "INSERT INTO [dbo].[Product]\n"
                + "           ([product_name]\n"
                + "           ,[category_id]\n"
                + "           ,[image]\n"
                + "           ,[price]\n"
                + "           ,[discount]\n"
                + "           ,[create_at]\n"
                + "           ,[description])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?)";
        try {
            stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setString(1, p.getProduct_name());
            stm.setInt(2, p.getCategory().getCategory_id());
            stm.setString(3, p.getImage());
            stm.setInt(4, p.getPrice());
            stm.setFloat(5, p.getDiscount());
            stm.setDate(6, new java.sql.Date(p.getCreate_at().getTime()));
            stm.setString(7, p.getDescription());
            stm.executeUpdate();

            //get generatedId
            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
       // connection.close();
        return generatedId;
    }

    public void updateProduct(Product p, int pid) {
        connection = getConnection();
        PreparedStatement stm = null;

        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [product_name] = ?\n"
                + "      ,[category_id] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[create_at] = ?\n"
                + "      ,[description] = ?\n"
                + "	  ,[image] = ?\n"
                + " WHERE product_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, p.getProduct_name());
            stm.setInt(2, p.getCategory().getCategory_id());
            stm.setInt(3, p.getPrice());
            stm.setDate(4, new java.sql.Date(p.getCreate_at().getTime()));
            stm.setString(5, p.getDescription());
            stm.setString(6, p.getImage());
            stm.setInt(7, pid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateDiscount(Product p, int pid) {
        connection = getConnection();
        PreparedStatement stm = null;

        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [product_name] = ?\n"
                + "      ,[category_id] = ?\n"
                + "      ,[price] = ?\n"
                + "	 ,[discount] = ?\n"
                + " WHERE product_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, p.getProduct_name());
            stm.setInt(2, p.getCategory().getCategory_id());
            stm.setInt(3, p.getPrice());
            stm.setFloat(4, p.getDiscount());
            stm.setInt(5, pid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int deleteProduct(int id) {
        connection = getConnection();
        int n = 0;
        PreparedStatement stm = null;

        String sql = "DELETE FROM [dbo].[Product]\n"
                + "      WHERE product_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);

            n = stm.executeUpdate();

        } catch (SQLException ex) {
            n = -1;
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public static void main(String[] args) {

        ProductDAO productDAO = new ProductDAO();

        int priceFrom = 40000; // giá tối thiểu
        int priceTo = 50000;   // giá tối đa

        List<Product> products = productDAO.getProductByPriceRange(priceFrom, priceTo);

        if (products.isEmpty()) {
            System.out.println("No products found in the given price range.");
        } else {
            for (Product product : products) {
                System.out.println("Product ID: " + product.getProduct_id());
                System.out.println("Product Name: " + product.getProduct_name());
                System.out.println("Category: " + product.getCategory().getCategory_name());
                System.out.println("Image: " + product.getImage());
                System.out.println("Price: " + product.getPrice());
                System.out.println("Discount: " + product.getDiscount());
                System.out.println("Create Date: " + product.getCreate_at());
                System.out.println("---------------------------------------");
            }
        }
    }

}
