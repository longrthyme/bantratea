<%-- 
    Document   : addBlog
    Created on : Jun 20, 2024, 9:42:38 PM
    Author     : ADMIN
--%>
<%-- 
    Document   : AddBlog
    Created on : Mar 27, 2024, 8:52:25 PM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
            <a class="navbar-brand ps-3" href="manageCustomer">Quản lí Bài viết</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group"></div>
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
                        <h3>Thêm bài viết</h3>
                        <form method="post" id="addBlogForm" action="addblog" enctype="multipart/form-data" onsubmit="return validateBlogForm()">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="category">Loại:</label>
                                    <select id="category" name="categoryID">
                                        <option value="1">Sản phẩm Reviews</option>
                                        <option value="2">Giảm giá</option>
                                        <option value="3">Giải thưởng</option>
                                        <option value="4">Khác</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Chủ đề</label>
                                    <input type="text" id="title" name="title" required class="form-control">
                                    <span id="titleError" class="text-danger"></span>
                                </div>
                                <div class="form-group">
                                    <label>Ảnh</label>
                                    <input type="file" id="image" name="image" size="60" class="form-control" required>
                                    <span id="imageError" class="text-danger"></span>
                                </div>
                                <div class="form-group">
                                    <label>Nội dung:</label>
                                    <textarea id="content" name="content" class="form-control" required></textarea>
                                    <span id="contentError" class="text-danger"></span>
                                </div>
                            </div>
                            <br />
                            <div style="justify-content: flex-start;">
                                <input type="submit" name="submit" class="btn btn-success" value="Thêm">
                                <button type="button" class="btn btn-secondary" onclick="cancelAdd()">Hủy</button>
                            </div>
                        </form>
                    </div>
                    <br/>
                    <div class="container-fluid px-4">
                        <button type="button" class="btn btn-primary" onclick="window.location.href = 'postlist'">Quay lại </button>
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
                            function cancelAdd() {
                                // Reset the form
                                document.getElementById("addBlogForm").reset();
                            }
        </script>
        <script>
            function validateBlogForm() {
                // Clear any previous error messages
                clearErrorMessages();

                // Validate title
                const title = document.getElementById('title').value.trim();
                if (title.length === 0) {
                    showError('titleError', 'Chủ đề không được để trống');
                    return false;
                } else if (title.length > 255) {
                    showError('titleError', 'Chủ đề tối đa 255 ký tự');
                    return false;
                }

                // Validate image (basic check for presence, you can add more)
                const image = document.getElementById('image').files[0];
                if (!image) {
                    showError('imageError', 'Vui lòng chọn ảnh');
                    return false;
                }

                // Validate content
                const content = document.getElementById('content').value.trim();
                if (content.length === 0) {
                    showError('contentError', 'Nội dung không được để trống');
                    return false;
                }

                // If all validations pass, return true to allow form submission
                return true;
            }

            // Function to clear error messages (same as previous example)
            function clearErrorMessages() {
                const errorElements = document.querySelectorAll('.text-danger');
                for (const errorElement of errorElements) {
                    errorElement.textContent = '';
                }
            }

            // Function to show error message (same as previous example)
            function showError(errorId, errorMessage) {
                const errorElement = document.getElementById(errorId);
                errorElement.textContent = errorMessage;
            }
        </script>

</html>

