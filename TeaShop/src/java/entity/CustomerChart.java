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
public class CustomerChart {
    private int number_User;
    private Date date;

    public CustomerChart() {
    }

    public CustomerChart(int number_User, Date date) {
        this.number_User = number_User;
        this.date = date;
    }

    public int getNumber_User() {
        return number_User;
    }

    public void setNumber_User(int number_User) {
        this.number_User = number_User;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Customer Chart {"+
                "date=" + date +
            ", Number User='" + number_User + 
            "}";
    }
    
}
