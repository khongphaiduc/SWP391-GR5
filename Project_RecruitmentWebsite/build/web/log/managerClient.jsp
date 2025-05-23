<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Sidebar Profile GitHub Style</title>
  <link rel="stylesheet"  href="<%= request.getContextPath() %>/css/managerClientcss.css">
</head>
<body>
  <aside class="sidebar">
    <div class="sidebar-header">
      <img src="https://avatars.githubusercontent.com/u/khongphaiduc?v=4" alt="Avatar" class="avatar">
      <span class="username"> khongphaiduc </span>
    </div>
    <button class="work-status">Working from home <span class="close-btn">✕</span></button>
    <nav class="sidebar-menu">
      <ul>
        <li><span>🏠</span> Your profile</li>
        <li><span>📁</span> Your repositories</li>
        <li><span>👤</span> Your Copilot</li>
        <li class="active"><span>📚</span> Your projects</li>
        <li><span>⭐</span> Your stars</li>
        <li><span>🗂️</span> Your gists</li>
        <li><span>🏢</span> Your organizations</li>
        <li><span>🌐</span> Your enterprises</li>
        <li><span>💖</span> Your sponsors</li>
      </ul>
      <ul>
        <li><span>🚀</span> Try Enterprise <span class="free-badge">Free</span></li>
        <li><span>🧪</span> Feature preview</li>
        <li><span>⚙️</span> Settings</li>
      </ul>
      <ul>
        <li><span>🌍</span> GitHub Website</li>
        <li><span>📖</span> GitHub Docs</li>
        <li><span>🆘</span> GitHub Support</li>
        <li><span>💬</span> GitHub Community</li>
      </ul>
      <ul>
        <li><span>↩️</span> Sign out</li>
      </ul>
    </nav>
  </aside>
</body>
</html>