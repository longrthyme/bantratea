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
public class PostChart {
    private Date postdate;
    private int number_Post;

    public PostChart() {
    }

    public PostChart(Date postdate, int number_Post) {
        this.postdate = postdate;
        this.number_Post = number_Post;
    }

    public Date getPostdate() {
        return postdate;
    }

    public void setPostdate(Date postdate) {
        this.postdate = postdate;
    }

    public int getnumber_Post() {
        return number_Post;
    }

    public void setnumber_Post(int number_Port) {
        this.number_Post = number_Port;
    }

    @Override
    public String toString() {
        return "Post Chart {"+
                "date=" + postdate +
            ", Numer Post='" + number_Post + '\'' +          
            "}";
    }
    
}
