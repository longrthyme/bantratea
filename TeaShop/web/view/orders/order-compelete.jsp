<%-- 
    Document   : order-compelete
    Created on : Jun 21, 2024, 1:14:28 AM
    Author     : HoangPC
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Fruitables - Vegetable Website Template</title>
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
            <jsp:include page="../common/homePage/header-start.jsp"></jsp:include>
                <div class="container px-0">
                    <nav class="navbar navbar-light bg-white navbar-expand-xl">
                        <a href="index.html" class="navbar-brand"><h1 class="text-primary display-6"></h1></a>
                        <h1 class="text-primary display-6">Dreamy Coffee</h1>

                        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars text-primary"></span>


                        </button>
                        <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                            <div class="navbar-nav mx-auto">
                                <a href="${pageContext.request.contextPath}/home" class="nav-item nav-link">Home</a>
                            <a href ="${pageContext.request.contextPath}/blog" class="nav-item nav-link">Blog</a>
                            <a href="${pageContext.request.contextPath}/shop" class="nav-item nav-link active">Shop</a>

                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="cart.jsp" class="dropdown-item">Cart</a>
                                    <a href="chackout.jsp" class="dropdown-item">Checkout</a>
                                    <a href="testimonial.jsp" class="dropdown-item">Testimonial</a>
                                    <a href="404.jsp" class="dropdown-item">404 Page</a>
                                </div>
                            </div>
                            <a href="contact.html" class="nav-item nav-link">Contact</a>
                        </div>
                        <div class="d-flex m-3 me-0">
                            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-primary"></i></button>
                            <a href="#" class="position-relative me-4 my-auto">
                                <i class="fa fa-shopping-bag fa-2x"></i>
                                <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
                            </a>
                            <a href="#" class="my-auto">
                                <i class="fas fa-user fa-2x"></i>
                            </a>
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
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->


        <!-- Single Page Header start -->
        <div class="container-fluid page-header bg-primary py-5">
            <h1 class="text-center text-white display-6">Đánh giá </h1>

        </div>
        <!-- Single Page Header End -->


        <!-- Cart Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="mb-4">
                    <button class="btn ${statusFeedback == 1 ? 'btn-primary' : 'btn'}" onclick="filterOrders(1)">Đã đánh giá</button>
                    <button class="btn ${statusFeedback == 2 ? 'btn-primary' : 'btn'}" onclick="filterOrders(2)">Chưa đánh giá</button>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sản phẩm</th>

                                <th scope="col">Tên</th>
                                <th scope="col">Loại</th>
                                <th scope="col">Giá</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderDetailsList}" var="lo">
                                <tr>

                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="${lo.product.image}" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;" alt="">
                                        </div>
                                    </th>
                                    <td>
                                        <p class="mb-0 mt-4">${lo.product.category.category_name}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${lo.product.product_name}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${lo.product.price} đ</p>
                                    </td>
                                    <td>
                                        <c:if test="${lo.status_feedback_id == 2}">
                                            <button class="btn btn-md bg-light border mt-4" data-bs-toggle="modal" data-bs-target="#feedbackModal"
                                                    onclick="setProductId(${lo.product.product_id}), setOrderDetailsId(${lo.order_details_id})">
                                                Đánh giá
                                            </button>
                                        </c:if>
                                        <c:if test="${lo.status_feedback_id == 1}">
                                            <a href="product-details?id=${lo.product.product_id}">
                                            <button class="btn btn-md bg-light border mt-4"
                                                    onclick="viewFeedback(${lo.product.product_id}, ${lo.orders.account.account_id})">
                                                Xem đánh giá của bạn
                                            </button>
                                                </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
           
            function filterOrders(statusFeedback) {
                window.location.href = 'orderCompelete?statusFeedback=' + statusFeedback;
            }
        </script>

        <!-- Cart Page End -->

        <!-- Feedback Modal Start -->
        <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="feedbackModalLabel">Gửi Đánh Giá</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="feedbackForm" method="get" action="feedback">
                    <div class="modal-body">
                        
                            <input type="hidden" name="product_id" id="product_id" value="">
                            <input type="hidden" name="order_details_id" id="order_details_id" value="">
                            <input type="hidden" name="account_id" value="${sessionScope.acc.account_id}">
                            <div class="mb-3">
                                <label for="feedback" class="form-label">Đánh giá của bạn</label>
                                <textarea class="form-control" id="feedback" name="feedback" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="rating" class="form-label">Đánh giá bằng sao</label>
                                <select class="form-select" id="rating" name="rating" required>
                                    <option value="5">5 sao</option>
                                    <option value="4">4 sao</option>
                                    <option value="3">3 sao</option>
                                    <option value="2">2 sao</option>
                                    <option value="1">1 sao</option>
                                </select>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Gửi</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Xem Đánh Giá -->
    <div class="modal fade" id="viewFeedbackModal" tabindex="-1" aria-labelledby="viewFeedbackModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewFeedbackModalLabel">Đánh Giá Của Bạn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="userFeedbackContent">
                        <!-- Nội dung đánh giá sẽ được tải vào đây -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        function setProductId(productId) {
            document.getElementById('product_id').value = productId;
        }
        function setOrderDetailsId(order_details_id) {
            document.getElementById('order_details_id').value = order_details_id;
        }
    </script>
    <!-- Feedback Modal End -->
    <!-- Footer Start -->
    <jsp:include page="../common/homePage/footer-start.jsp"></jsp:include>
        <!-- Footer End -->


        <!-- Copyright End -->



        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   


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
