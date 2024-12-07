<%-- 
    Document   : topbar
    Created on : Jun 20, 2024, 10:55:52 PM
    Author     : HoangPC
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container topbar bg-primary d-none d-lg-block">
    <div class="d-flex justify-content-between">
        <div class="top-info ps-2">
            <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Đại học FPT Hà Nội</a></small>
            <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">Email@Example.com</a></small>
        </div>
        <div class="top-link pe-2">
            <c:choose>
                <c:when test="${empty sessionScope.account}">
                    <a href="${pageContext.request.contextPath}/Signup.jsp" class="text-white"><small class="text-white mx-2">Đăng ký</small>/</a>
                    <a href="${pageContext.request.contextPath}/login" class="text-white"><small class="text-white mx-2">Đăng nhập</small></a>
                </c:when>
                <c:otherwise>
                    <a href="#" class="text-white"><small class="text-white mx-2"> ${sessionScope.account.full_name}</small>/</a>
                    <a href="logout" class="text-white"><small class="text-white ms-2">Đăng xuất</small></a>
                </c:otherwise>
            </c:choose>
                                    
        </div>
    </div>
</div>