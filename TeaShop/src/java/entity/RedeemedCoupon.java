/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Huyen Tranq
 */
public class RedeemedCoupon {
     private int redeemedID;
    private int accountID;
    private String couponCode;
    private Date redeemedAt;

    public RedeemedCoupon() {
    }

    public RedeemedCoupon(int redeemedID, int accountID, String couponCode, Date redeemedAt) {
        this.redeemedID = redeemedID;
        this.accountID = accountID;
        this.couponCode = couponCode;
        this.redeemedAt = redeemedAt;
    }

    public int getRedeemedID() {
        return redeemedID;
    }

    public void setRedeemedID(int redeemedID) {
        this.redeemedID = redeemedID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public Date getRedeemedAt() {
        return redeemedAt;
    }

    public void setRedeemedAt(Date redeemedAt) {
        this.redeemedAt = redeemedAt;
    }
    
}
