<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Chào bạn</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #fafbfc;
                min-height: 100vh;
                margin: 0;
            }
            .main-card {
                background: #fff;
                border-radius: 20px;
                max-width: 750px;
                margin: 40px auto;
                padding: 40px 0 0 0;
                box-shadow: 0 6px 24px 0 rgba(31, 47, 70, 0.15);
            }
            .greeting {
                font-size: 2rem;
                font-weight: 700;
                color: #232323;
                text-align: center;
            }
            .sub-greeting {
                color: #8893a4;
                text-align: center;
                margin-bottom: 30px;
                font-size: 1rem;
            }
            .info-card {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 1px 4px 0 rgba(31, 47, 70, 0.08);
                padding: 32px 20px 48px 20px;
                margin: 0 30px 30px 30px;
            }
            .info-text {
                font-size: 1.1rem;
                color: #232323;
                text-align: center;
                margin-bottom: 32px;
                font-weight: 500;
            }
            .user-selection {
                display: flex;
                justify-content: center;
                gap: 75px;
                margin-bottom: 40px;
            }
            .avatar-card {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 10px;
                width: 180px;
            }
            .avatar-img {
                width: 140px;
                height: 140px;
                object-fit: cover;
                border-radius: 50%;
                background: #f2f4f7;
                border: 2px solid #e5e7eb;
                box-shadow: 0 2px 12px 0 rgba(31, 47, 70, 0.05);
            }
            .choice-btn {
                width: 200px;
                font-size: 1.05rem;
                font-weight: 500;
                border-radius: 30px;
                margin-top: 15px;
                padding: 12px 0;
            }
            @media (max-width: 900px) {
                .user-selection {
                    gap: 20px;
                }
                .avatar-card {
                    width: 130px;
                }
                .avatar-img {
                    width: 100px;
                    height: 100px;
                }
                .choice-btn {
                    width: 130px;
                }
            }
            @media (max-width: 600px) {
                .main-card {
                    padding: 10px 0 0 0;
                    margin: 10px auto;
                }
                .info-card {
                    margin: 0 5px 20px 5px;
                    padding: 14px 5px 32px 5px;
                }
                .user-selection {
                    flex-direction: column;
                    align-items: center;
                    gap: 30px;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-card">
            <div class="greeting">Chào fen,</div>
            <div class="sub-greeting">
                Fen hãy dành ra vài giây để xác nhận thông tin dưới đây nhé! <span>🐥</span>
            </div>
            <div class="info-card">
                <div class="info-text">
                    Để tối ưu tốt nhất cho trải nghiệm của bạn với GenZTimViec,<br>
                    vui lòng lựa chọn nhóm phù hợp nhất với fen.
                </div>
                <div class="user-selection">
                    <!-- Nhà tuyển dụng -->
                    <div class="avatar-card">
                        <img class="avatar-img" src="https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/1/26/874469/Son-Tung-Dep-Trai-5..jpg" alt="Nhà tuyển dụng">
                        <a  href="<%= request.getContextPath() %>/log/FormEmployer.jsp"  class="btn btn-success choice-btn">Tôi là nhà tuyển dụng</a>
                    </div>
                    <!-- Ứng viên tìm việc -->
                    <div class="avatar-card">
                        <img class="avatar-img" src="https://cafefcdn.com/203337114487263232/2023/8/5/3484279376430838645258425639566057508889131n-16912026716341620218990-1691208620129-16912086203201350581624.jpg" alt="Ứng viên tìm việc">
                        <a  href="<%= request.getContextPath() %>/RegisterWithGoogle?role=Candidate" class="btn btn-success choice-btn">Tôi là ứng viên tìm việc</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>