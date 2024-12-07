<%-- 
    Document   : select-payment
    Created on : May 27, 2024, 6:03:28 PM
    Author     : HuyTD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Dreamy Tea Shop</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    </head>
<style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f0f0; /* Optional: Set background color */
        }
        #autoSubmitForm {
            display: none; /* Hide the form */
        }
    </style>
    <body>
        <h4>Đơn hàng đang được xử lí...</h4>
        <script type="text/javascript">
            window.onload = function () {
                document.getElementById("autoSubmitForm").submit();
            };
        </script>
        <form id="autoSubmitForm" action="PaymentResult" method="post">
            <input type="hidden" name="fullname" value="${fullname}">
            <input type="hidden" name="address" value="${address}">
            <input type="hidden" name="district" value="${district}">
            <input type="hidden" name="ward" value="${ward}">
            <input type="hidden" name="phone_number" value="${phone_number}">
            <input type="hidden" name="amount" value="${amount}">
            <input type="hidden" name="service" value="cash-on-delivery">
        </form>
    </body>

</html>
