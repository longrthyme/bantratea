/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Orders;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author This PC
 */
public class StaffDAO extends DBContext {

    public List<Orders> getAllOrder(int page) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order;

        int pageSize = 10; // Number of orders per page
        int offset = (page - 1) * pageSize; // Calculate the offset

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT * \n"
                    + "FROM Orders \n"
                    + "ORDER BY order_date ASC \n"
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, offset);
            pre.setInt(2, pageSize);

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.order_id = rs.getInt("order_id");
                
                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.phone_number = rs.getString("phone_number");
                order.full_name = rs.getString("full_name");
                order.status = (new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.orderDetails = (new OrderDetailsDAO().findByOrderId(rs.getInt("order_id")));
                order.total_amount = rs.getInt("total_amount");
                order.setOrder_date(rs.getTimestamp("order_date"));
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setShipper_delivery_time(rs.getTimestamp("shipper_delivery_time"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.payment_method = rs.getString("payment_method");
                order.address = rs.getString("address");
                // order.setAccountShip(new AccountDAO().getAccountByAccountID(rs.getInt("shiper_id")));
                ordersList.add(order);
            }
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
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders
    }

    public List<Orders> getOrderByStatusId(int status_id, int page) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order;

        int pageSize = 10; // Number of orders per page
        int offset = (page - 1) * pageSize; // Calculate the offset

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT * \n"
                    + "FROM Orders \n"
                    + "WHERE status_id = ? \n"
                    + "ORDER BY order_date ASC \n"
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, status_id); // Set the status ID parameter
            pre.setInt(2, offset);
            pre.setInt(3, pageSize);

            ResultSet rs = pre.executeQuery();

            int rowCount = 0;

            if (rs.last()) { // Move cursor to the last row
                rowCount = rs.getRow(); // Get row number (i.e., the row count)
                rs.beforeFirst(); // Move cursor back to the start if you need to iterate again
            }
            System.out.println("Number of rows orders: " + rowCount);
            

            while (rs.next()) {
                order = new Orders();
                order.order_id = rs.getInt("order_id");
                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.status = (new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.orderDetails = (new OrderDetailsDAO().findByOrderId(rs.getInt("order_id")));
                order.total_amount = rs.getInt("total_amount");
                order.setOrder_date(rs.getTimestamp("order_date"));
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setShipper_delivery_time(rs.getTimestamp("shipper_delivery_time"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.phone_number = rs.getString("phone_number");
                order.full_name = rs.getString("full_name");
                order.address = rs.getString("address");
                order.payment_method = rs.getString("payment_method");
                // order.setAccountShip(new AccountDAO().getAccountByAccountID(rs.getInt("shiper_id")));
                ordersList.add(order);
            }
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
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders
    }

    public List<Orders> getOrderByInfo(String full_name, int lowerAmount, int upperAmount, Timestamp lowerDate, Timestamp upperDate, int status_id, String payment_method) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order;

        try {
            connection = getConnection(); // Obtain database connection
            StringBuilder sql = new StringBuilder("SELECT * FROM Orders WHERE 1=1");

            if (full_name != null) {
                sql.append(" AND full_name LIKE ?");;
            }           
            if (lowerAmount > 0) {
                sql.append(" AND total_amount >= ?");
            }
            if (upperAmount > 0) {
                sql.append(" AND total_amount <= ?");
            }
            if (lowerDate != null) {
                sql.append(" AND order_date >= ?");
            }
            if (upperDate != null) {
                sql.append(" AND order_date <= ?");
            }
            if (status_id > 0) {
                sql.append(" AND status_id = ?");
            }
            if (payment_method != null && !payment_method.isEmpty()) {
                sql.append(" AND payment_method = ?");
            }

            PreparedStatement pre = connection.prepareStatement(sql.toString());

            // Set parameter values
            int paramIndex = 1;
            if (full_name != null) {
                pre.setString(paramIndex++, "%" + full_name + "%");
            }
            if (lowerAmount > 0) {
                pre.setInt(paramIndex++, lowerAmount);
            }
            if (upperAmount > 0) {
                pre.setInt(paramIndex++, upperAmount);
            }
            if (lowerDate != null) {
                pre.setTimestamp(paramIndex++, lowerDate);
            }
            if (upperDate != null) {
                pre.setTimestamp(paramIndex++, upperDate);
            }
            if (status_id > 0) {
                pre.setInt(paramIndex++, status_id);
            }
            if (payment_method != null && !payment_method.isEmpty()) {
                pre.setString(paramIndex++, payment_method);
            }

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                order = new Orders();
                order.order_id = rs.getInt("order_id");
                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.status = new StatusDAO().getStatusByStatusID(rs.getInt("status_id"));
                order.orderDetails = new OrderDetailsDAO().findByOrderId(rs.getInt("order_id"));
                order.total_amount = rs.getInt("total_amount");
                order.setOrder_date(rs.getTimestamp("order_date"));
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setShipper_delivery_time(rs.getTimestamp("shipper_delivery_time"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.phone_number = rs.getString("phone_number");
                order.full_name = rs.getString("full_name");
                order.address = rs.getString("address");
                order.payment_method = rs.getString("payment_method");
                ordersList.add(order);
            }
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

    public List<Orders> getOrderByOrderId(int order_id) {
        List<Orders> ordersList = new ArrayList<>();
        Orders order;

        try {
            connection = getConnection(); // Obtain database connection
            String sql = "SELECT * \n"
                    + "FROM Orders \n"
                    + "WHERE order_id = ?";

            PreparedStatement pre = connection.prepareStatement(
                    sql,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pre.setInt(1, order_id); // Set the status ID parameter

            ResultSet rs = pre.executeQuery();

            if (rs.next()) {
                order = new Orders();
                order.order_id = rs.getInt("order_id");
                order.setAccount(new AccountDAO().getAccountByAccountID(rs.getInt("account_id")));
                order.status = (new StatusDAO().getStatusByStatusID(rs.getInt("status_id")));
                order.orderDetails = (new OrderDetailsDAO().findByOrderId(rs.getInt("order_id")));
                order.total_amount = rs.getInt("total_amount");
                order.setOrder_date(rs.getTimestamp("order_date"));
                order.setEstimated_delivery_date(rs.getTimestamp("estimated_delivery_date"));
                order.setShipper_delivery_time(rs.getTimestamp("shipper_delivery_time"));
                order.setNote(rs.getString("note"));
                order.setShipper_note(rs.getString("shipper_note"));
                order.setStaff_note(rs.getString("staff_note"));
                order.phone_number = rs.getString("phone_number");
                order.full_name = rs.getString("full_name");
                order.address = rs.getString("address");
                order.payment_method = rs.getString("payment_method");
                ordersList.add(order);
            }
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
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ordersList; // Return the list of orders
    }

    public boolean updateOrderStatus(int orderId, int newStatusId) {
        connection = null;
        String sql = "UPDATE Orders SET status_id = ? WHERE order_id = ?";
        boolean updateSuccessful = false;

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, newStatusId); // Set the new status ID
            pre.setInt(2, orderId);     // Set the order ID

            int rowsAffected = pre.executeUpdate();
            updateSuccessful = rowsAffected > 0;

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
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return updateSuccessful; // Return whether the update was successful
    }

    public String getVnp_TxnRefFromOrderId(int orderId) {
        String vnp_TxnRef = null; // Initialize the return value
        String sql = "SELECT vnp_TxnRef FROM [dbo].[Orders] WHERE order_id = ?";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderId);

            ResultSet rs = pre.executeQuery(); // Execute the query

            if (rs.next()) {
                vnp_TxnRef = rs.getString("vnp_TxnRef"); // Retrieve the vnp_TxnRef value
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
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return vnp_TxnRef; // Return the retrieved value
    }

    public String getTranscationDateFromOrderId(int orderId) {
        String TranscationDate = null; // Initialize the return value
        String sql = "SELECT order_date FROM [dbo].[Orders] WHERE order_id = ?";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderId);

            ResultSet rs = pre.executeQuery(); // Execute the query

            if (rs.next()) {
                Timestamp orderDate = rs.getTimestamp("order_date"); // Retrieve the order_date
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                TranscationDate = sdf.format(orderDate);
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
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return TranscationDate; // Return the retrieved value
    }
}
