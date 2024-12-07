/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Product;
import entity.Status;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author HoangPC
 */
public class StatusDAO extends DBContext {

    public List<Status> findAll() {
        List<Status> list = new ArrayList<>();

        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "select * from Status";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Status status = new Status();

                int status_id = resultSet.getInt("status_id");
                String status_name = resultSet.getString("status_name");

                status.setStatus_id(status_id);
                status.setStatus_name(status_name);
                //add to collections
                list.add(status);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return list;
    }
    public List<Status> statusShipper() {
        List<Status> list = new ArrayList<>();

        //ket noi duoc voi database
        connection = getConnection();
        //co cau lenh de goi xuong database
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Status]\n"
                + "  Where status_id IN ( 4, 5)";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Status status = new Status();

                int status_id = resultSet.getInt("status_id");
                String status_name = resultSet.getString("status_name");

                status.setStatus_id(status_id);
                status.setStatus_name(status_name);
                //add to collections
                list.add(status);
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return list;
    }
    public Status getStatusByStatusID(int id) {
        Status status = new Status();
        //ket noi duoc voi database
        connection = getConnection();
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Status]\n"
                + "  Where status_id = ?";
        try {
            //Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            
            statement.setInt(1, id);
            //thuc thi cau lenh o tren => tra ve ket qua
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                

                int status_id = resultSet.getInt("status_id");
                String status_name = resultSet.getString("status_name");

                status.setStatus_id(status_id);
                status.setStatus_name(status_name);
                //add to collections
               
            }

        } catch (SQLException ex) {
            System.out.println("Error " + ex.getMessage());

        }
        return status;
    }
    public static void main(String[] args) {
        int productId = 2;
         StatusDAO statusDAO = new StatusDAO();
        List<Status> list = statusDAO.findAll();
       
        
        System.out.println(list);

    }
}
