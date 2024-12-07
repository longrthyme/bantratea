<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><!DOCTYPE html><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en-US" dir="ltr">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <!-- ===============================================-->
        <!--    Document Title-->
        <!-- ===============================================-->
        <title>Falcon | Dashboard &amp; Web App Template</title>


        <!-- ===============================================-->
        <!--    Favicons-->
        <!-- ===============================================-->
        <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/assets/img/favicons/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/assets/img/favicons/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/assets/img/favicons/favicon-16x16.png">
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicons/favicon.ico">
        <link rel="manifest" href="${pageContext.request.contextPath}/assets/img/favicons/manifest.json">
        <meta name="msapplication-TileImage" content="${pageContext.request.contextPath}/assets/img/favicons/mstile-150x150.png">
        <meta name="theme-color" content="#ffffff">
        <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
        <script src="${pageContext.request.contextPath}/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>


        <!-- ===============================================-->
        <!--    Stylesheets-->
        <!-- ===============================================-->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/vendors/overlayscrollbars/OverlayScrollbars.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/theme-rtl.min.css" rel="stylesheet" id="style-rtl">
        <link href="${pageContext.request.contextPath}/assets/css/theme.min.css" rel="stylesheet" id="style-default">
        <link href="${pageContext.request.contextPath}/assets/css/user-rtl.min.css" rel="stylesheet" id="user-style-rtl">
        <link href="${pageContext.request.contextPath}/assets/css/user.min.css" rel="stylesheet" id="user-style-default">
        <script>
            var isRTL = JSON.parse(localStorage.getItem('isRTL'));
            if (isRTL) {
                var linkDefault = document.getElementById('style-default');
                var userLinkDefault = document.getElementById('user-style-default');
                linkDefault.setAttribute('disabled', true);
                userLinkDefault.setAttribute('disabled', true);
                document.querySelector('html').setAttribute('dir', 'rtl');
            } else {
                var linkRTL = document.getElementById('style-rtl');
                var userLinkRTL = document.getElementById('user-style-rtl');
                linkRTL.setAttribute('disabled', true);
                userLinkRTL.setAttribute('disabled', true);
            }
        </script>

    </head>


    <body>


        <!-- ===============================================-->
        <!--    Main Content-->
        <!-- ===============================================-->
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

                    <jsp:include page="../../common/dashboard/shipper/topbar.jsp"></jsp:include>
                        <div class="card mb-3">
                            <div class="bg-holder d-none d-lg-block bg-card" style="background-image:url(../../../assets/img/icons/spot-illustrations/corner-4.png);opacity: 0.7;"></div>
                            <div class="card-body position-relative">
                                <h5>Chi tiết đơn hàng: #${orders.order_id}</h5>
                            <p class="alert alert-warning highlighted-text me-2">
                                Thời gian giao hàng chỉ định: ${orders.formattedOrderDate} đến ${orders.formattedEstimated_delivery_date}
                            </p>
                            <p class="me-2">Thời gian bạn giao hàng cho khách: ${orders.formattedShipper_delivery_time}</p>
                            <p class="me-2">${orders.deliveryTimeMessage}</p>


                            <div><strong class="me-2">Trạng thái: </strong>
                                <c:choose>
                                    <c:when test="${orders.status.status_name == 'Chờ xác nhận'}">
                                        <span class="badge rounded-pill badge-soft-success fs--2">
                                            Chờ xác nhận<span class="ms-1 fas fa-stream" data-fa-transform="shrink-2"></span>
                                        </span>
                                    </c:when>
                                    <c:when test="${orders.status.status_name == 'Chờ giao hàng'}">
                                        <span class="badge rounded-pill badge-soft-success fs--2">
                                            Chờ giao hàng<span class="ms-1 fas fa-redo" data-fa-transform="shrink-2"></span>
                                        </span>
                                    </c:when>
                                    <c:when test="${orders.status.status_name == 'Hoàn thành'}">
                                        <span class="badge rounded-pill badge-soft-success fs--2">
                                            Hoàn thành<span class="ms-1 fas fa-check" data-fa-transform="shrink-2"></span>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge rounded-pill badge-soft-success fs--2">
                                            ${orders.status.status_name}<span class="ms-1 fas fa-question-circle" data-fa-transform="shrink-2"></span>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
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
                                                <th class="border-0 text-end">Giá</th>
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
                                                    <td class="align-middle text-end">
                                                        <img src="${pageContext.request.contextPath}/${lod.image}"  width="100" class="mt-2"/>
                                                    </td>
                                                    <td class="align-middle text-center">
                                                        <form action="shipdetail" method="post" enctype="multipart/form-data" class="d-inline" onsubmit="return validateForm(this);">
                                                            <input type="hidden" name="order_id" value="${orders.order_id}" />
                                                            <input type="hidden" name="orderDetailsId" value="${lod.order_details_id}" />
                                                            <input type="hidden" name="deliveryTime" value="<%= session.getAttribute("savedTime") != null ? session.getAttribute("savedTime") : ""%>">
                                                            <c:if test="${orders.status.status_id != 4 && orders.status.status_id != 5}">
                                                                <div class="custom-file mb-3">
                                                                    <input type="file" class="custom-file-input" id="fileUpload${lod.order_details_id}" name="fileUpload${lod.order_details_id}" accept="image/*" onchange="previewImage(event, ${lod.order_details_id})">
                                                                </div>
                                                                <button type="submit" class="btn btn-primary">Upload</button>
                                                            </c:if>
                                                            <c:if test="${not empty lod.image_after_ship}">
                                                                <img src="${pageContext.request.contextPath}/${lod.image_after_ship}" id="imagePreview${lod.order_details_id}" width="100" class="mt-2"/>
                                                            </c:if>
                                                        </form>
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
                                <h5>Note của Shipper</h5>
                                <form id="shipperNoteForm" action="shipdetail" method="post" enctype="multipart/form-data">
                                    <!-- Các trường form -->
                                    <textarea id="shipperNote" name="shipperNote" class="form-control" rows="3" placeholder="Nhập note của Shipper">${orders.shipper_note}</textarea>
                                    <input type="hidden" name="deliveryTime" value="<%= session.getAttribute("savedTime") != null ? session.getAttribute("savedTime") : ""%>">
                                    <!-- Button submit -->
                                    <c:if test="${orders.status.status_id != 4 && orders.status.status_id != 5}">
                                        <button type="submit" class="btn btn-primary mt-2">Lưu</button>
                                    </c:if>
                                    <!-- Hidden field để truyền order_id -->
                                    <input type="hidden" name="order_id" value="${orders.order_id}">
                                </form>
                            </div>
                            <div class="col-md-4">
                                <h5>Note của Customer</h5>
                                <textarea class="form-control" rows="3" readonly>${orders.note}</textarea>
                            </div>
                            <div class="col-md-4">
                                <h5>Note của Staff</h5>
                                <textarea class="form-control" rows="3" readonly>${orders.staff_note}</textarea>
                            </div>
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
            <div class="modal fade" id="authentication-modal" tabindex="-1" role="dialog" aria-labelledby="authentication-modal-label" aria-hidden="true">
                <div class="modal-dialog mt-6" role="document">
                    <div class="modal-content border-0">
                        <div class="modal-header px-5 position-relative modal-shape-header bg-shape">
                            <div class="position-relative z-index-1 light">
                                <h4 class="mb-0 text-white" id="authentication-modal-label">Register</h4>
                                <p class="fs--1 mb-0 text-white">Please create your free Falcon account</p>
                            </div>
                            <button class="btn-close btn-close-white position-absolute top-0 end-0 mt-2 me-2" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </main>
    <!-- ===============================================-->
    <!--    End of Main Content-->
    <!-- ===============================================-->


    <div class="offcanvas offcanvas-end settings-panel border-0" id="settings-offcanvas" tabindex="-1" aria-labelledby="settings-offcanvas">
        <div class="offcanvas-header settings-panel-header bg-shape">
            <div class="z-index-1 py-1 light">
                <h5 class="text-white"> <span class="fas fa-palette me-2 fs-0"></span>Settings</h5>
                <p class="mb-0 fs--1 text-white opacity-75"> Set your own customized style</p>
            </div>
            <button class="btn-close btn-close-white z-index-1 mt-0" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body scrollbar-overlay px-card" id="themeController">
            <h5 class="fs-0">Color Scheme</h5>
            <p class="fs--1">Choose the perfect color mode for your app.</p>
            <div class="btn-group d-block w-100 btn-group-navbar-style">
                <div class="row gx-2">
                    <div class="col-6">
                        <input class="btn-check" id="themeSwitcherLight" name="theme-color" type="radio" value="light" data-theme-control="theme" />
                        <label class="btn d-inline-block btn-navbar-style fs--1" for="themeSwitcherLight"> <span class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0" src="${pageContext.request.contextPath}/assets/img/generic/falcon-mode-default.jpg" alt=""/></span><span class="label-text">Light</span></label>
                    </div>
                    <div class="col-6">
                        <input class="btn-check" id="themeSwitcherDark" name="theme-color" type="radio" value="dark" data-theme-control="theme" />
                        <label class="btn d-inline-block btn-navbar-style fs--1" for="themeSwitcherDark"> <span class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0" src="${pageContext.request.contextPath}/assets/img/generic/falcon-mode-dark.jpg" alt=""/></span><span class="label-text"> Dark</span></label>
                    </div>
                </div>
            </div>
            <hr />
            <div class="d-flex justify-content-between">
                <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/assets/img/icons/left-arrow-from-left.svg" width="20" alt="" />
                    <div class="flex-1">
                        <h5 class="fs-0">RTL Mode</h5>
                        <p class="fs--1 mb-0">Switch your language direction </p><a class="fs--1" href="../../../documentation/customization/configuration.html">RTL Documentation</a>
                    </div>
                </div>
                <div class="form-check form-switch">
                    <input class="form-check-input ms-0" id="mode-rtl" type="checkbox" data-theme-control="isRTL" />
                </div>
            </div>
            <hr />
            <div class="d-flex justify-content-between">
                <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/assets/img/icons/arrows-h.svg" width="20" alt="" />
                    <div class="flex-1">
                        <h5 class="fs-0">Fluid Layout</h5>
                        <p class="fs--1 mb-0">Toggle container layout system </p><a class="fs--1" href="../../../documentation/customization/configuration.html">Fluid Documentation</a>
                    </div>
                </div>
                <div class="form-check form-switch">
                    <input class="form-check-input ms-0" id="mode-fluid" type="checkbox" data-theme-control="isFluid" />
                </div>
            </div>
            <hr />

            <hr />
            <h5 class="fs-0 d-flex align-items-center">Vertical Navbar Style</h5>
            <p class="fs--1 mb-0">Switch between styles for your vertical navbar </p>
            <p> <a class="fs--1" href="../../../modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See Documentation</a></p>
            <div class="btn-group d-block w-100 btn-group-navbar-style">
                <div class="row gx-2">
                    <div class="col-6">
                        <input class="btn-check" id="navbar-style-transparent" type="radio" name="navbarStyle" value="transparent" data-theme-control="navbarStyle" />
                        <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-transparent"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/assets/img/generic/default.png" alt="" /><span class="label-text"> Transparent</span></label>
                    </div>
                    <div class="col-6">
                        <input class="btn-check" id="navbar-style-inverted" type="radio" name="navbarStyle" value="inverted" data-theme-control="navbarStyle" />
                        <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-inverted"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/assets/img/generic/inverted.png" alt="" /><span class="label-text"> Inverted</span></label>
                    </div>
                    <div class="col-6">
                        <input class="btn-check" id="navbar-style-card" type="radio" name="navbarStyle" value="card" data-theme-control="navbarStyle" />
                        <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-card"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/assets/img/generic/card.png" alt="" /><span class="label-text"> Card</span></label>
                    </div>
                    <div class="col-6">
                        <input class="btn-check" id="navbar-style-vibrant" type="radio" name="navbarStyle" value="vibrant" data-theme-control="navbarStyle" />
                        <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-vibrant"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/assets/img/generic/vibrant.png" alt="" /><span class="label-text"> Vibrant</span></label>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5"><img class="mb-4" src="${pageContext.request.contextPath}/assets/img/icons/spot-illustrations/47.png" alt="" width="120" />
                <h5>Like What You See?</h5>
                <p class="fs--1">Get Falcon now and create beautiful dashboards with hundreds of widgets.</p><a class="mb-3 btn btn-primary" href="https://themes.getbootstrap.com/product/falcon-admin-dashboard-webapp-template/" target="_blank">Purchase</a>
            </div>
        </div>
    </div>


    <!-- ===============================================-->
    <!--    JavaScripts-->
    <!-- ===============================================-->
    <script src="${pageContext.request.contextPath}/vendors/popper/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/anchorjs/anchor.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/is/is.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/fontawesome/all.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/lodash/lodash.min.js"></script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
    <script src="${pageContext.request.contextPath}/vendors/list.js/list.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>

</body>

</html>