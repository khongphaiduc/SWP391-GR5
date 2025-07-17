package Controller_Promotion;

import DAO.PromotionDAO;
import Models.Promotion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/delete-promotion")
public class DeletePromotionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("promotionId"));
            PromotionDAO dao = new PromotionDAO();
            Promotion promo = dao.getPromotionById(id);

            if (promo == null) {
                req.setAttribute("promotionError", "❌ Không tìm thấy khuyến mãi.");
                req.getRequestDispatcher("/viewuser.jsp").forward(req, resp);
            } else {
                Date now = new Date();
                if (promo.getDateEnd().after(now)) {
                    req.setAttribute("promotionError", "❌ Không thể xoá khuyến mãi đang hoạt động.");
                    req.getRequestDispatcher("/list").forward(req, resp);
                } else {
                    boolean deleted = dao.deletePromotion(id);
                    if (deleted) {
                        // Redirect về list với thông báo qua query string (nếu muốn)
                        resp.sendRedirect(req.getContextPath() + "/list?promotionMessage=deleted");
                        return;
                    } else {
                        req.setAttribute("promotionError", "❌ Xoá thất bại.");
                        req.getRequestDispatcher("/viewuser.jsp").forward(req, resp);
                    }
                }
            }

        } catch (Exception e) {
            req.setAttribute("promotionError", "❌ Lỗi: " + e.getMessage());
            e.printStackTrace();
            req.getRequestDispatcher("/viewuser.jsp").forward(req, resp);
        }
    }
}

