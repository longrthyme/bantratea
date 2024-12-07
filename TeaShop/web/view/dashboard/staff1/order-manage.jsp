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
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger " role="alert" style="text-align: center">
                                    ${errorMessage}
                                </div>
                            </c:if>
                            <c:if test="${empty listOrders}">
                                <div class="row justify-content-center align-items-top" style="height: 100vh;">
                                    <div class="col-auto">
                                        <c:choose>
                                            <c:when test="${current_status_id == 0}">
                                                <h4>Hiện tại không có đơn hàng nào</h4>
                                            </c:when>
                                            <c:when test="${current_status_id == 1}">
                                                <h4>Hiện tại không có đơn hàng nào cần xác nhận</h4>
                                            </c:when>
                                            <c:when test="${current_status_id == 2}">
                                                <h4>Hiện tại không có đơn hàng nào cần làm</h4>
                                            </c:when>
                                            <c:when test="${current_status_id == 7}">
                                                <h4>Hiện tại không có đơn hàng nào</h4>
                                            </c:when>
                                            <c:when test="${current_status_id == 3}">
                                                <h4>Hiện tại không có đơn hàng nào cần được giao</h4>
                                            </c:when>
                                            <c:when test="${current_status_id == 4}">
                                                <h4>Hiện tại không có đơn hàng đã hoàn thành</h4>
                                            </c:when>
                                            <c:when test="${current_status_id == 6}">
                                                <h4>Hiện tại không có đơn hàng đã bị hủy</h4>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:if>

                            <div style="text-align: center;">
                                <c:choose>
                                    <c:when test="${current_status_id == 0}">
                                        <h4>Tất cả đơn hàng</h4>
                                    </c:when>
                                    <c:when test="${current_status_id == 1}">
                                        <h4>Đơn hàng cần xác nhận</h4>
                                    </c:when>
                                    <c:when test="${current_status_id == 2}">
                                        <h4>Đơn hàng cần làm</h4>
                                    </c:when>
                                    <c:when test="${current_status_id == 7}">
                                        <h4>Chọn nhân viên giao hàng</h4>
                                    </c:when>
                                    <c:when test="${current_status_id == 3}">
                                        <h4>Đơn hàng cần được giao</h4>
                                    </c:when>
                                    <c:when test="${current_status_id == 4}">
                                        <h4>Đơn hàng đã hoàn thành</h4>
                                    </c:when>
                                    <c:when test="${current_status_id == 6}">
                                        <h4>Đơn hàng đã bị hủy</h4>
                                    </c:when>
                                </c:choose>
                            </div>

                            <h5>Số đơn hàng: ${number_of_orders}</h5>

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
                                            <p>Nhân viên giao hàng: ${p.accountShip.user_name}</p>
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
                                                <c:when test="${current_status_id == 0}">
                                                    <c:choose>
                                                        <c:when test="${p.status.status_id == 1}">
                                                            <!-- Confirm Order Form -->
                                                            <form action="Staff" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xác nhận đơn hàng?')">
                                                                <input type="hidden" name="service" value="update">
                                                                <input type="hidden" name="order_id" value="${p.order_id}">
                                                                <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                                <input type="hidden" name="status_id" value="2">
                                                                <div style="display: flex; align-items: center;">
                                                                    <button type="submit" class="btn border border-secondary rounded-pill px-3 confirm-green custom-btn">Xác nhận đơn hàng</button>
                                                                </div>
                                                            </form>

                                                            <!-- Cancel Order Form -->
                                                            <form action="Staff" method="post" onsubmit="return validateRefundForm(this)">
                                                                <input type="hidden" name="service" value="refund">
                                                                <input type="hidden" name="order_id" value="${p.order_id}">
                                                                <input type="hidden" name="amount" value="${p.total_amount}">
                                                                <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                                <input type="hidden" name="payment_method" value="${p.payment_method}">
                                                                <input type="hidden" name="status_id" value="6">
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
                                                                <input type="hidden" name="service" value="update">
                                                                <input type="hidden" name="order_id" value="${p.order_id}">
                                                                <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                                <input type="hidden" name="status_id" value="7">
                                                                <div style="display: flex; align-items: center; margin-top: 16px;">
                                                                    <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn confirm-green">Đã xong đơn hàng</button>
                                                                </div>
                                                            </form>
                                                        </c:when>
                                                        <c:when test="${p.status.status_id == 7}">
                                                            <!-- Confirm Order Form (Already Confirmed) -->
                                                            <div style="display: flex; align-items: center;">
                                                                <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn" disabled>Xác nhận đơn hàng</button>
                                                                <span style="color: red; margin-left: 10px;">Đã xác nhận</span>

                                                            </div>
                                                            <div style="display: flex; align-items: center; margin-top: 16px;">
                                                                <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn" disabled>Đơn hàng cần làm</button>
                                                                <span style="color: red; margin-left: 10px;">Đã làm xong</span>
                                                            </div>
                                                            <button class="btn btn-md bg-light border mt-4" data-bs-toggle="modal" data-bs-target="#feedbackModal"
                                                                    onclick="setOrderId(${p.order_id})">
                                                                Chọn nhân viên giao hàng
                                                            </button>
                                                            <script>
                                                                function setOrderId(order_id) {
                                                                    var orderIdInput = document.getElementById('order_id');
                                                                    if (orderIdInput) {
                                                                        orderIdInput.value = order_id;
                                                                    }
                                                                }

                                                                function selectShipper(shipper_id) {
                                                                    // Cập nhật giá trị của shipper_id
                                                                    var shipperIdInput = document.getElementById('shipper_id');
                                                                    if (shipperIdInput) {
                                                                        shipperIdInput.value = shipper_id;
                                                                    }

                                                                    // Submit form
                                                                    document.getElementById('feedbackForm').submit();
                                                                }
                                                            </script>



                                                            <!-- Modal -->
                                                            <!-- Modal -->
                                                            <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title" id="feedbackModalLabel">Danh sách nhân viên giao hàng</h5>
                                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <ul class="list-group">
                                                                                <form id="feedbackForm" method="post" action="Staff">
                                                                                    <!-- Dynamic content -->
                                                                                    <c:forEach items="${listAccountShipper}" var="las">
                                                                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                                                                            <div>
                                                                                                <strong>${las.user_name}</strong><br>
                                                                                                <small>${las.phone_number}</small><br>
                                                                                                <small>${las.email}</small><br>
                                                                                                <input type="hidden" name="service" value="updateShipOrder">
                                                                                                <input type="hidden" name="order_id" id="order_id" value="">
                                                                                                <!-- Input for shipper_id, will be updated by JavaScript -->
                                                                                                <input type="hidden" name="shipper_id" id="shipper_id" value="">
                                                                                                <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                                                                <input type="hidden" name="status_id" value="7">
                                                                                                <small>Số lượng đơn hàng đang giao: ${las.listOrderShipper.size()}</small>
                                                                                            </div>
                                                                                            <!-- Nút chọn và submit form -->
                                                                                            <button type="button" class="btn btn-outline-primary btn-sm" onclick="selectShipper('${las.account_id}')">Chọn</button>
                                                                                        </li>
                                                                                    </c:forEach>
                                                                                </form>
                                                                            </ul>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <!-- Complete Order Form -->
                                                            <form action="Staff" method="post" onsubmit="return confirm('Bạn có chắc chắn rằng đơn hàng đã hoàn thành?')">
                                                                <input type="hidden" name="service" value="update">
                                                                <input type="hidden" name="order_id" value="${p.order_id}">
                                                                <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                                <input type="hidden" name="status_id" value="3">
                                                                <div style="display: flex; align-items: center; margin-top: 16px;">
                                                                    <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn confirm-green">Hoàn thành đơn hàng</button>
                                                                </div>
                                                            </form>
                                                        </c:when>
                                                    </c:choose>
                                                </c:when>

                                                <c:when test="${p.status.status_id == 1}">
                                                    <!-- Confirm Order Form -->
                                                    <form action="Staff" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xác nhận đơn hàng?')">
                                                        <input type="hidden" name="service" value="update">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                        <input type="hidden" name="status_id" value="2">
                                                        <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn confirm-green">Xác nhận đơn hàng</button>
                                                    </form>

                                                    <!-- Cancel Order Form -->
                                                    <form action="Staff" method="post" onsubmit="return validateRefundForm(this)">
                                                        <input type="hidden" name="service" value="refund">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <input type="hidden" name="amount" value="${p.total_amount}">
                                                        <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                        <input type="hidden" name="payment_method" value="${p.payment_method}">
                                                        <input type="hidden" name="status_id" value="6">
                                                        <div style="display: flex; align-items: center; margin-top: 16px;">
                                                            <button type="submit" class="btn border border-secondary rounded-pill px-3 confirm-red custom-btn">Huỷ đơn hàng</button>
                                                        </div>
                                                    </form>
                                                </c:when>

                                                <c:when test="${p.status.status_id == 2}">
                                                    <!-- Complete Order Form -->
                                                    <form action="Staff" method="post">
                                                        <input type="hidden" name="service" value="update">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                        <input type="hidden" name="status_id" value="7">
                                                        <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn confirm-green" onclick="confirmUpdateStatus('${p.order_id}', '${p.status.status_id}')">Đã xong đơn hàng</button>
                                                    </form>
                                                </c:when>
                                                <c:when test="${current_status_id == 7}">

                                                    <button class="btn btn-md bg-light border mt-4" data-bs-toggle="modal" data-bs-target="#feedbackModal"
                                                            onclick="setOrderId(${p.order_id})">
                                                        Chọn nhân viên giao hàng
                                                    </button>
                                                    <script>
                                                        function setOrderId(order_id) {
                                                            var orderIdInput = document.getElementById('order_id');
                                                            if (orderIdInput) {
                                                                orderIdInput.value = order_id;
                                                            }
                                                        }

                                                        function selectShipper(shipper_id) {
                                                            // Cập nhật giá trị của shipper_id
                                                            var shipperIdInput = document.getElementById('shipper_id');
                                                            if (shipperIdInput) {
                                                                shipperIdInput.value = shipper_id;
                                                            }

                                                            // Submit form
                                                            document.getElementById('feedbackForm').submit();
                                                        }
                                                    </script>



                                                    <!-- Modal -->
                                                    <!-- Modal -->
                                                    <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="feedbackModalLabel">Danh sách nhân viên giao hàng</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <ul class="list-group">
                                                                        <form id="feedbackForm" method="post" action="Staff">
                                                                            <!-- Dynamic content -->
                                                                            <c:forEach items="${listAccountShipper}" var="las">
                                                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                                                    <div>
                                                                                        <strong>${las.user_name}</strong><br>
                                                                                        <small>${las.phone_number}</small><br>
                                                                                        <small>${las.email}</small><br>
                                                                                        <input type="hidden" name="service" value="updateShipOrder">
                                                                                        <input type="hidden" name="order_id" id="order_id" value="">
                                                                                        <!-- Input for shipper_id, will be updated by JavaScript -->
                                                                                        <input type="hidden" name="shipper_id" id="shipper_id" value="">
                                                                                        <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                                                        <input type="hidden" name="status_id" value="7">
                                                                                        <small>Số lượng đơn hàng đang giao: ${las.listOrderShipper.size()}</small>
                                                                                    </div>
                                                                                    <!-- Nút chọn và submit form -->
                                                                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="selectShipper('${las.account_id}')">Chọn</button>
                                                                                </li>
                                                                            </c:forEach>
                                                                        </form>
                                                                    </ul>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>



                                                    <!-- Complete Order Form -->
                                                    <form action="Staff" method="post" onsubmit="return confirm('Bạn có chắc chắn rằng đơn hàng đã hoàn thành?')">
                                                        <input type="hidden" name="service" value="update">
                                                        <input type="hidden" name="order_id" value="${p.order_id}">
                                                        <input type="hidden" name="current_status_id" value="${current_status_id}">
                                                        <input type="hidden" name="status_id" value="3">
                                                        <div style="display: flex; align-items: center; margin-top: 16px;">
                                                            <button type="submit" class="btn border border-secondary rounded-pill px-3 custom-btn confirm-green">Hoàn thành đơn hàng</button>
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
                                <style>
                                    .custom-btn {
                                        color: black;
                                        background-color: white;
                                        transition: background-color 0.3s ease;
                                    }

                                    .confirm-green:hover {
                                        background-color: #13f240;
                                        color: white;
                                    }

                                    .confirm-red:hover {
                                        background-color: red;
                                        color: white;
                                    }
                                </style>
                            </c:forEach>
                            <div class="pagination-container" style="text-align: center; padding-top: 50px; padding-bottom: 50px; overflow-x: auto; white-space: nowrap;">
                                <div class="pagination" style="display: inline-block;">
                                    <c:forEach var="pageNumber" begin="1" end="${number_of_page}">
                                        <a href="Staff?current_status_id=${current_status_id}&current_page=${pageNumber}" 
                                           class="page-link ${current_page == pageNumber ? 'active' : ''}" 
                                           style="
                                           margin: 0 5px;
                                           display: inline-block;
                                           padding: 10px 15px;
                                           border: 2px solid green;
                                           background-color: lightyellow;
                                           color: black;
                                           text-decoration: none;
                                           border-radius: 5px;
                                           ">
                                            ${pageNumber}
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
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
