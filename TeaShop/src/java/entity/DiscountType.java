/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Huyen Tranq
 */
public class DiscountType {

    private int discountTypeID;
    private String discountTypeName;
    private String description;

    public DiscountType() {
    }

    public DiscountType(int discountTypeID, String discountTypeName, String description) {
        this.discountTypeID = discountTypeID;
        this.discountTypeName = discountTypeName;
        this.description = description;
    }

    public int getDiscountTypeID() {
        return discountTypeID;
    }

    public void setDiscountTypeID(int discountTypeID) {
        this.discountTypeID = discountTypeID;
    }

    public String getDiscountTypeName() {
        return discountTypeName;
    }

    public void setDiscountTypeName(String discountTypeName) {
        this.discountTypeName = discountTypeName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
