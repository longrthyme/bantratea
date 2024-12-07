/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author HoangPC
 */
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Feedback {
    public int feedback_id;
    public Accounts account;
    public Product product;
    public String comment;
    public Timestamp  created_at;
    public int rating;
    public String formattedCreatedAt;
    
     public void formatCreatedAt() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        this.formattedCreatedAt = dateFormat.format(this.created_at);
    }

    // Getter cho trường đã định dạng
    public String getFormattedCreatedAt() {
        return formattedCreatedAt;
    }
}
