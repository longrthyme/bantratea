<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Orders" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Staff Page</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet"/>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <style>
            img {
                width: 200px;
                height: 150px;
            }
            .checkbox-option {
                display: inline-block;
                margin-right: 10px;
            }
            .hidden {
                display: none;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <p class="navbar-brand ps-3">Nhân viên</p>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">

                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i> ${sessionScope.account.fullName}</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="userProfile">Profile</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="login">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

        <div id="layoutSidenav">
            <jsp:include page="../../common/staff/sidebarStaff.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="mt-4">
                            <div class="container-fluid px-4">                      
                                
                                <c:choose>
                                    <c:when test="${vnp_ResponseCode == '00'}">
                                        <h4>Hoàn tiền thành công</h4>

                                        <p>ID hóa đơn: ${orderInfo.order_id}</p>
                                        <p>Họ và tên: ${orderInfo.full_name}</p>
                                        <p>Số điện thoại: ${orderInfo.phone_number}</p>
                                        <p>Ngày: ${orderInfo.formattedOrderDate}</p>
                                        <p>Tổng tiền hóa đơn: <fmt:formatNumber value="${orderInfo.total_amount}" type="number" groupingUsed="true"/> đồng</p>
                                        <p>Phương thức thanh toán: ${orderInfo.payment_method}</p>
                                    </c:when>
                                    <c:when test="${vnp_ResponseCode == '94'}">
                                        <h4>Đơn hàng đã được hoàn tiền</h4>
                                    </c:when>
                                    <c:when test="${vnp_ResponseCode != null && vnp_ResponseCode != '00' && vnp_ResponseCode != '94'}">
                                        <h4>Đã xảy ra sự cố. Vui lòng thử lại sau</h4>
                                    </c:when>
                                </c:choose>

                                <p><a href="Staff?service=show" class="btn border border-secondary rounded-pill px-3 text-primary">Quay về</a></p>
                            
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Bootstrap core JS-->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>

    </body>
</html>
