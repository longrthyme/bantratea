/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Accounts;
import entity.HistoryFund;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class HisFundDAO extends DBContext {

    // tìm tất cả thuộc tính 
    public List<HistoryFund> findAll() {

        List<HistoryFund> listHisFund = new ArrayList<>();
        connection = getConnection();
        String sql = "SELECT *\n"
                + "FROM [dbo].[history_fund]\n"
                + "ORDER BY day DESC;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet resultSet = pre.executeQuery();

            while (resultSet.next()) {
                int history_id = resultSet.getInt(1);
                int account_id = resultSet.getInt(2);
                Timestamp day = resultSet.getTimestamp(3);
                int add_money = resultSet.getInt(4);
                int subtract_money = resultSet.getInt(5);
                int total = resultSet.getInt(6);
                String content = resultSet.getString(7);

                HistoryFund history = new HistoryFund(history_id, account_id, day, add_money, subtract_money, total, content);
                listHisFund.add(history);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return listHisFund;
    }

   public void insertHistory(int account_id, Timestamp day, int add_money, int subtract_money, String content) {
    String sql = "INSERT INTO [dbo].[history_fund] ([account_id], [day], [add_money], [subtract_money], [content]) VALUES (?, ?, ?, ?, ?)";
    connection = getConnection();
    try {
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, account_id);
        preparedStatement.setTimestamp(2, day);
        preparedStatement.setInt(3, add_money);
        preparedStatement.setInt(4, subtract_money);
        preparedStatement.setString(5, content);

        int rowsAffected = preparedStatement.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Thêm dữ liệu thành công");
        } else {
            System.out.println("Thêm dữ liệu thất bại");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    public static void main(String[] args) {
        // Create an instance of HisFundDAO
        HisFundDAO dao = new HisFundDAO();

        // Test findAll method
        System.out.println("** Find All History Funds **");
        List<HistoryFund> historyFunds = dao.findAll();
        if (historyFunds.isEmpty()) {
            System.out.println("No history funds found.");
        } else {
            for (HistoryFund historyFund : historyFunds) {
                System.out.println(historyFund); // Use toString() method in HistoryFund class for better output
            }
        }

        // Sample data for insertHistory method
        int account_id = 93;
        Timestamp day = Timestamp.valueOf(LocalDateTime.now());
        int add_money = 50000;
        int subtract_money = 12300;
        String content = "Nạp tiền qua ứng dụng";

        // Test insertHistory method
        System.out.println("\n** Insert New History Fund **");
        try {
            dao.insertHistory(account_id, day, add_money, subtract_money, content);
            System.out.println("History fund inserted successfully.");
        } catch (Exception e) {
            System.out.println("Error inserting history fund: " + e.getMessage());
        }

        // You can call findAll again here to see the newly inserted record (optional)
    }

}
