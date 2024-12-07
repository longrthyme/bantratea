/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;
import java.util.Iterator;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.activation.DataHandler;
import javax.activation.DataSource;

/**
 *
 * @author pc
 */
public class Email {

    // email: quangtuan3903@gmail.com
    // password: ctkb ailk wesw uwcy
    final static String from = "mthuw93@gmail.com";
    final static String password = "fvzc ufbf ekaq pmzr";

    public static boolean sendEmail(String to, String tieuDe, String noiDung) {
        // Properties : khai bÃ¡o cÃ¡c thuá»™c tÃ­nh
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
        props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // TODO Auto-generated method stub
                return new PasswordAuthentication(from, password);
            }
        };

        // PhiÃªn lÃ m viá»‡c
        Session session = Session.getInstance(props, auth);

        // Táº¡o má»™t tin nháº¯n
        MimeMessage msg = new MimeMessage(session);

        try {
            // Kiá»ƒu ná»™i dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

            // NgÆ°á»i gá»­i
            msg.setFrom(from);

            // NgÆ°á»i nháº­n
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // TiÃªu Ä‘á» email
            msg.setSubject(tieuDe);

            // Quy Ä‘inh ngÃ y gá»­i
            msg.setSentDate(new Date());

            // Quy Ä‘á»‹nh email nháº­n pháº£n há»“i
            // msg.setReplyTo(InternetAddress.parse(from, false))
            // Ná»™i dung
            msg.setContent(noiDung, "text/HTML; charset=UTF-8");

            // Gá»­i email
            Transport.send(msg);
            System.out.println("Gửi mail thành công");
            return true;
        } catch (Exception e) {
            System.out.println("Gặp lỗi trong quá trình gửi mail");
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {

        Email.sendEmail("tran50787@gmail.com", System.currentTimeMillis() + "", "Nội dung");

    }

}
