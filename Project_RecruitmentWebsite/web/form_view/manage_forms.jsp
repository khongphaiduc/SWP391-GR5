<%@ page import="java.util.List" %>
<%@ page import="Models.Form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Quản lý Form</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 900px;
                margin: 50px auto;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                padding: 30px;
            }

            h2 {
                text-align: center;
                color: #00b86b;
                font-weight: 600;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 12px 16px;
                border-bottom: 1px solid #ddd;
                text-align: left;
            }

            th {
                background-color: #f0f0f0;
                font-weight: 600;
            }

            .actions form {
                display: inline-block;
                margin-right: 8px;
            }

            .btn {
                padding: 8px 14px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                color: white;
            }

            .btn-preview {
                background-color: #00b86b;
            }

            .btn-edit {
                background-color: #007bff;
            }

            .btn-delete {
                background-color: #dc3545;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .no-data {
                text-align: center;
                padding: 20px;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/navbar.jsp" />
        <div class="container">

            <h2>Danh sách Form đã tạo</h2>

            <%
                List<Form> forms = (List<Form>) request.getAttribute("forms");
                if (forms == null || forms.isEmpty()) {
            %>
            <p class="no-data">Bạn chưa tạo biểu mẫu nào.</p>
            <%
                } else {
            %>
            <table>
                <tr>
                    <th>Tiêu đề</th>
                    <th>Hành động</th>
                </tr>
                <%
                    for (Form form : forms) {
                %>
                <tr>
                    <td><%= form.getTitle() %></td>
                    <td class="actions">
                        <form action="manageForm" method="post">
                            <input type="hidden" name="formId" value="<%= form.getFormId() %>"/>
                            <input type="hidden" name="action" value="view"/>
                            <button type="submit" class="btn btn-preview">Xem trước</button>
                        </form>
<!--                        <form action="manageForm" method="post">
                            <input type="hidden" name="formId" value="<%= form.getFormId() %>"/>
                            <input type="hidden" name="action" value="Edit"/>
                            <button type="submit" class="btn btn-edit">Chỉnh sửa</button>
                        </form>-->
                        <form action="manageForm" method="post" onsubmit="return confirm('Bạn chắc chắn muốn xóa?')">
                            <input type="hidden" name="formId" value="<%= form.getFormId() %>"/>
                            <input type="hidden" name="action" value="Delete"/>

                            <button type="submit" class="btn btn-delete">Xóa</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
            <% } %>
        </div>
    </body>
</html>
