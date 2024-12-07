<%-- 
    Document   : order-information
    Created on : May 26, 2024, 08:07:46 AM
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

        <!-- cart-details Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">            
                <div class="row g-4">
                    <div class="col-lg-12">
                        <h1 class="mb-4"></h1>
                        <div class="row g-4">
                            <div class="col-6"></div>
                            <div class="row g-4">
                                <div class="col-lg-3">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <h4>Loại sản phẩm</h4>
                                                <c:forEach items="${listCategory}" var="cate">
                                                    <ul class="list-unstyled fruite-categorie">
                                                        <li>
                                                            <div class="d-flex justify-content-between fruite-name">
                                                                <a href="shop?search=category&category_id=${cate.category_id}"><i class="fas fa-apple-alt me-2"></i>${cate.category_name}</a>

                                                            </div>
                                                        </li>
                                                    </ul>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div class="container">
                                            <div class="col-lg-12">
                                                <h4 class="mb-3">Sản phẩm nổi bật</h4>
                                                <c:forEach items="${listSpecialProduct}" var="special">
                                                    <div class="d-flex align-items-center mb-4 p-3 border rounded shadow-sm product-card">
                                                        <div class="rounded me-4" style="width: 100px; height: 100px; overflow: hidden;">
                                                            <img src="${special.image}" class="img-fluid rounded" alt="${special.product_name}">
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-2">${special.product_name}</h6>
                                                            <div class="d-flex mb-2 text-warning">
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                            </div>
                                                            <div class="d-flex mb-2">
                                                                <h5 class="fw-bold me-2">${special.price}</h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-lg-9">
                                    <div class="row g-4 justify-content-center"> 
                                        <div class="col-md-12">
                                            <div class="p-4 border border-secondary rounded">
                                                <div class="row">
                                                    <div class="col-md-6 col-lg-6 col-xl-6">
                                                        <p>ID hóa đơn: ${orderInfo.order_id}</p>
                                                        <p>Ngày: ${orderInfo.formattedOrderDate}</p>
                                                        <p>Tổng tiền hóa đơn: <fmt:formatNumber value="${orderInfo.total_amount}" type="number" groupingUsed="true"/> đồng</p>
                                                        <p>Trạng thái: ${orderInfo.status.status_name}</p>
                                                        <c:if test="${orderInfo.status.status_id == 3}">
                                                            <p>Thời gian dự tính hàng sẽ được giao: ${orderInfo.formattedEstimated_delivery_date}</p>
                                                        </c:if>
                                                        <c:if test="${orderInfo.status.status_id == 6 && orderInfo.staff_note != null}">
                                                            <p>Lý do hủy đơn hàng: ${orderInfo.staff_note}</p>
                                                        </c:if>
                                                    </div>

                                                    <div class="col-md-6 col-lg-6 col-xl-6">
                                                        <p>Họ và tên: ${orderInfo.full_name}</p>
                                                        <p>Giới tính: ${accInfo.gender}</p>
                                                        <p>Email: ${accInfo.email}</p>
                                                        <p>Số điện thoại: ${accInfo.phone_number}</p>
                                                    </div>
                                                </div>

                                                <h4>Danh sách sản phẩm</h4>
                                                <c:forEach var="item" items="${infoList}">
                                                    <div class="col-md-12 col-lg-12 col-xl-12 mb-4">
                                                        <div class="p-4 border border-secondary rounded">
                                                            <div class="row">
                                                                <div class="col-md-4 col-lg-4 col-xl-4">
                                                                    <p><img src="${item.product.image}" class="img-fluid w-100" alt="" width="50" height="50"></p>
                                                                </div>
                                                                <div class="col-md-8 col-lg-8 col-xl-8">
                                                                    <p>Tên sản phẩm: ${item.product.product_name}</p>
                                                                    <p>Category: ${item.category.category_name}</p>
                                                                    <p>Số lượng: ${item.quantity}</p>
                                                                    <p>Topping: <c:if test="${empty item.topping}">Không có</p></c:if> 
                                                                        <ul>
                                                                        <c:forEach var="topping" items="${item.topping}">
                                                                            <li>${topping.topping_name}</li>
                                                                            </c:forEach>
                                                                    </ul>
                                                                    <form action="CartDetails" method="post">
                                                                        <input type="hidden" name="service" value="add2cart">
                                                                        <input type="hidden" name="order_id" value="${orderInfo.order_id}">
                                                                        <input type="hidden" name="product_id" value="${item.product.product_id}">
                                                                        <input type="hidden" name="quantity" value="${item.quantity}">
                                                                        <input type="hidden" name="link_id" value="2">
                                                                        <c:forEach var="topping" items="${item.topping}">
                                                                            <input type="hidden" name="topping_names" value="${topping.topping_name}">
                                                                        </c:forEach>
                                                                        <button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary">Mua lại sản phẩm</button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
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
            <!-- order-information End-->        

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
