
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <jsp:include page="../common/homePage/header-start.jsp"></jsp:include>

            <!-- Navbar end -->

            <!-- Single Blog Start -->
            <div class="container-fluid fruite py-5">
                <div class="container py-5">

                    <h1 class="mb-4">Tin Tức & Sự Kiện</h1>
                    <form  action="blog" method="get">             
                        <div class="position-relative mx-auto">
                            <input class="form-control border-2 border-secondary w-75 py-3 px-4" type="text" name="search" placeholder="Search" required >
                            <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute  text-center h-100" style="top: 0; right: 25%;">Search</button>
                        </div>
                    </form>
                    <div class="row g-4">
                        <div class="col-lg-12">

                            <form action="blogdetail" method ="get">
                                <div class="row g-4">

                                    <div class="col-lg-3">
                                        <div class="row g-4">
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <h4>Loại Bài Đăng</h4>

                                                <c:forEach items="${listBlogCategory}" var="lbc">

                                                    <ul class="list-styled fruite-categorie">
                                                        <li>
                                                            <div class="d-flex justify-content-between fruite-name">
                                                                <a href="blog?cateblog=${lbc.getCategoryID()}"><i class="fas fa-alt me-2"></i>${lbc.getCategoryName()}</a>

                                                            </div>
                                                        </li>
                                                    </ul>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <h4>Bài viết mới</h4>
                                                <c:forEach items="${topblog}" var="b">
                                                    <ul class="list-styled fruite-categorie">
                                                        <li>
                                                            <div class="d-flex justify-content-between fruite-name">
                                                                <a href="blogdetail?bid=${b.getId()}"><i class="fas fa-alt me-2"></i>${b.getBlog_name()}</a>


                                                            </div>
                                                            <i class="fas fa-alt me-2">${b.getCreated_at()}</i> 
                                                        </li>
                                                    </ul>
                                                </c:forEach>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-lg-9">
                                    <div class="row g-4 justify-content-center">
                                        <c:set var="b" value="${requestScope.error}"/>
                                        <h4 style="color: red"> ${error}</h4>
                                        <div class="">
                                            <c:set var="b" value="${requestScope.blog}"/>

                                            <div class=" border rounded">
                                                <a href="">
                                                    <img src="${b.getImg()}" class="img-fluid" rounded alt=""/>
                                                </a>
                                            </div>
                                            <h4 class="fw-bold mb-3">${b.getBlog_name()}</h4>

                                            <pre class="mb-4 ">${b.getContent()}</pre>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
        <!--        <div class="container-fluid py-5 mt-5">
                    <div class="container py-5">
        <c:set var="b" value="${requestScope.error}"/>
                <h4 style="color: red"> ${error}</h4>
        <div class="">
        <c:set var="b" value="${requestScope.blog}"/>

        <div class=" border rounded">
            <a href="">
                <img src="/TeaShop/img/${b.getImg()}" class="img-fluid" rounded alt=""/>
            </a>
        </div>
        <h4 class="fw-bold mb-3">${b.getBlog_name()}</h4>

        <pre class="mb-4 pre">${b.getContent()}</pre>





    </div>
</div>
</div>-->

        <!-- Single Blog End -->

        <!-- Tastimonial Start -->
        <div class="container-fluid testimonial py-5">
            <div class="container py-5">
                <div class="testimonial-header text-center">
                    <!--                    <div class="container topbar bg-primary d-none d-lg-block">
                                            <div class="d-flex justify-content-between">
                                                <div class="top-info ps-2">
                                                    <h4 class="text-primary">FEEDBACK </h4>
                                                </div>
                    
                                            </div>
                                        </div>-->

                    <h1 class="display-5 mb-5 text-dark">Khách hàng của chúng tôi nói!!</h1>
                </div>
                <c:if test="${sessionScope.account != null}">
                    <div style="margin-bottom: 10px">
                        <a href="AddBlog.jsp" class="add-blog-button">Do you want to write a blog? Click Here!</a>
                    </div>
                </c:if>
                <div class="owl-carousel testimonial-carousel">
                    <div class="testimonial-item img-border-radius bg-light rounded p-4 ">
                        <div class="position-relative ">
                            <i class="fa fa-quote-right fa-2x text-secondary position-absolute " style="bottom: 30px; right: 0;"></i>

                            <div class="d-flex align-items-center flex-nowrap ">
                                <div class="bg-secondary rounded">
                                    <img src="img/clien1.jpg" class="img-fluid rounded" style="width: 100px; height: 100px;" alt="">
                                </div>
                                <div class="ms-4 d-block">
                                    <h4 class="text-dark">N.X Hoàng</h4>
                                    <p class="m-0 pb-3">Giao hàng nhanh, nước ngon ạ</p>
                                    <div class="d-flex pe-5">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-item img-border-radius bg-light rounded p-4">
                        <div class="position-relative">
                            <i class="fa fa-quote-right fa-2x text-secondary position-absolute" style="bottom: 30px; right: 0;"></i>

                            <div class="d-flex align-items-center flex-nowrap">
                                <div class="bg-secondary rounded">
                                    <img src="img/clien2.jpg" class="img-fluid rounded" style="width: 100px; height: 100px;" alt="">
                                </div>
                                <div class="ms-4 d-block">
                                    <h4 class="text-dark">P.X Hoà</h4>
                                    <p class="m-0 pb-3">Nước ngon , dịch vụ tốt xứng đáng 6 sao nếu có</p>
                                    <div class="d-flex pe-5">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
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
