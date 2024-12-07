<%-- 
    Document   : EditCustomer.jsp
    Created on : Jul 26, 2024, 9:55:19 PM
    Author     : Huyen Tranq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Admin Management</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="chartorderday">Quản lý Nhân sự cửa hàng</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
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

        <!--Update Product-->

        <div id="layoutSidenav">
            <jsp:include page="../../common/admin/sidebarAdmin.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">


                            <form id="switchForm" action="editcustomer" method="post" enctype="multipart/form-data">
                                <fieldset>
                                    <legend style="margin-top: 15px;">Cập nhật thông tin staff</legend>

                                    <section style="background-color: #eee;">
                                        <div class="container py-5">
                                            <div class="row">
                                                <div class="col">
                                                    <nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
                                                        <ol class="breadcrumb mb-0">
                                                            <li class="breadcrumb-item active" aria-current="page">Thông tin của Staff</li>
                                                        </ol>
                                                    </nav>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <div class="card mb-4">
                                                        <div class="card-body text-center">
                                                            <img id="previewImg1" src="${acc.avartar}" alt="avatar" class="rounded-circle img-fluid" style="width: 150px; height: 150px;">
                                                        <input id="filebutton1" name="img" class="form-control mt-3" type="file" onchange="displayImage(this, 'previewImg1')">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-8">
                                                <div class="card mb-4" style="padding-left: 10px; padding-right: 10px">

                                                    <!-- Define a consistent row structure for form fields -->
                                                    <div class="row mb-3 align-items-center" style="padding-top: 10px">
                                                        <div class="col-sm-3">
                                                            <h6 class="mb-0">Tên người dùng</h6>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <input type="text" name="name" class="form-control" value="${acc.user_name}" readonly="">
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3 align-items-center">
                                                        <div class="col-sm-3">
                                                            <h6 class="mb-0">Email</h6>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <input type="email" name="email" class="form-control" value="${acc.email}" readonly="">
                                                        </div>
                                                    </div>
                                                   
                                                    <div class="row mb-3 align-items-center">
                                                        <div class="col-sm-3">
                                                            <h6 class="mb-0">Số điện thoại</h6>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <input type="text" name="phone" class="form-control" value="${acc.phone_number}" readonly="">
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3 align-items-center">
                                                        <div class="col-sm-3">
                                                            <h6 class="mb-0">Giới tính</h6>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <input type="text" name="gender" class="form-control" value="${acc.gender}" readonly="">
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3 align-items-center">
                                                        <div class="col-sm-3">
                                                            <h6 class="mb-0">Địa chỉ</h6>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <input type="text" name="address" class="form-control" value="${acc.address}" readonly="">
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3 align-items-center">
                                                        <div class="col-sm-3">
                                                            <h6 class="mb-0">Role</h6>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <select name="role" class="form-control" required>
                                                                <option value="2" ${'Customer' eq acc.role_name ? "selected" : ""}>Khách hàng</option>
                                                                <option value="1" ${'Admin' eq acc.role_name ? "selected" : ""}>Admin</option> 
                                                                <option value="3" ${'Staff' eq acc.role_name ? "selected" : ""}>Staff</option> 
                                                                <option value="4" ${'Shipper' eq acc.role_name ? "selected" : ""}>Shipper</option>  
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3 align-items-center">
                                                        <div class="col-sm-3">
                                                            <h6 class="mb-0">Status</h6>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <select name="status" class="form-control" required>
                                                                <option value="1" ${'Active' eq acc.status_name ? "selected" : ""}>Active</option>   
                                                                <option value="2" ${'Inactive' eq acc.status_name ? "selected" : ""}>Inactive</option>   
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-sm-9 offset-sm-3">
                                                            <button id="singlebutton" name="singlebutton" class="btn btn-primary">Cập nhật</button>
                                                        </div>
                                                    </div>
                                                    <p class="text-danger">${errorMessage}</p>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </fieldset>
                        </form>

                    </div>
                </main>
            </div>
        </div>





        <footer class="py-4 bg-light mt-auto">
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center justify-content-between small">
                    <div class="text-muted">Tea Shop - Admin Management</div>

                </div>
            </div>
        </footer>
        <style>
            datatables-UpdateProduct {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {

                text-align: center; /* Căn giữa chữ */
            }
            th {
                background-color: #f2f2f2;
            }

            .card-body {
                display: flex;
                justify-content: center;
            }

            td ion-icon {
                font-size: 30px;
                color: #000;
            }

            .update-productDone{
                font-weight: 500;
                font-size: 20px;
                text-align: center; /* Căn giữa ngang */
                vertical-align: middle;
                text-transform: uppercase;
            }

            .button-update {
                font-family: 'Arial';

                background-color: #fff; /* Màu nền ban đầu */
                color: inherit; /* Màu chữ */
                border: 2px solid #0B3649; /* Bỏ viền */
                padding: 10px 20px; /* Kích thước bên trong */
                text-align: center; /* Căn giữa văn bản */
                text-decoration: none; /* Bỏ gạch chân */
                display: inline-block; /* Hiển thị dạng khối nội tuyến */
                font-size: 16px; /* Kích thước chữ */
                margin: 4px 2px; /* Khoảng cách bên ngoài */
                cursor: pointer; /* Con trỏ chuột */
                border-radius: 12px; /* Bo góc */
                transition: background-color 0.3s, box-shadow 0.3s; /* Hiệu ứng chuyển đổi */
            }

            .button-update:hover {
                background-color: #0B3649; /* Màu nền khi lướt chuột qua */
                color: white; /* Màu chữ khi lướt chuột qua */
                border-color: #0B3649;/* Màu nền khi lướt chuột qua */
                box-shadow: 0 0 10px #0056b3; /* Hiệu ứng đổ bóng khi lướt chuột qua */
            }
            .singlebutton {
                background-color: #37697a; /* Màu nền mới */
                color: white; /* Màu chữ mới */
            }


        </style>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/datatables-simple-demo.js"></script>
</body>
</html>
