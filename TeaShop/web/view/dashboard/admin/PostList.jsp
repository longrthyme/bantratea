

<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <a class="navbar-brand ps-3" href="manageCustomer">Quản lí Bài viết</a>
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
<!--            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Menu</div>
                            <a class="nav-link" href="#">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                            
                            

                            
                            <a class="nav-link" href="postlist">
                                <div class="sb-nav-link-icon"><i class="fa-regular fa-address-card"></i></div>
                                Post Management

                            </a>
                            
                          
                            
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                       Marketing
                    </div>
                </nav>
            </div>-->
            <div id="layoutSidenav_content">
                <form action="postlist" method="post" >
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4"></h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="chartorderday">Dashboard</a></li>
                            <li class="breadcrumb-item active">Danh sách bài viết</li>
                        </ol>
                        
                        <br/>
                       <div style="margin-left: 15px; margin-bottom: 20px">
                                <a href="addBlog.jsp"><button type="button" class="btn btn-danger">Thêm bài viết</button> </a>
                            </div>
                        <br/>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                            </div>
                            <div class="card-body">                              
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Ảnh</th>
                                            <th>Nội dung</th>
                                            
                                            <th>Ngày tạo</th>
                                            
                                            <th>Status</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                           <th>ID</th>
                                            <th>Ảnh</th>
                                            <th>Nội dung</th>
                                            
                                            <th>Ngày tạo</th>
                                            
                                            <th>Status</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </tfoot>

                                    <tbody>
                                        <c:forEach items="${data}" var="b">
                                            <tr>
                                                <td>${b.getId()}</td>                                
                                                <td>
                                                    <img src="${b.getImg()}">
                                                </td>
                                                <td><a href="postdetail?id=${b.getId()}">${b.getBlog_name()}</a></td>
                                                                             
                                                <td>${b.getCreated_at()}</td>                                                           
                                                                             
                                                
                                                <td>${b.isIs_deleted()==0 ? 'Inactive' :'Active'}</td>
                                                <td>
                                                    <c:if test="${b.isIs_deleted() == 0}">
                                                        <div class="col">
                                                            <a href="inactivepost?id=${b.getId()}" class="btn btn-danger btn-block" style="color: white;">Hide</a>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${b.isIs_deleted() == 1}">
                                                        <div class="col">
                                                            <a href="activepost?id=${b.getId()}" class="btn btn-success btn-block" style="color: white;">Show</a>
                                                        </div>
                                                    </c:if>
<!--                                                    <a href="deletepost?id=${b.getId()}" class="delete" onclick="return confirm('Do you really want to delete this post?');">
                                                        <i class="material-icons" data-toggle="tooltip" title="Delete">delete</i>  Garbage bin icon 
                                                    </a>-->
                                                </td> 
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
                    </form>
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
        <script>
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
            
        </script>
    </body>
</html>

