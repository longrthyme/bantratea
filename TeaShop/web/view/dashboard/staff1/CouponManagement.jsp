


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Coupon Management</title>

        <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="customerManagement">Quản lý khách hàng</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="searchUser">                 
                <div class="input-group">
                    <input type="search" name="search" class="form-control rounded" placeholder="Nhập tên tìm kiếm ..." aria-label="Search" aria-describedby="search-addon" />
                </div>
            </form>          
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="home">Home</a></li>                     
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <jsp:include page="../../common/staff/sidebarStaff.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">                         
                            <ol class="breadcrumb mb-4">                              
                                <li style="margin-top: 20px" class="breadcrumb-item active"><a href="CouponManagement?service=AddCoupon"><b style="color: #37697a">Thêm coupon</b></a></li>
                            </ol>                                                                     

                            <form action="CouponManagement">
                                <div class="card-body">
                                    <table id="couponTable">
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Coupon ID</th>
                                                    <th>Coupon Code</th>
                                                    <th>Description</th>
                                                    <th>Discount Type</th>
                                                    <th>Valid From</th>
                                                    <th>Valid Until</th>
                                                    <th>Created At</th>
                                                    <th>Update At</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>                                       
                                            <tbody>
                                            <c:forEach items="${coupons}" var="lc">
                                                <tr>                                                 
                                                    <td>${lc.couponID}</td>
                                                    <td>${lc.couponCode}</td>
                                                    <td>${lc.description}</td>
                                                    <td>${lc.discountType}</td>
                                                    <td>${lc.validFrom}</td>
                                                    <td>${lc.validUltil}</td>
                                                    <td>${lc.createdAt}</td>
                                                    <td>${lc.updatedAt}</td>
                                                    <td>${lc.couponStatus}</td>
                                                    <td>
                                                        <a href="CouponManagement?service=EditCoupon&couponCode=${lc.couponCode}"><ion-icon name="create-outline"></ion-icon></a>
                                                        <a href="CouponManagement?service=DeleteCoupon&couponCode=${lc.couponCode}"><ion-icon name="trash-outline"></ion-icon></a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <%
                                       String message = (String) session.getAttribute("messageAdd");
                                       if (message != null) {
                                    %>
                                    <div class="alert alert-success">
                                        <%= message %>
                                    </div>
                                    <%
                                        session.removeAttribute("messageAdd");
                                    }
                                    %>
                                    <%
                                      String messageDelete = (String) session.getAttribute("messageDelete");
                                      if (messageDelete != null) {
                                    %>
                                    <div class="alert alert-success">
                                        <%= messageDelete %>
                                    </div>
                                    <%
                                        session.removeAttribute("messageDelete");
                                    }
                                    %>
                            </div>
                        </form>
                    </div>
                    <style>
                        .table {
                            font-family: Arial, sans-serif;
                            margin-top: 20px;
                        }
                        .table thead {
                            background-color: #f8f9fa;
                        }
                        .table th, .table td {
                            text-align: center;
                            vertical-align: middle;
                        }
                        .table td a {
                            text-decoration: none;
                            color: #007bff;
                        }
                        .table td a:hover {
                            color: #0056b3;
                        }
                        .table tbody tr:hover {
                            background-color: #f1f1f1;
                        }
                        .btn {
                            margin: 0 2px;
                        }
                    </style>
            </div>
        </main>
        <footer class="py-4 bg-light mt-auto">
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center justify-content-between small">
                    <div class="text-muted">Copyright &copy; Your Website 2023</div>
                    <div>
                        <a href="#">Privacy Policy</a>
                        &middot;
                        <a href="#">Terms &amp; Conditions</a>
                    </div>
                </div>
            </div>
        </footer>
        <style>
            .search-header {
                background-color: #37697a; /* Màu nền */
                border: none; /* Bỏ viền */
                color: white;
                padding: 8px 12px;
            }
            .search-header:hover{
                background-color: #0B3649; /* Màu nền khi hover */
                color: white;
            }
            .filerByPrice {
                background-color: #37697a; /* Màu nền */
                border: none; /* Bỏ viền */
                color: white; /* Màu chữ */
                padding: 7px 11px; /* Khoảng cách trong */
                text-align: center; /* Canh giữa văn bản */
                text-decoration: none; /* Bỏ gạch chân */
                display: inline-block; /* Hiển thị dạng khối nội tuyến */
                font-size: 16px; /* Cỡ chữ */
                margin: 10px 0; /* Khoảng cách ngoài */
                cursor: pointer; /* Con trỏ chuột */
                border-radius: 13px; /* Bo góc */
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu nền */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng nhẹ */

            }

            .filerByPrice:hover {
                background-color: #0B3649; /* Màu nền khi hover */
                color: white;
            }

            .filerByPrice:active {
                background-color: #3e8e41; /* Màu nền khi nhấn giữ */
                transform: translateY(2px); /* Hiệu ứng nhấn xuống */
            }
            .datatable-table
            {

                font-family: 'Verdana', sans-serif; /* Bạn có thể thay đổi phông chữ nếu muốn */
                font-size: 15px; /* Thiết lập kích thước phông chữ */
                color: #333; /* Màu sắc của chữ */
                text-align: center; /* Căn giữa ngang */
                vertical-align: middle; /* Căn giữa dọc */
                padding: 10px; /* Thêm khoảng đệm cho nội dung */
            }
            .datatable-table th a {

                font-family: 'Arial', sans-serif;
                color: inherit;
                text-align: center; /* Căn giữa ngang */
                vertical-align: middle; /* Căn giữa dọc */
                /*   
                */ }
            td ion-icon {
                font-size: 30px;
                color: #000;
            }

            .h1 {
                padding: 20px; /* Thêm padding cho thẻ div */
                background-color: #fff; /* Màu nền cho thẻ div */
                text-align: center; /* Căn giữa nội dung bên trong theo chiều ngang */

            }

            .h1 a {
                display: flex; /* Sử dụng flexbox */
                align-items: center; /* Căn giữa theo chiều dọc */
                justify-content: center; /* Căn giữa theo chiều ngang */
                font-weight: 500;
                font-size: 20px;
                text-transform: uppercase;
                text-decoration: none; /* Bỏ gạch chân */
                color: inherit; /* Giữ nguyên màu chữ */
                padding: 10px 20px; /* Thêm padding cho liên kết */
                border: 2px solid #0B3649; /* Thêm viền */
                border-radius: 8px; /* Bo tròn các góc */
                background-color: #fff; /* Màu nền cho liên kết */
                transition: background-color 0.3s, color 0.3s, border-color 0.3s; /* Hiệu ứng chuyển đổi */
            }

            .h1 a ion-icon {
                margin-right: 8px; /* Khoảng cách giữa icon và chữ */
                font-size: 24px; /* Kích thước icon */
            }

            .h1 a:hover {
                background-color: #0B3649; /* Màu nền khi lướt chuột qua */
                color: white; /* Màu chữ khi lướt chuột qua */
                border-color: #0B3649; /* Màu viền khi lướt chuột qua */
            }

            a ion-icon {
                font-size: 25px;
                text-align: center; /* Căn giữa ngang */
                vertical-align: middle; /* Căn giữa dọc */
            }

            .datatable-sorter::before, .datatable-sorter::after {
                content: "";
                height: 0;
                width: 0;
                position: absolute;
                right: 4px;
                border-left: 4px solid transparent;
                border-right: 4px solid transparent;
                opacity: 0.8;
            }
            element.style {
                font-family: 'Arial';
                transform: translateX(25vw);
                width: 25%;
                color: #00a5bb;
            }

            h6 ion-icon {
                font-size: 26px;
                text-align: center; /* Căn giữa ngang */
                vertical-align: middle; /* Căn giữa dọc */
                margin-right: 5px; /* Khoảng cách giữa icon và chữ */

            }
            .card-header input[type="number"] {
                border: 2px solid #37697a; /* Màu border */
                border-radius: 15px; /* Bo tròn border */
                padding: 6px; /* Padding bên trong */
                font-size: 16px; /* Kích thước font chữ */
                outline: none; /* Loại bỏ viền outline khi focus */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng nhẹ */
                transition: border-color 0.3s, box-shadow 0.3s; /* Hiệu ứng chuyển đổi mượt */
            }

            .card-header input[type="number"]:focus {
                border-color: #37697a; /* Màu border khi focus */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5); /* Hiệu ứng đổ bóng khi focus */
            }
            .filter {
                display: flex;
                align-items: center;
                gap: 10px; /* Space between elements */
            }

            .filter-select {
                padding: 8px 12px; /* Adjust padding for better size */
                font-size: 16px; /* Make font size consistent */
                border: 1px solid #ccc; /* Border for visibility */
                border-radius: 4px; /* Rounded corners */
                outline: none; /* Remove default outline */
            }

            .filter-submit {
                padding: 8px 16px; /* Adjust padding for button */
                font-size: 16px; /* Consistent font size */
                color: #fff; /* Text color */
                background-color: #37697a; /* Light teal color */
                border: none; /* Remove default border */
                border-radius: 4px; /* Rounded corners */
                cursor: pointer; /* Pointer cursor on hover */
                transition: background-color 0.3s ease; /* Smooth background color transition */
            }

            .filter-submit:hover {
                background-color: #009d8a; /* Darker teal color on hover */
            }
        </style>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script src="https://unpkg.com/ionicons@5.0.0/dist/ionicons.js"></script>
</body>
</html>



