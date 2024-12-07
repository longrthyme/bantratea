/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**

 */
public class Fund {

    
    public int fund_id;
    public int account_id;
    public int input_money, close_money, profit_loss;
    public Date day;
    public Fund() {
    }

    public Fund(int fund_id, int account_id, int input_money, int close_money, int profit_loss, Date day) {
        this.fund_id = fund_id;
        this.account_id = account_id;
        this.input_money = input_money;
        this.close_money = close_money;
        this.profit_loss = profit_loss;
        this.day = day;
    }

    public int getFund_id() {
        return fund_id;
    }

    public void setFund_id(int fund_id) {
        this.fund_id = fund_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
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

    public Date getDay() {
        return day;
    }

    public void setDay(Date day) {
        this.day = day;
    }
    
}
