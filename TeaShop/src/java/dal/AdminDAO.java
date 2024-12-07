/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.AccountStatus;
import entity.Accounts;
import entity.Role;
import entity.Topping;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Huyen Tranq
 */
public class AdminDAO extends DBContext {

    protected PreparedStatement statement;
    protected ResultSet resultSet;

    public List<Accounts> getAllAccount() {
        //khởi tạo 1 list để load sản phẩm lên và lưu trong đấy
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id where a.role_id = 2";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public Accounts getAccountById(int id) {
        String query = "SELECT a.account_id,\n"
                + "                a.user_name,\n"
                + "                r.role_name,\n"
                + "                a.email,\n"
                + "                acs.status_name,\n"
                + "                a.gender,\n"
                + "                a.address,\n"
                + "                a.phone_number,\n"
                + "                a.created_at,\n"
                + "                a.full_name,\n"
                + "                a.avartar\n"
                + "                FROM Accounts a\n"
                + "                JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "                JOIN Role r ON a.role_id = r.role_id\n"
                + "                WHERE a.account_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8),
                        resultSet.getDate(9), resultSet.getString(10), resultSet.getString(11));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Accounts getUserInfor(String email) {
        String query = "SELECT a.account_id,\n"
                + "                a.user_name,\n"
                + "                a.pass_word,\n"
                + "                r.role_id,\n"
                + "                a.email,\n"
                + "                acs.status_id,\n"
                + "                a.gender,\n"
                + "                a.address,\n"
                + "                a.phone_number,\n"
                + "                a.created_at,\n"
                + "                a.full_name,\n"
                + "                a.avartar\n"
                + "                FROM Accounts a\n"
                + "                JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "                JOIN Role r ON a.role_id = r.role_id\n"
                + "                WHERE a.email = ?";
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
        }
        return null;
    }

    public String getProductImage1ById(int id) {
        String query = "select [avartar] from Accounts\n"
                + " where account_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return resultSet.getString(1);
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void editUserById(int role, int status, int id) {
        String query = "Update Accounts\n"
                + "  set\n"
                + "  [role_id]=?\n"
                + " ,[status_id]=?\n"
                + "from Accounts\n"
                + "where account_id=?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, role);
            statement.setInt(2, status);
            statement.setInt(3, id);
            statement.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteUser(int id) {
        String query = "Delete from Accounts where account_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
        } catch (Exception e) {
        }

    }

    public void addUser(String email, String pass, String name, int role, int status, String phone, String gender, String address) {
        String query = "insert into Accounts (email, pass_word, user_name, role_id, created_at, status_id, phone_number, gender, address)\n"
                + "values(?,?,?,?,?,?,?,?,?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            LocalDate curDate = java.time.LocalDate.now();
            String date = curDate.toString();
            statement.setString(1, email);
            statement.setString(2, pass);
            statement.setString(3, name);
            statement.setInt(4, role);
            statement.setString(5, date);
            statement.setInt(6, status);
            statement.setString(7, phone);
            statement.setString(8, gender);
            statement.setString(9, address);
            statement.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Accounts> searchUser(String search) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id where (a.user_name LIKE ? or a.email LIKE ? or a.phone_number LIKE ?) AND a.role_id = 2";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, "%" + search + "%");
            statement.setString(2, "%" + search + "%");
            statement.setString(3, "%" + search + "%");
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllStaff() {
        //khởi tạo 1 list để load sản phẩm lên và lưu trong đấy
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id where a.role_id = 3";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllShipper() {
        //khởi tạo 1 list để load sản phẩm lên và lưu trong đấy
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id where a.role_id = 4";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<AccountStatus> getAllStatus() {
        List<AccountStatus> list = new ArrayList<>();
        String query = "select * from AccountStatuses";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new AccountStatus(resultSet.getInt(1), resultSet.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllAccountMale() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where gender = 'Male' and a.role_id = 2\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllAccountMaleStaff() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where gender = 'Male' and a.role_id = 3\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllAccountMaleShipper() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where gender = 'Male' and a.role_id = 4\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllAccountFemale() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where gender = 'Female' and a.role_id = 2\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllAccountFemaleStaff() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where gender = 'Female' and a.role_id = 3\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAllAccountFemaleShipper() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where gender = 'Female' and a.role_id = 4\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountsActive() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.status_id = 1 and a.role_id = 2\n"
                + "ORDER BY created_at DESC";

        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountsActiveStaff() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.status_id = 1 and a.role_id = 3\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountsActiveShipper() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.status_id = 1 and a.role_id = 4\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountsInActive() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.status_id = 2 and a.role_id = 2\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountsInActiveStaff() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.status_id = 2 and a.role_id = 3\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountsInActiveShipper() {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.status_id = 2 and a.role_id = 4\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountByGenderAndStatus(String gender, int status) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.gender = ? and a.status_id = ? and a.role_id = 2\n"
                + "ORDER BY created_at DESC\n";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, gender);
            statement.setInt(2, status);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountByGenderAndStatusStaff(String gender, int status) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.gender = ? and a.status_id = ? and a.role_id = 3\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, gender);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> getAccountByGenderAndStatusShipper(String gender, int status) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id\n"
                + "where a.gender = ? and a.status_id = ? and a.role_id = 4\n"
                + "ORDER BY created_at DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, gender);
            statement.setInt(2, status);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Role> getAllRole() {
        //khởi tạo 1 list để load sản phẩm lên và lưu trong đấy
        List<Role> list = new ArrayList<>();
        String query = "select * from Role";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Role(resultSet.getInt(1), resultSet.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public Role getRoleById(int id) {
        String query = "SELECT r.role_id,\n"
                + "r.role_name\n"
                + "FROM Role r\n"
                + "WHERE r.role_id = ?;";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return new Role(resultSet.getInt(1), resultSet.getString(2));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return null;
    }

    public Role getRoleInfor(String role_name) {
        String query = "SELECT r.role_id,\n"
                + "r.role_name\n"
                + "FROM Role r\n"
                + "WHERE r.role_name = ?;";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, role_name);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return new Role(resultSet.getInt(1), resultSet.getString(2));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return null;
    }

    public void updateRole(String name, int id) {
        String query = "Update Role\n"
                + "set\n"
                + "[role_name]=?\n"
                + "where role_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, name);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
    }

    public void deleteRole(int id) {
        String query = "Delete from Role where role_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }

    }

    public void deleteStatus(int id) {
        String query = "Delete from AccountStatuses where status_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }

    }

    public List<Topping> getAllTopping() {
        //khởi tạo 1 list để load sản phẩm lên và lưu trong đấy
        List<Topping> list = new ArrayList<>();
        String query = "select * from Topping";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Topping(resultSet.getInt(1), resultSet.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public void deleteTopping(int id) {
        String query = "Delete from Topping where topping_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }

    }

    public AccountStatus getStatusById(int id) {
        String query = "SELECT acs.status_id,\n"
                + "acs.status_name\n"
                + "FROM AccountStatuses acs\n"
                + "WHERE acs.status_id = ?;";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return new AccountStatus(resultSet.getInt(1), resultSet.getString(2));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return null;
    }

    public void updateStatus(String name, int id) {
        String query = "Update AccountStatuses\n"
                + "set\n"
                + "[status_name]=?\n"
                + "where status_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, name);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
    }

    public Topping getToppingById(int id) {
        String query = "SELECT t.topping_id,\n"
                + "t.topping_name\n"
                + "FROM Topping t\n"
                + "WHERE t.topping_id = ?;";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return new Topping(resultSet.getInt(1), resultSet.getString(2));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return null;
    }

    public void updateTopping(String name, int id) {
        String query = "Update Topping\n"
                + "set\n"
                + " topping_name =?\n"
                + "where topping_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, name);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
    }

    public void addRole(int id, String name) {
        String query = "insert into Role\n"
                + "values(?,?);";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.setString(2, name);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
    }

    public void addTopping(String name) {
        String query = "insert into Topping\n"
                + "values(?);";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, name);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }

    }

    public boolean isRoleIdExists(int id) {
        boolean exists = false;
        String query = "SELECT COUNT(*) FROM Role WHERE role_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                exists = resultSet.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return exists;
    }

    public List<Topping> searchTopping(String search) {
        List<Topping> list = new ArrayList<>();
        String query = "SELECT t.topping_id,\n"
                + "t.topping_name\n"
                + "FROM Topping t where t.topping_id LIKE ? or t.topping_name LIKE ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, "%" + search + "%");
            statement.setString(2, "%" + search + "%");
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Topping(resultSet.getInt(1), resultSet.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Role> searchRole(String search) {
        List<Role> list = new ArrayList<>();
        String query = "SELECT r.role_id,\n"
                + "r.role_name\n"
                + "FROM Role r where r.role_id LIKE ? or r.role_name LIKE ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, "%" + search + "%");
            statement.setString(2, "%" + search + "%");
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Role(resultSet.getInt(1), resultSet.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> searchStaff(String search) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id where (a.user_name LIKE ? or a.email LIKE ? or a.phone_number LIKE ?) AND a.role_id = 3";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, "%" + search + "%");
            statement.setString(2, "%" + search + "%");
            statement.setString(3, "%" + search + "%");
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public List<Accounts> searchShipper(String search) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT a.account_id,\n"
                + "a.user_name,\n"
                + "r.role_name,\n"
                + "a.email,\n"
                + "acs.status_name, \n"
                + "a.gender,\n"
                + "a.address,\n"
                + "a.phone_number,\n"
                + "a.created_at\n"
                + "FROM Accounts a\n"
                + "JOIN AccountStatuses acs ON a.status_id = acs.status_id\n"
                + "JOIN Role r ON a.role_id = r.role_id where (a.user_name LIKE ? or a.email LIKE ? or a.phone_number LIKE ?) AND a.role_id = 4";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, "%" + search + "%");
            statement.setString(2, "%" + search + "%");
            statement.setString(3, "%" + search + "%");
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(new Accounts(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3),
                        resultSet.getString(4), resultSet.getString(5),
                        resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getDate(9)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ bằng cách in ra stack trace
        }
        return list;
    }

    public static void main(String[] args) {
        AdminDAO dao = new AdminDAO();
        List<Accounts> list = dao.getAllAccountMale();
        for (Accounts listhi : list) {
            System.out.println(listhi);

        }

    }

  

}
