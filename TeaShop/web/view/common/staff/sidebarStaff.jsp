<%-- 
    Document   : sidebarStaff
    Created on : Jun 19, 2024, 12:05:49 PM
    Author     : Huyen Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div id="layoutSidenav_nav">

    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">Interface</div>

                <nav class="sb-sidenav-menu-nested nav">
                    <a class="nav-link" href="customerManagement">Khách hàng</a>
                </nav>
                 <nav class="sb-sidenav-menu-nested nav">
                    <a class="nav-link" href="CouponManagement">Coupon</a>
                </nav>
                <nav class="sb-sidenav-menu-nested nav">
                    <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#collapseOrderManagement" aria-expanded="true" aria-controls="collapseOrderManagement">
                        Đơn hàng
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>

                    <div class="collapse show" id="collapseOrderManagement" aria-labelledby="headingOne" data-bs-parent="#collapseLayouts">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link ${current_status_id == '0' ? 'text-white' : ''}" href="Staff">
                                Tất cả đơn hàng
                            </a>
                            <a class="nav-link ${current_status_id == '1' ? 'text-white' : ''}" href="Staff?current_status_id=1">
                                Đơn hàng cần xác nhận
                            </a>
                            <a class="nav-link ${current_status_id == '2' ? 'text-white' : ''}" href="Staff?current_status_id=2">
                                Đơn hàng cần làm
                            </a>
                            <a class="nav-link ${current_status_id == '7' ? 'text-white' : ''}" href="Staff?current_status_id=7">
                                Chọn nhân viên giao hàng
                            </a>
                            <a class="nav-link ${current_status_id == '3' ? 'text-white' : ''}" href="Staff?current_status_id=3">
                                Đơn hàng cần được giao
                            </a>
                            <a class="nav-link ${current_status_id == '4' ? 'text-white' : ''}" href="Staff?current_status_id=4">
                                Đơn hàng đã hoàn thành
                            </a>
                            <a class="nav-link ${current_status_id == '6' ? 'text-white' : ''}" href="Staff?current_status_id=6">
                                Đơn hàng đã bị hủy
                            </a>
                            <a class="nav-link" href="Staff?service=search">
                                Tìm kiếm đơn hàng
                            </a>
                        </nav>
                    </div>
                </nav>
                <a class="nav-link" href="saleManager">Sale</a>
                <a class="nav-link" href="fund">Quỹ</a>
            </div>
        </div>
    </nav>
</div>
