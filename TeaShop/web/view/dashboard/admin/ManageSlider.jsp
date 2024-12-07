<%-- 
    Document   : MangageSlider
    Created on : Feb 24, 2024, 8:57:41 PM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>MKT Page</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet"/>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <style>
            img{
                width: 200px;
                height: 150px;
            }
            .checkbox-option {
                display: inline-block;
                margin-right: 10px;
            }
            .hidden {
                display: none;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="manageCustomer">Quản lí Slide</a>
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
                        <li><a class="dropdown-item" href="#!">Cài đặt</a></li>
                        <li><a class="dropdown-item" href="#!">Hồ sơ</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Đăng xuất</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
  <jsp:include page="../../common/admin/sidebarAdmin.jsp"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4"></h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="UserChartByDay">Dashboard</a></li>
                            <li class="breadcrumb-item active"> Danh sách Slider </li>
                        </ol>
                        <div id="checkbox_div">
                            <p>MỞ / Ẩn Cột:</p>                           
                        </div>
                        <br/>
                        <form action="filterslide" method="post" class="filter-form" onsubmit="return handleFormSubmit(event)">
                            <label for="status-filter">Status:</label>
                            <select id="status-filter" name="status">
                                <option value="">Tất cả</option>
                                <option value="1">Hoạt động</option>
                                <option value="0">Không hoạt động</option>
                            </select>
                            <button type="submit" class="btn btn-secondary btn-number">Lọc</button>
                        </form>
                        <br/>
                        <div class="card mb-4">
                            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                                <i class="fas fa-table me-1"></i>
                                <a href="AddSlider.jsp" class="btn btn-success" style="display: flex; justify-content: center; align-items: center;">
                                    <i class="material-icons"></i> <span>Thêm mới slide</span>
                                </a>
                            </div>

                            <div class="card-body">                              
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Ảnh</th>
                                            <th>Tên</th>
                                            <th>Status</th>
                                            <th>Hành động</th>
                                            <th>Xóa</th>
                                            <th>Sửa</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ID</th>
                                            <th>Ảnh</th>
                                            <th>Tên</th>
                                            <th>Status</th>
                                            <th>Hành động</th>
                                            <th>Xóa</th>
                                            <th>Sửa</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach items="${list}" var="s">
                                            <tr>
                                                <td>${s.id}</td>
                                                <td>
                                                    <img src="${s.image}">
                                                </td>
                                                <td><a href="slidedetail?id=${s.id}">${s.name}</a></td>
                                                <td>${s.status==1 ? 'Active' : 'Inactive'}</td>
                                                
                                                <td>
                                                    <c:if test="${s.status == 1}">
                                                        <div class="col">
                                                            <a href="inactiveslider?id=${s.id}" class="btn btn-danger btn-block" style="color: white;">Ẩn</a>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${s.status == 0}">
                                                        <div class="col">
                                                            <a href="activeslider?id=${s.id}" class="btn btn-success btn-block" style="color: white;">MỞ</a>
                                                        </div>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <a href="#" onclick="doDelete('${s.id}')">
                                                        <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a href="updatesliderdetail?id=${s.id}" class="edit" data-toggle="modal">
                                                        <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Tea Shop - Admin Management</div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
        <script src="js/manager.js" type="text/javascript"></script>
        <script type="text/javascript">
                                                        function doDelete(id) {
                                                            if (confirm("Bạn có thật sự muốn xóa slider này?")) {
                                                                window.location.href = "deleteslider?id=" + id;
                                                            }
                                                        }
        </script>
        <script>
            function handleFormSubmit(event) {
                var statusFilter = document.getElementById('status-filter');
                if (statusFilter.value === "") {
                    // Call the function to display all posts
                    displayAllPosts();
                    // Prevent the form submission
                    event.preventDefault();
                }
            }
            function displayAllPosts() {
                window.location.href = "manageslide";
            }
        </script>

        <script>
            window.onload = function () {
                var table = document.getElementById("datatablesSimple");
                var headerRow = table.getElementsByTagName("thead")[0].getElementsByTagName("tr")[0];
                var headerCells = headerRow.getElementsByTagName("th");
                var checkboxContainer = document.getElementById("checkbox_div");

                for (var i = 0; i < headerCells.length; i++) {
                    var checkboxDiv = document.createElement("div");
                    checkboxDiv.className = "checkbox-option";

                    var checkbox = document.createElement("input");
                    checkbox.type = "checkbox";
                    checkbox.id = "checkbox" + i; // Đặt id cho checkbox
                    checkbox.onchange = new Function("toggleColumn(" + i + ");");

                    var label = document.createElement("label");
                    label.htmlFor = "checkbox" + i; // Liên kết label với checkbox
                    label.innerText = headerCells[i].innerText;

                    checkboxDiv.appendChild(checkbox);
                    checkboxDiv.appendChild(label);
                    checkboxContainer.appendChild(checkboxDiv);
                }
            }

            function toggleColumn(columnIndex) {
                var table = document.getElementById("datatablesSimple");
                var headerRow = table.getElementsByTagName("thead")[0].getElementsByTagName("tr")[0];
                var bodyRows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

                // Ẩn/hiện cột trong hàng tiêu đề
                var headerCell = headerRow.getElementsByTagName("th")[columnIndex];
                headerCell.classList.toggle("hidden");

                // Ẩn/hiện cột trong các hàng dữ liệu
                for (var i = 0; i < bodyRows.length; i++) {
                    var bodyCell = bodyRows[i].getElementsByTagName("td")[columnIndex];
                    bodyCell.classList.toggle("hidden");
                }
            }
        </script>
    </body>
</html>