/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Huyen Tranq
 */
public class PointDAO extends DBContext {

    public int getUserPoints(int accountID) {
        String sql = "select points from Points where account_id = " + accountID;
        PreparedStatement prepare;
        ResultSet rs;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            rs = prepare.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public void minusPointsAfterRedeemed(int accountID) {
        String sql = "update Points set points = points - 5 where account_id = " + accountID;
        PreparedStatement pre;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void addPointsForUser(int accountID) {
        String sql = "insert into Points(account_id, points, last_updated) values(?, ?, ?)";
        PreparedStatement pre;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            pre.setInt(1, accountID);
            pre.setInt(2, 0);
            java.sql.Date redeemed_at = new java.sql.Date(new java.util.Date().getTime());
            pre.setDate(3, redeemed_at);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void BonusPointsAfterBuy(int accountID) {
        String sql = "update Points set points = points + 1 where account_id = " + accountID;
        PreparedStatement pre;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
