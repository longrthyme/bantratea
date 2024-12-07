<%-- 
    Document   : EditSlider
    Created on : Mar 11, 2024, 8:40:27 PM
    Author     : Acer
--%>

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
        <title>Admin Management</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet"/>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
            <div id="layoutSidenav_nav">
            
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="chartorderday">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                            <div class="sb-sidenav-menu-heading">Admin Manager</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Quản lý
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="productmanager">Quản lý Sản phẩm</a>
                                    <a class="nav-link" href="categorymanager">Quản lý Danh mục</a>                                   
                                    <a class="nav-link" href="staffmanager">Quản lý Nhân viên</a>
                                    <a class="nav-link" href="shippermanager">Quản lý Shipper</a>                                    
                                    <a class="nav-link" href="postlist">Quản lý Bài viết</a>
                                    <a class="nav-link" href="manageslide">Quản lý Slide </a>
                                </nav>
                                <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseOrderManagement" aria-expanded="false" aria-controls="collapseOrderManagement">
                            Quản lý Setting cửa hàng
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseOrderManagement" aria-labelledby="headingOne" data-bs-parent="#collapseLayouts">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="rolemanager">
                                    Quản lý Role
                                </a>
                                <a class="nav-link" href="statusmanager">
                                    Quản lý Status
                                </a>
                                <a class="nav-link" href="toppingmanager">
                                    Quản lý Topping
                                </a>                      
                            </nav>
                        </div>
                    </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Pages
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="login.html">Login</a>
                                            <a class="nav-link" href="register.html">Register</a>
                                            <a class="nav-link" href="password.html">Forgot Password</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        Error
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">                                          
                                            <a class="nav-link" href="admin404.jsp">404 Page</a>                                           
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">Add on</div>
                            <a class="nav-link" href="chartsAdmin.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area" ></i></div>
                                Charts
                            </a>
                            <a class="nav-link" href="tables.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Tables
                            </a>
                        </div>
                    </div>
                   
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h3>Update Slider</h3>
                        <form method="post" id="addSliderForm" action="updateslider" enctype="multipart/form-data">
                            <div class="modal-body">                                
                                <input type="hidden" name="id" value="${requestScope.slider.id}">
                                <div class="form-group">
                                    <label>Tên</label>
                                    <input name="name" type="text" class="form-control" value="${requestScope.slider.name}">
                                </div>
                                <div class="form-group">
                                    <label>Ảnh</label>
                                    <input type="hidden" name="original_image" value="${requestScope.slider.image}">
                                    <input name="image" type="file" class="form-control" size="60">
                                </div>
                                <div class="form-group">
                                    <label>Miêu tả</label>
                                    <input name="description" type="text" class="form-control" value="${requestScope.slider.description}">
                                </div>
                                <div class="form-group">
                                    <label>Url</label>
                                    <input name="url" type="text" class="form-control" value="${requestScope.slider.url}">
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <select name="status" class="form-select" aria-label="Default select example" onchange="updateAction(this)">
                                        <option value="1" ${requestScope.slider.status == true ? 'selected' : ''}>Active</option>
                                        <option value="0" ${requestScope.slider.status == false ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <br/>
                            <div style="justify-content: flex-start;">
                                <input type="submit" name="submit" class="btn btn-success" value="Cập nhật">
                                <button type="button" class="btn btn-secondary" onclick="cancelAdd()">Hủy</button>
                            </div>
                        </form>
                    </div>
                    <br/>
                    <div class="container-fluid px-4">
                        <button type="button" class="btn btn-primary" onclick="window.location.href = 'manageslide'">Quay lại </button>
                    </div>
                    <% String updateMessage = (String) request.getAttribute("updateMessage");
                        if (updateMessage != null && !updateMessage.isEmpty()) { %>
                    <div class="alert alert-success" role="alert">
                        <%= updateMessage %>
                    </div>
                    <% } %>
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
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
        <script type="text/javascript">
                            function doDelete(id) {
                                if (confirm("Do you really want to delete this slider?")) {
                                    window.location.href = "deleteslider?id=" + id;
                                }
                            }
        </script>
        <script type="text/javascript">
            function cancelAdd() {
                // Reset the form
                document.getElementById("addSliderForm").reset();
            }
        </script>
    </body>
</html>
