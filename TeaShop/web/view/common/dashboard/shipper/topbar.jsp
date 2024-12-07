<%-- 
    Document   : topbar
    Created on : Jul 4, 2024, 3:58:51 PM
    Author     : HoangPC
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-light navbar-glass navbar-top navbar-expand">

    <a class="navbar-brand me-1 me-sm-3" href="${pageContext.request.contextPath}/ship">
        <div class="d-flex align-items-center">
            <img class="me-2" src="${pageContext.request.contextPath}/img/logoG6.png" alt="" width="40" />
            <span class="font-sans-serif">Tea shop</span>
        </div>
    </a>

    <ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
        <li class="nav-item">
            <div class="theme-control-toggle fa-icon-wait px-2">
                <input class="form-check-input ms-0 theme-control-toggle-input" id="themeControlToggle" type="checkbox" data-theme-control="theme" value="dark" />
                <label class="mb-0 theme-control-toggle-label theme-control-toggle-light" for="themeControlToggle" data-bs-toggle="tooltip" data-bs-placement="left" title="Switch to light theme">
                    <span class="fas fa-sun fs-0"></span>
                </label>
                <label class="mb-0 theme-control-toggle-label theme-control-toggle-dark" for="themeControlToggle" data-bs-toggle="tooltip" data-bs-placement="left" title="Switch to dark theme">
                    <span class="fas fa-moon fs-0"></span>
                </label>
            </div>
        </li>

       

        <li class="nav-item dropdown">
            <a class="nav-link pe-0" id="navbarDropdownUser" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <div class="avatar avatar-xl">
                    <img class="rounded-circle" src="${sessionScope.acc.avartar}" alt="" />
                </div>
            </a>
            <div class="dropdown-menu dropdown-menu-end py-0" aria-labelledby="navbarDropdownUser">
                <div class="bg-white dark__bg-1000 rounded-2 py-2">
                    <a class="dropdown-item fw-bold text-warning"><span class="fas fa-crown me-1"></span><span>${sessionScope.acc.full_name}</span></a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#!">Tài khoản của tôi</a>
                    
                    <div class="dropdown-divider"></div>
               
                    <a class="dropdown-item" href="logout">Đăng xuất</a>
                </div>
            </div>
        </li>
    </ul>
</nav>
