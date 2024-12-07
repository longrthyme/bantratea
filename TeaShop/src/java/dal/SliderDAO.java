/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Slider;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class SliderDAO extends DBContext {

    public List<Slider> getAll() {
        List<Slider> sliders = new ArrayList<>();
        String sql = "SELECT [id]\n"
                + "      ,[name]\n"
                + "      ,[description]\n"
                + "      ,[url]\n"
                + "      ,[image]\n"
                + "      ,[status]\n"
               + "  FROM [dbo].[Slider] WHERE status = 1 or status=0 \n";
        PreparedStatement pre;
        connection = getConnection();

        try {
            pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {

                int id = rs.getInt(1);
                String name = rs.getString(2);
                String description = rs.getString(3);
                String url = rs.getString(4);
                String image = rs.getString(5);
                int status = rs.getInt(6);
                Slider sl = new Slider(id, name, description, url, image, status);
                sliders.add(sl);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    //Retrieves all sliders from a database with a status of 1 (true) 
    public List<Slider> getSlideByStatus() {
        List<Slider> sliders = new ArrayList<>();
        String sql = "SELECT [id]\n"
                + "      ,[name]\n"
                + "      ,[description]\n"
                + "      ,[url]\n"
                + "      ,[image]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[Slider] WHERE status = 1 \n";
        PreparedStatement pre;
        connection = getConnection();

        try {
            pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {

                int id = rs.getInt(1);
                String name = rs.getString(2);
                String description = rs.getString(3);
                String url = rs.getString(4);
                String image = rs.getString(5);
                int status = rs.getInt(6);
                Slider sl = new Slider(id, name, description, url, image, status);
                sliders.add(sl);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public List<Slider> filterByStatus(int status) {
        connection = getConnection();
        String sql = "SELECT [id], [name], [description], [url], [image], "
                + "[status] FROM [dbo].[Slider] WHERE [status] = ?";
        List<Slider> sliders = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, status);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                sliders.add(new Slider(rs.getInt("id"), rs.getString("name"),
                        rs.getString("description"), rs.getString("url"),
                        rs.getString("image"), rs.getInt("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public Slider getSliderByID(int id) {
        connection = getConnection();
        String sql = "SELECT * "
                + " FROM [dbo].[Slider] WHERE [id] = ?";
        Slider slider = null;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                slider = new Slider(rs.getInt("id"), rs.getString("name"),
                        rs.getString("description"), rs.getString("url"),
                        rs.getString("image"), rs.getInt("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slider;
    }

    public void SetActive(String id) {
        connection = getConnection();
        String sql = "UPDATE [dbo].[Slider] "
                + "SET [status] = 1 "
                + "WHERE [id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void SetInactive(String id) {
        connection = getConnection();
        String query = "UPDATE [dbo].[Slider] "
                + "SET [status] = 0 "
                + "WHERE [id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateSlider(String name, String description, String url,
            String image, String status, int id) {
        connection = getConnection();
        String sql = "UPDATE [dbo].[Slider]\n"
                + "   SET [name] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[url] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[status] = ?\n"
                + " WHERE [id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, description);
            st.setString(3, url);
            st.setString(4, image);
            st.setString(5, status);
            st.setInt(6, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteByID(int id) {
        connection = getConnection();
        String sql = "UPDATE [dbo].[Slider] "
                + "SET [status] = 2 "
                + "WHERE [id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertSlider(String name, String description, String url, String image, String status) {
        connection = getConnection();
        String query = "INSERT INTO [dbo].[Slider]\n"
                + "           ([name]\n"
                + "           ,[description]\n"
                + "           ,[url]\n"
                + "           ,[image]\n"
                + "           ,[status])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, name);
            st.setString(2, description);
            st.setString(3, url);
            st.setString(4, image);
            st.setString(5, status);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
