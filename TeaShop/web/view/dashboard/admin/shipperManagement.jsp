<%-- 
    Document   : shipperManagement.jsp
    Created on : Jul 5, 2024, 2:44:12 AM
    Author     : Huyen Tranq
--%>

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
        <title>Admin Management</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="shippermanager">Quản lý Shipper</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
             <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="searchShipper">
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
            <jsp:include page="../../common/admin/sidebarAdmin.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>
                        <div style="margin-top: 20px" class="container-fluid px-4">

                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="chartorderday">Dashboard</a></li>
                                <li class="breadcrumb-item active"><a href="shippermanager" style="color: #37697a" >Quản lý Shipper</a></li>
                            </ol>

                            <div class="card mb-4">
                                <div class="h1">                                
                                    <a href="adduser"><ion-icon name="add-circle-outline"></ion-icon> Thêm shipper mới</a>                               
                                </div>  
                            </div>     
                                               
                       
                        <div class="card mb-4">
                            <div class="card-header">
                                
                            <div class="filter1">
                                <form action="filtershipper">
                                     <div class="filter" style="display: flex; align-items: center;">
                                                <select name="gender" class="filter-select">
                                                    <option value="">Giới tính</option>
                                                    <option value="Female" ${'Female' == gender ? "selected" : ""}>Female</option>
                                                <option value="Male" ${'Male' == gender ? "selected" : ""}>Male</option>
                                            </select>
                                            <select name="status" class="filter-select">
                                                <option value="">Status</option>
                                                <c:forEach items="${listas}" var="s">
                                                    <option value="${s.getStatus_id()}" ${s.getStatus_id() == status ? "selected" : ""}>${s.getStatus_name()}</option>
                                                </c:forEach>
                                            </select>
                                            <input type="submit" value="Tìm kiếm" class="filter-submit"/>
                                        </div>
                            </form>                             
                        </div>
                            </div>
                            <form action="shippermanager">
                                <div class="card-body">
                                    <table id="datatablesSimple">
                                        <thead>
                                            <tr>
                                                <th>Họ Tên</th>
                                                <th>Giới tính</th>
                                                <th>Email</th>
                                                <th>Số điện thoại</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                                <th>Chỉnh sửa</th>
                                            </tr>
                                        </thead>                                           
                                        <tbody>
                                            <c:forEach items="${listShipper}" var="lp">
                                                <tr>                                                 
                                                    <td>${lp.user_name}</td>
                                                    <td>${lp.gender}</td>
                                                    <td>${lp.email}</td>
                                                    <td>${lp.phone_number}</td>
                                                    <td>${lp.role_name}</td>
                                                    <td>${lp.status_name}</td>
                                                    <td><a href="editShipper?id=${lp.account_id}"><ion-icon name="create-outline"></ion-icon></a>
                                                        <a href="deleteshipper?id=${lp.account_id}"><ion-icon name="trash-outline"></ion-icon></a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                            </form>
                        </div>
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
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/datatables-simple-demo.js"></script>
        <script src="https://unpkg.com/ionicons@5.0.0/dist/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    </body>
</html>


