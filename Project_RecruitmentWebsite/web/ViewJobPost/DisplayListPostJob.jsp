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
        </style>


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
                        <input type="text" class="form-control" id="keyword" name="searchKey" placeholder="Nhập từ khoá và Enter">
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
                            <a href="#" class="job-title">${s.title}</a>
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
<!--<<<<<<< HEAD
                            <form action="apply" style="display:inline;">
                                <input type="hidden" name="jobPostID" value="${jobPost.jobPost_ID}" />
                                <input type="hidden" name="candidateID" value="${sessionScope.candidate.candidate_ID}" />
                                <button type="submit" class="apply-btn">Ứng tuyển ngay</button>
                            </form>
=======-->
                            <!-- Nút ứng tuyển với icon trái tim cùng dòng -->

                            <div class="d-flex align-items-center justify-content-between mt-2">
                                <button class="apply-btn">
                                    <i class="bi bi-send-fill"></i> Ứng tuyển ngay
                                </button>
                                <a href="javascript:void(0)" class="ms-3 heart-btn" style="text-decoration:none;">
                                    <svg class="heart-svg" width="38" height="28" viewBox="0 0 60 54" fill="none" stroke="#ff4d6d" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle">
                                    <path 
                                        d="M30 50 
                                        C 28 47, 8 33, 8 18
                                        A 10 10 0 0 1 30 15
                                        A 10 10 0 0 1 52 18
                                        C 52 33, 32 47, 30 50 Z"/>
                                    </svg>
                                </a>
                            </div>

                        </div>
                    </div>
                </div>
            </c:forEach>
            <!-- End hiển thị job -->


            <!--              hiển thị support-->
            <div class="floating-actions-v2">
                <div class="fab-item fab-heart" title="Việc làm yêu thích">
                    <a href="<%= request.getContextPath() %>/getListJobPostSaveOfCandidate" target="_blank" id="favorite-btn-v2" class="fab-btn" >
                        <i class="bi bi-heart-fill"></i>
                        <span class="fab-badge" id="favorite-count-v2">0</span>
                    </a>
                    <span class="fab-hover-label">Danh sách việc làm đã lưu</span>
                </div>
                <div class="fab-item" title="Bảo mật">
                    <a  href="<%= request.getContextPath() %>/getListJobPostSaveOfCandidate" target="_blank" class="fab-btn">
                        <i class="bi bi-shield-check"></i>
                    </a>
                    <span class="fab-hover-label">Tìm việc an toàn</span>
                </div>
                <div class="fab-item" title="Góp ý">
                    <a  href="<%= request.getContextPath() %>/giveComments" target="_blank" class="fab-btn">
                        <i class="bi bi-chat-dots"></i>
                    </a>
                    <span class="fab-hover-label">Góp ý GenZTimViec</span>
                </div>
                <div class="fab-item" title="Hỗ trợ">
                    <a  href="<%= request.getContextPath() %>/SupportUser" target="_blank" class="fab-btn">
                        <i class="bi bi-headset"></i>
                    </a>
                    <span class="fab-hover-label">Hỗ trợ</span>
                </div>
            </div>


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

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Quote rotate giữ nguyên phía trên

            // Xử lý thả tim
            document.querySelectorAll('.heart-btn').forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    var svg = btn.querySelector('.heart-svg');
                    svg.classList.toggle('filled');
                });
            });
        });
    </script>
</html>