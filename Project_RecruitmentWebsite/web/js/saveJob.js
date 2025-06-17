
//200 – 299	true 
//400 – 599	false 

document.addEventListener("DOMContentLoaded", function () {
    const saveButtons = document.querySelectorAll(".save-job-btn");

    saveButtons.forEach(button => {
        button.addEventListener("click", function (e) {
            e.preventDefault(); // chặn load trang
            const jobPostId = this.getAttribute("data-id");

            fetch(`SaveJobPost?idJobPost=${jobPostId}`, {method: "GET" })   //fetch là hàm tích hợp sẵn của JavaScript dùng để gửi HTTP request đến server.
            .then(response => {                                            // then để sử lý sau  khi nhận respone của server
                if (response.ok) {
                  document.getElementById("thongbao1-status1-message").style.display='block';
                  document.getElementById("thongbao1-status1-message").style.display='none';
                } else {
                    document.getElementById("thongbao2-status1-message").style.display='block';
                  document.getElementById("thongbao2-status1-message").style.display='none';
                }
            })
            .catch(error => {
                console.error("Lỗi:", error);
                alert("Đã xảy ra lỗi!");
            });
        });
    });
});
