package dal;

import dal.DBContext;
import entity.Accounts;
import entity.OrderChart;
import entity.Orders;
import entity.Product;
import entity.Status;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Date;
import java.util.Vector;

/**
 * Data Access Object cho Orders.
 */
public class OrdersDAO extends DBContext {

    public int insertOrder(Integer accountId, String orderDate, String estimatedDeliveryDate, int totalAmount, int statusId, String note, String paymentMethod, String phoneNumber, String fullName, String address, String vnp_TxnRef) {
        String insertSQL = "INSERT INTO [dbo].[Orders] ([account_id], [order_date], [estimated_delivery_date], [total_amount], [status_id], [note], [payment_method], [phone_number], [full_name], [address] ,[vnp_TxnRef]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int orderId = -1; // Default value if insertion fails

        try {
            connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);

            // Set the parameters for the query
            if (accountId == null) {
                statement.setNull(1, Types.INTEGER);
            } else {
                statement.setInt(1, accountId);
            }
            statement.setString(2, orderDate);
            statement.setString(3, estimatedDeliveryDate);
            statement.setInt(4, totalAmount);
            statement.setInt(5, statusId);
            statement.setString(6, note);
            statement.setString(7, paymentMethod);
            statement.setString(8, phoneNumber);
            statement.setString(9, fullName);
            statement.setString(10, address);
            statement.setString(11, vnp_TxnRef);

            // Execute the update
            int affectedRows = statement.executeUpdate();

            if (affectedRows > 0) {
                // Retrieve the generated key
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
                }
            }

            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return orderId;
    }

    public List<Orders> getAllListOrder() {
        List<Orders> ordersList = new ArrayList<>();
        Orders order = null;
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "select * from Orders";
        try {
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {

                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));
                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders

    }

    /**
     * Finds orders by account ID.
     *
     * @param accountId The ID of the account for which to retrieve orders.
     * @return A list of orders associated with the given account ID.
     */
    public List<Orders> findByAccountId(int accountId, int page) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order;

        int pageSize = 12; // Number of orders per page
        int offset = (page - 1) * pageSize; // Calculate the offset

        String sql = "SELECT * \n"
                + "FROM Orders \n"
                + "WHERE account_id = ? \n"
                + "ORDER BY order_date DESC \n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try {
            connection = getConnection(); // Obtain database connection
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, accountId); // Set the account ID parameter
            pre.setInt(2, offset);
            pre.setInt(3, pageSize);

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date"));
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));
                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders
    }

    public List<Orders> findByAccountIdAndStatusId(int accountId, int statusId, int page) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order;

        int pageSize = 12; // Number of orders per page
        int offset = (page - 1) * pageSize; // Calculate the offset

        String sql = "SELECT * \n"
                + "FROM Orders \n"
                + "WHERE account_id = ? \n"
                + "  AND status_id = ? \n"
                + "ORDER BY order_date DESC \n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try {
            connection = getConnection(); // Obtain database connection
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, accountId); // Set the account ID parameter
            pre.setInt(2, statusId); // Set the status ID parameter
            pre.setInt(3, offset);
            pre.setInt(4, pageSize);

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date"));
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));
                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders
    }

    /**
     * Finds an order by order ID.
     *
     * @param orderId The ID of the order to retrieve.
     * @return The order associated with the given order ID, or null if not
     * found.
     */
    public Orders findByOrderId(int orderId) {
        Orders order = null;
        connection = getConnection(); // Obtain database connection
        String sql = "SELECT * FROM Orders WHERE order_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderId); // Set the order ID parameter
            ResultSet rs = pre.executeQuery();

            if (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setShipper_delivery_time(rs.getTimestamp("shipper_delivery_time"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.full_name = rs.getString("full_name");
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));

            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return order; // Return the order object
    }

    public void updateOrderStatus(int orderId, int statusId) {
        connection = getConnection();
        String sql = "UPDATE Orders SET status_id = ? WHERE order_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, statusId);
            pre.setInt(2, orderId);
            pre.executeUpdate();
            pre.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Orders> getOrderByStatusCompeleteAndAccountID(int account_id) {
        List<Orders> ordersList = new ArrayList<>();
        connection = getConnection();
        Orders order = null;
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Orders]\n"
                + "  Where status_id = 3 and account_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, account_id);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {

                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));
                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }

        return ordersList;
    }

    public List<Orders> getOrderByStatusCompeleteAndAccountIDAndFeedback(int account_id, int statusFeedback) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order = null;
        try {
            connection = getConnection(); // get connection to your database
            String query = "SELECT * FROM Orders WHERE account_id = ? AND status_id = ? AND status_feedback_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, account_id);
            ps.setInt(2, 3);
            ps.setInt(3, statusFeedback);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));

                ordersList.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ordersList;
    }

    

    public void updateDeliveryTime(int orderId, Timestamp deliveryTime) {
        String query = "UPDATE Orders SET estimated_delivery_date = ? WHERE order_id = ?";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setTimestamp(1, deliveryTime);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateShipperNote(int orderId, String shipperNote) {

        String query = "UPDATE Orders SET shipper_note = ? WHERE order_id = ?";
        try {

            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, shipperNote);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public void updateStaffNote(int orderId, String staffNote) {

        String query = "UPDATE Orders SET staff_note = ? WHERE order_id = ?";
        try {

            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, staffNote);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    //huydx
    public Vector<OrderChart> get7OrderChartByMonth() {
        connection = getConnection();
        Vector<OrderChart> vector = new Vector<>();
        String query = "DECLARE @Today DATE = GETDATE();\n"
                + "DECLARE @OneMonthAgo DATE = DATEADD(WEEK, -8, GETDATE() );\n"
                + "\n"
                + "SELECT \n"
                + "    O.order_date AS date,\n"
                + "    COUNT(CASE WHEN O.status_id != 0 THEN 1 END) AS done_order,\n"
                + "    COUNT(*) AS total_order,\n"
                + "       CASE WHEN COUNT(*) > 0 THEN COUNT(CASE WHEN O.status_id != 0 THEN 1 END) * 100.0 / COUNT(*) ELSE 0 END AS success_rate,\n"
                + "    SUM(O.total_amount) AS revenue\n"
                + "FROM \n"
                + "    [dbo].[Orders] O\n"
                + "JOIN \n"
                + "    [dbo].[OrderDetails] OD ON O.order_id = OD.order_id\n"
                + "WHERE \n"
                + "    O.order_date >= @OneMonthAgo \n"
                + "    AND O.order_date < @Today\n"
                + "    AND O.status_id != 0  -- Excluding orders with status_id = 0\n"
                + "GROUP BY \n"
                + "    O.order_date\n"
                + "ORDER BY \n"
                + "    O.order_date;";

        try (Connection connection = getConnection();
                PreparedStatement st = connection.prepareStatement(query);
                ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                vector.add(new OrderChart(rs.getDate("date"),
                        rs.getInt("done_order"),
                        rs.getInt("total_order"),
                        rs.getDouble("success_rate"),
                        rs.getDouble("revenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vector;
    }

    public Vector<OrderChart> get7OrderChartByDay() {
    Vector<OrderChart> vector = new Vector<>();
    String query = "SELECT \n"
                 + "    CONVERT(DATE, O.order_date) AS date,\n"
                 + "    COUNT(CASE WHEN O.status_id != 0 THEN 1 END) AS done_order,\n"
                 + "    COUNT(*) AS total_order,\n"
                 + "    CASE WHEN COUNT(*) > 0 THEN \n"
                 + "        COUNT(CASE WHEN O.status_id != 0 THEN 1 END) * 100.0 / COUNT(*) \n"
                 + "    ELSE \n"
                 + "        0 \n"
                 + "    END AS success_rate,\n"
                 + "    SUM(O.total_amount) AS revenue\n"
                 + "FROM \n"
                 + "    dbo.Orders O\n"
                 + "WHERE \n"
                 + "    O.order_date >= DATEADD(day, -7, GETDATE())\n"
                 + "GROUP BY \n"
                 + "    CONVERT(DATE, O.order_date)\n"
                 + "ORDER BY \n"
                 + "    date DESC;";

    try (Connection connection = getConnection(); 
         PreparedStatement st = connection.prepareStatement(query); 
         ResultSet rs = st.executeQuery()) {

        while (rs.next()) {
            vector.add(new OrderChart(
                rs.getDate("date"),
                rs.getInt("done_order"),
                rs.getInt("total_order"),
                rs.getDouble("success_rate"),
                rs.getDouble("revenue")
            ));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return vector;
}


    public boolean checkDuplicatevnp_TxnRef(String vnp_TxnRef) {
        boolean flag = false;

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT [vnp_TxnRef] FROM [dbo].[Orders] WHERE vnp_TxnRef IS NOT NULL";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String existingVnpTxnRef = resultSet.getString("vnp_TxnRef");
                if (vnp_TxnRef.equals(existingVnpTxnRef)) {
                    flag = true;
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }

    public void updateShipperDeliveryTime(int orderId, Timestamp shipperDeliveryTime) {
        String sql = "UPDATE Orders SET shipper_delivery_time = ? WHERE order_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, shipperDeliveryTime);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int numberOfOrder() {
        int orderCount = 0; // Initialize the count variable

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT COUNT([order_id]) AS order_count FROM [dbo].[Orders]";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Retrieve the count from the result set
            if (resultSet.next()) {
                orderCount = resultSet.getInt("order_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderCount; // Return the count
    }

    public int numberOfOrderWithStatusId(int status_id) {
        int orderCount = 0; // Initialize the count variable

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT COUNT([order_id]) AS order_count FROM [dbo].[Orders] WHERE status_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, status_id); // Set the status_id parameter
            ResultSet resultSet = preparedStatement.executeQuery();

            // Retrieve the count from the result set
            if (resultSet.next()) {
                orderCount = resultSet.getInt("order_count");
            }

            resultSet.close(); // Close ResultSet
            preparedStatement.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderCount; // Return the count
    }

    public int numberOfOrderWithAccountId(int accountId) {
        int orderCount = 0; // Initialize the count variable

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT COUNT(order_id) AS order_count FROM Orders WHERE account_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, accountId); // Set the account_id parameter
            ResultSet resultSet = preparedStatement.executeQuery();

            // Retrieve the count from the result set
            if (resultSet.next()) {
                orderCount = resultSet.getInt("order_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderCount; // Return the count
    }

    public int numberOfOrderWithAccountIdAndStatusId(int accountId, int statusId) {
        int orderCount = 0; // Initialize the count variable

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT COUNT(order_id) AS order_count FROM Orders WHERE account_id = ? AND status_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, accountId); // Set the account_id parameter
            preparedStatement.setInt(2, statusId); // Set the status_id parameter
            ResultSet resultSet = preparedStatement.executeQuery();

            // Retrieve the count from the result set
            if (resultSet.next()) {
                orderCount = resultSet.getInt("order_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderCount; // Return the count
    }

    public List<Orders> findOrdersStatusId(int statusId, int page, int shiper_id) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order = null;
        String sql = "SELECT * FROM Orders \n"
                + "WHERE status_id = ? and shiper_id = ?\n"
                + "ORDER BY order_id";

        // Thay đổi ORDER BY nếu status_id là 4 hoặc 5
        if (statusId == 4 || statusId == 5) {
            sql += " DESC";
        }

        sql += "\nOFFSET ? ROWS \n"
                + "FETCH NEXT ? ROWS ONLY";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, statusId);
            pre.setInt(2, shiper_id);
            pre.setInt(3, (page - 1) * 6);
            pre.setInt(4, 6);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));

                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders
    }

    public int findTotalRecordByStatusId(int status_id) {
        int total = 0;
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Orders]\n"
                + "  where status_id = ?";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters

            statement.setInt(1, status_id);
            //thuc thi cau lenh o tren => tra ve ket qua
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
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Orders]";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);

            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }

        return total;

    }

    public List<Orders> findOrdersOrderId(String orderId, int shiper_id) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order = null;
        String sql = "SELECT * FROM Orders \n"
                + "WHERE order_id = ? and shiper_id = ?\n";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setString(1, orderId);
            pre.setInt(2, shiper_id);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));

                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders
    }

    public int findTotalRecordByStatusIdAndOrderId(int statusOrder, String orderId) {
        int total = 0;
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Orders]\n"
                + "  where status_id = ?";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters

            statement.setInt(1, statusOrder);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }

        return total;
    }

    public List<Orders> findOrdersUserName(String key_word, int page, int shiper_id) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order = null;
        String sql = "SELECT * FROM Orders \n"
                + "Where full_name like ? and shiper_id= ? \n"
                + "ORDER BY order_id\n"
                + "OFFSET ? ROWS \n"
                + "FETCH NEXT ? ROWS ONLY";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setString(1, "%" + key_word + "%");
             pre.setInt(2, shiper_id);
            pre.setInt(3, (page - 1) * 6);
            pre.setInt(4, 6);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));

                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders    }
    }

    public int findTotalRecordByUserName(String key_word) {
        int total = 0;
        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Orders]\n"
                + "  Where full_name like ?";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters

            statement.setString(1, "%" + key_word + "%");
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }

        return total;
    }


    public List<Orders> findOrderByShiperId(int shipper_id) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order = null;
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Orders] where shiper_id = ?";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, shipper_id);

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.setOrder_id(rs.getInt("order_id"));

                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.setStatus(new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.setTotal_amount(rs.getInt("total_amount"));
                order.setOrder_date(rs.getTimestamp("order_date")); // Set order_date directly
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.setAddress(rs.getString("address"));
                order.setFull_name(rs.getString("full_name"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setPhone_number(rs.getString("phone_number"));

                ordersList.add(order);
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders    }
    }

    public void UpdateShiper_IdByOrder_Id(int order_id, int shipper_id) {
        connection = getConnection();
        PreparedStatement stm = null;
        String sql = "UPDATE [dbo].[Orders]\n"
                + "   SET \n"
                + "      [shiper_id] = ?\n"
                + " WHERE order_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, shipper_id);
            stm.setInt(2, order_id);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getShipperIdByOrderId(int orderId) {
        String shipper_id = null;
        String sql = "SELECT \n"
                + "     [shiper_id]\n"
                + "  FROM [dbo].[Orders]\n"
                + "  Where order_id = ?";
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, orderId);

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
               
               shipper_id = rs.getString("shiper_id");

                
            }

            rs.close(); // Close ResultSet
            pre.close(); // Close PreparedStatement
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { // Catch any parsing exceptions
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close the database connection
                }
            } catch (SQLException e) {
                Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return shipper_id;
    }
;

}
