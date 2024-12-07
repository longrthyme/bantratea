<%-- 
    Document   : AddRole.jsp
    Created on : Jul 22, 2024, 2:29:08 PM
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
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">Quản lý Setting cửa hàng</a>
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
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
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
                            <ol class="breadcrumb mb-4" style="padding-top: 24px">                              
                                <li class="breadcrumb-item active"><a href="rolemanager">Quản lý Role</a></li>
                                <li class="breadcrumb-item">Thêm Role</li>
                            </ol>

                            <form action="addrole" method="post">

                                <div class="card mb-4">
                                     
                                    <div class="card-header" >
                                        <i class="fas fa-table me-1"></i>
                                       
                                </div>
                                    <h3 class="error-message">
                                        ${errorMessage}
                                    </h3>

                                <div class="card-body">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Role ID</th>
                                                <th>Tên Role</th>                                                    
                                            </tr>
                                        </thead>
                                        <tbody>                                       
                                            <tr>
                                                <td>
                                                    <input type="number" name="id" style="height: 35px; width: 60px" value="${id}" required=""/>
                                                </td>
                                                <td>
                                                    <input type="text" name="name" size="30" style="height: 35px" value="${name}" required=""/>
                                                </td>
                                            </tr>                                         
                                        </tbody>

                                    </table>

                                </div>
                                <button
                                    class="button-update"
                                    style="transform: translateX(70vw) ; width: 10%"
                                    onclick="document.getElementById('updatedProduct').submit();">
                                    THÊM
                                </button>
                            </div>
                        </form>

                    </div>                    
                </main>
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



                </style>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/datatables-simple-demo.js"></script>
    </body>
</html>

