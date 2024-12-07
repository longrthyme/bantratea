<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Orders" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Staff Page</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet"/>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <style>
            img {
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
        <%@ page import="java.util.List" %>
        <%@ page import="entity.OrderDetails" %>
        <%@ page import="entity.Orders" %>
        <%
            // Lưu giá trị thời gian giao hàng dự kiến vào session
            if (request.getParameter("deliveryTime") != null) {
                String savedTime = request.getParameter("deliveryTime");
                session.setAttribute("savedTime", savedTime);
            }
        %>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <p class="navbar-brand ps-3">Nhân viên</p>
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
                        <li><a class="dropdown-item" href="login">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

        <div id="layoutSidenav">
            <jsp:include page="../../common/staff/sidebarStaff.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main class="main" id="top">
                        <div class="container" data-layout="container">
                            <script>
                                var isFluid = JSON.parse(localStorage.getItem('isFluid'));
                                if (isFluid) {
                                    var container = document.querySelector('[data-layout]');
                                    container.classList.remove('container');
                                    container.classList.add('container-fluid');
                                }
                            </script>
                            <nav class="navbar navbar-light navbar-vertical navbar-expand-xl">
                                <script>
                                    var navbarStyle = localStorage.getItem("navbarStyle");
                                    if (navbarStyle && navbarStyle !== 'transparent') {
                                        document.querySelector('.navbar-vertical').classList.add(`navbar-${navbarStyle}`);
                                    }
                            </script>


                        </nav>
                        <div class="content">


                            <div class="card mb-3">
                                <div class="bg-holder d-none d-lg-block bg-card" style="background-image:url(../../../assets/img/icons/spot-illustrations/corner-4.png);opacity: 0.7;"></div>
                                <div class="card-body position-relative">
                                    <h5>Chi tiết đơn hàng: #${orders.order_id}</h5>
                                    <p class="me-2">Thời gian giao hàng: </p>
                                    <p class="me-2">${orders.formattedOrderDate} đến ${orders.formattedEstimated_delivery_date}</p>
                                    <c:if test="${orders.status.status_id == 1 || orders.status.status_id == 2}">
                                        <form id="deliveryForm" action="stafforderdetails" method="post" enctype="multipart/form-data" onsubmit="return validateDeliveryTime()">
                                            <%
                                        String savedTime = request.getParameter("savedTime");
                                            %>
                                            <p class="me-2">
                                                <input type="datetime-local" id="deliveryTime" value="<%= savedTime != null ? savedTime : ""%>" name="deliveryTime" required> 
                                                <input type="hidden" name="orderID" value="${orders.order_id}">
                                                <button type="submit">Lưu thời gian giao hàng dự kiến</button>
                                            </p>
                                        </form>
                                        <p id="error-message" style="color: red;"></p>
                                    </c:if>

                                    <script>
                                        function validateDeliveryTime() {
                                            const deliveryTime = new Date(document.getElementById('deliveryTime').value);
                                            const orderTime = new Date('${orderTimeFormatted}');

                                            if (deliveryTime <= orderTime) {
                                                document.getElementById('error-message').innerText = "Thời gian giao hàng phải sau thời gian tạo đơn hàng.";
                                                return false;
                                            }

                                            return true;
                                        }
                                    </script>
                                    <div><strong class="me-2">Trạng thái: ${orders.status.status_name}</strong>

                                    </div>
                                </div>
                            </div>
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                                            <h5 class="mb-3 fs-0">Thông tin khách hàng</h5>
                                            <h6 class="mb-2">${orders.full_name}</h6>
                                            <p class="mb-1 fs--1">${orders.address}</p>
                                            <p class="mb-0 fs--1"> <strong>Email: </strong>${orders.account.email}</p>
                                            <p class="mb-0 fs--1"> <strong>Phone: </strong>${orders.phone_number}</p>
                                        </div>
                                        <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                                            <h5 class="mb-3 fs-0">Địa chỉ giao hàng</h5>
                                            <h6 class="mb-2">${orders.full_name}</h6>
                                            <p class="mb-1 fs--1">${orders.address}</p>
                                            <div class="text-500 fs--1">(Free Shipping)</div>
                                        </div>
                                        <div class="col-md-6 col-lg-4">
                                            <h5 class="mb-3 fs-0">Phương thức thanh toán</h5>
                                            <h6 class="mb-0">${orders.payment_method}</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="container mt-5">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="table-responsive fs--1">
                                            <table class="table table-striped border-bottom">
                                                <thead class="bg-200 text-900">
                                                    <tr>
                                                        <th class="border-0">Sản phẩm</th>
                                                        <th class="border-0 text-center">Số lượng</th>
                                                        <th class="border-0 text-end">Giá sản phẩm</th>
                                                        <th class="border-0 text-end">Số tiền</th>
                                                        <th class="border-0 text-center">Ảnh trước khi giao</th>
                                                        <th class="border-0 text-center">Ảnh sau khi giao</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${listOrderDetails}" var="lod">
                                                        <tr class="border-200">
                                                            <td class="align-middle">
                                                                <h6 class="mb-0 text-nowrap">${lod.product.product_name}</h6>
                                                                <p class="mb-0">
                                                                    <c:set var="toppingsList" value="" />
                                                                    <c:forEach items="${lod.topping}" var="topping" varStatus="status">
                                                                        <c:set var="toppingsList" value="${toppingsList}${topping.topping_name}${status.last ? '' : ', '}" />
                                                                    </c:forEach>
                                                                    <c:choose>
                                                                        <c:when test="${empty toppingsList}">
                                                                            Không có
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${toppingsList}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </p>
                                                            </td>
                                                            <td class="align-middle text-center">${lod.quantity}</td>
                                                            <td class="align-middle text-end"><fmt:formatNumber value="${lod.product.price}" type="number" groupingUsed="true"/> đồng</td>
                                                            <td class="align-middle text-end">
                                                                <c:set var="toppingCount" value="${fn:length(lod.topping)}" />
                                                                <c:set var="toppingTotal" value="${toppingCount * 6000}" />
                                                                <c:set var="itemTotal" value="${lod.quantity * (lod.product.price + toppingTotal)}" />
                                                                <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                                                                <fmt:formatNumber value="${itemTotal}" type="number" groupingUsed="true"/> đồng
                                                                
                                                            </td>
                                                            <td class="align-middle text-center">
                                                                <form action="stafforderdetails" method="post" enctype="multipart/form-data" class="d-inline" onsubmit="return validateForm(this);">
                                                                    <input type="hidden" name="orderID" value="${orders.order_id}" />
                                                                    <input type="hidden" name="orderDetailsId" value="${lod.order_details_id}" />
                                                                    <input type="hidden" name="deliveryTime" value="<%= session.getAttribute("savedTime") != null ? session.getAttribute("savedTime") : ""%>">
                                                                    <c:if test="${orders.status.status_id == 1 || orders.status.status_id == 2}">
                                                                        <div class="custom-file mb-3">
                                                                            <input type="file" class="custom-file-input" id="fileUpload${lod.order_details_id}" name="fileUpload${lod.order_details_id}" accept="image/*" onchange="previewImage(event, ${lod.order_details_id})">
                                                                        </div>
                                                                        <button type="submit" class="btn btn-primary">Upload</button>
                                                                    </c:if>
                                                                    <c:if test="${not empty lod.image}">
                                                                        <img src="${pageContext.request.contextPath}/${lod.image}" id="imagePreview${lod.order_details_id}" class="img-fluid img-thumbnail mt-2" width="100" />
                                                                    </c:if>
                                                                </form>
                                                            </td>
                                                            <td class="align-middle text-end">
                                                                <img src="${pageContext.request.contextPath}/${lod.image_after_ship}" class="img-fluid img-thumbnail" width="100" />
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                <style>
                                                    .img-thumbnail {
                                                        max-width: 100%;
                                                        height: auto;
                                                        object-fit: cover;
                                                    }
                                                </style>

                                            </table>
                                        </div>
                                        <div class="row g-0 justify-content-end">
                                            <div class="col-auto">
                                                <table class="table table-sm table-borderless fs--1 text-end">
                                                    <tr>
                                                        <th class="text-900">Tổng thanh toán: <fmt:formatNumber value="${orders.total_amount}" type="number" groupingUsed="true"/> đồng</th>

                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <script>
                                function validateForm(form) {
                                    var fileInputs = form.querySelectorAll('input[type="file"]');
                                    var allFilesSelected = true;

                                    fileInputs.forEach(function (fileInput) {
                                        if (!fileInput.value) {
                                            allFilesSelected = false;
                                        }
                                    });

                                    if (!allFilesSelected) {
                                        alert("Vui lòng chọn ảnh trước khi upload.");
                                        return false;
                                    }

                                    return true;
                                }

                                function previewImage(event, orderDetailsId) {
                                    var reader = new FileReader();
                                    reader.onload = function () {
                                        var output = document.getElementById('imagePreview' + orderDetailsId);
                                        output.src = reader.result;
                                    };
                                    reader.readAsDataURL(event.target.files[0]);
                                }
                            </script>

                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-md-4">
                                        <h5>Note của Staff</h5>
                                        <form id="staffNoteForm" action="stafforderdetails" method="post" enctype="multipart/form-data">
                                            <!-- Các trường form -->
                                            <textarea id="staffNote" name="staffNote" class="form-control" rows="3" placeholder="Nhập note của Staff">
                                                <c:if test="${orders.status.status_id != 1 || orders.status.status_id != 2}">
                                                    ${orders.staff_note}
                                                </c:if></textarea>
                                            <input type="hidden" name="deliveryTime" value="<%= session.getAttribute("savedTime") != null ? session.getAttribute("savedTime") : ""%>">
                                            <!-- Button submit -->
                                            <c:if test="${orders.status.status_id == 1 || orders.status.status_id == 2}">
                                                <button type="submit" class="btn btn-primary mt-2">Lưu</button>
                                            </c:if>
                                            <!-- Hidden field để truyền order_id -->
                                            <input type="hidden" name="orderID" value="${orders.order_id}">
                                        </form>
                                    </div>
                                    <div class="col-md-4">
                                        <h5>Note của Customer</h5>
                                        <textarea class="form-control" rows="3" readonly>${orders.note}</textarea>
                                    </div>
                                    <c:if test="${orders.status.status_id == 4 || orders.status.status_id == 5}">
                                        <div class="col-md-4">
                                            <h5>Note của Shipper</h5>

                                            <textarea class="form-control" rows="3" readonly>${orders.shipper_note}</textarea>

                                        </div>
                                    </c:if>
                                </div>
                            </div>   
                        </div>




                        <footer class="footer">
                            <div class="row g-0 justify-content-between fs--1 mt-4 mb-3">
                                <div class="col-12 col-sm-auto text-center">
                                    <p class="mb-0 text-600">Thank you for creating with Falcon <span class="d-none d-sm-inline-block">| </span><br class="d-sm-none" /> 2021 &copy; <a href="https://themewagon.com">Themewagon</a></p>
                                </div>
                                <div class="col-12 col-sm-auto text-center">
                                    <p class="mb-0 text-600">v3.4.0</p>
                                </div>
                            </div>
                        </footer>


                    </div>
                </main>
            </div>
        </div>

        <!-- Bootstrap core JS-->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>

    </body>
</html>
