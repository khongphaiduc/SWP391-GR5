<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="../css/SaveJobPostcss.css"/>
        <style>
            body {
                background: linear-gradient(135deg, #e3f2fd 0%, #fffde7 100%);
                font-family: 'Montserrat', Arial, sans-serif;
            }
            .filter-bar {
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 2px 12px #1976d20d;
                padding: 16px 18px 6px 18px;
                font-size: 0.98rem;
                margin-bottom: 22px;
                display: flex;
                flex-wrap: wrap;
                gap: 14px 24px;
                align-items: flex-end;
            }
            .filter-bar .filter-group {
                min-width: 160px;
                flex: 1 1 160px;
                margin-bottom: 10px;
            }
            .filter-bar .form-label {
                margin-bottom: 4px;
                font-weight: 600;
                color: #1976d2;
                font-size: 0.97rem;
            }
            .filter-bar .form-select,
            .filter-bar .form-control {
                font-size: 0.98rem;
                border-radius: 7px;
                margin-bottom: 0;
            }
            .filter-bar .btn-primary {
                background: linear-gradient(90deg,#40c057 60%,#1976d2 100%);
                border: none;
                font-weight: 700;
                border-radius: 6px;
                font-size: 1rem;
                padding: 8px 28px;
                box-shadow: 0 1px 8px #1976d222;
                margin-top: 10px;
                height: 42px;
            }
            .filter-bar .btn-primary:hover {
                background: linear-gradient(90deg, #1976d2 70%, #40c057 100%);
            }
            @media (max-width: 991.98px) {
                .filter-bar {
                    padding: 10px 6px 4px 6px;
                    gap: 8px 10px;
                }
                .filter-bar .filter-group {
                    min-width: 120px;
                }
                .filter-bar .btn-primary {
                    width: 100%;
                    margin-top: 0;
                    padding: 8px 0;
                }
            }
            @media (max-width: 700px) {
                .filter-bar {
                    flex-direction: column;
                    align-items: stretch;
                    padding: 10px 2px;
                    gap: 6px 0;
                }
                .filter-bar .filter-group {
                    min-width: 0;
                    flex: 1 1 100%;
                }
                .filter-bar .btn-primary {
                    width: 100%;
                    margin-top: 5px;
                    font-size: 0.98rem;
                }
            }
            /* Job Card Styles - unchanged from original */
            .job-card {
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 4px 18px rgba(30,136,229,0.08);
                padding: 18px 12px;
                margin-bottom: 20px;
                transition: box-shadow .16s, transform .15s;
                border: none;
                font-size: 0.98rem;
            }
            .job-card:hover {
                box-shadow: 0 8px 30px rgba(30,136,229,0.15);
                transform: translateY(-2px) scale(1.012);
            }
            .company-logo {
                width: 38px;
                height: 38px;
                object-fit: cover;
                border-radius: 50%;
                border: 2px solid #40c057;
                background: #e0f7fa;
                margin-right: 10px;
                box-shadow: 0 1px 6px #40c05716;
            }
            .job-title {
                color: #1976d2;
                font-weight: 600;
                font-size: 1rem;
                text-decoration: none;
                margin-bottom: 2px;
                display: inline-block;
                transition: color .14s;
            }
            .job-title:hover {
                color: #40c057;
                text-decoration: underline;
            }
            .company-name {
                font-size: 0.93rem;
                color: #263238;
                font-weight: 500;
                margin-bottom: 4px;
            }
            .job-meta {
                font-size: 0.92rem;
                color: #495057;
                margin-bottom: 4px;
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                align-items: center;
            }
            .salary-badge {
                background: linear-gradient(90deg,#40c057 70%,#1976d2 100%);
                color: #fff;
                font-weight: 600;
                font-size: 0.94rem;
                border-radius: 30px;
                padding: 2px 10px;
                box-shadow: 0 1px 6px #40c05716;
                margin-left: 2px;
            }
            .job-location {
                color: #1976d2;
                font-weight: 500;
            }
            .job-type {
                background: #e3f6f5;
                color: #1976d2;
                font-weight: 500;
                padding: 2px 8px;
                border-radius: 10px;
                font-size: 0.93rem;
            }
            .job-deadline {
                background: #fff3cd;
                color: #b58900;
                padding: 2px 8px;
                border-radius: 10px;
                font-size: 0.93rem;
                font-weight: 500;
            }
            .job-desc {
                color: #546e7a;
                font-size: 0.97rem;
                margin-bottom: 10px;
                margin-top: 4px;
            }
            .apply-btn {
                background: linear-gradient(90deg,#40c057 60%,#1976d2 100%);
                color: #fff;
                border: none;
                padding: 6px 18px;
                border-radius: 6px;
                font-size: 0.97rem;
                font-weight: 700;
                box-shadow: 0 1px 8px #1976d222;
                transition: background .15s, transform .12s;
                letter-spacing: 0.5px;
            }
            .apply-btn:hover {
                background: linear-gradient(90deg, #1976d2 70%, #40c057 100%);
                transform: translateY(-1px) scale(1.03);
            }
            .heart-svg.filled {
                fill: #ff4d6d;
                stroke: #ff4d6d;
                transition: fill 0.2s;
            }

            /*            css thông báo*/
            .custom-toast {
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%) scale(0.97);
                min-width: 320px;
                max-width: 90vw;
                background: #fff;
                color: #222;
                font-weight: 700;
                font-size: 1.14rem;
                border-radius: 16px;
                box-shadow: 0 12px 40px #2bdbb855, 0 2px 10px #1976d244;
                z-index: 11000;
                padding: 32px 38px 32px 36px;
                display: flex;
                align-items: center;
                gap: 20px;
                opacity: 0;
                pointer-events: none;
                transition: all 0.55s cubic-bezier(.23,1.18,.82,0.97);
            }
            .custom-toast.show {
                opacity: 1;
                pointer-events: auto;
                transform: translate(-50%, -50%) scale(1);
            }
            .toast-success {
                border-left: 7px solid #3ec56b;
                background: linear-gradient(90deg, #eafaf3 80%, #d7f5e3 100%);
            }
            .toast-error {
                border-left: 7px solid #ff4d6d;
                background: linear-gradient(90deg, #fff0f3 80%, #ffe8e6 100%);
            }
            .toast-anim-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 58px;
                height: 58px;
                flex-shrink: 0;
                margin-right: 8px;
                position: relative;
            }
            .checkmark, .crossmark {
                width: 52px;
                height: 52px;
                display: block;
            }
            .checkmark-circle, .crossmark-circle {
                stroke: #3ec56b;
                stroke-width: 4;
                stroke-dasharray: 166;
                stroke-dashoffset: 166;
                stroke-linecap: round;
                animation: draw-circle 0.5s ease-out forwards;
            }
            .crossmark-circle {
                stroke: #ff4d6d;
                animation: draw-circle-red 0.5s ease-out forwards;
            }
            .checkmark-check {
                stroke: #3ec56b;
                stroke-width: 5;
                stroke-linecap: round;
                stroke-linejoin: round;
                stroke-dasharray: 48;
                stroke-dashoffset: 48;
                animation: draw-check 0.35s 0.5s cubic-bezier(.65,.05,.36,1) forwards;
            }
            .crossmark-cross {
                stroke: #ff4d6d;
                stroke-width: 5;
                stroke-linecap: round;
                stroke-dasharray: 36 36;
                stroke-dashoffset: 36;
                animation: draw-cross 0.28s 0.5s cubic-bezier(.65,.05,.36,1) forwards;
            }
            @keyframes draw-circle {
                to {
                    stroke-dashoffset: 0;
                }
            }
            @keyframes draw-circle-red {
                to {
                    stroke-dashoffset: 0;
                }
            }
            @keyframes draw-check {
                to {
                    stroke-dashoffset: 0;
                }
            }
            @keyframes draw-cross {
                to {
                    stroke-dashoffset: 0;
                }
            }
            .toast-close {
                background: none;
                border: none;
                font-size: 2rem;
                color: #199c89;
                cursor: pointer;
                outline: none;
                margin-left: 15px;
                margin-right: 0;
                transition: color 0.18s;
                position: absolute;
                top: 12px;
                right: 20px;
            }
            .toast-close:hover {
                color: #e74c3c;
            }
            @media (max-width:600px) {
                .custom-toast {
                    min-width: 0;
                    width: 95vw;
                    font-size: 1rem;
                    padding: 18px 12px 18px 8px;
                    left: 50%;
                    top: 15%;
                    transform: translate(-50%, 0%) scale(1);
                }
                .toast-close {
                    right: 4px;
                    top: 7px;
                    font-size: 1.4rem;
                }
                .toast-anim-icon {
                    width: 40px;
                    height: 40px;
                }
                .checkmark, .crossmark {
                    width: 36px;
                    height: 36px;
                }
            }

        </style>
        <!--          End css thong bao-->



        <!--        Css action menu-->
        <style>
            .floating-actions-v2 {
                position: fixed;
                bottom: 32px;
                left: 24px;
                z-index: 9999;
                display: flex;
                flex-direction: column;
                gap: 16px;
                align-items: flex-start;
            }
            .fab-item {
                display: flex;
                align-items: center;
                gap: 8px;
                background: rgba(255,255,255,0.97);
                border-radius: 18px;
                box-shadow: 0 8px 32px 0 rgba(20,184,102,0.10), 0 1.5px 8px #1976d211;
                padding: 3px 8px 3px 3px;
                transition: box-shadow 0.18s, transform 0.14s;
            }
            .fab-item:hover {
                box-shadow: 0 12px 32px 0 rgba(20,184,102,0.22), 0 3px 16px #1976d222;
                transform: translateY(-3px) scale(1.03);
            }
            .fab-btn {
                background: linear-gradient(135deg, #38ef7d 60%, #11998e 100%);
                border: none;
                border-radius: 50%;
                box-shadow: 0 2px 12px #14b86633;
                width: 48px;
                height: 48px;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                cursor: pointer;
                transition: background 0.13s, box-shadow 0.13s, transform 0.13s;
                outline: none;
            }
            .fab-btn:active {
                transform: scale(0.95);
            }
            .fab-btn i {
                font-size: 1.45rem;
                color: #fff;
                transition: color .17s;
            }
            .fab-label {
                color: #11998e;
                font-size: 1.04rem;
                font-weight: 600;
                letter-spacing: 0.03em;
                padding: 0 10px;
                border-radius: 10px;
                background: linear-gradient(90deg, #e2fdeb 60%, #e0f7fa 100%);
                margin-left: 2px;
            }
            .fab-heart .fab-btn {
                background: linear-gradient(135deg, #ff4d6d 70%, #14b866 100%);
                box-shadow: 0 2px 14px #ff4d6d22;
            }
            .fab-heart .fab-btn.filled i {
                color: #ff4d6d;
                text-shadow: 0 2px 8px #ff4d6d22, 0 0px 2px #fff;
            }
            .fab-badge {
                position: absolute;
                top: -7px;
                right: -7px;
                background: #14b866;
                color: #fff;
                font-size: 0.93rem;
                font-weight: 700;
                border-radius: 50%;
                min-width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 2px solid #fff;
                box-shadow: 0 1.5px 5px #14b86622;
                z-index: 2;
            }
            .fab-heart .fab-badge {
                background: #ff4d6d;
            }
            @media (max-width: 600px) {
                .floating-actions-v2 {
                    left: 7px;
                    bottom: 10px;
                    gap: 12px;
                }
                .fab-btn {
                    width: 42px;
                    height: 42px;
                }
                .fab-label {
                    font-size: 0.95rem;
                    padding: 0 6px;
                }
                .fab-badge {
                    min-width: 20px;
                    height: 20px;
                    font-size: 0.87rem;
                }
            }
        </style>
        <style>
            .fab-item {
                position: relative;
            }
            .fab-hover-label {
                display: none;
                position: absolute;
                left: 60px;
                top: 50%;
                transform: translateY(-50%);
                background: #fff;
                color: #11998e;
                font-weight: 600;
                font-size: 1.02rem;
                padding: 5px 16px;
                border-radius: 9px;
                box-shadow: 0 3px 16px #1976d211;
                white-space: nowrap;
                z-index: 10000;
                pointer-events: none;
                opacity: 0;
                transition: opacity 0.17s, left 0.17s;
            }
            .fab-item:hover .fab-hover-label,
            .fab-item:focus-within .fab-hover-label {
                display: block;
                opacity: 1;
                left: 60px;
            }
            @media (max-width: 600px) {
                .fab-hover-label {
                    left: 45px;
                    font-size: 0.95rem;
                    padding: 4px 10px;
                }
            }
        </style>

        <style>
            .support-popup {
                position: fixed;
                left: 90px;
                bottom: 32px;
                width: 350px;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 8px 32px 0 rgba(20,184,102,0.13), 0 1.5px 8px #1976d211;
                z-index: 10001;
                animation: fadeInFabDropdown 0.22s;
            }
            @keyframes fadeInFabDropdown {
                from {
                    opacity: 0;
                    transform: translateY(30px) scale(0.97);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }
            .support-popup-body {
                padding: 12px 0;
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
            .support-popup-link {
                display: flex;
                align-items: center;
                gap: 13px;
                padding: 14px 22px;
                color: #1a9e7c;
                text-decoration: none;
                background: none;
                font-size: 1.08rem;
                border-bottom: 1px solid #f1f1f1;
                transition: background 0.12s, color 0.12s;
                font-weight: 500;
            }
            .support-popup-link:last-child {
                border-bottom: none;
            }
            .support-popup-link:hover {
                background: #eafaf2;
                color: #0a8e65;
            }
            @media (max-width:600px) {
                .support-popup {
                    width: 95vw;
                    left: 2vw;
                    bottom: 12px;
                }
                .support-popup-header {
                    padding: 12px 10px 10px 10px !important;
                }
                .support-popup-link {
                    padding: 10px 10px;
                    font-size: 1rem;
                }
            }
        </style>
        <!--    End Action Menu-->
    </head>
    <body>
        <div class="container py-4">
            <!-- Chèn chỗ này -->
            <div class="w-100 d-flex align-items-center justify-content-center" 
                 style="min-height:60px; background: linear-gradient(90deg, #045943 90%, #097969 100%); border-radius: 14px; margin-bottom: 12px; border:1px solid #034634;">
                <div class="d-flex align-items-center" style="gap:12px;">
                    <div class="flex-grow-1 text-center">
                        <h5 style="color:  #e0f7fa">GenZTimViec.VN</h5>
                        <div id="quote-rotate"
                             style="color:#fff;font-size:1.02rem;font-weight:700;letter-spacing:0.02em;line-height:1.2;min-height:24px;transition:opacity .5s;">
                            Sơn Tùng-MTP :  Muốn ngồi một vị trí không ai ngồi được thì bạn phải chịu cảm giác mà không ai chịu được    .
                        </div>
                    </div>
                </div>
            </div>
            <!-- Horizontal Filter Bar -->


            <div class="filter-bar mb-4">
                <!-- Lương -->
                <form action="searchListJobPost" method="get">                 
                    <div class="filter-group">
                        <label for="salary" class="form-label"> <i class="bi bi-cash-stack"></i>  Lương</label>
                        <select class="form-select" id="salary" name="salary" onchange="this.form.submit()">
                            <option value="0" ${sessionScope.selectedSalary == '0' ? 'selected' : ''}>Tất cả</option>
                            <option value="1" ${sessionScope.selectedSalary == '1' ? 'selected' : ''}>Dưới 10 triệu</option>
                            <option value="2" ${sessionScope.selectedSalary == '2' ? 'selected' : ''}>10-20 triệu</option>
                            <option value="3" ${sessionScope.selectedSalary == '3' ? 'selected' : ''}>20-30 triệu</option>
                            <option value="4" ${sessionScope.selectedSalary == '4' ? 'selected' : ''}>30-40 triệu</option>
                            <option value="5" ${sessionScope.selectedSalary == '5' ? 'selected' : ''}>Trên 40 triệu</option>
                        </select>
                        <input type="hidden" name="location" value="${sessionScope.location}" />

                        <input type="hidden" name="career" value="${sessionScope.career}" />
                        <input type="hidden" name="exp" value="${sessionScope.exp}" />
                        <input type="hidden" name="typeJob" value="${sessionScope.typeJob}" />
                    </div>
                </form>



                <!--              form vị trí-->
                <form action="searchListJobPost" method="get">
                    <div class="filter-group">
                        <label for="location" class="form-label"><i class="bi bi-geo-alt"></i> Vị trí</label>

                        <!--                        đang chạy thì đừng động vào -->

                        <select class="form-select" id="location" name="location" onchange="this.form.submit()">
                            <option value="" ${sessionScope.location == '' ? 'selected' : ''}>Tất cả</option>
                            <option value="Hà Nội" ${sessionScope.location == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>                         
                            <option value="TP Hồ Chí Minh" ${sessionScope.location == 'TP Hồ Chí Minh' ? 'selected' : ''}>TP Hồ Chí Minh</option>
                            <option value="Đà Nẵng" ${sessionScope.location == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
                            <option value="Hải Phòng" ${sessionScope.location == 'Hải Phòng' ? 'selected' : ''}>Hải Phòng</option>
                            <option value="Cần Thơ" ${sessionScope.location == 'Cần Thơ' ? 'selected' : ''}>Cần Thơ</option>
                            <option value="Kiên Giang" ${sessionScope.location == 'Kiên Giang' ? 'selected' : ''}>Kiên Giang</option>
                            <option value="Bắc Giang" ${sessionScope.location == 'Bắc Giang' ? 'selected' : ''}>Bắc Giang</option>
                            <option value="Lâm Đồng" ${sessionScope.location == 'Lâm Đồng' ? 'selected' : ''}>Lâm Đồng</option>
                            <option value="Cà Mau" ${sessionScope.location == 'Cà Mau' ? 'selected' : ''}>Cà Mau</option>
                            <option value="Cao Bằng" ${sessionScope.location == 'Cao Bằng' ? 'selected' : ''}>Cao Bằng</option>
                            <option value="Đắk Lắk" ${sessionScope.location == 'Đắk Lắk' ? 'selected' : ''}>Đắk Lắk</option>
                            <option value="Điện Biên" ${sessionScope.location == 'Điện Biên' ? 'selected' : ''}>Điện Biên</option>
                            <option value="Đồng Nai" ${sessionScope.location == 'Đồng Nai' ? 'selected' : ''}>Đồng Nai</option>
                            <option value="Tiền Giang" ${sessionScope.location == 'Tiền Giang' ? 'selected' : ''}>Tiền Giang</option>
                            <option value="Bình Định" ${sessionScope.location == 'Bình Định' ? 'selected' : ''}>Bình Định</option>
                            <option value="Hà Tĩnh" ${sessionScope.location == 'Hà Tĩnh' ? 'selected' : ''}>Hà Tĩnh</option>
                            <option value="Hưng Yên" ${sessionScope.location == 'Hưng Yên' ? 'selected' : ''}>Hưng Yên</option>
                            <option value="Khánh Hóa" ${sessionScope.location == 'Khánh Hóa' ? 'selected' : ''}>Khánh Hóa</option>
                            <option value="Lai Châu" ${sessionScope.location == 'Lai Châu' ? 'selected' : ''}>Lai Châu</option>
                            <option value="Lạng Sơn" ${sessionScope.location == 'Lạng Sơn' ? 'selected' : ''}>Lạng Sơn</option>
                            <option value="Yên Bái" ${sessionScope.location == 'Yên Bái' ? 'selected' : ''}>Yên Bái</option>
                            <option value="Nghệ An" ${sessionScope.location == 'Nghệ An' ? 'selected' : ''}>Nghệ An</option>
                            <option value="Ninh Bình" ${sessionScope.location == 'Ninh Bình' ? 'selected' : ''}>Ninh Bình</option>
                            <option value="Phú Thọ" ${sessionScope.location == 'Phú Thọ' ? 'selected' : ''}>Phú Thọ</option>
                            <option value="Quảng Ngãi" ${sessionScope.location == 'Quảng Ngãi' ? 'selected' : ''}>Quảng Ngãi</option>
                            <option value="Quảng Ninh" ${sessionScope.location == 'Quảng Ninh' ? 'selected' : ''}>Quảng Ninh</option>
                            <option value="Quảng Bình" ${sessionScope.location == 'Quảng Bình' ? 'selected' : ''}>Quảng Bình</option>
                            <option value="Sơn La" ${sessionScope.location == 'Sơn La' ? 'selected' : ''}>Sơn La</option>
                            <option value="Long An" ${sessionScope.location == 'Long An' ? 'selected' : ''}>Long An</option>
                            <option value="Thái Nguyên" ${sessionScope.location == 'Thái Nguyên' ? 'selected' : ''}>Thái Nguyên</option>
                            <option value="Thanh Hóa" ${sessionScope.location == 'Thanh Hóa' ? 'selected' : ''}>Thanh Hóa</option>
                            <option value="TP Huế" ${sessionScope.location == 'TP Huế' ? 'selected' : ''}>TP Huế</option>
                            <option value="Tuyên Quang" ${sessionScope.location == 'Tuyên Quang' ? 'selected' : ''}>Tuyên Quang</option>
                            <option value="Vĩnh Long" ${sessionScope.location == 'Vĩnh Long' ? 'selected' : ''}>Vĩnh Long</option>

                        </select>
                        <input type="hidden" name="salary" value="${sessionScope.selectedSalary}" />
                        <input type="hidden" name="career" value="${sessionScope.career}" />
                        <input type="hidden" name="exp" value="${sessionScope.exp}" />
                        <input type="hidden" name="typeJob" value="${sessionScope.typeJob}" />
                    </div>
                </form>


                <!--             form ngành nghề -->
                <form action="searchListJobPost" method="get"> 
                    <div class="filter-group">
                        <label for="career" class="form-label"><i class="bi bi-briefcase"></i> Ngành nghề</label>
                        <select class="form-select" id="career" name="career" onchange="this.form.submit()">
                            <option value="" ${sessionScope.career == '' ?'selected' : ''}>Tất cả</option>
                            <option value="IT" ${sessionScope.career=='IT' ? 'selected' : ''}>IT - CNTT</option>
                            <option value="Marketing" ${sessionScope.career=='Marketing' ?'selected' : ''}>Marketing</option>
                            <option value="Kinh doanh" ${sessionScope.career== 'Kinh doanh' ?'selected' : ''}>Kinh doanh</option>
                            <option value="Nhân sự" ${sessionScope.career== 'Nhân sự' ?'selected' : ''}>Nhân sự</option>
                            <option value="Tài chính" ${sessionScope.career== 'Tài chính' ?'selected' : ''}>Tài chính</option>
                            <option value="Mỹ Thuật" ${sessionScope.career== 'Mỹ Thuật' ?'selected' : ''}>Mỹ Thuật</option>
                            <option value="Kiểm Toán" ${sessionScope.career== 'Kiểm Toán' ?'selected' : ''}>Kiểm Toán</option>
                            <option value="Hành chính" ${sessionScope.career== 'Hành chính' ?'selected' : ''}>Hành chính</option>
                            <option value="Design" ${sessionScope.career== 'Design' ?'selected' : ''}>Design</option>
                            <option value="Kế toán" ${sessionScope.career== 'Kế toán' ?'selected' : ''}>Kế toán</option>
                            <option value="Finance" ${sessionScope.career== 'Finance' ?'selected' : ''}>Finance</option>
                            <!--hihi-->

                        </select>
                        <input type="hidden" name="location" value="${sessionScope.location}" />
                        <input type="hidden" name="salary" value="${sessionScope.selectedSalary}" />

                        <input type="hidden" name="exp" value="${sessionScope.exp}" />
                        <input type="hidden" name="typeJob" value="${sessionScope.typeJob}" />
                    </div>
                </form>

                <!--                      form  kinh nghiệm-->
                <form action="searchListJobPost" method="get">
                    <div class="filter-group">
                        <label for="exp" class="form-label"><i class="bi bi-award"></i> Kinh nghiệm</label>
                        <select class="form-select" id="exp" name="exp" onchange="this.form.submit()">
                            <option value="" ${sessionScope.exp  == '' ? 'selected':''}>Tất cả</option>                           
                            <option value="1" ${sessionScope.exp  == '1' ? 'selected':''}>1 năm</option>
                            <option value="2" ${sessionScope.exp  == '2' ? 'selected':''}>2 năm</option>
                            <option value="3" ${sessionScope.exp  == '3' ? 'selected':''}>3 năm+</option>
                        </select>
                        <input type="hidden" name="location" value="${sessionScope.location}" />
                        <input type="hidden" name="salary" value="${sessionScope.selectedSalary}" />
                        <input type="hidden" name="career" value="${sessionScope.career}" />

                        <input type="hidden" name="typeJob" value="${sessionScope.typeJob}" />
                    </div>

                </form>

                <!--                   form hình thức-->
                <form action="searchListJobPost" method="get">

                    <div class="filter-group">
                        <label for="field" class="form-label"><i class="bi bi-clock-history"></i> Hình Thức</label>
                        <select class="form-select" id="field" name="typeJob" onchange="this.form.submit()">                          
                            <option value="" ${typeJob=='' ? 'selected' : '' }>Tất Cả</option>
                            <option value="Part time" ${typeJob=='Part time' ? 'selected' : '' }>Bán Thời Gian</option>
                            <option value="Full time" ${typeJob=='Full time' ? 'selected' : '' }>Full Time </option>
                            <option value="Internship" ${typeJob=='Internship' ? 'selected' : '' }>Thực Tập</option>
                            <option value="Remote" ${typeJob=='Remote' ? 'selected' : '' }>Remote</option>
                        </select>
                        <input type="hidden" name="location" value="${sessionScope.location}" />
                        <input type="hidden" name="salary" value="${sessionScope.selectedSalary}" />
                        <input type="hidden" name="career" value="${sessionScope.career}" />
                        <input type="hidden" name="exp" value="${sessionScope.exp}" />
                    </div>

                </form>

                <!-- Từ khoá -->
                <form action="searchListJobPost" method="get" class="filter-group flex-grow-1 d-flex align-items-end" style="gap:10px;">
                    <div style="flex:2;">
                        <label for="keyword" class="form-label"> <i class="bi bi-search"></i> Tìm Theo Tên Công Ty</label>
                        <input type="text" class="form-control" id="keyword" name="searchKey" value="${keySearch}" placeholder="Nhập từ khoá và Enter">
                    </div>
                    <input type="hidden" name="location" value="${sessionScope.location}" />
                    <input type="hidden" name="salary" value="${sessionScope.selectedSalary}" />
                    <input type="hidden" name="career" value="${sessionScope.career}" />
                    <input type="hidden" name="exp" value="${sessionScope.exp}" />
                    <input type="hidden" name="typeJob" value="${sessionScope.typeJob}" />
                    <input type="submit" style="display:none">
                </form>
            </div>

            <c:if test="${status != null}">
                <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 80vh; text-align: center;">
                    <h1 style="color: #9446e6; font-family: 'Poppins', cursive; font-size: 48px;">
                        Ối Rồi Ôi  !!!!
                    </h1>

                    <h3 style="font-family: 'Poppins', sans-serif; color: #146c43">
                        Hiện tại không có công việc phù hợp với nhu cầu của bạn !
                    </h3>

                    <img src="<%= request.getContextPath() %>/img/meme1.jpg" alt="meme" style="max-width: 100%; height: auto; margin-top: 20px;border-radius:80px" />

                </div>
            </c:if>


            <!-- Hiển thị job động từ ListJobPost -->
            <c:forEach var="s" items="${ListJobPost}">
                <div class="col-12">
                    <div class="job-card d-flex align-items-start flex-wrap flex-md-nowrap">
                        <img src="../img/carousel-1.jpg" alt="ABC Corp Logo" class="company-logo">
                        <div class="flex-grow-1">
                            <a href="${pageContext.request.contextPath}/detailJob?postId=${s.jobPost_ID}" class="job-title">${s.title}</a>
                            <div class="company-name"> <i class="bi bi-building"></i> ${s.compapy}  </div>
                            <div class="job-meta">
                                <span class="job-location">📍 ${s.location}</span>
                                <span class="salary-badge"><i class="bi bi-cash-stack"></i> ${s.offer_Min} - ${s.offer_Max} triệu</span>
                                <span class="job-type"> <i class="bi bi-clock-history"></i> ${s.typeJob}</span>
                                <span style="background-color: #ccffff ;color: #6699ff" class="job-deadline"> <i class="bi bi-award"></i> Kinh Nghiệm ${s.number_exp} Năm</span>
                                <span style="background-color: #fff" class="job-deadline"><i class="bi bi-calendar-event"></i> Ngày Đăng  ${s. dayCre} </span>
                            </div>

                            <div class="job-desc">
                                <i class="bi bi-card-text"></i>   ${s.description}
                            </div>

                            <!-- Nút ứng tuyển với icon trái tim cùng dòng -->

                            <div class="d-flex align-items-center justify-content-between mt-2">
                                <a href="${pageContext.request.contextPath}/detailJob?postId=${s.jobPost_ID}" target="_self" class="apply-btn" style="text-decoration: none;">
                                    <i class="bi bi-send-fill"></i> Ứng tuyển ngay
                                </a>

                                <!--                               lưu jobPost-->
                                <c:if test="${sessionScope.username != null and sessionScope.role eq 'Candidate'}">
                                    <a href="SaveJobPost?idJobPost=${s.jobPost_ID}" target="_self" style="text-decoration: none;">

                                        <svg width="36" height="40" viewBox="0 0 49 55" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <circle cx="24.5" cy="27.5" r="17" stroke="#16B155" stroke-width="2.5" fill="none"/>
                                        <path d="M24.5 34
                                              C22.5 32.5, 15.5 27.5, 18.5 23.5
                                              C20.2 21.2, 24.5 24, 24.5 26.5
                                              C24.5 24, 28.8 21.2, 30.5 23.5
                                              C33.5 27.5, 26.5 32.5, 24.5 34Z"
                                              stroke="#16B155" stroke-width="2" fill="none"/>
                                        </svg>


                                    </a>
                                </c:if>

                                <c:if test="${sessionScope.username == null}">
                                    <a href="log/login.jsp" target="_self" style="text-decoration: none" > 
                                        <svg width="36" height="40" viewBox="0 0 49 55" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <circle cx="24.5" cy="27.5" r="17" stroke="#16B155" stroke-width="2.5" fill="none"/>
                                        <path d="M24.5 34
                                              C22.5 32.5, 15.5 27.5, 18.5 23.5
                                              C20.2 21.2, 24.5 24, 24.5 26.5
                                              C24.5 24, 28.8 21.2, 30.5 23.5
                                              C33.5 27.5, 26.5 32.5, 24.5 34Z"
                                              stroke="#16B155" stroke-width="2" fill="none"/>
                                        </svg>
                                    </a>
                                </c:if>

                                <c:if test="${sessionScope.username != null and sessionScope.role eq 'Admin'}">
                                    <a href="#" target="_self" style="text-decoration: none;"> Xóa Tin </a>
                                </c:if>
                            </div>

                        </div>
                    </div>
                </div>
            </c:forEach>

            <!--             thông báo-->
            <c:if test="${temporary == true}">

                <c:choose>
                    <c:when test="${status1 == true}">
                        <div id="status1-message" class="custom-toast toast-success">
                            <span class="toast-anim-icon">
                                <!-- Animated checkmark SVG -->
                                <svg class="checkmark" viewBox="0 0 52 52">
                                <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
                                <path class="checkmark-check" fill="none" d="M14 27l7 7 17-17"/>
                                </svg>
                            </span>
                            <span>Lưu Thành Công</span>

                        </div>
                        <% session.removeAttribute("status1"); %>
                    </c:when>
                    <c:otherwise>
                        <div id="status1-message" class="custom-toast toast-error">
                            <span class="toast-anim-icon">
                                <!-- Animated cross SVG -->
                                <svg class="crossmark" viewBox="0 0 52 52">
                                <circle class="crossmark-circle" cx="26" cy="26" r="25" fill="none"/>
                                <path class="crossmark-cross" fill="none" d="M17 17 35 35 M35 17 17 35"/>
                                </svg>
                            </span>
                            <span>Tin tuyển dụng này đã được lưu</span>

                        </div>
                    </c:otherwise>
                </c:choose>

                <% session.removeAttribute("temporary"); %>

            </c:if>


            <!-- End hiển thị job -->
            <!--            hiển thị Action Menu-->
            <div class="floating-actions-v2">
                <div class="fab-item fab-heart" title="Việc làm yêu thích">
                    <a href="<%= request.getContextPath() %>/DisplayListJobPostSaveOfCandidate" target="_self" id="favorite-btn-v2" class="fab-btn" >
                        <i class="bi bi-heart-fill"></i>
                        <c:if test="${username!=null}">
                            <span class="fab-badge" id="favorite-count-v2"> ${numberJobPost}</span>
                        </c:if>

                    </a>
                    <span class="fab-hover-label">Danh sách việc làm đã lưu</span>
                </div>
                <div class="fab-item" title="Góp ý">
                    <a  href="<%= request.getContextPath() %>/ViewActionMenu/Feedback.jsp" target="_self" class="fab-btn">
                        <i class="bi bi-chat-dots"></i>
                    </a>
                    <span class="fab-hover-label">Góp ý GenZTimViec</span>
                </div>
                <div class="fab-item" title="Hỗ trợ" style="z-index:10000;">
                    <button class="fab-btn" id="openSupportPanel" type="button">
                        <i class="bi bi-headset"></i>
                    </button>
                    <span class="fab-hover-label">Hỗ trợ</span>
                </div>

                <div class="support-popup" id="supportPopup" style="display:none;">
                    <div class="support-popup-header d-flex align-items-center justify-content-between" style="background: #15c564; color:#fff; padding: 18px 18px 13px 18px; border-radius: 12px 12px 0 0;">
                        <div>
                            <div style="font-size:1.18rem; font-weight:700;">Trung tâm hỗ trợ </div>
                            <div class="d-flex align-items-center mt-2">
                                <img src="https://genk.mediacdn.vn/thumb_w/640/139269124445442048/2024/6/1/photo-1-17168606131071257137350-1717278776106716631383.jpg" alt="avatar" class="rounded-circle" style="width:38px; height:38px; object-fit:cover; margin-right:10px;">
                                <div>
                                    <div style="font-weight:600;">Sơn Tùng MTP</div>
                                    <div style="font-size:0.97rem;">GenZTimViec thường phản hồi trong vòng 24h</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="support-popup-body">
                        <!--                        <a class="support-popup-link" href="#" target="_blank">
                                                    <i class="bi bi-person"></i> Hướng dẫn quản lý tài khoản
                                                </a>-->
                        <a class="support-popup-link" href="#" target="_blank">
                            <i class="bi bi-question-circle"></i> Các câu hỏi thường gặp
                        </a>
                        <a class="support-popup-link" href="SupportUser" target="_blank">
                            <i class="bi bi-envelope-paper"></i> Yêu cầu hỗ trợ
                        </a>
                        <a class="support-popup-link" href="#" id="contactButton">
                            <i class="bi bi-telephone"></i> Liên hệ GenZTimViec
                        </a>
                    </div>
                </div>
            </div>

            <!--                       Sub Action Menu -->

            <!-- hiển thị thong tin liên hệ -->
            <div id="contactModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.4);">
                <div style="background:#fff; border-radius:10px; max-width:600px; margin:100px auto; padding:24px 16px 16px 16px; position:relative; box-shadow:0 2px 8px rgba(0,0,0,0.2);">
                    <div style="text-align:center;">
                        <div style="color:#24963F; font-weight:600; font-size:20px; margin-bottom:8px;">Liên hệ</div>
                        <div style="font-weight:500; color:#222; margin-bottom:8px;">
                            GenZTimViec cam kết sẽ xử lý các vấn đề của bạn trong vòng tối đa 24h.
                        </div>
                        <div style="margin-bottom:8px;">
                            Tổng đài: <span style="color:#24963F; font-weight:600;">99999 nhé các ngài </span>
                            <span style="color:#24963F;">(Giờ hành chính)</span>
                        </div>
                        <div style="margin-bottom:8px;">
                            Trong trường hợp không liên lạc được, vui lòng gửi hỗ trợ tới email: <br>
                            <a href="mailto:hotro@genztimviec.vn" style="color:#24963F; font-weight:600;">hotro@genztimviec.vn</a>
                        </div>
                        <div style="margin-bottom:16px;">
                            Xin cảm ơn!
                        </div>
                        <button id="closeModalBtn" style="padding: 8px 24px; border:none; background:#E4E6EB; border-radius:6px; font-size:16px; cursor:pointer;">Đóng lại</button>
                    </div>
                </div>
            </div>


            <script>
                const supportBtn = document.getElementById("openSupportPanel");
                const supportPopup = document.getElementById("supportPopup");
                const closeBtn = document.getElementById("closeSupportPanel");

                supportBtn.onclick = function (e) {
                    // Toggle panel
                    if (supportPopup.style.display === "block") {
                        supportPopup.style.display = "none";
                    } else {
                        supportPopup.style.display = "block";
                    }
                };

                // Đóng popup khi bấm nút X
                closeBtn.onclick = function () {
                    supportPopup.style.display = "none";
                };

                // Đóng popup khi click ra ngoài panel
                document.addEventListener('mousedown', function (e) {
                    if (
                            supportPopup.style.display === "block" &&
                            !supportPopup.contains(e.target) &&
                            !supportBtn.contains(e.target)
                            ) {
                        supportPopup.style.display = "none";
                    }
                });
            </script>


            <script>
// Show modal on click
                document.getElementById('contactButton').onclick = function (e) {
                    e.preventDefault();
                    document.getElementById('contactModal').style.display = 'block';
                };
// Hide modal on close
                document.getElementById('closeModalBtn').onclick = function () {
                    document.getElementById('contactModal').style.display = 'none';
                };
// Optional: hide modal when clicking outside the modal box
                document.getElementById('contactModal').onclick = function (event) {
                    if (event.target === this) {
                        this.style.display = 'none';
                    }
                };
            </script>
<!--                    End Action Menu-->

        </div>

        <!-- Bootstrap 5 JS (for modal/tooltips if needed) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const quotes = [
                        "Cơ hội luôn ở đó – bạn chỉ cần một nơi để bắt đầu hành trình.",
                        "Chúng tôi không đưa bạn việc làm, chúng tôi trao bạn tương lai.",
                        "Công việc không chỉ là nguồn sống, mà là nơi ta viết nên câu chuyện cuộc đời.",
                        "Đừng tìm việc chỉ để làm, hãy tìm việc để sống đúng với giá trị của mình.",
                        "Sơn Tùng-MTP :  Muốn ngồi một vị trí không ai ngồi được thì bạn phải chịu cảm giác mà không ai chịu được    .",
                        "Thành công không chờ ai, nhưng luôn mở cửa cho người biết tìm đúng lối đi.",
                        "Không chỉ là tìm việc, mà là tìm thấy chính mình trong sự nghiệp mơ ước"
                    ];
                    let idx = 0;
                    const quoteElem = document.getElementById('quote-rotate');
                    setInterval(() => {
                        quoteElem.style.opacity = 0;
                        setTimeout(() => {
                            idx = (idx + 1) % quotes.length;
                            quoteElem.textContent = quotes[idx];
                            quoteElem.style.opacity = 1;
                        }, 500);
                    }, 5000);
                });
        </script>


        <!--         thêm phân trang -->
        <div class="d-flex justify-content-center mt-4">
            <nav>
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="getListJobPost?page=${currentPage - 1}">&laquo; Trước</a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="getListJobPost?page=${i}"> ${i} </a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="getListJobPost?page=${currentPage + 1}">Sau &raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <!--         kết thúc phân trang-->
    </body>


    <!--     thông báo -->
    <script>
        function hideStatusToast() {
            const elem = document.getElementById('status1-message');
            if (elem) {
                elem.classList.remove('show');
                setTimeout(() => elem.style.display = 'none', 550);
            }
        }
        document.addEventListener("DOMContentLoaded", function () {
            const statusElem = document.getElementById('status1-message');
            if (statusElem) {
                statusElem.classList.add('show');
                setTimeout(() => hideStatusToast(), 1000);
            }
        });
    </script>
</html>