<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách JobPost đã lưu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/SaveJobPostcss.css">
        <link rel="stylesheet" href="../css/phantrangcss.css"/>
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
                                <a class="nav-link" href="/Project_RecruitmentWebsite/Index"><i class="bi bi-house-door"></i> Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="searchListJobPost"><i class="bi bi-briefcase"></i> Việc làm</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/log/profile.jsp"><i class="bi bi-person-circle"></i> Tài khoản</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <!-- Header End -->


        <div class="container py-5">

            <c:set var="escapedJson" value="${fn:escapeXml(listJobPostSave)}"/>
            <a id="listJobPost" data-listJobPost='${escapedJson}'></a>

            <div id="areDisplayJob" class="row g-4">

                <!-- Hiện thị list  -->





            </div>
            <!--                   hiển thị thông tin nếu list rỗng -->
            
            
            
            <div id="status" style="display:none">
                <h3 style="display: flex;justify-content: center ;color: #14b866">Bạn Chưa Lưu JobPost Nào !</h3>
                <img src="./img/memeEmty.png" width="300" height="700" style="border-radius: 100px"/>              
            </div>
               
           

            <jsp:include page="/IconActionMenu.jsp" />


            <!--            Phần phân trang -->
            <div class="d-flex justify-content-center mt-4">
                <nav>
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="DisplayListJobPostSaveOfCandidate?page=${currentPage - 1}">&laquo; Trước</a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="DisplayListJobPostSaveOfCandidate?page=${i}"> ${i} </a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="DisplayListJobPostSaveOfCandidate?page=${currentPage + 1}">Sau &raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
            <!--            Phần phân trang -->

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!--     thông báo -->
        <script>

            function attachDeleteEvents() {
                const removeButtons = document.querySelectorAll('.userRemove');
                removeButtons.forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();
                        const idSaveJobPost = this.dataset.idsavejobpost;
                        fetch(`/Project_RecruitmentWebsite/DeleteJobPostSaved?idJobPost=` + idSaveJobPost)
                                .then(response => {
                                    if (response.status === 200) {  // xóa thành  công để thì return  về 200
                                        const indexToRemove = listJobPost.findIndex(job => job.saveIdJobPost == idSaveJobPost);
                                        if (indexToRemove !== -1) {
                                            listJobPost.splice(indexToRemove, 1);
                                            renderListPost(); // Gọi lại để cập nhật giao diện
                                          
                                        }
                                    } else {
                                        alert("Xóa thất bại");
                                    }
                                })
                                .catch(error => {
                                    console.error("Lỗi:", error);
                                    alert("Có lỗi xảy ra khi xóa");
                                });
                    });
                });
            }




            const areDisplayJob = document.getElementById('areDisplayJob');
            const rawData = document.getElementById('listJobPost').dataset.listjobpost;
            const listJobPost = JSON.parse(rawData);   // biến thằng json thành object 
            console.log("Dữ liệu đã parse:", listJobPost);
            console.log("thằng list da luu nay :" + listJobPost);

            function renderListPost() {
                let html = ""; // Gom toàn bộ kết quả vào một biến
                listJobPost.forEach(s => {
                    html += `
                    <div class="col-md-6 col-lg-4">
                        <div class="card cv-card h-100 shadow border-0">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="job-logo-wrap me-3">
                                        <img src="./img/logpmtp.png" alt="MTP" class="job-logo">  
                                    </div>
                                    <div>
                                        <div class="cv-title">` + s.title + `
                                            <i class="bi bi-patch-check-fill text-success" title="Tin xác thực"></i>
                                        </div>
                                        <span class="badge cv-badge mb-1">` + s.company + `</span>
                                        <div class="cv-date">
                                            <i class="bi bi-geo-alt"></i> ` + s.location + `
                                             · <i class="bi bi-calendar2-check"></i> Ngày Lưu ` + s.dayCre + `
                                        </div>
                                    </div>
                                </div>
                                <div class="cv-description mb-2">
            ` + s.description + `
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-light text-success"><i class="bi bi-fire text-danger"></i> Hot Job</span>
                                </div>
                                <div>
                                    <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                    <a href="#" data-idsavejobpost="` + s.saveIdJobPost + `" class="btn btn-outline-danger btn-sm userRemove">
                                        <i class="bi bi-bookmark-x"> Xóa</i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>`;
                });
                areDisplayJob.innerHTML = html;
                attachDeleteEvents();
                
                const  thongbao = document.getElementById('status');
                
                if(listJobPost.length==0){
                    thongbao.style.display='block';
                }else{
                    thongbao.style.display='none';
                }
                
            }

         
            renderListPost();
            
            
          
            
            
            
        </script>


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
    </body>
</html>