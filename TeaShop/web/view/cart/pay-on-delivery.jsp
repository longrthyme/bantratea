<%-- 
    Document   : pay-on-delivery
    Created on : May 27, 2024, 6:03:28 PM
    Author     : HuyTD
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="entity.CartDetails, java.util.Enumeration"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Dreamy Coffee</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar start -->
        <div class="container-fluid fixed-top">

            <div class="container topbar bg-primary d-none d-lg-block">    
                <div class="d-flex justify-content-between">
                    <c:if test="${sessionScope.acc==null}">                                                                    
                        <div class="top-info ps-2">
                            <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Đại học FPT Hà Nội</a></small>
                            <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">dreamycoffee@gmail.com</a></small>            
                        </div>
                        <div class="top-link pe-2">            
                            <a href="${pageContext.request.contextPath}/Signup.jsp" class="text-white"><small class="text-white mx-2">Đăng ký</small>/</a>
                            <a href="${pageContext.request.contextPath}/login" class="text-white"><small class="text-white mx-2">Đăng nhập</small></a>                 
                        </div>           
                    </c:if>
                    <c:if test="${sessionScope.acc!=null}">
                        <div class="top-info ps-2">
                            <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Đại học FPT Hà Nội</a></small>
                            <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">dreamycoffee@gmail.com</a></small>            
                        </div>
                        <div class="top-link pe-2">            
                            <a href="#" class="text-white"><small class="text-white mx-2"> Welcome ${sessionScope.acc.user_name}</small>/</a>
                            <a href="logout" class="text-white"><small class="text-white ms-2">Đăng xuất</small></a>               
                        </div>           
                    </c:if>
                </div>
            </div>

            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="home" class="navbar-brand"><h1 class="text-primary display-6"  >Dreamy Coffee</h1></a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="home" class="nav-item nav-link">Home</a>
                            <a href ="blog" class="nav-item nav-link">Blog</a>
                            <a href="shop" class="nav-item nav-link">Shop</a>
                        </div>

                        <div class="d-flex m-3 me-0">
                            <%
                        int count = 0;
                        Enumeration<String> em = session.getAttributeNames();
                        while (em.hasMoreElements()) {
                            String key = em.nextElement();

                            if (key.startsWith("cartItem")) {
                                count++;
                            }
                        } 
                            %>
                            <a href="CartDetails?service=showcart" class="position-relative me-4 my-auto">
                                <i class="fa fa-shopping-bag fa-2x" style="color: orange;"></i>
                                <%if(count>0){%>
                                <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;"><%=count%></span>
                                <%}%>
                            </a>
                            <c:if test="${sessionScope.acc!=null}">  
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link" data-bs-toggle="dropdown" style="color: black;">
                                        <i class="fas fa-user fa-2x" style="color: black;"></i>
                                    </a>
                                    <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                        <a href="userprofile?email=${sessionScope.acc.email}" class="dropdown-item">Thông tin</a>
                                        <a href="MyOrder" class="dropdown-item">Đơn hàng</a>
                                        <a href="orderCompelete" class="dropdown-item">Đánh giá của bạn</a>
                                    </div>
                                </div>
                            </c:if> 
                            <c:if test="${sessionScope.acc==null}"> 
                                <a href="login" class="nav-link" style="color: black;">
                                    <i class="fas fa-user fa-2x" style="color: black;"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->

        <!-- cart-details Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">            
                <div class="row g-4">
                    <div class="col-lg-12">
                        <h1 class="mb-4"></h1>
                        <div class="row g-4">
                            <div class="col-6"></div>
                            <div class="row g-4">
                                <div class="col-lg-3">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <h4>Loại sản phẩm</h4>
                                                <c:forEach items="${listCategory}" var="cate">
                                                    <ul class="list-unstyled fruite-categorie">
                                                        <li>
                                                            <div class="d-flex justify-content-between fruite-name">
                                                                <a href="shop?search=category&category_id=${cate.category_id}"><i class="fas fa-apple-alt me-2"></i>${cate.category_name}</a>

                                                            </div>
                                                        </li>
                                                    </ul>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div class="container">
                                            <div class="col-lg-12">
                                                <h4 class="mb-3">Sản phẩm nổi bật</h4>
                                                <c:forEach items="${listSpecialProduct}" var="special">
                                                    <div class="d-flex align-items-center mb-4 p-3 border rounded shadow-sm product-card">
                                                        <div class="rounded me-4" style="width: 100px; height: 100px; overflow: hidden;">
                                                            <img src="${special.image}" class="img-fluid rounded" alt="${special.product_name}">
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-2">${special.product_name}</h6>
                                                            <div class="d-flex mb-2 text-warning">
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                            </div>
                                                            <div class="d-flex mb-2">
                                                                <h5 class="fw-bold me-2">${special.price}</h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-lg-9">
                                    <div class="row g-4 justify-content-center"> 
                                        <form id="paymentForm" action="Payment" method="post" onsubmit="return validateAndConfirm()">
                                            <h2>Thanh toán bằng tiền mặt</h2>
                                            <div class="col-md-12 col-lg-12 col-xl-12 mb-4">
                                                <div class="p-4 border border-secondary rounded">
                                                    <p>Họ và tên:</p>
                                                    <input type="text" id="fullname" name="fullname" value="${fullname}" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-lg-12 col-xl-12 mb-4">
                                                <div class="p-4 border border-secondary rounded">
                                                    <p>Địa chỉ nhận hàng:</p>
                                                    <p>Quận: 
                                                        <select id="district" name="district">
                                                            <option value="">Chọn quận</option>
                                                            <option value="Quận Ba Đình" ${district == 'Quận Ba Đình' ? 'selected' : ''}>Ba Đình</option>
                                                            <option value="Quận Hoàn Kiếm" ${district == 'Quận Hoàn Kiếm' ? 'selected' : ''}>Hoàn Kiếm</option>
                                                            <option value="Quận Tây Hồ" ${district == 'Quận Tây Hồ' ? 'selected' : ''}>Tây Hồ</option>
                                                            <option value="Quận Cầu Giấy" ${district == 'Quận Cầu Giấy' ? 'selected' : ''}>Cầu Giấy</option>
                                                            <option value="Quận Đống Đa" ${district == 'Quận Đống Đa' ? 'selected' : ''}>Đống Đa</option>
                                                            <option value="Quận Hai Bà Trưng" ${district == 'Quận Hai Bà Trưng' ? 'selected' : ''}>Hai Bà Trưng</option>
                                                            <option value="Quận Hoàng Mai" ${district == 'Quận Hoàng Mai' ? 'selected' : ''}>Hoàng Mai</option>
                                                            <option value="Quận Thanh Xuân" ${district == 'Quận Thanh Xuân' ? 'selected' : ''}>Thanh Xuân</option>
                                                            <option value="Quận Long Biên" ${district == 'Quận Long Biên' ? 'selected' : ''}>Long Biên</option>
                                                            <option value="Quận Bắc Từ Liêm" ${district == 'Quận Bắc Từ Liêm' ? 'selected' : ''}>Bắc Từ Liêm</option>
                                                            <option value="Quận Nam Từ Liêm" ${district == 'Quận Nam Từ Liêm' ? 'selected' : ''}>Nam Từ Liêm</option>
                                                            <option value="Quận Hà Đông" ${district == 'Quận Hà Đông' ? 'selected' : ''}>Hà Đông</option>
                                                        </select>
                                                    </p>
                                                    <p>Phường: 
                                                        <select id="ward" name="ward">
                                                            <option value="">Chọn phường</option>
                                                        </select>
                                                    </p>
                                                    <p>Số nhà và Tên đường:</p>
                                                    <textarea id="address" name="address" class="form-control" rows="2">${address}</textarea>
                                                </div>
                                            </div>

                                            <script>
                                                const wards = {
                                                    "Quận Ba Đình": ["Cống Vị", "Điện Biên", "Đội Cấn", "Giảng Võ", "Kim Mã", "Liễu Giai", "Ngọc Hà", "Ngọc Khánh", "Nguyễn Trung Trực", "Phúc Xá", "Quán Thánh", "Thành Công", "Trúc Bạch", "Vĩnh Phúc"],
                                                    "Quận Hoàn Kiếm": ["Chương Dương", "Cửa Đông", "Cửa Nam", "Đồng Xuân", "Hàng Bạc", "Hàng Bài", "Hàng Bồ", "Hàng Bông", "Hàng Buồm", "Hàng Đào", "Hàng Gai", "Hàng Mã", "Hàng Trống", "Lý Thái Tổ", "Phan Chu Trinh", "Phúc Tân", "Trần Hưng Đạo", "Tràng Tiền"],
                                                    "Quận Tây Hồ": ["Bưởi", "Nhật Tân", "Phú Thượng", "Quảng An", "Thụy Khuê", "Tứ Liên", "Xuân La", "Yên Phụ"],
                                                    "Quận Cầu Giấy": ["Dịch Vọng", "Dịch Vọng Hậu", "Mai Dịch", "Nghĩa Đô", "Nghĩa Tân", "Quan Hoa", "Trung Hòa", "Yên Hòa"],
                                                    "Quận Đống Đa": ["Cát Linh", "Hàng Bột", "Khâm Thiên", "Khương Thượng", "Kim Liên", "Láng Hạ", "Láng Thượng", "Nam Đồng", "Ngã Tư Sở", "Ô Chợ Dừa", "Phương Liên", "Phương Mai", "Quang Trung", "Quốc Tử Giám", "Thịnh Quang", "Thổ Quan", "Trung Liệt", "Trung Phụng", "Trung Tự", "Văn Chương", "Văn Miếu"],
                                                    "Quận Hai Bà Trưng": ["Bách Khoa", "Bạch Đằng", "Bạch Mai", "Cầu Dền", "Đống Mác", "Đồng Nhân", "Đồng Tâm", "Lê Đại Hành", "Minh Khai", "Nguyễn Du", "Phạm Đình Hổ", "Phố Huế", "Quỳnh Lôi", "Quỳnh Mai", "Thanh Lương", "Thanh Nhàn", "Trương Định", "Vĩnh Tuy"],
                                                    "Quận Hoàng Mai": ["Đại Kim", "Định Công", "Giáp Bát", "Hoàng Liệt", "Hoàng Văn Thụ", "Lĩnh Nam", "Mai Động", "Tân Mai", "Thanh Trì", "Thịnh Liệt", "Trần Phú", "Tương Mai", "Vĩnh Hưng", "Yên Sở"],
                                                    "Quận Thanh Xuân": ["Hạ Đình", "Khương Đình", "Khương Mai", "Khương Trung", "Kim Giang", "Nhân Chính", "Phương Liệt", "Thanh Xuân Bắc", "Thanh Xuân Nam", "Thanh Xuân Trung", "Thượng Đình"],
                                                    "Quận Long Biên": ["Bồ Đề", "Cự Khối", "Đức Giang", "Gia Thụy", "Giang Biên", "Long Biên", "Ngọc Lâm", "Ngọc Thụy", "Phúc Đồng", "Phúc Lợi", "Sài Đồng", "Thạch Bàn", "Thượng Thanh", "Việt Hưng"],
                                                    "Quận Bắc Từ Liêm": ["Cổ Nhuế 1", "Cổ Nhuế 2", "Đông Ngạc", "Đức Thắng", "Liên Mạc", "Minh Khai", "Phú Diễn", "Phúc Diễn", "Tây Tựu", "Thượng Cát", "Thụy Phương", "Xuân Đỉnh", "Xuân Tảo"],
                                                    "Quận Nam Từ Liêm": ["Cầu Diễn", "Đại Mỗ", "Mễ Trì", "Mỹ Đình 1", "Mỹ Đình 2", "Phú Đô", "Phương Canh", "Tây Mỗ", "Trung Văn", "Xuân Phương"],
                                                    "Quận Hà Đông": ["Biên Giang", "Đồng Mai", "Dương Nội", "Hà Cầu", "Kiến Hưng", "La Khê", "Mộ Lao", "Nguyễn Trãi", "Phú La", "Phú Lãm", "Phú Lương", "Phúc La", "Quang Trung", "Vạn Phúc", "Văn Quán", "Yên Nghĩa", "Yết Kiêu"]
                                                };

                                                document.getElementById('district').addEventListener('change', function () {
                                                    const district = this.value;
                                                    const wardSelect = document.getElementById('ward');
                                                    wardSelect.innerHTML = '';

                                                    if (district && wards[district]) {
                                                        wards[district].forEach(function (ward) {
                                                            const option = document.createElement('option');
                                                            option.value = ward;
                                                            option.text = ward;
                                                            wardSelect.appendChild(option);
                                                        });
                                                    } else {
                                                        const defaultOption = document.createElement('option');
                                                        defaultOption.value = '';
                                                        defaultOption.text = 'Chọn phường';
                                                        wardSelect.appendChild(defaultOption);
                                                    }
                                                });

                                                document.addEventListener('DOMContentLoaded', function () {
                                                    const district = "${district}";
                                                    const ward = "${ward}";

                                                    if (district) {
                                                        document.getElementById('district').value = district;
                                                        if (wards[district]) {
                                                            wards[district].forEach(function (wardOption) {
                                                                const option = document.createElement('option');
                                                                option.value = wardOption;
                                                                option.text = wardOption;
                                                                if (wardOption === ward) {
                                                                    option.selected = true;
                                                                }
                                                                document.getElementById('ward').appendChild(option);
                                                            });
                                                        }
                                                    }
                                                });
                                            </script>
                                            <div class="col-md-12 col-lg-12 col-xl-12 mb-4">
                                                <div class="p-4 border border-secondary rounded">
                                                    <p>Số điện thoại:</p>
                                                    <input type="text" id="phonenumber" name="phone_number" value="${phone_number}" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-lg-12 col-xl-12 mb-4">
                                                <div class="p-4 border border-secondary rounded">
                                                    <p>Tổng tiền hóa đơn: <fmt:formatNumber value="${totalCartAmount}" type="number" groupingUsed="true"/> đồng</p>
                                                </div>
                                            </div>
                                            <input type="hidden" name="amount" value="${totalCartAmount}">
                                            <input type="hidden" name="service" value="COD">
                                            <button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary">Xác nhận thanh toán</button>
                                        </form>

                                        <script>
                                            function validateAndConfirm() {
                                                // Regex patterns
                                                const namePattern = /^[a-zA-ZÀ-ỹ]+\s+[a-zA-ZÀ-ỹ]+(?:\s+[a-zA-ZÀ-ỹ]+)*$/;
                                                const addressPattern = /^.{1,200}$/;
                                                const phonePattern = /^0\d{9}$/;

                                                // Form values
                                                const fullname = document.getElementById('fullname').value.trim();
                                                const address = document.getElementById('address').value.trim();
                                                const phonenumber = document.getElementById('phonenumber').value.trim();
                                                const district = document.getElementById('district').value;
                                                const ward = document.getElementById('ward').value;

                                                // Validate name
                                                if (!namePattern.test(fullname) || fullname.length < 1 || fullname.length > 50) {
                                                    alert("Họ và tên chỉ chứa chữ cái và phải có dấu cách ở giữa.");
                                                    return false;
                                                }

                                                // Validate district selection
                                                if (district === "") {
                                                    alert("Bạn phải chọn quận giao hàng.");
                                                    return false;
                                                }

                                                // Validate ward selection
                                                if (ward === "") {
                                                    alert("Bạn phải chọn phường giao hàng.");
                                                    return false;
                                                }

                                                // Validate address
                                                if (!addressPattern.test(address)) {
                                                    alert("Địa chỉ nhận hàng phải dài từ 1 đến 200 ký tự.");
                                                    return false;
                                                }

                                                // Validate phone number
                                                if (!phonePattern.test(phonenumber)) {
                                                    alert("Số điện thoại phải là số chứa đúng 10 chữ số và có số 0 ở đầu.");
                                                    return false;
                                                }



                                                return confirm("Bạn có chắc chắn muốn đặt mua đơn hàng?");
                                            }
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- pay-on-delivery End-->        

            <!-- Footer Start -->
            <jsp:include page="../common/homePage/footer-start.jsp"></jsp:include>
                <!-- Footer End -->  

                <!-- JavaScript Libraries-->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

            <!-- Template Javascript -->
            <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>

</html>
