/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author HoangNX
 */
import java.util.Date;
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
public class Product {

    public int product_id;
    public String product_name;
    public Category category;
    public String image;
    public int price;
    public float discount;
    public Date create_at;
    public String description;
    
    

    public Product(String product_name, Category category, String image, int price, Date create_at, String description) {
        this.product_name = product_name;
        this.category = category;
        this.image = image;
        this.price = price;
        this.create_at = create_at;
        this.description = description;
    }

}
