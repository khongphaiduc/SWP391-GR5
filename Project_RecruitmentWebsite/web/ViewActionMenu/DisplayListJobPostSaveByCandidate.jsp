<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách JobPost đã lưu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/SaveJobPostcss.css">
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

        <header class="main-header shadow-sm">
            <nav class="navbar navbar-expand-lg py-3">
                <div class="container">
                    <a class="navbar-brand d-flex align-items-center" href="#">
                        <span class="brand-icon rounded-circle me-2 d-flex align-items-center justify-content-center">
                            <i class="bi bi-briefcase-fill"></i>
                        </span>
                        <span class="fw-bold brand-title">GenZTimViec</span>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                            aria-controls="navbarContent" aria-expanded="false" aria-label="Menu">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarContent">

                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">

                            <li class="nav-item">
                                <a class="nav-link" href="./index.jsp"><i class="bi bi-house-door"></i> Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#"><i class="bi bi-briefcase"></i> Việc làm</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#"><i class="bi bi-person-circle"></i> Tài khoản</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <!-- Header End -->


        <div class="container py-5">
            <div class="row g-4">

                <!-- JobPost Mẫu 1 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/google.com" alt="Google" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">Frontend Developer <i class="bi bi-patch-check-fill text-success" title="Tin xác thực"></i></div>
                                    <span class="badge cv-badge mb-1">Google</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Hà Nội · <i class="bi bi-calendar2-check"></i> Hạn: 30/06/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Tham gia phát triển giao diện web hiện đại với ReactJS, môi trường sáng tạo, năng động.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-fire text-danger"></i> Hot Job</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 2 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/microsoft.com" alt="Microsoft" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">Backend Engineer</div>
                                    <span class="badge cv-badge mb-1 bg-success">Microsoft</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Đà Nẵng · <i class="bi bi-calendar2-check"></i> Hạn: 20/06/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Làm việc với .NET Core, Azure Cloud, đãi ngộ cạnh tranh, môi trường đa quốc gia.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-person-workspace"></i> Hybrid</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 3 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/vng.com.vn" alt="VNG" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">UX/UI Designer</div>
                                    <span class="badge cv-badge mb-1 bg-warning text-dark">VNG Corp</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Hồ Chí Minh · <i class="bi bi-calendar2-check"></i> Hạn: 15/06/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Thiết kế sản phẩm game/app di động, môi trường trẻ trung, sáng tạo, đãi ngộ cao.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-lightbulb"></i> Ý tưởng mới</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 4 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/amazon.com" alt="Amazon" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">Cloud Solutions Architect <i class="bi bi-cloud-arrow-up-fill text-success"></i></div>
                                    <span class="badge cv-badge mb-1">Amazon Web Services</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Remote · <i class="bi bi-calendar2-check"></i> Hạn: 05/07/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Triển khai giải pháp Cloud, quản lý hệ thống AWS, bonus hấp dẫn, phỏng vấn online.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-globe"></i> Remote</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 5 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/novaland.com.vn" alt="Novaland" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">Data Analyst <i class="bi bi-bar-chart-line-fill text-success"></i></div>
                                    <span class="badge cv-badge mb-1">NovaLand</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Hồ Chí Minh · <i class="bi bi-calendar2-check"></i> Hạn: 25/06/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Phân tích dữ liệu lớn, sử dụng Power BI/Tableau, ưu tiên ứng viên có chứng chỉ.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-award"></i> Ưu tiên chứng chỉ</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 6 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/viettel.com.vn" alt="Viettel" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">Network Security Specialist</div>
                                    <span class="badge cv-badge mb-1 bg-success">Viettel Group</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Hà Nội · <i class="bi bi-calendar2-check"></i> Hạn: 10/07/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Đảm bảo an ninh mạng, triển khai firewall, ưu tiên ứng viên từng làm về bảo mật.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-shield-lock"></i> Bảo mật cao</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 7 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/techcombank.com.vn" alt="Techcombank" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">Mobile App Developer</div>
                                    <span class="badge cv-badge mb-1">Techcombank</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Hà Nội · <i class="bi bi-calendar2-check"></i> Hạn: 20/07/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Phát triển ứng dụng mobile banking bằng Flutter/React Native. Cơ hội thăng tiến rõ ràng.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-phone"></i> Mobile</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 8 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/vinamilk.com.vn" alt="Vinamilk" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">Business Analyst</div>
                                    <span class="badge cv-badge mb-1 bg-success">Vinamilk</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Hồ Chí Minh · <i class="bi bi-calendar2-check"></i> Hạn: 28/06/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Phân tích nghiệp vụ, bridge giữa IT & business, yêu cầu tiếng Anh giao tiếp tốt.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-graph-up"></i> Business</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JobPost Mẫu 9 -->
                <div class="col-md-6 col-lg-4">
                    <div class="card cv-card h-100 shadow border-0">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="job-logo-wrap me-3">
                                    <img src="https://logo.clearbit.com/fpt.com.vn" alt="FPT" class="job-logo">
                                </div>
                                <div>
                                    <div class="cv-title">AI Engineer <i class="bi bi-cpu-fill text-success"></i></div>
                                    <span class="badge cv-badge mb-1">FPT Software</span>
                                    <div class="cv-date"><i class="bi bi-geo-alt"></i> Đà Nẵng · <i class="bi bi-calendar2-check"></i> Hạn: 18/07/2025</div>
                                </div>
                            </div>
                            <div class="cv-description mb-2">
                                Nghiên cứu, phát triển AI/ML, xử lý ngôn ngữ tự nhiên, môi trường trẻ trung, sáng tạo.
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-light text-success"><i class="bi bi-cpu"></i> AI/ML</span>
                            </div>
                            <div>
                                <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

<!--             Action Menu-->
            <div class="floating-actions-v2">
                <div class="fab-item fab-heart" title="Việc làm yêu thích">
                    <a href="<%= request.getContextPath() %>/getListJobPostSaveOfCandidate" target="_self" id="favorite-btn-v2" class="fab-btn" >
                        <i class="bi bi-heart-fill"></i>
                        <span class="fab-badge" id="favorite-count-v2">0</span>
                    </a>
                    <span class="fab-hover-label">Danh sách việc làm đã lưu</span>
                </div>
                <div class="fab-item" title="Bảo mật">
                    <a  href="<%= request.getContextPath() %>/getListJobPostSaveOfCandidate" target="_self" class="fab-btn">
                        <i class="bi bi-shield-check"></i>
                    </a>
                    <span class="fab-hover-label">Tìm việc an toàn</span>
                </div>
                <div class="fab-item" title="Góp ý">
                    <a  href="<%= request.getContextPath() %>/giveComments" target="_self" class="fab-btn">
                        <i class="bi bi-chat-dots"></i>
                    </a>
                    <span class="fab-hover-label">Góp ý GenZTimViec</span>
                </div>
                <div class="fab-item" title="Hỗ trợ">
                    <a  href="<%= request.getContextPath() %>/SupportUser" target="_self" class="fab-btn">
                        <i class="bi bi-headset"></i>
                    </a>
                    <span class="fab-hover-label">Hỗ trợ</span>
                </div>
            </div>

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>