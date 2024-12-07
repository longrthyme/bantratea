/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author HuyTD
 */
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
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

public class Orders {

    public int order_id, total_amount ;
    public Timestamp order_date;
    public String note, shipper_note, staff_note, payment_method, phone_number, full_name, address, vnp_TxnRef;
    public Status status;
    public Product product;
    public Accounts account;
    public Accounts accountShip;
    public int status_feedback_id;
    public Timestamp estimated_delivery_date, shipper_delivery_time;
    public String formattedOrderDate, formattedEstimated_delivery_date, formattedShipper_delivery_time;
    public List<OrderDetails> orderDetails;

    public Timestamp getCurrentTimestamp() {
        LocalDateTime now = LocalDateTime.now();
        return Timestamp.valueOf(now);
    }

    // Phương thức để định dạng ngày và giờ
    public void setOrder_date(Timestamp order_date) {
        this.order_date = order_date;
        if (order_date != null) {
            LocalDateTime localDateTime = order_date.toLocalDateTime();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy, HH:mm");
            this.formattedOrderDate = localDateTime.format(formatter);
        }
    }

    public void setEstimated_delivery_date(Timestamp estimated_delivery_date) {
        this.estimated_delivery_date = estimated_delivery_date;
        if (estimated_delivery_date != null) {
            LocalDateTime localDateTime = estimated_delivery_date.toLocalDateTime();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy, HH:mm");
            this.formattedEstimated_delivery_date = localDateTime.format(formatter);
        }
    }

    public void setShipper_delivery_time(Timestamp shipper_delivery_time) {
        this.shipper_delivery_time = shipper_delivery_time;
        if (shipper_delivery_time != null) {
            LocalDateTime localDateTime = shipper_delivery_time.toLocalDateTime();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy, HH:mm");
            this.formattedShipper_delivery_time = localDateTime.format(formatter);
        }
    }

    public String getDeliveryTimeMessage() {
        if (shipper_delivery_time != null && estimated_delivery_date != null) {
            long millisecondsDifference = shipper_delivery_time.getTime() - estimated_delivery_date.getTime();
            long minutesDifference = millisecondsDifference / (1000 * 60);
            long hoursDifference = minutesDifference / 60;
            minutesDifference = minutesDifference % 60;

            if (millisecondsDifference <= 0) {
                return "Đúng giờ";
            } else {
                return String.format("Muộn %d giờ %d phút", hoursDifference, minutesDifference);
            }
        }
        return "";
    }
}
