<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.CartDetails, java.util.Enumeration"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <script>
            function sortBy() {
                var sortValue = document.getElementById("sort").value;
                var urlParams = new URLSearchParams(window.location.search);
                urlParams.set("sort", sortValue);
                window.location.search = urlParams.toString();
            }
        </script>

        <style>
            .product-card {
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .product-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }
            .product-card img {
                transition: transform 0.3s;
            }
            .product-card:hover img {
                transform: scale(1.1);
            }
            .selected {
                color: orange; /* Màu cam */
            }
            .error-message {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>

    <body>

        <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
        intent="WELCOME"
        chat-title="Teashop_chatbot"
        agent-id="1c5afa8b-a018-4fe2-a813-ea37b5e90bff"
        language-code="vi"
        chat-icon="https://upload.wikimedia.org/wikipedia/vi/a/a5/Mixigaming-Logo.jpg?20210321094042"
        ></df-messenger>               
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
                <c:if test="${sessionScope.acc!=null}">
                    <div class="top-info ps-2">
                        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Đại học FPT Hà Nội</a></small>
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
                        <a href="shop" class="nav-item nav-link active">Shop</a>
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
                                    <a href="MyOrder" class="dropdown-item">Đơn hàng</a>
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


    <!-- Modal Search Start -->
    <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content rounded-0">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Nhập tên sản phẩm...</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex align-items-center">
                    <div class="input-group w-75 mx-auto d-flex">
                        <input type="search" class="form-control p-3" placeholder="Search by Keywords" aria-describedby="search-icon-1">
                        <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Search End -->


    <!-- Single Page Header start -->
    <div class="container-fluid page-header bg-primary py-5">
        <h1 class="text-center text-white display-6">Shop </h1>

    </div>
    <!-- Single Page Header End -->


    <!-- Fruits Shop Start-->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">            
            <div class="row g-4">
                <div class="col-lg-12">
                    <h1 class="mb-4"></h1>
                    <div class="row g-4">
                        <div class="col-xl-3">
                            <form action="shop" method="GET">
                                <div class="input-group w-100 mx-auto d-flex">

                                    <input type="hidden" name="search" value="searchByName">
                                    <input type="text" class="form-control p-3" name="keyword" placeholder="Tìm kiếm theo từ khóa" arikeywordsa-describedby="search-icon-1">
                                    <span id="search-icon-1" class="input-group-text p-3" onclick="return this.closest('form').submit()"><i class="fa fa-search"></i></span>
                                </div>
                            </form>

                        </div>
                        <div class="col-6"></div>
                        <div class="col-xl-3">
                            <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                <label for="sort">Sắp xếp theo:</label>
                                <select name="sort" id="sort" onchange="sortBy()" class="border-0 form-select-sm bg-light me-3">
                                    <option value="product_id" <c:if test="${param.sort == null || param.sort == 'product_id'}">selected</c:if>>None</option>
                                    <option value="create_at" <c:if test="${param.sort == 'create_at'}">selected</c:if>>Sản phẩm mới nhất</option>
                                    <option value="reduced_price" <c:if test="${param.sort == 'reduced_price'}">selected</c:if>>Cao đến Thấp</option>
                                    <option value="increase_price" <c:if test="${param.sort == 'increase_price'}">selected</c:if>>Thấp đến Cao</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row g-4">
                            <div class="col-lg-3">
                                <div class="row g-4">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h4>Danh mục sản phẩm</h4>
                                        <c:forEach items="${listCategory}" var="cate">
                                            <ul class="list-unstyled fruite-categorie">
                                                <li>
                                                    <div class="d-flex justify-content-start align-items-center fruite-name">
                                                        <a href="shop?search=category&category_id=${cate.category_id}" class="${param.category_id == cate.category_id ? 'selected' : ''} d-flex align-items-center">
                                                            <ion-icon name="caret-forward-outline"></ion-icon> 
                                                            <span class="ms-2">${cate.category_name}</span>
                                                        </a>
                                                    </div>
                                                </li>
                                            </ul>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <h4 class="mb-3">Khoảng Giá</h4>

                                        <div class="input-group">
                                            <form action="shop" method="GET" class="d-flex">
                                                <input type="hidden" name="search" value="searchByPriceRange">
                                                <input type="number" class="form-control" id="priceFrom" name="priceFrom" placeholder="Từ"
                                                       aria-label="Giá từ" value="${param.priceFrom}">
                                                <span class="input-group-text bg-white border-0">-</span>
                                                <input type="number" class="form-control" id="priceTo" name="priceTo" placeholder="Đến"
                                                       aria-label="Giá đến" value="${param.priceTo}">
                                                <button type="submit" class="btn btn-success ms-2">Áp Dụng</button>
                                            </form>
                                        </div>

                                        <c:if test="${not empty priceErrorMessage}">
                                            <div class="alert alert-danger mt-3" role="alert">
                                                ${priceErrorMessage}
                                            </div>
                                        </c:if>
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
                                                    <fmt:setLocale value="vi_VN" />
                                                    <div class="d-flex mb-2">
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
                        <div class="col-lg-9">
                            <div class="row g-4 justify-content-center">
                                <c:forEach items="${listProduct}" var="p">
                                    <div class="col-md-6 col-lg-6 col-xl-4">

                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <a href="product-details?id=${p.product_id}">
                                                    <img src="${p.image}" class="img-fluid w-100 rounded-top" alt="">
                                                </a>
                                            </div>
                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">${p.category.category_name}</div>
                                            <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                <h4>${p.product_name}</h4>

                                                <fmt:setLocale value="vi_VN" />

                                                <div class="d-flex justify-content-between flex-lg-wrap">
                                                    <p class="text-dark fs-5 fw-bold mb-0">
                                                        <c:choose>
                                                            <c:when test="${p.discount > 0}">
                                                                <span style="text-decoration: line-through; opacity: 0.6; font-style: italic;">
                                                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" />
                                                                </span>
                                                                &nbsp;
                                                                <fmt:formatNumber value="${p.price - (p.price * (p.discount / 100))}" type="currency" currencySymbol="₫" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <a href="CartDetails?service=add2cart&product_id=${p.product_id}&link_id=1" class="btn border border-secondary rounded-pill px-3 text-primary">
                                                        <i class="fa fa-shopping-bag me-2 text-primary"></i> Mua ngay
                                                    </a>                                                 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="col-12">
                                    <div class="pagination d-flex justify-content-center mt-5">

                                        <c:forEach begin="1" end="${pageControl.totalPage}" var="pageNumber">
                                            <c:set var="currentPage" value="${pageControl.page}" />
                                            <c:choose>
                                                <c:when test="${currentPage eq pageNumber}">
                                                    <a href="#" class="active rounded">${pageNumber}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageControl.urlPattern}page=${pageNumber}" class="rounded">${pageNumber}</a>
                                                </c:otherwise>
                                            </c:choose>
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
    <!-- Fruits Shop End-->


    <!-- Footer Start -->
    <jsp:include page="../common/homePage/footer-start.jsp"></jsp:include>
        <!-- Footer End -->

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
