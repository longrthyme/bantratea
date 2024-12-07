<%-- 
    Document   : login.jsp
    Created on : May 27, 2024, 8:08:30 AM
    Author     : Huyen Tranq
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Login</title>

        <!-- Font Icon -->
        <link rel="stylesheet" href="colorlib-regform-7/fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="colorlib-regform-7/css/style.css">

        <style>
            .notification {
                background-color: #f44336; /* Màu nền đỏ */
                color: white; /* Màu văn bản trắng */
                padding: 10px; /* Khoảng cách nội dung bên trong */
                text-align: center; /* Căn giữa văn bản */
                position: fixed; /* Hiển thị thông báo cố định */
                top: 0; /* Hiển thị ở đầu trang */
                left: 0; /* Hiển thị ở góc trái */
                right: 0; /* Hiển thị ở góc phải */
                z-index: 9999; /* Sắp xếp trên cùng */
            }

        </style>

    </head>
    <body>

        <c:if test="">
            <div id="message" class="notification">

            </div>
            <script>
                // Đợi 3 giây sau khi trang tải xong
                setTimeout(function () {
                    var messageDiv = document.getElementById("message");
                    if (messageDiv) {
                        messageDiv.style.display = "none";

                <%
                            session.removeAttribute("message");
                %>
                    }
                }, 3000);
            </script>
        </c:if>
        <div class="main">


            <!-- Sign up form -->
            <!-- Sing in  Form -->
            <section class="sign-in">
                <div class="container">

                    <div class="signin-content">

                        <div class="signin-image">
                            <figure><img src="colorlib-regform-7/images/signin-image.jpg" alt="sing up image"></figure>
                            <a href="signup?mode=1" class="signup-image-link">Create an account</a>
                        </div>

                        <div class="signin-form">
                            <h2 class="form-title">Login</h2>
                            <c:set var="cookie" value=""/>
                            <form action="login" method="POST" class="register-form" id="login-form">
                                <div class="form-group">
                                    <label for="your_name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="email" value="${email}" name="email" id="email" placeholder="Your Email" required=""/>
                                </div>
                                <div class="form-group">
                                    <label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
                                    <input type="password" value="" name="password" id="pass" placeholder="Password" required=""/>
                                </div>
                                <c:if test="${showForgotPassword == true}">
                                    <a href="resetpass.jsp">Forgot Password?</a>
                                </c:if>
                                  <input type="hidden" name="failedAttempts" value="${failedAttempts}">

                                <div class="alert alert-danger" role="alert">
                                    <p class="text-danger">${mess}</p>
                                </div>
                                <div class="form-group form-button">
                                    <input type="submit" name="signin" id="signin" class="form-submit" value="Log in"/>
                                </div>


                                <h4 style="color: green">${Notification}</h4> 
                                <h4 style="color: red">${error}</h4>
                            </form>

                        </div>
                    </div>
                </div>
            </section>

        </div>

        <!-- JS -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="js/main.js"></script>
    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
