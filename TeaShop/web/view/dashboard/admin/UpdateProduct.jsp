<%-- 
    Document   : UpdateProduct
    Created on : Jun 25, 2024, 2:39:45 AM
    Author     : Pham Toan
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
            <a class="navbar-brand ps-3" href="index.html">Quản lý sản phẩm</a>
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
                        <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
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
                                <li class="breadcrumb-item active"><a href="productmanager">Quản lý sản phẩm</a></li>
                                <li class="breadcrumb-item">Chỉnh sửa sản phẩm</li>
                            </ol>
                        <c:if test="${UpdateDone ne null}">
                            <h3 class="update-productDone">
                                ${UpdateDone}
                            </h3>
                        </c:if>

                        <c:if test="${errorMessage ne null}">
                            <h4 class="error-message">
                                ${errorMessage}
                            </h4>
                        </c:if>

                        <c:if test="${productUpdate ne null}">
                            <form action="updateProductManager" id="updatedProduct" enctype="multipart/form-data" method="post">
                                <input type="hidden" name="service" value="sendUpdateDetail" />
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-table me-1"></i>
                                    </div>

                                    <div class="card-body">
                                        <table id="datatables-UpdateProduct">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Danh mục</th>
                                                    <th>Hình ảnh</th>
                                                    <th>Giá</th>
                                                    <th>Ngày chỉnh sửa</th>
                                                    <th>Mô tả</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><input type="number" name="id" style="height: 35px; width: 60px" value="${productUpdate.product_id}" readonly /></td>
                                                    <td>
                                                        <input type="text" name="name" size="30" style="height: 35px" value="${param.name != null ? param.name : productUpdate.product_name}"/>
                                                    </td>
                                                    <td>
                                                        <select name="category" style="width: 180px; height: 35px">
                                                            <c:forEach items="${allCategorys}" var="category">
                                                                <option value="${category.category_id}" ${param.category != null ? (category.category_id == param.category ? 'selected' : '') : (category.category_id == productUpdate.category.category_id ? 'selected' : '')}>
                                                                    ${category.category_name}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <div class="file-input-wrapper">
                                                            <input type="file" name="image_url" id="file-upload" />
                                                            <label for="file-upload" class="custom-file-label">Chọn ảnh</label>
                                                            <span id="file-name" class="file-name-label">Không có tệp nào được chọn</span>
                                                        </div>
                                                        
                                                    </td>
                                                    <td>
                                                        <input type="number" name="price" size="15" style="height: 35px" step="1" min="1" value="${param.price != null ? param.price : productUpdate.price}"/>
                                                    </td>
                                                    <td>
                                                        <input type="date" name="create_at" style="height: 35px" value="${param.create_at != null ? param.create_at : productUpdate.create_at}"/>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="description" size="35" style="height: 35px" value="${param.description != null ? param.description : productUpdate.description}"/>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <button
                                        class="button-update"
                                        style="transform: translateX(70vw); width: 10%"
                                        onclick="document.getElementById('updatedProduct').submit();">
                                        Chỉnh sửa
                                    </button>
                                </div>
                            </form>
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
                    .error-message{
                        display: flex; /* Sử dụng flexbox */
                        justify-content: center; /* Căn giữa ngang */
                        align-items: center; /* Căn giữa dọc */
                        color: #ff0000;
                        text-align: center; /* Căn giữa nội dung bên trong (nếu cần) */
                    }
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

                    .file-input-wrapper {
                        position: relative;
                        display: inline-block;
                        width: 100%;
                    }

                    .file-input-wrapper input[type="file"] {
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        opacity: 0;
                        cursor: pointer;
                    }

                    .custom-file-label {
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

                    .file-input-wrapper .file-name-label {
                        display: inline-block;
                        padding: 2px 2px;
                        font-size: 16px;
                        color: #333;
                        vertical-align: middle;
                        max-width: 150px; /* Giới hạn chiều rộng tối đa */
                        white-space: nowrap; /* Không cho phép xuống dòng */
                        overflow: hidden; /* Ẩn phần nội dung tràn */
                        text-overflow: ellipsis;
                    }

                    .custom-file-label:hover {
                        background-color: #0B3649; /* Màu nền khi hover */
                        color: white;
                    }

                    .custom-file-label:active {
                        background-color: #3e8e41; /* Màu nền khi nhấn giữ */
                        transform: translateY(2px); /* Hiệu ứng nhấn xuống */
                    }

                </style>
                <script>
                    document.getElementById('file-upload').addEventListener('change', function () {
                        var fileName = this.files.length ? this.files[0].name : 'Không có tệp nào được chọn';
                        document.getElementById('file-name').textContent = fileName;
                    });
                </script>
            </div>
                 
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/datatables-simple-demo.js"></script>
    </body>
</html>



