/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class OrderChart {
    private Date date;
    private int done_order;
    private int total_order;
    private double success_rate;
    private double revenue;

    public OrderChart() {
    }

    public OrderChart(Date date, int done_order, int total_order, double success_rate, double revenue) {
        this.date = date;
        this.done_order = done_order;
        this.total_order = total_order;
        this.success_rate = success_rate;
        this.revenue = revenue;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getDone_order() {
        return done_order;
    }

    public void setDone_order(int done_order) {
        this.done_order = done_order;
    }

    public int getTotal_order() {
        return total_order;
    }

    public void setTotal_order(int total_order) {
        this.total_order = total_order;
    }

    public double getSuccess_rate() {
        return success_rate;
    }

    public void setSuccess_rate(double success_rate) {
        this.success_rate = success_rate;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    @Override
    public String toString() {
        return "Order Chart {"+
                "date=" + date +
            ", done='" + done_order + '\'' +
            ", total='" + total_order + '\'' +
            ", success='" + success_rate + '\'' +
            ", revenue='" + revenue  +
            "}";
    }
    
    
}
