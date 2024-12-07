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
                    <main>
                        <div class="mt-4">

                            <div class="container-fluid px-4">
                                <c:if test="${not empty message}">
                                <div class="alert alert-danger " role="alert" style="text-align: center; padding-top:10px">
                                    ${message}
                                </div>
                            </c:if>
                                <div class="mt-3 mb-3">
                                    <button class="btn btn-primary" onclick="toggleForm('byOrderId')">Tìm kiếm theo ID hóa đơn</button>
                                    <button class="btn btn-primary" onclick="toggleForm('byInfo')">Tìm kiếm theo thông tin</button>
                                </div>
                                <form action="Staff" method="post" id="searchByOrderIdForm" style="display: none;">
                                    <input type="hidden" name="service" value="search">
                                    <input type="hidden" name="search" value="byOrderId">     
                                    <div class="form-group row">
                                        <label for="order_id_search" class="col-sm-2 col-form-label">ID hóa đơn:</label>
                                        <div class="col-sm-3">
                                            <input type="number" class="form-control" id="order_id_search" name="order_id_search" value="${order_id_search}">
                                    </div>
                                </div>                        
                                <button type="submit" class="btn btn-primary mt-3">Tìm kiếm</button>
                            </form>

                            <form action="Staff" method="post" id="searchByInfoForm" style="display: none;">
                                <input type="hidden" name="service" value="search">
                                <input type="hidden" name="search" value="byInfo">

                                <h6>Chỉ điền vào nhứng ô mà bạn cần lọc</h6>
                                <div class="form-group row" style="padding-top : 10px">
                                    <label for="full_name" class="col-sm-3 col-form-label">Họ và tên:</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="full_name" name="full_name" value="${full_name}">
                                    </div>
                                </div>

                                <div class="form-group row" style="padding-top : 10px">
                                    <p class="col-sm-2 col-form-label">Tổng tiền hóa đơn:</p>
                                    <label for="lower_amount" class="col-sm-1 col-form-label">Tối thiểu:</label>
                                    <div class="col-sm-4">
                                        <input type="number" class="form-control" id="lower_amount" name="lower_amount" value="${lower_amount}">
                                    </div>
                                    <label for="upper_amount" class="col-sm-1 col-form-label">Tối đa:</label>
                                    <div class="col-sm-4">
                                        <input type="number" class="form-control" id="upper_amount" name="upper_amount" value="${upper_amount}">
                                    </div>
                                </div>

                                <div class="form-group row" style="padding-top : 10px">
                                    <p class="col-sm-2 col-form-label">Ngày tạo đơn hàng:</p>
                                    <label for="lower_date" class="col-sm-1 col-form-label">Sau ngày:</label>
                                    <div class="col-sm-4">
                                        <input type="date" class="form-control" id="lower_date" name="lower_date" value="${lower_date}">
                                    </div>
                                    <label for="upper_date" class="col-sm-1 col-form-label">Trước ngày:</label>
                                    <div class="col-sm-4">
                                        <input type="date" class="form-control" id="upper_date" name="upper_date" value="${upper_date}">
                                    </div>
                                </div>

                                <div class="form-group row" style="padding-top : 10px">
                                    <label for="status_id_search" class="col-sm-3 col-form-label">Trạng thái hóa đơn:</label>
                                    <div class="col-sm-3">
                                        <select class="form-control" id="status_id_search" name="status_id_search">
                                            <option value="">Tất cả</option>
                                            <option value="1" ${status_id_search == 1 ? 'selected' : ''}>Chờ xác nhận</option>
                                            <option value="2" ${status_id_search == 2 ? 'selected' : ''}>Chờ làm đơn hàng</option>
                                            <option value="3" ${status_id_search == 3 ? 'selected' : ''}>Chờ giao hàng</option>
                                            <option value="4" ${status_id_search == 4 ? 'selected' : ''}>Hoàn thành</option>
                                            <option value="5" ${status_id_search == 5 ? 'selected' : ''}>Đơn hàng giao không thành công</option>
                                            <option value="6" ${status_id_search == 6 ? 'selected' : ''}>Đã hủy đơn hàng</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row" style="padding-top : 10px">
                                    <label for="payment_method_search" class="col-sm-3 col-form-label">Phương thức thanh toán:</label>
                                    <div class="col-sm-3">
                                        <select class="form-control" id="payment_method_search" name="payment_method_search">
                                            <option value="">Tất cả</option>
                                            <option value="COD" ${payment_method_search == 'COD' ? 'selected' : ''}>COD</option>
                                            <option value="VNPay" ${payment_method_search == 'VNPay' ? 'selected' : ''}>VNPay</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-sm-12">
                                        <button type="submit" class="btn btn-primary mt-3">Tìm kiếm</button>
                                    </div>
                                </div>
                            </form>

                            <script>
                                let currentForm = '';

                                function toggleForm(formType) {
                                    const orderIdForm = document.getElementById('searchByOrderIdForm');
                                    const infoForm = document.getElementById('searchByInfoForm');

                                    if (currentForm === formType) {
                                        // Hide form if the button is clicked again
                                        orderIdForm.style.display = 'none';
                                        infoForm.style.display = 'none';
                                        currentForm = '';
                                    } else {
                                        // Show the corresponding form
                                        orderIdForm.style.display = formType === 'byOrderId' ? 'block' : 'none';
                                        infoForm.style.display = formType === 'byInfo' ? 'block' : 'none';
                                        currentForm = formType;
                                    }
                                }
                            </script>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger " role="alert" style="text-align: center; padding-top:10px">
                                    ${errorMessage}
                                </div>
                            </c:if>
                            <c:if test="${empty listOrders}">
                                <div class="row justify-content-center align-items-top" style="height: 100vh;">
                                    <div class="col-auto">
                                        <h4>Không tìm thấy đơn hàng nào</h4>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${not empty listOrders}">
                                <h5 style="padding-top : 10px">Số đơn hàng tìm thấy: ${listOrders.size()}</h5>
                            </c:if>
                            <c:forEach items="${listOrders}" var="p">

                                <div class="p-4 border border-secondary rounded mt-4">
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <a href="stafforderdetails?order_id=${p.order_id}">
                                                <strong>
                                                    <p>ID hóa đơn: ${p.order_id}

                                                    </p></strong></a>

                                            <p>Họ và tên: ${p.full_name}</p>
                                            <p>Số điện thoại: ${p.phone_number}</p>
                                            <p>Thời gian đặt hàng: ${p.formattedOrderDate}</p>
                                            <p>Thời gian giao hàng dự kiến: ${p.formattedEstimated_delivery_date}</p>
                                            <p>Thời gian shipper giao hàng đến cho khách: ${p.formattedShipper_delivery_time} - ${p.deliveryTimeMessage}</p>

                                            <p>Tổng tiền hóa đơn: <fmt:formatNumber value="${p.total_amount}" type="number" groupingUsed="true"/> đồng</p>
                                            <p>Phương thức thanh toán: ${p.payment_method}</p>
                                            <p>Ghi chú của nhân viên: ${p.staff_note}</p>
                                            <p>Ghi chú của khách: ${p.note}</p>
                                            <c:if  test="${current_status_id == 4 || current_status_id == 5}">
                                                <p>Ghi chú của người giao hàng: ${p.shipper_note}</p>

                                            </c:if>
                                        </div>
                                        <div class="col-lg-6">
                                            <p>Đơn hàng:</p>
                                            <table class="table table-striped" style="border-collapse: collapse; width: 100%;">
                                                <colgroup>
                                                    <col style="width: 45%;">
                                                    <col style="width: 20%;">
                                                    <col style="width: 35%;">
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="border: 1px solid black;">Sản phẩm</th>
                                                        <th style="border: 1px solid black;">Số lượng</th>
                                                        <th style="border: 1px solid black;">Topping</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${p.orderDetails}" var="detail">
                                                        <tr>
                                                            <td style="border: 1px solid black;">${detail.product.product_name} (ID: ${detail.product.product_id})</td>
                                                            <td style="border: 1px solid black;">${detail.quantity}</td>
                                                            <td style="border: 1px solid black;">
                                                                <c:set var="toppingsList" value="" />
                                                                <c:forEach items="${detail.topping}" var="topping" varStatus="status">
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
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="col-lg-3">
                                            <h5>Trạng thái: ${p.status.status_name}</h5>
                                            <c:choose>
                                                <c:when test="${p.status.status_id == 1}">
                                                    <!-- Confirm Order Form -->
                                                    <form action="Staff" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xác nhận đơn hàng?')">
                                                        <input type="hidden" name="service" value="updateInSearchOrder">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <input type="hidden" name="status_id" value="2">
                                                        <input type="hidden" name="search" value="${search}">
                                                        <input type="hidden" name="order_id_search" value=${order_id_search}>
                                                        <input type="hidden" name="full_name" value="${full_name}">
                                                        <input type="hidden" name="lower_amount" value="${lower_amount}">
                                                        <input type="hidden" name="upper_amount" value="${upper_amount}">
                                                        <input type="hidden" name="status_id_search" value="${status_id_search}">
                                                        <input type="hidden" name="payment_method_search" value="${payment_method_search}">
                                                        <input type="hidden" name="lower_date" value="${lower_date}">
                                                        <input type="hidden" name="upper_date" value="${upper_date}">
                                                        <div style="display: flex; align-items: center;">
                                                            <button type="submit" class="btn border border-secondary rounded-pill px-3 confirm-green custom-btn">Xác nhận đơn hàng</button>
                                                        </div>
                                                    </form>

                                                    <!-- Cancel Order Form -->
                                                    <form action="Staff" method="post" onsubmit="return validateRefundForm(this)">
                                                        <input type="hidden" name="service" value="refund">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <input type="hidden" name="amount" value="${p.total_amount}">
                                                        <input type="hidden" name="payment_method" value="${p.payment_method}">
                                                        <input type="hidden" name="status_id" value="6">
                                                        <input type="hidden" name="link_id" value="2">
                                                        <input type="hidden" name="search" value="${search}">
                                                        <input type="hidden" name="order_id_search" value=${order_id_search}>
                                                        <input type="hidden" name="full_name" value="${full_name}">
                                                        <input type="hidden" name="lower_amount" value="${lower_amount}">
                                                        <input type="hidden" name="upper_amount" value="${upper_amount}">
                                                        <input type="hidden" name="status_id_search" value="${status_id_search}">
                                                        <input type="hidden" name="payment_method_search" value="${payment_method_search}">
                                                        <input type="hidden" name="lower_date" value="${lower_date}">
                                                        <input type="hidden" name="upper_date" value="${upper_date}">
                                                        <div style="display: flex; align-items: center; margin-top: 16px;">
                                                            <button type="submit" class="btn border border-secondary rounded-pill px-3 confirm-red custom-btn">Huỷ đơn hàng</button>
                                                        </div>
                                                    </form>

                                                    <!-- Complete Order Button -->
                                                    <div style="display: flex; align-items: center; margin-top: 16px;">
                                                        <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn" disabled>Đã xong đơn hàng</button>
                                                        <span style="color: red; margin-left: 10px;">Chờ xác nhận</span>
                                                    </div>
                                                </c:when>

                                                <c:when test="${p.status.status_id == 2}">
                                                    <!-- Confirm Order Form (Already Confirmed) -->
                                                    <div style="display: flex; align-items: center;">
                                                        <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn" disabled>Xác nhận đơn hàng</button>
                                                        <span style="color: red; margin-left: 10px;">Đã xác nhận</span>
                                                    </div>

                                                    <!-- Complete Order Form -->
                                                    <form action="Staff" method="post" onsubmit="return confirm('Bạn có chắc chắn rằng đơn hàng đã hoàn thành?')">
                                                        <input type="hidden" name="service" value="updateInSearchOrder">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <input type="hidden" name="status_id" value="3">
                                                        <input type="hidden" name="search" value="${search}">
                                                        <input type="hidden" name="order_id_search" value=${order_id_search}>
                                                        <input type="hidden" name="full_name" value="${full_name}">
                                                        <input type="hidden" name="lower_amount" value="${lower_amount}">
                                                        <input type="hidden" name="upper_amount" value="${upper_amount}">
                                                        <input type="hidden" name="status_id_search" value="${status_id_search}">
                                                        <input type="hidden" name="payment_method_search" value="${payment_method_search}">
                                                        <input type="hidden" name="lower_date" value="${lower_date}">
                                                        <input type="hidden" name="upper_date" value="${upper_date}">
                                                        <div style="display: flex; align-items: center; margin-top: 16px;">
                                                            <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn confirm-green">Đã xong đơn hàng</button>
                                                        </div>
                                                    </form>
                                                </c:when>
                                            </c:choose>
                                            <script>
                                                function confirmUpdateStatus(orderId, statusId) {
                                                    var form = document.getElementById("updateStatusForm_" + orderId + "_" + statusId);
                                                    if (statusId === 2) {
                                                        if (confirm("Bạn có chắc chắn muốn cập nhật trạng thái đơn hàng này thành Hoàn thành?")) {
                                                            form.submit();
                                                        }
                                                    } else {
                                                        form.submit();
                                                    }
                                                }
                                                function validateRefundForm(form) {
                                                    const staffNote = prompt("Vui lòng nhập lý do huỷ đơn hàng:");
                                                    if (staffNote && staffNote.trim() !== "") {
                                                        // Add the staff_note to the form
                                                        const noteInput = document.createElement('input');
                                                        noteInput.type = 'hidden';
                                                        noteInput.name = 'staff_note';
                                                        noteInput.value = staffNote.trim();
                                                        form.appendChild(noteInput);
                                                        return true; // Allow form submission
                                                    } else {
                                                        alert("Bạn phải nhập lý do huỷ đơn hàng.");
                                                        return false; // Prevent form submission
                                                    }
                                                }
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>


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
