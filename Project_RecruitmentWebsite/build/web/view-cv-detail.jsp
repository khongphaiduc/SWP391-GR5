<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Models.CV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết CV</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <!-- Thông báo nếu có -->
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-info">${sessionScope.message}</div>
        <c:remove var="message" scope="session" />
    </c:if>

    <div class="container mt-4">
        <h2 class="text-center">Chi tiết CV</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:if test="${not empty cv}">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">${cv.fullName}</h5>
                    <p class="card-text"><strong>Vị trí:</strong> ${cv.position}</p>
                    <p class="card-text"><strong>Địa chỉ:</strong> ${cv.address}</p>
                    <p class="card-text"><strong>Email:</strong> ${cv.email}</p>
                    <p class="card-text"><strong>Kinh nghiệm:</strong> ${cv.numberExp} năm</p>
                    <p class="card-text"><strong>Trình độ:</strong> ${cv.education}</p>
                    <p class="card-text"><strong>Lĩnh vực:</strong> ${cv.field}</p>
                    <p class="card-text"><strong>Mức lương:</strong> ${cv.currentSalary}</p>
                    <p class="card-text"><strong>Ngày sinh:</strong> ${cv.birthday}</p>
                    <p class="card-text"><strong>Quốc tịch:</strong> ${cv.nationality}</p>
                    <p class="card-text"><strong>Giới tính:</strong> ${cv.gender}</p>

                    <!-- Hiển thị trạng thái -->
                    <c:if test="${not empty apply}">
                        <p class="mt-3">
                            <span class="cv-step-badge badge bg-info text-dark">Trạng thái: ${apply.step}</span>
                        </p>
                    </c:if>
                </div>
            </div>

            <!-- FORM CẬP NHẬT STEP -->
            <c:if test="${not empty applyId}">
                <form action="update-step" method="post" class="mt-3">
                    <input type="hidden" name="applyId" value="${applyId}">
                    <input type="hidden" name="cvId" value="${cv.cvId}"> <!-- để redirect lại -->
                    <div class="mb-3">
                        <label for="step" class="form-label">Cập nhật trạng thái:</label>
                        <select name="step" id="step" class="form-select w-auto d-inline">
                            <option value="Đã nhận hồ sơ">Đã nhận hồ sơ</option>
                            <option value="Đang xét duyệt">Đang xét duyệt</option>
                            <option value="Mời phỏng vấn">Mời phỏng vấn</option>
                            <option value="Đã phỏng vấn">Đã phỏng vấn</option>
                            <option value="Gửi offer">Gửi offer</option>
                            <option value="Đã nhận việc">Đã nhận việc</option>
                        </select>
                        <button type="submit" class="btn btn-primary btn-sm ms-2">Cập nhật</button>
                    </div>
                </form>
            </c:if>
        </c:if>

        <a href="view-applied-cvs" class="btn btn-secondary mt-3">Quay lại danh sách</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
