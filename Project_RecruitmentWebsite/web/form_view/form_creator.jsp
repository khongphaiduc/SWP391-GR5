<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Tạo form</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 800px;
                margin: 50px auto;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                padding: 30px;
            }

            h1 {
                text-align: center;
                color: #00b86b;
                font-weight: 600;
            }

            textarea,
            select {
                width: 100%;
                padding: 12px;
                margin-top: 10px;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-sizing: border-box;
                font-size: 15px;
                resize: vertical;
            }

            textarea {
                min-height: 80px;
            }

            input[type="text"] {
                width: 100%;
                padding: 12px;
                margin-top: 10px;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-sizing: border-box;
                font-size: 15px;
            }

            .question-block {
                border: 1px solid #eee;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 15px;
                background-color: #fafafa;
                position: relative;
            }

            .btn {
                padding: 10px 18px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                margin-right: 10px;
            }

            .btn-green {
                background-color: #00b86b;
                color: white;
            }

            .btn-green:hover {
                background-color: #009b5a;
            }

            .btn-red {
                background-color: #ff4d4d;
                color: white;
                position: absolute;
                top: 10px;
                right: 10px;
            }

            .btn-red:hover {
                background-color: #e60000;
            }
            .btn-back {
                background-color: #6c757d; /* Bootstrap secondary */
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
                margin-top: 10px;
                transition: background-color 0.2s ease-in-out;
                margin-left: 30px;
            }

            .btn-back:hover {
                background-color: #5a6268;
                color: white;
                text-decoration: none;
            }

        </style>

        <script>
            function addQuestion() {
                const container = document.getElementById("questionContainer");

                const questionCount = container.children.length;
                const html = document.createElement('div');
                html.className = "question-block";
                html.innerHTML = `
                    <textarea name="questionText" placeholder="Câu hỏi" required></textarea>
                    <select name="questionType">
                        <option value="text">Tự luận</option>
                        <option value="choice">Trắc nghiệm</option>
                    </select>
                    <textarea name="answer" placeholder="Đáp án đúng (nếu có)"></textarea>
                    <button type="button" class="btn btn-red" onclick="removeQuestion(this)">Xóa</button>
                `;
                container.appendChild(html);
                updateDeleteButtons();
            }

            function removeQuestion(button) {
                const container = document.getElementById("questionContainer");
                if (container.children.length <= 1) {
                    alert("Phải có ít nhất 1 câu hỏi.");
                    return;
                }
                button.parentElement.remove();
                updateDeleteButtons();
            }


            function updateDeleteButtons() {
                const blocks = document.querySelectorAll(".question-block");
                const showDelete = blocks.length > 1;
                blocks.forEach(block => {
                    const deleteBtn = block.querySelector(".btn-red");
                    if (deleteBtn) {
                        deleteBtn.style.display = showDelete ? 'inline-block' : 'none';
                    }
                });
            }

            window.onload = function () {
                updateDeleteButtons();
            }
        </script>
    </head>
    <body>
        <a href="index.jsp" class="btn btn-back">← Quay lại Trang chủ</a>

        <div class="container">

            <h1>Tạo Form câu hỏi</h1>
            <form action="form" method="post">
                <input type="text" name="formTitle" placeholder="Tiêu đề form" required />
                <div id="questionContainer">
                    <div class="question-block">
                        <textarea name="questionText" placeholder="Câu hỏi" required></textarea>
                        <select name="questionType">
                            <option value="text">Tự luận</option>
                            <option value="choice">Trắc nghiệm</option>
                        </select>
                        <textarea name="answer" placeholder="Đáp án đúng (nếu có)"></textarea>
                        <button type="button" class="btn btn-red" onclick="removeQuestion(this)">Xóa</button>
                    </div>
                </div>
                <button type="button" class="btn btn-green" onclick="addQuestion()">+ Thêm câu hỏi</button>
                <button type="submit" class="btn btn-green">Xem trước</button>
            </form>
        </div>
    </body>
</html>
