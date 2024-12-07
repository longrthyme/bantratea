<%-- 
    Document   : Dashboard
    Created on : Feb 29, 2024, 4:40:25 PM
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
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="ShowChart">Admin</a>
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
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i>${sessionScope.account.fullName}</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
<!--                        <li><a class="dropdown-item" href="ManageOrder">Order List</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="logout">Logout</a></li>-->
                        <li><a class="dropdown-item" href="home">Home</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
             <jsp:include page="../../common/admin/sidebarAdmin.jsp"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>
                        
                        <div >
                            <a href="chartorderday">
                                <button class="btn btn-primary">
                                    Theo ngày
                                </button>
                            </a>
                            <a href="chartorderweek">
                                <button class="btn btn-primary">
                                    Theo tuần
                                </button>
                            </a>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        Doanh thu theo ngày
                                    </div>
                                    <div class="card-body"><canvas id="myRevenuesChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        Tỉ lệ lượng đơn thành công 
                                    </div>
                                    <div class="card-body"><canvas id="myOrderChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            
                        </div>
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        Quản lí quỹ theo tuần
                                    </div>
                                    <div class="card-body"><canvas id="myFundChart" width="100%" height="40"></canvas></div>
                                </div>
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
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script type="text/javascript">
            var ctx = document.getElementById("myOrderChart");
            var labels = [
            <c:forEach items="${list}" var="order">
                '<c:out value="${order.date}" />',
            </c:forEach>
            ];
            var data = [
            <c:forEach items="${list}" var="order">
                <c:out value="${order.success_rate}" />,
            </c:forEach>
            ];
            var myLineChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                            label: "Succes Rate",
                            backgroundColor: "rgba(2,117,216,1)",
                            borderColor: "rgba(2,117,216,1)",
                            data: data
                        }]
                },
                options: {
                    scales: {
                        xAxes: [{
                                time: {
                                    unit: 'month'
                                },
                                gridLines: {
                                    display: false
                                },
                                ticks: {
                                    maxTicksLimit: 6
                                }
                            }],
                        yAxes: [{
                                ticks: {
                                    min: 0,
                                    max: 1500000,
                                    maxTicksLimit: 5
                                },
                                gridLines: {
                                    display: true
                                }
                            }]
                    },
                    legend: {
                        display: false
                    }
                }
            });
        </script>
        <script type="text/javascript">
            var ctx = document.getElementById("myRevenuesChart");
            var labels = [
            <c:forEach items="${list}" var="order">
                '<c:out value="${order.date}" />',
            </c:forEach>
            ];
            var data = [
            <c:forEach items="${list}" var="order">
                <c:out value="${order.revenue}" />,
            </c:forEach>
            ];
            var myLineChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                            label: "Revenue",
                            lineTension: 0.3,
                            backgroundColor: "rgba(2,117,216,0.2)",
                            borderColor: "rgba(2,117,216,1)",
                            pointRadius: 5,
                            pointBackgroundColor: "rgba(2,117,216,1)",
                            pointBorderColor: "rgba(255,255,255,0.8)",
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(2,117,216,1)",
                            pointHitRadius: 50,
                            pointBorderWidth: 2,
                            data: data,
                        }],
                },
                options: {
                    scales: {
                        xAxes: [{
                                time: {
                                    unit: 'date'
                                },
                                gridLines: {
                                    display: false
                                },
                                ticks: {
                                    maxTicksLimit: 7
                                }
                            }],
                        yAxes: [{
                                ticks: {
                                    min: 0,
                                    max: 4000000,
                                    maxTicksLimit: 5
                                },
                                gridLines: {
                                    color: "rgba(0, 0, 0, .125)",
                                }
                            }],
                    },
                    legend: {
                        display: false
                    }
                }
            });
        </script>
        <script type="text/javascript">
    var ctx = document.getElementById("myFundChart");
    var labels = [
        <c:forEach items="${listf}" var="fund">
            '<c:out value="${fund.getDay()}" />',
        </c:forEach>
    ];
    var inputData = [
        <c:forEach items="${listf}" var="fund">
            <c:out value="${fund.getInput_money()}" />,
        </c:forEach>
    ];
    var closeData = [
        <c:forEach items="${listf}" var="fund">
            <c:out value="${fund.getClose_money()}" />,
        </c:forEach>
    ];
    var profitData = [
        <c:forEach items="${listf}" var="fund">
            <c:out value="${fund.getProfit_loss()}" />,
        </c:forEach>
    ];

    var myMixedChart = new Chart(ctx, {
        type: 'bar', // Default chart type
        data: {
            labels: labels,
            datasets: [{
                    label: "Input Money ",
                    type: 'bar', // Set the chart type to 'bar'
                    backgroundColor: "rgba(75, 192, 192, 0.2)",
                    borderColor: "rgba(75, 192, 192, 1)",
                    pointRadius: 5,
                    pointBackgroundColor: "rgba(75, 192, 192, 1)",
                    pointBorderColor: "rgba(255,255,255,0.8)",
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: "rgba(75, 192, 192, 1)",
                    pointHitRadius: 50,
                    pointBorderWidth: 2,
                    data: inputData,
                    minBarLength: 5, // Minimum bar length
                },
                {
                    label: "Close Money ",
                    type: 'bar', // Set the chart type to 'bar'
                    backgroundColor: "rgba(2, 117, 216, 0.2)",
                    borderColor: "rgba(2, 117, 216, 1)",
                    pointRadius: 5,
                    pointBackgroundColor: "rgba(2, 117, 216, 1)",
                    pointBorderColor: "rgba(255,255,255,0.8)",
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: "rgba(2, 117, 216, 1)",
                    pointHitRadius: 50,
                    pointBorderWidth: 2,
                    data: closeData,
                    minBarLength: 5, // Minimum bar length
                },
                {
                    label: "Profit/Loss",
                    type: 'line', // Set the chart type to 'line'
                    lineTension: 0.3,
                    backgroundColor: "rgba(255, 99, 132, 0.2)",
                    borderColor: "rgba(255, 99, 132, 1)",
                    pointRadius: 5,
                    pointBackgroundColor: "rgba(255, 99, 132, 1)",
                    pointBorderColor: "rgba(255,255,255,0.8)",
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: "rgba(255, 99, 132, 1)",
                    pointHitRadius: 50,
                    pointBorderWidth: 2,
                    data: profitData,
                }
            ],
        },
        options: {
            scales: {
                xAxes: [{
                    time: {
                        unit: 'date'
                    },
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 7
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        max: 100000000000,
                        maxTicksLimit: 7
                    },
                    gridLines: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                }],
            },
            legend: {
                display: true
            }
        }
    });
</script>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>

