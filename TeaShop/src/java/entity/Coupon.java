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
public class Coupon {

    private int couponID;
    private String couponCode;
    private String description;
    private int discountType;
    private Date validFrom;
    private Date validUltil;
    private Date createdAt;
    private Date updatedAt;
    private String couponStatus;
    private int timeUsed;
    private int maxUsed;

    public Coupon() {
    }

    public Coupon(int couponID, String couponCode, String description, int discountType, Date validFrom, Date validUltil, Date createdAt, Date updatedAt, String couponStatus, int timeUsed, int maxUsed) {
        this.couponID = couponID;
        this.couponCode = couponCode;
        this.description = description;
        this.discountType = discountType;
        this.validFrom = validFrom;
        this.validUltil = validUltil;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.couponStatus = couponStatus;
        this.timeUsed = timeUsed;
        this.maxUsed = maxUsed;
    }

    public int getCouponID() {
        return couponID;
    }

    public void setCouponID(int couponID) {
        this.couponID = couponID;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDiscountType() {
        return discountType;
    }

    public void setDiscountType(int discountType) {
        this.discountType = discountType;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidUltil() {
        return validUltil;
    }

    public void setValidUltil(Date validUltil) {
        this.validUltil = validUltil;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCouponStatus() {
        return couponStatus;
    }

    public void setCouponStatus(String couponStatus) {
        this.couponStatus = couponStatus;
    }

    public int getTimeUsed() {
        return timeUsed;
    }

    public void setTimeUsed(int timeUsed) {
        this.timeUsed = timeUsed;
    }

    public int getMaxUsed() {
        return maxUsed;
    }

    public void setMaxUsed(int maxUsed) {
        this.maxUsed = maxUsed;
    }
}
