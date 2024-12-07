/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Accounts;
import entity.Category;
import entity.OrderDetails;
import entity.Product;
import entity.Topping;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HuyTD
 */
public class OrderDetailsDAO extends DBContext {
    
    public List<OrderDetails> getOrderDetailByAccountIDAndStatusFeedbackID(int account_id, int status_feedback_id) {
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        OrderDetails orderdetail = null;
        try {
            connection = getConnection();
            String query = "SELECT od.[order_details_id]\n"
                    + "      ,od.[product_id]\n"
                    + "      ,od.[order_id]\n"
                    + "      ,od.[quantity]\n"
                    + "      ,od.[status_feedback_id]\n"
                    + "FROM [dbo].[OrderDetails] od\n"
                    + "JOIN [dbo].[Orders] o ON od.[order_id] = o.[order_id]\n"
                    + "WHERE o.[status_id] = 4\n"
                    + "  AND o.[account_id] = ?\n"
                    + "  AND od.[status_feedback_id] = ?;";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, account_id);
            
            ps.setInt(2, status_feedback_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orderdetail = new OrderDetails();
            orderdetail.setOrder_details_id(rs.getInt("order_details_id"));
            orderdetail.setProduct(new ProductDAO().getProductsById(rs.getInt("product_id")));
            orderdetail.setQuantity(rs.getInt("quantity"));
            
            orderdetail.setStatus_feedback_id(rs.getInt("status_feedback_id"));
            orderdetail.setOrders(new OrdersDAO().findByOrderId(rs.getInt("order_id")));
            orderDetailsList.add(orderdetail);
            }
        rs.close(); // Close ResultSet
            ps.close(); // Close PreparedStatement
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return orderDetailsList;
    }

    public List<OrderDetails> findByOrderId(int orderId) {
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        Connection connection = getConnection(); // Obtain database connection
        String sql = "SELECT * FROM OrderDetails WHERE order_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, orderId); // Set the order ID parameter
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                OrderDetails orderDetails = new OrderDetails();
                orderDetails.order_details_id = rs.getInt("order_details_id");
                orderDetails.setProduct(new ProductDAO().getProductsById(rs.getInt("product_id")));
                orderDetails.setOrders(new OrdersDAO().findByOrderId(rs.getInt("order_id")));
                orderDetails.image = rs.getString("image");
                orderDetails.image_after_ship = rs.getString("image_after_ship");
                orderDetails.quantity = rs.getInt("quantity");
                orderDetails.setStatus_feedback_id(rs.getInt("status_feedback_id"));
                orderDetails.topping = getToppingNamesByOrderDetailId(orderDetails.order_details_id);
                orderDetailsList.add(orderDetails); // Add the order details to the list
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }

