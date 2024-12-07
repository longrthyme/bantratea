/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dal.DBContext;
import entity.Accounts;
import entity.Orders;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Huyen Tranq
 */
public class AccountDAO extends DBContext {

    protected PreparedStatement statement;
    protected ResultSet resultSet;

    public Accounts getAccountByAccountID(int id) {
        Accounts accounts = new Accounts();
        connection = getConnection();
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Accounts]\n"
                + "  Where account_id = ?";
        try {

            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);

            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3), resultSet.getInt(4),
                        resultSet.getString(5), resultSet.getInt(6), resultSet.getString(7),
                        resultSet.getString(8), resultSet.getString(9), resultSet.getDate(10), resultSet.getString(11), resultSet.getString(12));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return accounts;
    }

    public Accounts login(String email, String password) {

        String query = "SELECT * FROM Accounts WHERE email = ? AND pass_word = ?";

        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            statement.setString(2, password);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3), resultSet.getInt(4),
                        resultSet.getString(5), resultSet.getInt(6), resultSet.getString(7),
                        resultSet.getString(8), resultSet.getString(9), resultSet.getDate(10), resultSet.getString(11), resultSet.getString(12));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return null;
    }

    public Accounts checkAccountExist(String email) {
        String query = "select * from Accounts where email = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, email);

            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3), resultSet.getInt(4),
                        resultSet.getString(5), resultSet.getInt(6), resultSet.getString(7),
                        resultSet.getString(8), resultSet.getString(9), resultSet.getDate(10), resultSet.getString(11), resultSet.getString(12));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return null;
    }

    public Accounts checkAccountName(String user_name) {
        String query = "select * from Accounts where user_name = ? ";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, user_name);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return new Accounts(user_name);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return null;
    }

    public void Signup(String user_name, String pass_word, String email, String gender, String address, String phone_number) {
        String query = "   INSERT INTO [dbo].[Accounts]\n"
                + "           ([user_name]\n"
                + "           ,[pass_word]\n"
                + "           ,[role_id]\n"
                + "           ,[email]\n"
                + "           ,[status_id]\n"
                + "           ,[gender]\n"
                + "           ,[address]\n"
                + "           ,[phone_number]\n"
                + "           ,[created_at])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?)";

        try {
            LocalDate curDate = java.time.LocalDate.now();
            String date = curDate.toString();
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, user_name);
            statement.setString(2, pass_word);
            statement.setInt(3, 2);
            statement.setString(4, email);
            statement.setInt(5, 1);
            statement.setString(6, gender);
            statement.setString(7, address);
            statement.setString(8, phone_number);
            statement.setString(9, date);
            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
    }

    public boolean changePass(String email, String newpass) {
        String query = "UPDATE Accounts SET pass_word = ? WHERE email = ? ";
        boolean rowUpdated = false;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, newpass);
            statement.setString(2, email);
            rowUpdated = statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return rowUpdated;
    }

    public int getAccountIdByEmail(String email) {
        String query = "SELECT account_id FROM Accounts where email= ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, email);

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                int accountId = resultSet.getInt(1);
                return accountId;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return 0;
    }

    public int updateProfile(String user_name, String phone, String email, String address) {
        String query = "update Accounts set user_name = ?, phone_number = ?, email = ?,\n"
                + "address = ? where email = ?;";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, user_name);
            statement.setString(2, phone);
            statement.setString(3, email);
            statement.setString(4, address);
            statement.setString(5, email);
            int rowUpdated = statement.executeUpdate();
            return rowUpdated;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return -1;
    }

    public int updatePassword(String newPassword, String email) {
        String query = "update Accounts set pass_word = ? where email = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, newPassword);
            statement.setString(2, email);
            int rowUpdated = statement.executeUpdate();
            return rowUpdated;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return -1;
    }

    public int updateAvatar(String newAvatar, String email) {
        String query = "update Accounts set avartar = ? where email = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, newAvatar);
            statement.setString(2, email);
            int rowUpdated = statement.executeUpdate();
            return rowUpdated;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return -1;
    }

    public List<Accounts> findAccountsShipperByRoleId() {
        ArrayList<Accounts> listAccount = new ArrayList<>();
        String query = "SELECT *\n"
                + "  FROM [dbo].[Accounts]\n"
                + "  Where role_id = 4";
        Accounts account = null;
        connection = getConnection();
        try {
            PreparedStatement pre = connection.prepareStatement(
                    query,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);

            ResultSet rs = pre.executeQuery();

            while (rs.next()) {

                account = new Accounts();
                
                account.setAccount_id(rs.getInt("account_id"));
                account.listOrderShipper = (new OrdersDAO().findOrderByShiperId(rs.getInt("account_id")));
                account.setUser_name(rs.getString("user_name"));
                account.setEmail(rs.getString("email"));
                account.setGender(rs.getString("gender"));
                account.setPhone_number(rs.getString("phone_number"));
                listAccount.add(account);
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
        return listAccount;
    }

}
