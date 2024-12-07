/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Fund;
import entity.Fundchart;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class FundDAO extends DBContext {

    public List<Fund> listFund() {
        List<Fund> listFunds = new ArrayList<>();
        connection = getConnection();
        String sql = "SELECT * FROM [dbo].[fund] ORDER BY day DESC;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet resultSet = pre.executeQuery();

            Fund previousFund = null;

            while (resultSet.next()) {
                int fund_id = resultSet.getInt(1);
                int account_id = resultSet.getInt(2);
                int input_money = resultSet.getInt(3);
                int close_money = resultSet.getInt(4);
                int profit_loss = resultSet.getInt(5);
                Date day = resultSet.getDate(6);

                while (previousFund != null && !isConsecutiveDay((Date) previousFund.day, day)) {
                    previousFund = createMissingFundRecord(previousFund);
                    listFunds.add(previousFund);
                }

                Fund fund = new Fund(fund_id, 92, input_money, close_money, profit_loss, day);
                listFunds.add(fund);
                previousFund = fund;
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return listFunds;
    }

    // Kiểm tra xem hai ngày có liên tiếp hay không
    private boolean isConsecutiveDay(Date previousDay, Date currentDay) {
        return previousDay.toLocalDate().plusDays(1).equals(currentDay.toLocalDate());
    }

    // Tạo bản ghi giả khi thiếu ngày
    private Fund createMissingFundRecord(Fund previousFund) {
        int input_money = previousFund.close_money;
        int close_money = input_money;
        Calendar cal = Calendar.getInstance();
        cal.setTime(previousFund.day);
        cal.add(Calendar.DAY_OF_MONTH, 1);
        Date nextDay = new Date(cal.getTimeInMillis());

        return new Fund(0, previousFund.account_id, input_money, close_money, 0, nextDay);
    }

    public List<Fundchart> get7dayago() {
        List<Fundchart> listFunds = new ArrayList<>();
        connection = getConnection();
        String sql = "SELECT day, input_money, close_money, profit_loss " +
                     "FROM fund " +
                     "WHERE day >= DATEADD(DAY, -7, GETDATE()) " +
                     "AND day <= GETDATE() " +
                     "ORDER BY day DESC";
        try (PreparedStatement pre = connection.prepareStatement(sql);
             ResultSet resultSet = pre.executeQuery()) {

            while (resultSet.next()) {
                Date day = resultSet.getDate("day");
                int input_money = resultSet.getInt("input_money");
                int close_money = resultSet.getInt("close_money");
                int profit_loss = resultSet.getInt("profit_loss");

                Fundchart fundchart = new Fundchart(day, input_money, close_money, profit_loss);
                listFunds.add(fundchart);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listFunds;
    }

    public List<Fundchart> get8weekago() {
        List<Fundchart> listFunds = new ArrayList<>();
        connection = getConnection();
        String sql = "WITH WeeklyData AS (\n"
                + "    SELECT \n"
                + "        CAST(DATEADD(WEEK, DATEDIFF(WEEK, 0, [day]), 0) AS DATE) AS [week_start],\n"
                + "        input_money,\n"
                + "        close_money,\n"
                + "        profit_loss\n"
                + "    FROM fund\n"
                + "    WHERE [day] >= DATEADD(WEEK, -8, GETDATE()) \n"
                + "      AND [day] <= GETDATE()\n"
                + "),\n"
                + "MaxValues AS (\n"
                + "    SELECT\n"
                + "        [week_start],\n"
                + "        MAX(input_money) AS max_input_money,\n"
                + "        MAX(close_money) AS max_close_money\n"
                + "    FROM WeeklyData\n"
                + "    GROUP BY [week_start]\n"
                + ")\n"
                + "SELECT\n"
                + "    MaxValues.[week_start] AS [day],\n"
                + "    MaxValues.max_input_money AS input_money,\n"
                + "    MaxValues.max_close_money AS close_money,\n"
                + "    SUM(WeeklyData.profit_loss) AS profit_loss\n"
                + "FROM MaxValues\n"
                + "JOIN WeeklyData\n"
                + "ON MaxValues.[week_start] = WeeklyData.[week_start]\n"
                + "GROUP BY MaxValues.[week_start], MaxValues.max_input_money, MaxValues.max_close_money\n"
                + "ORDER BY MaxValues.[week_start] DESC;";
        try (PreparedStatement pre = connection.prepareStatement(sql);
             ResultSet resultSet = pre.executeQuery()) {

            while (resultSet.next()) {
                Date day = resultSet.getDate("day");
                int input_money = resultSet.getInt("input_money");
                int close_money = resultSet.getInt("close_money");
                int profit_loss = resultSet.getInt("profit_loss");

                Fundchart fundchart = new Fundchart(day, input_money, close_money, profit_loss);
                listFunds.add(fundchart);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listFunds;
    }
public static void main(String[] args) {
        FundDAO dao = new FundDAO();
        List<Fundchart> funds = dao.get7dayago();

        for (Fundchart fund : funds) {
            System.out.println(fund);
        }
    }
}
