<%-- 
    Document   : my-order
    Created on : May 25, 2024, 10:06:22 AM
    Author     : HuyTD
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.Enumeration"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Dreamy Coffee</title>
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

    <body>

        <!-- Spinner Start -->
        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar start -->
        <div class="container-fluid fixed-top">

            <div class="container topbar bg-primary d-none d-lg-block">    
                <div class="d-flex justify-content-between">
                    <c:if test="${sessionScope.acc==null}">                                                                    
                        <div class="top-info ps-2">
                            <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Lê Thái Tổ, Hàng Trống, Quận Hoàn Kiếm, Hà Nội</a></small>
                            <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">dreamycoffee@gmail.com</a></small>            
                        </div>
                        <div class="top-link pe-2">            
                            <a href="${pageContext.request.contextPath}/Signup.jsp" class="text-white"><small class="text-white mx-2">Đăng ký</small>/</a>
                            <a href="${pageContext.request.contextPath}/login" class="text-white"><small class="text-white mx-2">Đăng nhập</small></a>                 
                        </div>           
                    </c:if>
                    <c:if test="${sessionScope.acc!=null}">
                        <div class="top-info ps-2">
                            <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Lê Thái Tổ, Hàng Trống, Quận Hoàn Kiếm, Hà Nội</a></small>
                            <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">dreamycoffee@gmail.com</a></small>            
                        </div>
                        <div class="top-link pe-2">            
                            <a href="#" class="text-white"><small class="text-white mx-2"> Welcome ${sessionScope.acc.user_name}</small>/</a>
                            <a href="logout" class="text-white"><small class="text-white ms-2">Đăng xuất</small></a>               
                        </div>           
                    </c:if>
                </div>
            </div>

            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="home" class="navbar-brand"><h1 class="text-primary display-6"  >Dreamy Coffee</h1></a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="home" class="nav-item nav-link">Home</a>
                            <a href ="blog" class="nav-item nav-link">Blog</a>
                            <a href="shop" class="nav-item nav-link">Shop</a>
                        </div>

                        <div class="d-flex m-3 me-0">
                            <%
                        int count = 0;
                        Enumeration<String> em = session.getAttributeNames();
                        while (em.hasMoreElements()) {
                            String key = em.nextElement();

                            if (key.startsWith("cartItem")) {
                                count++;
                            }
                        } 
                            %>
                            <a href="CartDetails?service=showcart" class="position-relative me-4 my-auto">
                                <i class="fa fa-shopping-bag fa-2x"></i>
                                <%if(count>0){%>
                                <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;"><%=count%></span>
                                <%}%>
                            </a>
                            <c:if test="${sessionScope.acc!=null}">  
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link" data-bs-toggle="dropdown" style="color: black;">
                                        <i class="fas fa-user fa-2x" style="color: black;"></i>
                                    </a>
                                    <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                        <a href="userprofile?email=${sessionScope.acc.email}" class="dropdown-item">Thông tin</a>
                                        <a href="MyOrder" class="dropdown-item" style="color: orange;">Đơn hàng</a>
                                        <a href="orderCompelete" class="dropdown-item">Đánh giá của bạn</a>
                                    </div>
                                </div>
                            </c:if> 
                            <c:if test="${sessionScope.acc==null}"> 
                                <a href="login" class="nav-link" style="color: black;">
                                    <i class="fas fa-user fa-2x" style="color: black;"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->

        <!-- my-order Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">            
                <div class="row g-4">
                    <div class="col-lg-12">
                        <h1 class="mb-4"></h1>
                        <div class="row g-4">
                            <div class="col-6"></div>
                            <div class="row g-4">
                                <div class="col-lg-3">
                                    <div class="p-4 border border-secondary rounded">
                                        <h4><a class="nav-link" ${current_status_id == '0' ? '' : 'style="color: black;"'} href="MyOrder">
                                                Tất cả đơn hàng
                                            </a></h4>
                                        <a class="nav-link" ${current_status_id == '1' ? '' : 'style="color: black;"'} href="MyOrder?current_status_id=1">
                                            Đơn hàng đang chờ xác nhận
                                        </a>
                                        <a class="nav-link" ${current_status_id == '2' ? '' : 'style="color: black;"'} href="MyOrder?current_status_id=2">
                                            Đơn hàng đang làm
                                        </a>
                                        <a class="nav-link" ${current_status_id == '3' ? '' : 'style="color: black;"'} href="MyOrder?current_status_id=3">
                                            Đơn hàng đang được giao
                                        </a>
                                        <a class="nav-link" ${current_status_id == '4' ? '' : 'style="color: black;"'} href="MyOrder?current_status_id=4">
                                            Đơn hàng đã hoàn thành
                                        </a>
                                    </div>
                                </div>
                                <div class="col-lg-9">
                                    <h4>${message}</h4>
                                    <c:if test="${empty listOrders}">
                                        <div class="row justify-content-center align-items-middle" style="height: 100vh;">
                                            <div class="col-auto">
                                                <c:if test="${sessionScope.acc!=null}">
                                                <c:choose>
                                                    <c:when test="${current_status_id == 0}">
                                                        <h4>Hiện tại không có đơn hàng nào</h4>
                                                    </c:when>
                                                    <c:when test="${current_status_id == 1}">
                                                        <h4>Hiện tại không có đơn hàng nào đang xác nhận</h4>
                                                    </c:when>
                                                    <c:when test="${current_status_id == 2}">
                                                        <h4>Hiện tại không có đơn hàng nào đang làm</h4>
                                                    </c:when>
                                                    <c:when test="${current_status_id == 3}">
                                                        <h4>Hiện tại không có đơn hàng nào đang được giao</h4>
                                                    </c:when>
                                                    <c:when test="${current_status_id == 4}">
                                                        <h4>Hiện tại không có đơn hàng nào đã hoàn thành</h4>
                                                    </c:when>
                                                </c:choose>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="row g-4 justify-content-center">

                                        <c:forEach items="${listOrders}" var="p">
                                            <div class="col-md-6 col-lg-6 col-xl-4">
                                                <div class="p-4 border border-secondary rounded">
                                                    <p>ID hóa đơn: ${p.order_id}</p>
                                                    <p>Ngày: ${p.formattedOrderDate}</p> 
                                                    <p>Tổng tiền hóa đơn: <fmt:formatNumber value="${p.total_amount}" type="number" groupingUsed="true"/> đồng</p>
                                                    <p>Phương thức thanh toán: ${p.payment_method}</p>
                                                    <p>Trạng thái: ${p.status.status_name}</p>
                                                    <form action="OrderInformation" method="post" style="display:inline;">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary">Chi tiết</button>
                                                    </form>
                                                    <c:if test="${p.status.status_id == 1}">
                                                        <form action="MyOrder" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn huỷ đơn hàng?')">
                                                            <input type="hidden" name="service" value="refund">
                                                            <input type="hidden" name="order_id" value="${p.order_id}">
                                                            <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                            <input type="hidden" name="payment_method" value="${p.payment_method}">
                                                            <input type="hidden" name="amount" value="${p.total_amount}">
                                                            <div style="display: flex; align-items: center; margin-top: 16px;">
                                                                <button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary">Hủy đơn hàng</button>
                                                            </div>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="pagination-container" style="text-align: center; padding-top: 50px; padding-bottom: 50px; overflow-x: auto; white-space: nowrap;">
                                            <div class="pagination" style="display: inline-block;">
                                                <c:forEach var="pageNumber" begin="1" end="${number_of_page}">
                                                    <a href="MyOrder?current_status_id=${current_status_id}&current_page=${pageNumber}" 
                                                       class="page-link ${current_page == pageNumber ? 'active' : ''}" 
                                                       style="
                                                       margin: 0 5px;
                                                       display: inline-block;
                                                       padding: 10px 15px;
                                                       border: 2px solid green;
                                                       background-color: lightyellow;
                                                       color: black;
                                                       text-decoration: none;
                                                       border-radius: 5px;
                                                       ">
                                                        ${pageNumber}
                                                    </a>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- my-order End-->        

            <!-- Footer Start -->
            <jsp:include page="../common/homePage/footer-start.jsp"></jsp:include>
                <!-- Footer End -->  

                <!-- JavaScript Libraries-->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

            <!-- Template Javascript -->
            <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>

</html>
