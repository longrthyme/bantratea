/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Feedback;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/**
 *
 * @author HoangPC
 */
public class FeedbackDAO extends DBContext{
    
    public void saveFeedback(int product_id, int account_id, String comment, int rating) {
        connection = getConnection();
        String sql = "INSERT INTO Feedback (product_id, account_id, comment, created_at, rating) VALUES (?, ?, ?, ?, ?)";
        try {
            // Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            // Set the parameters
            statement.setInt(1, product_id);
            statement.setInt(2, account_id);
            statement.setString(3, comment);
            statement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            statement.setInt(5, rating);
            // Thực thi câu lệnh
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        
        }
    }
    public void updateOrderStatusFeedback(int order_details_id) {
        connection = getConnection();
        String sql = "UPDATE OrderDetails SET status_feedback_id = ? WHERE order_details_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, 1);
            statement.setInt(2, order_details_id);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Feedback> getFeedbackList(int id) {
        List<Feedback> feedbackList = new ArrayList<>();
        connection = getConnection();
        String sql = "SELECT * FROM Feedback where product_id = ? ";
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedback_id(resultSet.getInt("feedback_id"));
                feedback.product = (new ProductDAO().getProductsById(resultSet.getInt("product_id")));
                feedback.account = (new AccountDAO().getAccountByAccountID(resultSet.getInt("account_id")));
                feedback.setComment(resultSet.getString("comment"));
                feedback.setCreated_at(resultSet.getTimestamp("created_at"));
                
                // Định dạng thời gian trước khi thêm vào danh sách
                feedback.formatCreatedAt();
                feedback.setRating(resultSet.getInt("rating"));
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error executing SQL: " + e.getMessage());
        
        }
        
        return feedbackList;
    }

    
}