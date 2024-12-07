/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Fundchart {
    private Date day;
    private int input_money;
    private int close_money;
    private int profit_loss;

    public Fundchart() {
    }

    public Fundchart(Date day, int input_money, int close_money, int profit_loss) {
        this.day = day;
        this.input_money = input_money;
        this.close_money = close_money;
        this.profit_loss = profit_loss;
    }

    public Date getDay() {
        return day;
    }

    public void setDay(Date day) {
        this.day = day;
    }

    public int getInput_money() {
        return input_money;
    }

    public void setInput_money(int input_money) {
        this.input_money = input_money;
    }

    public int getClose_money() {
        return close_money;
    }

    public void setClose_money(int close_money) {
        this.close_money = close_money;
    }

    public int getProfit_loss() {
        return profit_loss;
    }

    public void setProfit_loss(int profit_loss) {
        this.profit_loss = profit_loss;
    }
@Override
    public String toString() {
        return "Fundchart{" +
                "day=" + day +
                ", input_money=" + input_money +
                ", close_money=" + close_money +
                ", profit_loss=" + profit_loss +
                '}';
    }
}
