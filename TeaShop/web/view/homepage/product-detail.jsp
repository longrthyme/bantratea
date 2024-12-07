<%-- 
    Document   : shop-detail
    Created on : May 19, 2024, 10:21:01 PM
    Author     : HoangPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Dreamy Tea Shop</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="Tìm kiếm bằng tên sản phẩm">
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

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
            <jsp:include page="../common/homePage/header-start.jsp"></jsp:include>
                <div class="container px-0">
                    <nav class="navbar navbar-light bg-white navbar-expand-xl">
                        <a href="shop" class="navbar-brand"><h1 class="text-primary display-6">Dreamy Coffee</h1></a>
                        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars text-primary"></span>
                        </button>
                        <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                            <div class="navbar-nav mx-auto">
                                <a href="home" class="nav-item nav-link">Home</a>
                                <a href="shop" class="nav-item nav-link">Shop</a>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                                    <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                        <a href="cart.jsp" class="dropdown-item">Cart</a>
                                        <a href="chackout.jsp" class="dropdown-item">Checkout</a>
                                        <a href="testimonial.jsp" class="dropdown-item">Testimonial</a>
                                        <a href="404.jsp" class="dropdown-item">404 Page</a>
                                    </div>
                                </div>
                                <a href="contact.jsp" class="nav-item nav-link">Contact</a>
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
                            <% 
    Integer accountId = (Integer) session.getAttribute("accountId");
    if (accountId != null) {
                            %>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link" data-bs-toggle="dropdown" style="color: black;">
                                    <i class="fas fa-user fa-2x" style="color: black;"></i>
                                </a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="userprofile" class="dropdown-item">Thông tin</a>
                                    <a href="MyOrder" class="dropdown-item">Đơn hàng</a>
                                </div>
                            </div>
                            <% 
                                } else { 
                            %>
                            <a href="login"><i class="fas fa-user fa-2x" style="color: black;"></i></a>
                                <% 
                                    } 
                                %>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->


        <!-- Modal Search Start -->
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Tìm kiếm bằng tên sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="Tìm kiếm bằng tên sản phẩm" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->


        <!-- Single Page Header start -->
        <div class="container-fluid page-header bg-primary py-5">
            <h1 class="text-center text-white display-6">Shop Details</h1>

        </div>
        <!-- Single Page Header End -->


        <!-- Single Product Start -->
        <div class="container-fluid py-5 mt-5">
            <div class="container py-5">
                <div class="row g-4 mb-5">
                    <div class="col-lg-8 col-xl-9">
                        <div class="row g-4">
                            <div class="col-lg-6">
                                <div class="border rounded">
                                    <a href="#">
                                        <img src="${product.image}" class="img-fluid rounded" alt="Image">
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <h4 class="fw-bold mb-3">${product.product_name}</h4>
                                <p class="" style="margin-bottom: 8px">${product.category.category_name}</p>
                                <fmt:setLocale value="vi_VN" />
                                <p class="text-dark fs-5 fw-bold mb-0" style="">
                                    <span style="text-decoration: line-through; opacity: 0.6; font-style: italic;">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" />
                                    </span>
                                    &nbsp;
                                    <fmt:formatNumber value="${product.price - (product.price * (product.discount / 100))}" type="currency" currencySymbol="₫" />
                                </p>
                                <div class="d-flex mb-4" style=" padding-top: 10px">
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star text-secondary"></i>
                                </div>
                                <p class="mb-4">${product.description}</p>

                                <form id="addToCartForm" method="POST" action="CartDetails">
                                    <div class="input-group quantity mb-5" style="width: 100px;">
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                        <input id="quantityInput" type="text" name="quantity" class="form-control form-control-sm text-center border-0" value="1">
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <input type="hidden" name="service" value="add2cart">
                                    <input type="hidden" name="product_id" value="${product.product_id}">
                                    <input type="hidden" name="link_id" value="4">
                                    <button type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">Mua ngay</button>
                                </form>

                                <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        var form = document.getElementById('addToCartForm');
                                        var quantityInput = document.getElementById('quantityInput');
                                        var btnMinus = document.querySelector('.btn-minus');
                                        var btnPlus = document.querySelector('.btn-plus');

                                        btnMinus.addEventListener('click', function () {
                                            var currentValue = parseInt(quantityInput.value);
                                            if (!isNaN(currentValue) && currentValue > 1) {
                                                quantityInput.value = currentValue - 1;
                                            }
                                        });

                                        btnPlus.addEventListener('click', function () {
                                            var currentValue = parseInt(quantityInput.value);
                                            if (!isNaN(currentValue)) {
                                                quantityInput.value = currentValue + 1;
                                            }
                                        });
                                    });
                                </script>

                            </div>
                            <div class="col-lg-12">
                                <nav>
                                    <div class="nav nav-tabs mb-3">                                      
                                        <button class="nav-link border-white border-bottom-0" type="button" role="tab"
                                                id="nav-mission-tab" data-bs-toggle="tab" data-bs-target="#nav-mission"
                                                aria-controls="nav-mission" aria-selected="false">Đánh giá sản phẩm</button>
                                    </div>
                                </nav>
                                <div class="tab-content mb-5">

                                    <div class="tab-pane" id="nav-mission" role="tabpanel" aria-labelledby="nav-mission-tab">
                                        <c:forEach items="${feedbackList}" var="fb">
                                            <div class="d-flex">
                                                <img src="${pageContext.request.contextPath}${fb.account.avartar}" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="">
                                                <div class="">
                                                    <p class="mb-2" style="font-size: 14px;">${fb.formattedCreatedAt}</p>
                                                    <div class="d-flex justify-content-between">
                                                        <h5>${fb.account.full_name}</h5>

                                                    </div>
                                                    <div class="d-flex mb-2 text-warning">
                                                        <c:forEach begin="1" end="${fb.rating}" var="star">
                                                            <i class="fa fa-star"></i>
                                                        </c:forEach>
                                                        <c:forEach begin="${fb.rating + 1}" end="5" var="star">
                                                            <i class="fa fa-star-o"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <p>${fb.comment}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="tab-pane" id="nav-vision" role="tabpanel">

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3">
                        <div class="row g-4 fruite">
                            <div class="col-lg-12">

                                <div class="mb-4">
                                    <h4>Danh mục sản phẩm</h4>
                                    <c:forEach items="${listCategory}" var="cate">
                                        <ul class="list-unstyled fruite-categorie">
                                            <li>
                                                <div class="d-flex justify-content-between fruite-name">

                                                    <a href="shop?search=category&category_id=${cate.category_id}"><ion-icon name="caret-forward-outline"></ion-icon> ${cate.category_name}
                                                    </a>

                                                </div>
                                            </li>
                                        </ul>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <h4 class="mb-4">Sản phẩm nổi bật</h4>
                                <c:forEach items="${listSpecialProduct}" var="special">
                                    <div class="d-flex align-items-center mb-4 p-3 border rounded shadow-sm product-card">
                                        <div class="rounded me-4" style="width: 100px; height: 100px; overflow: hidden;">
                                            <img src="${special.image}" class="img-fluid rounded" alt="${special.product_name}">
                                        </div>
                                        <div>
                                            <a href="product-details?id=${special.product_id}" class="mb-2">${special.product_name}</a>
                                            <div class="d-flex mb-2 text-warning">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <div class="d-flex mb-2">
                                                <fmt:setLocale value="vi_VN" />
                                                <a class="text-dark fs-5 fw-bold mb-0" href="product-details?id=${special.product_id}">
                                                    <c:choose>
                                                        <c:when test="${p.discount > 0}">
                                                            <span style="text-decoration: line-through; opacity: 0.6; font-style: italic;">
                                                                <fmt:formatNumber value="${special.price}" type="currency" currencySymbol="₫" />
                                                            </span>
                                                            &nbsp;
                                                            <fmt:formatNumber value="${special.price - (special.price * (special.discount / 100))}" type="currency" currencySymbol="₫" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${special.price}" type="currency" currencySymbol="₫" />
                                                        </c:otherwise>

                                                    </c:choose>
                                                </a>
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
<!-- Single Product End -->


<!-- Footer Start -->
<jsp:include page="../common/homePage/footer-start.jsp"></jsp:include>
    <!-- Footer End -->




    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="https://unpkg.com/ionicons@5.0.0/dist/ionicons.js"></script>
<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>
