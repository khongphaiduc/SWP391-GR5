<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bảng thống kê tổng quan</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background: #f1f4f8; font-family: 'Quicksand', Arial, sans-serif; min-height: 100vh; }
        .dashboard-header {
            padding: 18px 0 6px 0;
            text-align: center;
            background: linear-gradient(90deg, #43a047 60%, #388e3c 100%);
            color: #fff;
            border-bottom-left-radius: 28px;
            border-bottom-right-radius: 28px;
            margin-bottom: 18px;
        }
        .dashboard-header h1 { font-size: 1.35rem; font-weight: 700; letter-spacing: 1.2px; margin-bottom: 4px; }
        .dashboard-header .subtitle { font-size: 1rem; font-weight: 500; opacity: 0.88; margin-bottom: 2px; }
        .year-select-container {
            text-align: right;
            margin-bottom: 12px;
        }
        .year-select {
            border-radius: 8px;
            padding: 5px 13px;
            border: 1px solid #43a047;
            font-size: 1rem;
            color: #388e3c;
            background: #fff;
            margin-right: 4px;
        }
        .kpi-cards { margin-top: -24px; margin-bottom: 14px; }
        .kpi-card {
            background: #fff; border-radius: 14px; box-shadow: 0 3px 16px rgba(67, 160, 71, 0.10);
            padding: 15px 10px 13px 13px; text-align: center; transition: box-shadow 0.15s; border-left: 5px solid #43a047;
        }
        .kpi-icon { font-size: 1.5rem; margin-bottom: 6px; color: #43a047; }
        .kpi-title { font-size: 0.98rem; color: #888; letter-spacing: 0.2px; }
        .kpi-value { font-size: 1.25rem; font-weight: 700; color: #388e3c; margin-bottom: 2px; }
        .kpi-card:nth-child(2) { border-left-color: #388e3c; }
        .kpi-card:nth-child(2) .kpi-icon, .kpi-card:nth-child(2) .kpi-value { color: #388e3c; }
        .kpi-card:nth-child(3) { border-left-color: #fd7e14; }
        .kpi-card:nth-child(3) .kpi-icon, .kpi-card:nth-child(3) .kpi-value { color: #fd7e14; }
        .kpi-card:nth-child(4) { border-left-color: #5116ac; }
        .kpi-card:nth-child(4) .kpi-icon, .kpi-card:nth-child(4) .kpi-value { color: #5116ac; }
        .chart-title { text-align: left; margin-bottom: 0.5rem; font-size: 1.02rem; font-weight: 600; color: #1976d2; letter-spacing: 0.15px; padding-left: 7px; }
        .chart-box {
            background: #fff; border-radius: 12px; box-shadow: 0 2px 8px rgba(67,160,71,0.09);
            padding: 0.9rem 0.6rem 1rem 1rem; margin-bottom: 1.1rem; height: 100%; display: flex; flex-direction: column; justify-content: flex-start;
        }
        .chart-canvas { width: 100% !important; height: 230px !important; max-height: 230px !important; }
        @media (max-width: 991.98px) {
            .chart-canvas { height: 145px !important; max-height: 145px !important; }
            .dashboard-header { border-radius: 0 0 18px 18px; }
            .year-select-container { text-align: left; }
        }
        @media (max-width: 767.98px) {
            .chart-canvas { height: 100px !important; max-height: 100px !important; }
            .dashboard-header { font-size: 1rem; border-radius: 0; }
            .kpi-cards { margin-top: -14px; }
            .kpi-card { padding: 9px 4px 8px 7px; border-radius: 7px; }
        }
    </style>
</head>
<body>
    <div class="dashboard-header">
        <h1>Bảng thống kê tổng quan hệ thống</h1>
        <div class="subtitle">
            Quản lý hiệu quả doanh thu và người dùng trên nền tảng tuyển dụng
        </div>
    </div>
    <div class="container">
        <div class="year-select-container">
            <form method="get" action="StatictisData">
                <label for="yearSelect">Chọn năm: </label>
                <select id="yearSelect" name="year" class="year-select" onchange="this.form.submit()">
                    <c:forEach var="y" begin="2023" end="2030">
                        <option value="${y}" <c:if test="${y == param.year || (empty param.year && y == maxYear)}">selected</c:if>>                                                           
                                ${y} 
                        </option>
                    </c:forEach>
                </select>
            </form>
        </div>
    </div>
    <!-- KPI Cards -->
    <div class="container kpi-cards">
        <div class="row g-3">
            <div class="col-lg-3 col-md-6 col-12">
                <div class="kpi-card">
                    <div class="kpi-icon">📈</div>
                    <div class="kpi-title">Tổng doanh thu đến thời điểm hiện tại</div>
                    <div class="kpi-value">
                        <% Object tp = request.getAttribute("totalProfix"); %>
                        <% if (tp != null) { %>
                        <fmt:formatNumber value="${totalProfix}" type="number" groupingUsed="true" maxFractionDigits="2" /> triệu
                        <% } else { %>
                        -- triệu
                        <% } %>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-12">
                <div class="kpi-card">
                    <div class="kpi-icon">🧑‍💼</div>
                    <div class="kpi-title">Tổng candidate mới</div>
                    <div class="kpi-value">
                        <%= request.getAttribute("numberCandidateCurrent") != null ? request.getAttribute("numberCandidateCurrent") : "--" %>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-12">
                <div class="kpi-card">
                    <div class="kpi-icon">🏢</div>
                    <div class="kpi-title">Tổng employer mới</div>
                    <div class="kpi-value">
                        <%= request.getAttribute("numberEmployerCurrent") != null ? request.getAttribute("numberEmployerCurrent") : "--" %>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-12">
                <div class="kpi-card">
                    <div class="kpi-icon">📄</div>
                    <div class="kpi-title">Tin tuyển dụng mới</div>
                    <div class="kpi-value">
                        <%= request.getAttribute("numerJobPostInCurrentMonth") != null ? request.getAttribute("numerJobPostInCurrentMonth") : "--" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Chart Section -->
    <div class="container py-2">
        <div class="row g-4">
            <div class="col-lg-6 col-md-6">
                <div class="chart-box">
                    <div class="chart-title"> Doanh thu theo tháng</div>
                    <canvas id="chartByMonth" class="chart-canvas"></canvas>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="chart-box">
                    <div class="chart-title"> Doanh thu theo quý</div>
                    <canvas id="chartByQuarter" class="chart-canvas"></canvas>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="chart-box">
                    <div class="chart-title"> Đăng ký Candidate & Employer theo tháng</div>
                    <canvas id="chartRegisterBar" class="chart-canvas"></canvas>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="chart-box">
                    <div class="chart-title">So sánh doanh thu tháng & quý</div>
                    <canvas id="chartCompare" class="chart-canvas"></canvas>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="chart-box">
                    <div class="chart-title"> Số lượng báo cáo gửi về theo tháng </div>
                    <canvas id="chartReportByMonthBar" class="chart-canvas"></canvas>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="chart-box">
                    <div class="chart-title"> Số lượng tin tuyển dụng theo tháng </div>
                    <canvas id="chartJobPostBar" class="chart-canvas"></canvas>
                </div>
            </div>
        </div>
    </div>
    <!-- ChartJS Data & Drawing -->
    <script>
        // Dữ liệu từ backend (hoặc data giả, giữ nguyên theo ý bạn)
        const revenueByMonth = {
            labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
            data: <%= request.getAttribute("StatictisProFix") %>
        };
        const revenueByQuarter = {
            labels: ['Quý 1', 'Quý 2', 'Quý 3', 'Quý 4'],
            data: [
                revenueByMonth.data.slice(0, 3).reduce((a, b) => a + b, 0),
                revenueByMonth.data.slice(3, 6).reduce((a, b) => a + b, 0),
                revenueByMonth.data.slice(6, 9).reduce((a, b) => a + b, 0),
                revenueByMonth.data.slice(9, 12).reduce((a, b) => a + b, 0)
            ]
        };
        const registerData = {
            labels: revenueByMonth.labels,
            candidate: <%= request.getAttribute("candidateJson") %>,
            employer: <%= request.getAttribute("employerJson") %>
        };

        // Biểu đồ 1: Doanh thu theo tháng
        new Chart(document.getElementById('chartByMonth').getContext('2d'), {
            type: 'bar',
            data: {
                labels: revenueByMonth.labels,
                datasets: [{
                        label: 'Doanh thu (triệu VND)',
                        data: revenueByMonth.data,
                        backgroundColor: 'rgba(54, 162, 235, 0.7)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 2,
                        borderRadius: 6,
                    }]
            },
            options: {
                responsive: true,
                plugins: {legend: {display: false}},
                scales: {
                    y: {beginAtZero: true, title: {display: true, text: 'Doanh thu (triệu VND)'}}
                }
            }
        });
        // Biểu đồ 2: Doanh thu theo quý
        new Chart(document.getElementById('chartByQuarter').getContext('2d'), {
            type: 'bar',
            data: {
                labels: revenueByQuarter.labels,
                datasets: [{
                        label: 'Doanh thu (triệu VND)',
                        data: revenueByQuarter.data,
                        backgroundColor: 'rgba(40, 167, 69, 0.7)',
                        borderColor: 'rgba(40, 167, 69, 1)',
                        borderWidth: 2,
                        borderRadius: 6,
                    }]
            },
            options: {
                responsive: true,
                plugins: {legend: {display: false}},
                scales: {
                    y: {beginAtZero: true, title: {display: true, text: 'Doanh thu (triệu VND)'}}
                }
            }
        });
        // Biểu đồ 3: Đăng ký Candidate & Employer theo tháng
        new Chart(document.getElementById('chartRegisterBar').getContext('2d'), {
            type: 'bar',
            data: {
                labels: registerData.labels,
                datasets: [
                    {
                        label: 'Candidate mới',
                        data: registerData.candidate,
                        backgroundColor: 'rgba(54, 162, 235, 0.8)'
                    },
                    {
                        label: 'Employer mới',
                        data: registerData.employer,
                        backgroundColor: 'rgba(102, 16, 242, 0.8)'
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {position: 'top'},
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                return context.dataset.label + ': ' + context.raw + ' lượt đăng ký';
                            }
                        }
                    }
                },
                scales: {
                    y: {beginAtZero: true, title: {display: true, text: 'Số lượng đăng ký mới'}}
                }
            }
        });
        // Biểu đồ 4: So sánh doanh thu tháng & quý
        const quarterDataOnMonth = new Array(12).fill(null);
        quarterDataOnMonth[2] = revenueByQuarter.data[0];
        quarterDataOnMonth[5] = revenueByQuarter.data[1];
        quarterDataOnMonth[8] = revenueByQuarter.data[2];
        quarterDataOnMonth[11] = revenueByQuarter.data[3];
        new Chart(document.getElementById('chartCompare').getContext('2d'), {
            type: 'bar',
            data: {
                labels: revenueByMonth.labels,
                datasets: [
                    {
                        label: 'Doanh thu tháng (triệu VND)',
                        data: revenueByMonth.data,
                        backgroundColor: 'rgba(54, 162, 235, 0.4)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 2,
                        borderRadius: 6,
                    },
                    {
                        label: 'Tổng doanh thu quý',
                        data: quarterDataOnMonth,
                        type: 'line',
                        fill: false,
                        borderColor: '#fd7e14',
                        backgroundColor: '#fd7e14',
                        borderWidth: 3,
                        tension: 0.2,
                        pointRadius: 5,
                        pointBackgroundColor: '#fd7e14',
                        spanGaps: true
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: {legend: {position: 'top'}},
                scales: {
                    y: {beginAtZero: true, title: {display: true, text: 'Doanh thu (triệu VND)'}}
                },
                interaction: {mode: 'index', intersect: false}
            }
        });

        // Biểu đồ 5: Số lượng báo cáo gửi về mỗi tháng
        const reportByMonth = {
            labels: revenueByMonth.labels,
            data: <%= request.getAttribute("StatictisReport") %>
        };
        new Chart(document.getElementById('chartReportByMonthBar').getContext('2d'), {
            type: 'bar',
            data: {
                labels: reportByMonth.labels,
                datasets: [{
                        label: 'Số lượng báo cáo',
                        data: reportByMonth.data,
                        backgroundColor: 'rgba(255, 99, 132, 0.7)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 2,
                        borderRadius: 6
                    }]
            },
            options: {
                responsive: true,
                plugins: {legend: {display: false}},
                scales: {
                    y: {beginAtZero: true, title: {display: true, text: 'Số lượng báo cáo'}}
                }
            }
        });

        // Biểu đồ 6: Tin tuyển dụng theo tháng
        const jobPostByMonth = {
            labels: revenueByMonth.labels,
            data: <%= request.getAttribute("StatictisJobPost") %>
        };
        new Chart(document.getElementById('chartJobPostBar').getContext('2d'), {
            type: 'bar',
            data: {
                labels: jobPostByMonth.labels,
                datasets: [{
                        label: 'Số lượng tin tuyển dụng',
                        data: jobPostByMonth.data,
                        backgroundColor: 'rgba(255, 193, 7, 0.7)',
                        borderColor: 'rgba(255, 193, 7, 1)',
                        borderWidth: 2,
                        borderRadius: 6
                    }]
            },
            options: {
                responsive: true,
                plugins: {legend: {display: false}},
                scales: {
                    y: {beginAtZero: true, title: {display: true, text: 'Số lượng tin tuyển dụng'}}
                }
            }
        });
    </script>
</body>
</html>