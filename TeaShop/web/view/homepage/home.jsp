
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
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
        <!-- Template Stylesheet -->

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
                    <div class="top-info ps-2">
                        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Tân Xã, Thạch Hòa, Thạch Thất, Hòa Lạc</a></small>
                        <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">huydxhe172399@fpt.edu.vn</a></small>
                                <c:if test="${sessionScope.acc==null}">
                            <small class="me-3"><a href="login" class="text-white">Đăng nhập</a></small>
                        </c:if>
                    </div>
                    <div class="top-link pe-2">
                        <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
                        <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                        <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>                   
                    </div>
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
                            <a href="product-detail" class="nav-item nav-link">Shop Detail</a>
                            <!--                            <div class="nav-item dropdown">
                                                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                                                            <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                                                <a href="cart.jsp" class="dropdown-item">Cart</a>
                                                                <a href="chackout.jsp" class="dropdown-item">Chackout</a>
                                                                <a href="testimonial.jsp" class="dropdown-item">Testimonial</a>
                                                                <a href="404.jsp" class="dropdown-item">404 Page</a>
                                                            </div>
                                                        </div>-->
                            <a href="contact" class="nav-item nav-link">Contact</a>
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
                                <span>Welcome ${sessionScope.acc.user_name} <i class="arrow_carrot-down"></i></span>
                                <a href="userprofile?email=${sessionScope.acc.email}" class="my-auto">
                                    <i class="fas fa-user fa-2x"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>

        <!-- Navbar end -->     

        <!-- Header Start -->
        <jsp:include page="../common/homePage/header-start.jsp"></jsp:include>
            <!-- Header End -->

            <!-- Hero header Start -->
            <div class="card mb-4">
                <div class="h1">                                
                    <b>${message}</b>                                                                    
            </div>  
        </div>     
        <div class="container-fluid py-5 mb-5 hero-header">
            <div class="container-fluid py-5 ">
                <div class="row g-5 align-items-center">

                    <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                        <c:set var="firstActiveSet" value="false" />

                        <div class="carousel-inner py-5" role="listbox">
                            <!-- Start of carousel-item section -->
                            <c:forEach items="${listslider}" var="s" varStatus="status">
                                <c:if test="${s.status == 1}">
                                    <div class="carousel-item ${!firstActiveSet ? 'active' : ''}  rounded">
                                        <a href="/TeaShop/${s.url}" >
                                            <img src="${s.image}" class="w-100 h-100 bg-secondary rounded" alt="${s.name}">
                                        </a>
                                    </div>
                                    <c:if test="${!firstActiveSet}">
                                        <c:set var="firstActiveSet" value="true" />
                                    </c:if>
                                </c:if>
                            </c:forEach>
                            <!-- End of carousel-item section -->
                        </div>



                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>

                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>

                        </button>
                    </div>

                </div>
            </div>
        </div><!--
        <!-- Hero header End -->

        <!-- Hero Start -->
        <div class="container-fluid py-1 mb-3 hero-header">
            <div class="container py-1">
                <div class="row g-5 align-items-center">
                    <div class="col-md-12 col-lg-7">
                        <h3 class="mb-3 text-secondary">Cà Phê Tự Hào: Niềm Kiêu Hãnh Của Việt Nam</h4>
                        <h4 class="mb-1 text-primary">
                            Hạt cà phê vàng óng, căng tròn: Nổi bật trên nền xanh mướt của những đồi chè, những trái cà phê chín mọng như những viên ngọc quý, mang theo niềm tự hào về một thức uống đã làm say mê biết bao con người.

                        </h1>


                    </div>
                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item active rounded">
                                    <img src="${pageContext.request.contextPath}/img/anhtuhaovn2.jpg" class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Hero End -->

        <!-- Dreamy Coffee
 Shop Start-->
        <div class="container-fluid fruite py-3">
            <div class="container py-5">
                <div class="tab-class text-center">

                    <div class=" text-start navbar-nav ">
                        <h1>CÁC DÒNG SẢN PHẨM NỔI BẬT</h1>
                    </div>


                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane fade show p-0 active">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4 ">
                                        <c:forEach var="special" items="${listSpecialProduct}">
                                            <div class="col-md-6 col-lg-4 col-xl-4">
                                                <div class="rounded position-relative fruite-item text-center ">
                                                    <div class="fruite-img">
                                                        <a href="product-details?id=${special.product_id}">
                                                        <img src="${special.image}" class="img-fluid w-100 rounded-top center-block" alt="${special.product_name}">
                                                        </a>
                                                    </div>
                                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"></div>
                                                    <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                        <h4>${special.product_name} </h4>

                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold mb-0">${special.price}</p>
                                                            <a href="CartDetails?service=add2cart&product_id=${special.product_id}&link_id=3" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i>Mua ngay</a>
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
        <!-- Dreamy Coffee Shop End-->
        <!-- Featurs start -->

        <div class="container-fluid service py-5 ">
            <div class="container py-1">
                <div class=" text-start navbar-nav ">
                    <h1>CÁC BÀI ĐĂNG NỔI BẬT</h1>
                </div>

                <div class="row g-4 justify-content-center">

                    <c:forEach items="${topBog}" var="b">
                        <div class="col-md-6 col-lg-4 " >
                            <a href="blogdetail?bid=${b.getId()}">
                                <div class="service-item bg-secondary rounded border border-secondary" >
                                    <img src="${b.getImg()}"  alt="${b.getBlog_name()}"style="width: 100%; height: 200px; object-fit: cover;">
                                    <div class=" fix-bottom">
                                        <div class=" bg-primary text-center p-4 ">
                                            <h5 class="text-white">${b.getBlog_name()}</h5>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </div>

        <!-- Featurs End -->

        


        <!-- Tastimonial Start -->
        <div class="container-fluid testimonial py-5">
            <div class="container py-5">
                <div class="testimonial-header text-center">
                    <div class="container topbar bg-primary d-none d-lg-block">
                        <div class="d-flex justify-content-between">
                            <div class="top-info ps-2">
                                <h4 class="text-primary">FEEDBACK </h4>
                            </div>

                        </div>
                    </div>

                    <h1 class="display-5 mb-5 text-dark">Khách hàng của chúng tôi nói!!</h1>
                </div>
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
        <!-- Tastimonial End -->


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

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>

</html>
