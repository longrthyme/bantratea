/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Coupon;
import entity.DiscountType;
import entity.RedeemedCoupon;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Huyen Tranq
 */
public class CouponDAO extends DBContext {
     public String getCouponCode() {
        String sql = "select coupon_code from Coupon";
        PreparedStatement prepare;
        ResultSet rs;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            rs = prepare.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Coupon getCouponDetails(String couponCode) {
        String sql = "select *from Coupon where coupon_code = ?";
        PreparedStatement prepare;
        ResultSet rs;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            prepare.setString(1, couponCode);
            rs = prepare.executeQuery();
            while (rs.next()) {
                int couponID = rs.getInt(1);
                String couponCod = rs.getString(2);
                String description = rs.getString(3);
                int discountType = rs.getInt(4);
                Date validFrom = rs.getDate(5);
                Date validUntil = rs.getDate(6);
                Date createdAt = rs.getDate(7);
                Date updateAt = rs.getDate(8);
                String status = rs.getString(9);
                int timeUsed = rs.getInt(10);
                int maxUsed = rs.getInt(11);
                Coupon coupon = new Coupon(couponID, couponCod, description, discountType, validFrom, validUntil, createdAt, updateAt, status, timeUsed, maxUsed);
                return coupon;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Coupon> getAllCoupons() {
        List<Coupon> coupons = new ArrayList<>();
        String sql = "select *from Coupon ";
        PreparedStatement prepare;
        ResultSet rs;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            rs = prepare.executeQuery();
            while (rs.next()) {
                int couponID = rs.getInt(1);
                String couponCod = rs.getString(2);
                String description = rs.getString(3);
                int discountType = rs.getInt(4);
                Date validFrom = rs.getDate(5);
                Date validUntil = rs.getDate(6);
                Date createdAt = rs.getDate(7);
                Date updateAt = rs.getDate(8);
                String status = rs.getString(9);
                int timeUsed = rs.getInt(10);
                int maxUsed = rs.getInt(11);
                Coupon coupon = new Coupon(couponID, couponCod, description, discountType, validFrom, validUntil, createdAt, updateAt, status, timeUsed, maxUsed);
                coupons.add(coupon);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return coupons;
    }

    public String getDiscountType() {
        String sql = "select discount_type from Coupon";
        PreparedStatement prepare;
        ResultSet rs;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            rs = prepare.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public String getDiscountNameByDiscountType(int discountTypeID) {
        String sql = "select discount_name from DiscountType where discountType_id = " + discountTypeID;
        PreparedStatement prepare;
        ResultSet rs;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            rs = prepare.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int updateCoupon(Coupon coupon) {
        String sql = "update Coupon set description = ?, discount_type =?,\n"
                + "  valid_from =?, valid_until = ?, updated_at = ?, status = ? where coupon_code = ?";
        PreparedStatement prepare;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            prepare.setString(1, coupon.getDescription());
            prepare.setInt(2, coupon.getDiscountType());
            java.util.Date utilValidFrom = coupon.getValidFrom();
            java.sql.Date sqlValidFrom = new java.sql.Date(utilValidFrom.getTime());
            prepare.setDate(3, sqlValidFrom);

            java.util.Date utilValidUntil = coupon.getValidUltil();
            java.sql.Date sqlValidUntil = utilValidUntil != null ? new java.sql.Date(utilValidUntil.getTime()) : null;
            prepare.setDate(4, sqlValidUntil);
            java.sql.Date sqlUpdatedAt = new java.sql.Date(new java.util.Date().getTime());
            prepare.setDate(5, sqlUpdatedAt);
            prepare.setString(6, coupon.getCouponStatus());
            prepare.setString(7, coupon.getCouponCode());
            return prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public int addCoupon(Coupon coupon) {
        String sql = "insert into Coupon(coupon_code, description, discount_type, valid_from, valid_until, created_at, status) "
                + "values(?, ?, ?, ?, ?, ?, ?);";
        PreparedStatement prepare;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            prepare.setString(1, coupon.getCouponCode());
            prepare.setString(2, coupon.getDescription());
            prepare.setInt(3, coupon.getDiscountType());
            java.util.Date utilValidFrom = coupon.getValidFrom();
            if (utilValidFrom != null) {
                java.sql.Date sqlValidFrom = new java.sql.Date(utilValidFrom.getTime());
                prepare.setDate(4, sqlValidFrom);
            } else {
                prepare.setNull(4, java.sql.Types.DATE);
            }
            java.util.Date utilValidUntil = coupon.getValidUltil();
            if (utilValidUntil != null) {
                java.sql.Date sqlValidUntil = new java.sql.Date(utilValidUntil.getTime());
                prepare.setDate(5, sqlValidUntil);
            } else {
                prepare.setNull(5, java.sql.Types.DATE);
            }
            java.sql.Date sqlCreatedAt = new java.sql.Date(new java.util.Date().getTime());
            prepare.setDate(6, sqlCreatedAt);

            prepare.setString(7, coupon.getCouponStatus());

            return prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public List<DiscountType> getAllDiscountType() {
        List<DiscountType> discounts = new ArrayList<>();
        String sql = "select * from DiscountType";
        PreparedStatement prepare;
        ResultSet rs;
        try {
            connection = getConnection();
            prepare = connection.prepareStatement(sql);
            rs = prepare.executeQuery();
            while (rs.next()) {
                int discountTypeID = rs.getInt(1);
                String name = rs.getString(2);
                String dess = rs.getString(3);
                DiscountType discount = new DiscountType(discountTypeID, name, dess);
                discounts.add(discount);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return discounts;
    }

    public int deleteCoupon(String couponCode) {
        String sql = "delete from Coupon where coupon_code = ?";
        PreparedStatement pre;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            pre.setString(1, couponCode);
            return pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public void addToRedeemedCoupons(int accountID, String couponCode) {
        String sql = "insert into RedeemedCoupons(account_id, coupon_code, redeemed_at) values(?, ?, ?)";
        PreparedStatement pre;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            pre.setInt(1, accountID);
            pre.setString(2, couponCode);
            java.sql.Date redeemed_at = new java.sql.Date(new java.util.Date().getTime());
            pre.setDate(3, redeemed_at);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateCouponTimeUsed(String couponCode) {
        String sql = "update Coupon set time_used = 1 where coupon_code = ? ";
        PreparedStatement pre;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            pre.setString(1, couponCode);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    public void deleteRedeemedCoupon(String couponCode) {
        String sql = "delete from RedeemedCoupons where coupon_code = ? ";
        PreparedStatement pre;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            pre.setString(1, couponCode);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<RedeemedCoupon> getCouponByAccountID(int accountID) {
        List<RedeemedCoupon> coupons = new ArrayList<>();
        String sql = "select *from [RedeemedCoupons] where account_id = " + accountID;
        PreparedStatement pre;
        ResultSet rs;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int accountid = rs.getInt(2);
                String couponCode = rs.getString(3);
                Date redeemedAt = rs.getDate(4);
                RedeemedCoupon cp = new RedeemedCoupon(id, accountid, couponCode, redeemedAt);
                coupons.add(cp);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return coupons;
    }
}
