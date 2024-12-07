<%-- 
    Document   : productManagement
    Created on : Jun 18, 2024, 10:42:34 PM
    Author     : Pham Toan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
            <a class="navbar-brand ps-3" href="productmanager">Quản lý sản phẩm</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <c:if test="${showSearchProduct ne null}">
                <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="productmanager" id="searchByName">
                    <input type="hidden" name="service" value="searchByKeywords"/>
                    <div class="input-group">
                        <input class="form-control" type="text" placeholder="Nhập tên sản phẩm..." aria-label="Search by Keywords" aria-describedby="btnNavbarSearch" name="keywords"
                               value="${keywords}"/>
                        <button class="search-header" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
                    </div>
                </form>
            </c:if>


            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="home">Home</a></li>

                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                    </ul>
                </li>
            </ul>
        </nav>



        <div id="layoutSidenav">
            <jsp:include page="../../common/admin/sidebarAdmin.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>                   
                        <div class="container-fluid px-4">
                            <ol class="breadcrumb mb-4" style="padding-top: 24px">


                            </ol>

                        <c:if test="${notFoundProduct ne null}">
                            <h4 class="font-weight-semi-bold text-uppercase mb-3 text-center">
                                ${notFoundProduct}
                            </h4>
                        </c:if>


                        <c:if test="${deleteDone ne null}">
                            <h4 class="font-weight-semi-bold text-uppercase mb-3 text-center">
                                ${deleteDone}
                            </h4>
                        </c:if>

                        <c:if test="${errorMessageFilter ne null}">
                            <h5 class="font-weight-semi-bold text-uppercase mb-3 text-center text-danger">
                                ${errorMessageFilter}
                            </h5>
                        </c:if> 
                        <c:if test="${not empty listAllProduct}">
                            <div class="card mb-4">
                                <div class="h1">                                
                                    <a  
                                        href="addProductManager"><ion-icon name="add-circle-outline" ></ion-icon> Thêm sản phẩm mới</a>                                   
                                </div>  
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h6><ion-icon name="filter-outline"></ion-icon> Lọc theo giá sản phẩm</h6>
                                    <form action="productmanager" method="get">
                                        <input type="hidden" name="service" value="searchByPriceRange" />
                                        <label for="priceFrom"></label>
                                        <input type="number" id="priceFrom" name="priceFrom" step="1" min="1" placeholder="Từ" value="${param.priceFrom}" required />
                                        <label for="priceTo">~</label>
                                        <input type="number" id="priceTo" name="priceTo"  step="1" min="1" placeholder="Đến" value="${param.priceTo}" required />
                                        <button class="filerByPrice" type="submit">Tìm kiếm</button>
                                    </form>
                                </div>

                                <!--List all Product-->
                                <div class="card-body">
                                    <table id="datatablesSimple" >  

                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Danh mục</th>
                                                <th>Hình ảnh</th>
                                                <th>Giá</th>
                                                <th>Ngày thêm sản phẩm</th>
                                                <th>Chỉnh sửa</th>
                                                <th>Xóa</th>   
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listAllProduct}" var="product">
                                                <tr>
                                                    <td>${product.product_id}</td>
                                                    <td>${product.product_name}</td>
                                                    <td>${product.category.category_name}</td>
                                                    <td><img src="${product.image}" style="width: 130px" /></td>
                                                        <fmt:setLocale value="vi_VN" />
                                                    <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" /></td>
                                                    <td>${product.create_at}</td>
                                                    <td><a href="updateProductManager?service=requestUpdate&productId=${product.product_id}"><ion-icon name="create-outline"></ion-icon></a></td>
                                                    <td><a href="deleteProductManager?service=requestDelete&productId=${product.product_id}">
                                                            <ion-icon name="trash-outline"></ion-icon></a></td>
                                                </tr>  
                                            </c:forEach>
                                        </tbody>                                   
                                    </table>
                                </div>
                            </div>
                        </c:if>
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

