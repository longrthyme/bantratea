

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
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
                    <a href="home" class="nav-item nav-link active ">Home</a>
                    <a href ="blog" class="nav-item nav-link">Blog</a>
                    <a href="shop" class="nav-item nav-link">Shop</a>


                </div>
                <c:if test="${sessionScope.acc==null}">  
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
                            <i class="fa fa-shopping-bag fa-2x"></i>
                            <%if(count>0){%>
                            <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;"><%=count%></span>
                            <%}%>
                        </a>
                        <% 
        Integer accountId = (Integer) session.getAttribute("accountId");
        if (accountId != null) {
                        %>

                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link" data-bs-toggle="dropdown" style="color: black;">
                                <i class="fas fa-user fa-2x" style="color: black;"></i>
                            </a>
                            <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                <a href="MyOrder" class="dropdown-item">Đơn hàng</a>
                            </div>
                            <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                <a href="orderCompelete" class="dropdown-item">Đánh giá của bạn</a>
                            </div>
                        </div>
                        <% 
                            }                     else { 
                        %>

                        <% 
                            } 
                        %>

                    </div>
                </c:if> 
                <c:if test="${sessionScope.acc!=null}">  
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
                            <i class="fa fa-shopping-bag fa-2x"></i>
                            <%if(count>0){%>
                            <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;"><%=count%></span>
                            <%}%>
                        </a>
                        <% 
        Integer accountId = (Integer) session.getAttribute("accountId");
        if (accountId != null) {
                        %>

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
                        <% 
                            }                     else { 
                        %>
                            
                        <% 
                            } 
                        %>

                    </div>
                        
                </c:if> 
            </div>
        </nav>
    </div>
</div>
<!-- Navbar End -->

