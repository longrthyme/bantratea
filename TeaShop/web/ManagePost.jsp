
<%-- 
    Document   : ManagePost
    Created on : Feb 28, 2024, 8:41:37 AM
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
            <a class="navbar-brand ps-3" href="manageCustomer">Marketing</a>
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
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i> ${sessionScope.account.fullName}</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="userProfile">Profile</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Menu</div>
                            <a class="nav-link" href="UserChartByWeek">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Customer 
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="manageCustomer">Customer Tables</a>
                                    <a class="nav-link" href="addNewCustomer.jsp">Add New Customer</a>
                                </nav>
                            </div>
                            

                            
                            <a class="nav-link" href="postList">
                                <div class="sb-nav-link-icon"><i class="fa-regular fa-address-card"></i></div>
                                Post Management

                            </a>
                            
                            <a class="nav-link" href="sliderList">
                                <div class="sb-nav-link-icon"><i class="fa-solid fa-sliders"></i></div>
                                Slider Management

                            </a>
                            <a class="nav-link" href="ManageProduct">
                                <div class="sb-nav-link-icon"><i class="fa-brands fa-product-hunt"></i></div>
                                Product Management

                            </a>
                            
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                       Marketing
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4"></h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="UserChartByDay">Dashboard</a></li>
                            <li class="breadcrumb-item active">Post List</li>
                        </ol>
                        <div id="checkbox_div">
                            <p>Show Hide Column:</p>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(0);">ID</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(1);">Image</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(2);">Title</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(3);">Opening</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(4);">Date posted</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(5);">Content</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(6);">Category</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(7);">Author</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(8);">Status</div>
                            <div class="checkbox-option"><input type="checkbox" onchange="toggleColumn(9);">Action</div>
                        </div>
                        <br/>
                        <form action="filterPost" method="post" class="filter-form" onsubmit="return handleFormSubmit(event)">
                            <label for="status-filter">Status:</label>
                            <select id="status-filter" name="status">
                                <option value="">All</option>
                                <option value="true">Active</option>
                                <option value="false">Inactive</option>
                            </select>
                            <button type="submit" class="btn btn-secondary btn-number">Filter</button>
                        </form>
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
                                            <th>Image</th>
                                            <th>Title</th>
                                            <th>Opening</th>
                                            <th>Date posted</th>
                                            <th>Category</th>
                                            <th>Author</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ID</th>
                                            <th>Image</th>
                                            <th>Title</th>
                                            <th>Opening</th>
                                            <th>Date posted</th>
                                            <th>Category</th>
                                            <th>Author</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </tfoot>

                                    <tbody>
                                        <c:forEach items="${data}" var="b">
                                            <tr>
                                                <td>${b.id}</td>                                
                                                <td>
                                                    <img src="img/blog/${b.image}">
                                                </td>
                                                <td><a href="postDetail?id=${b.id}">${b.title}</a></td>
                                                <td>${b.opening}</td>                                
                                                <td>${b.datePosted}</td>                                                           
                                                <td>${b.categoryName}</td>                                
                                                <td>${b.authorName}</td>
                                                <td>${b.status ? 'Active' : 'Inactive'}</td>
                                                <td>
                                                    <c:if test="${b.status == true}">
                                                        <div class="col">
                                                            <a href="inactivePost?id=${b.id}" class="btn btn-danger btn-block" style="color: white;">Hide</a>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${b.status == false}">
                                                        <div class="col">
                                                            <a href="activePost?id=${b.id}" class="btn btn-success btn-block" style="color: white;">Show</a>
                                                        </div>
                                                    </c:if>
                                                    <a href="deletePost?id=${b.id}" class="delete" onclick="return confirm('Do you really want to delete this post?');">
                                                        <i class="material-icons" data-toggle="tooltip" title="Delete">delete</i> <!-- Garbage bin icon -->
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
                            <div class="text-muted">Shopping &copy; Website 2024</div>

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
            function displayAllPosts() {
                window.location.href = "postList";
            }
        </script>
    </body>
</html>

