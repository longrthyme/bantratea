<%-- 
    Document   : UserProfile.jsp
    Created on : Jul 23, 2024, 12:52:37 PM
    Author     : Huyen Tranq
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.CartDetails, java.util.Enumeration, entity.RedeemedCoupon, java.util.List"%>
<%@page import="entity.Coupon, dal.CouponDAO, java.text.SimpleDateFormat"%>
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
                color: green;
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
        <h1 class="text-center text-white display-6">Hồ sơ người dùng </h1>

    </div>
    <!-- Single Page Header End -->


    <!-- Fruits Shop Start-->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">            
            <div class="row">
                <div class="col-lg-4">
                    <div class="card">
                        <form id="avatarForm" action="userprofile?service=UpdateAvatar" class="form-horizontal" method="post" enctype="multipart/form-data">
                            <div class="card-body">                                  
                                <div class="d-flex flex-column align-items-center text-center">
                                    <img id="previewImg2" src="${pageContext.request.contextPath}${a.avartar}" alt="Preview Image" style="max-width: 100%; max-height: 250px;">
                                    <input id="filebutton2" name="img" class="input-file" type="file" onchange="displayImage(this, 'previewImg2')">
                                    <input type="hidden" name="email" value="${a.email}">
                                    <div class="mt-3">
                                        <h4>${a.user_name}</h4>
                                    </div>
                                </div>
                                <hr class="my-4">
                                <ul class="list-group list-group-flush">
                                    <input type="submit" value="Thay đổi">
                                </ul>
                                <h4 style="color: green ; margin-top: 20px">${updateAvtSuccess}</h4>
                                <h4 style="color: green ; margin-top: 20px">${updateAvtFailed}</h4>
                            </div>
                        </form>                   

                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <form action="userprofile?service=UpdateProfile" method="POST">
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Tên người dùng</h6>
                                    </div><div class="col-sm-9 text-secondary">
                                        <input type="text" name="user_name" class="form-control" value="${a.user_name}">
                                    </div>
                                </div>
                                <input type="hidden" name="email" value="${a.email}">
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Số điện thoại</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" name="phoneNumber" class="form-control" value="${a.phone_number}">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Email</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input name="email" class="form-control" value="${a.email}" readonly>
                                        <h9 class="mb-0">   (Bạn không thể thay đổi email của mình)</h9>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Role</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:if test="${a.role_id == 1}">
                                            <input name="role" class="form-control" value="Admin" readonly="">
                                            <h9 class="mb-0"> (Bạn không thể thay đổi vai trò của mình)</h9>
                                            </c:if>
                                            <c:if test="${a.role_id == 2}">
                                            <input name="role" class="form-control" value="Khách hàng" readonly />
                                            <h9 class="mb-0"> (Bạn không thể thay đổi vai trò của mình)</h9>
                                            </c:if>
                                            <c:if test="${a.role_id == 3}">
                                            <input name="role" class="form-control" value="Staff" readonly />
                                            <h9 class="mb-0"> (Bạn không thể thay đổi vai trò của mình)</h9>
                                            </c:if>
                                            <c:if test="${a.role_id == 4}">
                                            <input name="role" class="form-control" value="Shipper" readonly />
                                            <h9 class="mb-0"> (Bạn không thể thay đổi vai trò của mình)</h9>
                                            </c:if>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Địa chỉ</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" name="address" class="form-control" value="${a.address}">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="submit" class="btn btn-primary px-4" value="Thay đổi">
                                    </div>
                                </div>
                                <h4 style="color: green ; margin-top: 20px">${errorMessage}</h4>
                            </form>
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Số điểm tích lũy của bạn</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input name="email" class="form-control" value="${points}" readonly>
                                    <h9 class="mb-0"></h9>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-9 text-secondary">
                                        <button type="button" class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#pointsModal">
                                            Đổi điểm
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <%
                                            String message = (String) session.getAttribute("pointsMessage");
                                            if (message != null) {
                            %>
                            <div class="alert alert-danger">
                                <%= message %>
                            </div>
                            <%
                                session.removeAttribute("pointsMessage");
                            }
                            %>
                            <%
                                            String messages = (String) session.getAttribute("couponMessage");
                                            if (messages != null) {
                            %>
                            <div class="alert alert-success">
                                <%= messages %>
                            </div>
                            <%
                                session.removeAttribute("couponMessage");
                            }
                            %>
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Coupon của bạn</h6>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-9 text-secondary">
                                        <button type="button" class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#MyCouponModal">
                                            Xem
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="d-flex align-items-center mb-3">Đổi mật khẩu</h5>
                                    <div class="col-sm-9 text-secondary">
                                        <form action="userprofile?service=UpdatePassword" method="post">
                                            <div class="row mb-3">
                                                <div class="col-sm-3">
                                                    <h6 class="mb-0">Mật khẩu cũ</h6>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="password" class="form-control" name="oldpass" placeholder="Nhập mật khẩu cũ" value="${oldpass}" required>
                                                </div>
                                            </div>
                                            <input type="hidden" name="email" value="${a.email}">
                                            <div class="row mb-3">
                                                <div class="col-sm-3">
                                                    <h6 class="mb-0">Mật khẩu mới</h6>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input class="form-control" type="password" name="newpass" placeholder="Nhập mật khẩu mới" value="${newpass}" required />
                                                </div>
                                            </div> 
                                            <div class="row mb-3">
                                                <div class="col-sm-3">
                                                    <h6 class="mb-0">Nhắc lại mật khẩu mới</h6>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="password" class="form-control" name="re_newpass" placeholder="Nhập lại mật khẩu mới" value="${re_newpass}" required  />
                                                </div>
                                            </div> 
                                            <div class="row">
                                                <div class="col-sm-3"></div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="submit" class="btn btn-primary px-4" value="Thay đổi">
                                                </div>
                                            </div>  
                                            <c:if test="${not empty errorsList}">
                                                <h4 style="color: green ; margin-top: 20px">
                                                    <c:forEach items="${errorsList}" var="errorEntry">
                                                        ${errorEntry.value}<br>
                                                    </c:forEach>
                                                </h4>
                                            </c:if>
                                            <h4 style="color: green ; margin-top: 20px">${updateSuccess}</h4>
                                            <h4 style="color: green ; margin-top: 20px">${updateFailed}</h4>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="modal fade" id="pointsModal" tabindex="-1" aria-labelledby="pointsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="pointsModalLabel">Đổi điểm từ Coupon</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Nội dung modal để đổi điểm -->
                    <form action="userprofile?service=RedeemPoints" method="post">
                        <input type="hidden" name="email" value="${a.email}">
                        <div class="mb-3">
                            <label for="couponCode" class="form-label">Thể loại coupon</label>
                            <select name="discountType" class="form-control" required>
                                <c:forEach items="${discountsType}" var="dis">
                                    <option value="${dis.discountTypeID}">
                                        ${dis.discountTypeName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="pointsToRedeem" class="form-label">Số điểm cần đổi</label>
                            <input type="number" class="form-control" id="pointsToRedeem" name="pointsToRedeem" min="1" value="5" readonly="">
                        </div>
                        <div class="text-end">
                            <button type="submit" name="buttonSubmit" class="btn btn-primary">Đổi điểm</button>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="MyCouponModal" tabindex="-1" aria-labelledby="pointsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="pointsModalLabel">Đổi điểm từ Coupon</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">Mã Coupon</th>
                                    <th scope="col">Thể loại</th>
                                    <th scope="col">Ngày đổi</th>
                                    <th scope="col">Ngày hết hạn</th>
                                    <th scope="col">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                List<RedeemedCoupon> cp = (List<RedeemedCoupon>) request.getAttribute("redeemedCoupons");
                                CouponDAO daoCoupon = new CouponDAO();
                                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                                %>
                                <%for(RedeemedCoupon coupons : cp){
                                    String couponCode = coupons.getCouponCode();
                                    Coupon couponDetails = daoCoupon.getCouponDetails(couponCode);
                                    int discountType = couponDetails.getDiscountType();
                                    String discountName = daoCoupon.getDiscountNameByDiscountType(discountType);
                                    String validUltilFormatted = sdf.format(couponDetails.getValidUltil());
                                %>
                                <tr>
                                    <td><%=coupons.getCouponCode()%></td>
                                    <td><%=discountName%></td>
                                    <td><%=coupons.getRedeemedAt()%></td>
                                    <td><%=validUltilFormatted%></td>
                                    <%if(couponDetails.getTimeUsed() == 1){%>
                                    <td>Đã sử dụng</td>
                                    <%}else{%>
                                    <td>Chưa sử dụng</td>
                                    <%}%>
                                </tr>
                                <%}%>
                                <%if(cp == null){%>
                                <tr>
                                    <td>Không có coupon nào</td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
            function displayImage(input, imgId) {
                var preview = document.getElementById(imgId);
                var file = input.files[0];
                var reader = new FileReader();

                reader.onloadend = function () {
                    preview.src = reader.result;
                }

                if (file) {
                    reader.readAsDataURL(file);
                } else {
                    preview.src = "";
                }
            }
    </script>
</body>

</html>
