/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**


 */
public class HistoryFund {
    public int history_id;
    public int account_id;
    public Timestamp day;
    public int add_money, subtract_money, total;
    public String content;

    public HistoryFund() {
    }

    public HistoryFund(int history_id, int account_id, Timestamp day, int add_money, int subtract_money, int total, String content) {
        this.history_id = history_id;
        this.account_id = account_id;
        this.day = day;
        this.add_money = add_money;
        this.subtract_money = subtract_money;
        this.total = total;
        this.content = content;
    }

    public int getHistory_id() {
        return history_id;
    }

    public void setHistory_id(int history_id) {
        this.history_id = history_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public Timestamp getDay() {
        return day;
    }

    public void setDay(Timestamp day) {
        this.day = day;
    }

    public int getAdd_money() {
        return add_money;
    }

    public void setAdd_money(int add_money) {
        this.add_money = add_money;
    }

    public int getSubtract_money() {
        return subtract_money;
    }

    public void setSubtract_money(int subtract_money) {
        this.subtract_money = subtract_money;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    
    
    public Timestamp getCurrentTimestamp() {
        LocalDateTime now = LocalDateTime.now();
        return Timestamp.valueOf(now);
    }
    
    @Override
    public String toString() {
        // Use a DateTimeFormatter to format the timestamp for better readability
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDate = formatter.format(day.toLocalDateTime());

        return "HistoryFund{" +
                "history_id=" + history_id +
                ", account_id=" + account_id +
                ", day=" + formattedDate +
                ", add_money=" + add_money +
                ", subtract_money=" + subtract_money +
                ", total=" + total +
                ", content='" + content + '\'' +
                '}';
    }
    
}