        return orderDetailsList; // Return the list of order details
    }
    /**
     * Finds order details by order ID.
     *
     * @param orderId The ID of the order for which to retrieve order details.
     * @return A list of OrderDetails objects associated with the given order
     * ID.
     */
    public void updateImagePath(int orderDetailsId, String imagePath) {
    String query = "UPDATE OrderDetails SET image_after_ship = ? WHERE order_details_id = ?";
    try (Connection connection = getConnection();
         PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, imagePath);
        ps.setInt(2, orderDetailsId);
        ps.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}

    public String getCategoryNameById(int category_id) {
        String sql = "select category_name from Category where category_id=?";
        connection = getConnection(); // Obtain database connection
        String categoryName = null;

        try {
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, category_id); // Set the product_id parameter
            ResultSet rs = pre.executeQuery();

            if (rs.next()) { // Check if a result is found
                categoryName = rs.getString("category_name");
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the connection in the finally block to ensure it's closed even if an exception occurs
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return categoryName; // Return the product entity
    }

    public List<Topping> getToppingNamesByOrderDetailId(int order_details_id) {
        String sql = "SELECT ToppingDetails.topping_id,topping_name FROM Topping JOIN ToppingDetails ON Topping.topping_id = ToppingDetails.topping_id WHERE order_details_id = ?";
        connection = getConnection(); // Obtain database connection
        List<Topping> toppingList = new ArrayList<>();

        try {
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, order_details_id); // Set the order_details_id parameter
            ResultSet rs = pre.executeQuery();

            while (rs.next()) { // Iterate through results
                Topping topping = new Topping();
                topping.topping_id = rs.getInt("topping_id");
                topping.topping_name = rs.getString("topping_name");
                toppingList.add(topping);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the connection in the finally block to ensure it's closed even if an exception occurs
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return toppingList; // Return the list of topping names
    }

    /**
     * Retrieves detailed information about an order.
     *
     * @param orderId The ID of the order for which to retrieve detailed
     * information.
     * @return A list of string arrays, each containing detailed information
     * about a product in the order.
     */
    public List<OrderDetails> getinfo(int orderId) {
        List<OrderDetails> infoList = new ArrayList<>();
        connection = getConnection(); // Obtain database connection
        String sql = "SELECT order_details_id, p.product_id, p.image, product_name, category_id, price, quantity "
                + "FROM OrderDetails od "
                + "JOIN Product p ON od.product_id = p.product_id "
                + "WHERE order_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, orderId); // Set the order ID parameter
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                OrderDetails orderDetails = new OrderDetails();
                orderDetails.setCategory(new Category());
                orderDetails.setProduct(new Product());
                orderDetails.setTopping(new ArrayList<>());

                orderDetails.order_details_id = rs.getInt("order_details_id");
                orderDetails.getProduct().setProduct_id(rs.getInt("product_id"));
                orderDetails.getProduct().setImage(rs.getString("image"));
                orderDetails.getProduct().setProduct_name(rs.getString("product_name"));
                orderDetails.getCategory().setCategory_name(getCategoryNameById(rs.getInt("category_id")));
                orderDetails.getProduct().setPrice(rs.getInt("price"));
                orderDetails.setQuantity(rs.getInt("quantity"));
                orderDetails.topping = getToppingNamesByOrderDetailId(orderDetails.order_details_id);

                infoList.add(orderDetails);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }

        return infoList; // Return the list of detailed information
    }

    /**
     * Retrieves account information associated with a specific order.
     *
     * @param orderId The ID of the order for which to retrieve account
     * information.
     * @return An array of strings containing account information: full name,
     * gender, email, and phone number.
     */
    public Accounts accInfo(int orderId) {
        Accounts info = new Accounts();
        connection = getConnection(); // Obtain database connection
        String sql = "SELECT a.gender, a.email, a.phone_number FROM Orders o "
                + "JOIN Accounts a ON o.account_id = a.account_id WHERE o.order_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, orderId); // Set the order ID parameter
            ResultSet rs = pre.executeQuery();

            if (rs.next()) {
                // Populate the Accounts object with data from the ResultSet
                info.setGender(rs.getString("gender"));
                info.setEmail(rs.getString("email"));
                info.setPhone_number(rs.getString("phone_number"));
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException ex) {
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, e);
            }
        }

        return info; // Return the account information object
    }

    public List<OrderDetails> getAllOrderDetails() {
        List<OrderDetails> list = new ArrayList<>();
        String query = "SELECT od.order_details_id, od.product_id, od.order_id, od.quantity, "
                + "p.product_name, c.category_name, t.topping_id, t.topping_name "
                + "FROM OrderDetails od "
                + "JOIN Product p ON od.product_id = p.product_id "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "LEFT JOIN ToppingDetails td ON od.order_details_id = td.order_details_id "
                + "LEFT JOIN Topping t ON td.topping_id = t.topping_id";

        try {
            connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                OrderDetails orderDetails = new OrderDetails();
                orderDetails.setOrder_details_id(resultSet.getInt("order_details_id"));
                orderDetails.setProduct(new ProductDAO().getProductsById(resultSet.getInt("product_id")));
                orderDetails.setOrders(new OrdersDAO().findByOrderId(resultSet.getInt("order_id")));
                orderDetails.setQuantity(resultSet.getInt("quantity"));

                Product product = new Product();
                product.setProduct_name(resultSet.getString("product_name"));
                orderDetails.setProduct(product);

                Category category = new Category();
                category.setCategory_name(resultSet.getString("category_name"));
               

                List<Topping> toppings = new ArrayList<>();
                do {
                    if (resultSet.getString("topping_name") != null) {
                        Topping topping = new Topping();
                        topping.setTopping_id(resultSet.getInt("topping_id"));
                        topping.setTopping_name(resultSet.getString("topping_name"));
                        toppings.add(topping);
                    }
                } while (resultSet.next() && resultSet.getInt("order_details_id") == orderDetails.getOrder_details_id());

                orderDetails.setTopping(toppings);
                list.add(orderDetails);
                resultSet.previous();
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

    public void insertToppingDetails(int orderDetailsId, int toppingId) {
        String insertSQL = "INSERT INTO [dbo].[ToppingDetails] ([order_details_id], [topping_id]) VALUES (?, ?)";

        try {
            connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(insertSQL);

            // Set the parameters for the query
            statement.setInt(1, orderDetailsId);
            statement.setInt(2, toppingId);

            // Execute the update
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public int insertOrderDetails(int productId, int orderId, int quantity) {
        String insertSQL = "INSERT INTO [dbo].[OrderDetails] ([product_id], [order_id], [quantity], [status_feedback_id]) VALUES (?, ?, ?, ?)";
        int orderDetailsId = -1; // Default value if insertion fails

        try {
            connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);

            // Set the parameters for the query
            statement.setInt(1, productId);
            statement.setInt(2, orderId);
            statement.setInt(3, quantity);
            statement.setInt(4, 2);

            // Execute the update
            int affectedRows = statement.executeUpdate();

            if (affectedRows > 0) {
                // Retrieve the generated key
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderDetailsId = generatedKeys.getInt(1);
                }
            }

            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return orderDetailsId;
    }

    public int retrieveToppingIdByName(String topping_name) {
        int toppingId = 0;
        String sql = "SELECT topping_id FROM Topping WHERE topping_name = ?";

        try {
            connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, topping_name);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                toppingId = resultSet.getInt("topping_id");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            // Handle exception appropriately, log or throw further
        }
        return toppingId;
    }

    public void updateImageBeforePath(int orderDetailsId, String imagePath) {
    String query = "UPDATE OrderDetails SET image = ? WHERE order_details_id = ?";
    try (Connection connection = getConnection();
         PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, imagePath);
        ps.setInt(2, orderDetailsId);
        ps.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }}
}
