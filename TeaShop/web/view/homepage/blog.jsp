<%@ page import="java.util.Enumeration" %>

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

        <div class="container-fluid fixed-top">

            <div class="container topbar bg-primary d-none d-lg-block">    
                <div class="d-flex justify-content-between">

                    <c:if test="${sessionScope.acc==null}">                                                                    
                        <div class="top-info ps-2">
                            <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Đại học FPT Hà Nội</a></small>
                            <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">dreamycoffee@gmail.com</a></small>            
                        </div>
                        <div class="top-link pe-2">            
                            <a href="${pageContext.request.contextPath}/Signup.jsp" class="text-white"><small class="text-white mx-2">Đăng ký</small>/</a>
                            <a href="${pageContext.request.contextPath}/login" class="text-white"><small class="text-white mx-2">Đăng nhập</small></a>                 
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
                            <a href="home" class="nav-item nav-link ">Home</a>
                            <a href ="blog" class="nav-item nav-link active">Blog</a>
                            <a href="shop" class="nav-item nav-link">Shop</a>

                        </div>
                        <c:if test="${sessionScope.acc==null}">  
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
                                        <a href="MyOrder" class="dropdown-item">Đơn hàng</a>
                                    </div>
                                </div>
                                <% 
                                    }                     else { 
                                %>

                                <% 
                                    } 
                                %>

                            </div>
                        </c:if> 
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->
        <div class="container-fluid page-header bg-primary py-5">
            <h1 class="text-center text-white display-6">Blog </h1>

        </div>
        <!-- Blog Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">

                <h1 class="mb-4">Tin Tức & Sự Kiện</h1>
                <form action="blog" method="get" class="search-form">
                    <div class="position-relative mx-auto d-flex align-items-center">
                        <input class="form-control border-2 border-secondary w-75 py-3 px-4" type="text" name="search" id="search-box" placeholder="Search" required aria-label="Search for blog posts">
                        <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 ms-2" aria-label="Submit search">Search</button>
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
                                        <c:forEach items="${listBlog}" var="b">
                                            <div class="col-md-6 col-lg-6 col-xl-4">

                                                <div class="rounded position-relative fruite-item">
                                                    <a href="blogdetail?bid=${b.getId()}">
                                                        <div class="fruite-img">
                                                            <img src="${b.getImg()}" class="img-fluid w-100 rounded-top" alt="">
                                                        </div>

                                                        <div class="p-4  border-top-0  rounded-bottom">
                                                            <h4>${b.getBlog_name()}</h4>

                                                            <!--                                                <div class="d-flex justify-content-between flex-lg-wrap">
                                                                                                                
                                                                                                                <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                                                                            </div>-->
                                                        </div>
                                                    </a>
                                                </div>

                                            </div>
                                        </c:forEach>

                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
        <!-- Blog End-->


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
        <script> const searchForm = document.querySelector('.search-form');
            const searchBox = document.getElementById('search-box');

            searchForm.addEventListener('submit', (event) => {
                const searchTerm = searchBox.value.trim();

                // Basic validation
                if (!searchTerm) {
                    event.preventDefault();
                    searchBox.classList.add('is-invalid'); // Add Bootstrap class for visual feedback
                    searchBox.nextElementSibling.textContent = 'Please enter a search term.'; // Set error message next to input
                    return false; // Prevent form submission
                } else {
                    searchBox.classList.remove('is-invalid'); // Remove error class if search term is entered
                }

                // Additional validation (optional)
                // You could perform further validation here, such as checking for minimum search term length, allowed characters, etc.
                // If validation fails, prevent submission and display an appropriate error message.

                // Submit form if validation passes
                // event.preventDefault() is not needed here as validation already handles it
            });
        </script>
    </body>

</html>
