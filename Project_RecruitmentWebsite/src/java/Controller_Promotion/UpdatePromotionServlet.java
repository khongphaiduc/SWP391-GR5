package Controller_Promotion;

import DAO.PromotionDAO;
import Models.Promotion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/update-promotion")
public class UpdatePromotionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("promotionId"));
        Promotion promo = new PromotionDAO().getPromotionById(id);
        req.setAttribute("promotion", promo);
        req.getRequestDispatcher("/page_service/updatePromotion.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Promotion promo = new Promotion(); // tạo trước để luôn gán lại
        try {
            int id = Integer.parseInt(req.getParameter("promotionId"));
            String code = req.getParameter("code");
            double discount = Double.parseDouble(req.getParameter("discount"));
            String start = req.getParameter("dateStart");
            String end = req.getParameter("dateEnd");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateStart = sdf.parse(start);
            Date dateEnd = sdf.parse(end);

            promo.setPromotionId(id);
            promo.setCode(code);
            promo.setDiscount(discount);
            promo.setDateStart(dateStart);
            promo.setDateEnd(dateEnd);

            PromotionDAO dao = new PromotionDAO();
            boolean updated = dao.updatePromotion(promo);

            if (updated) {
                req.setAttribute("message", "✅ Cập nhật thành công.");
            } else {
                req.setAttribute("error", "❌ Không thể cập nhật khuyến mãi.");
            }

        } catch (Exception e) {
            req.setAttribute("error", "❌ Lỗi: " + e.getMessage());
            e.printStackTrace();
        }

        // luôn gán lại promotion để hiển thị lại form
        req.setAttribute("promotion", promo);
        req.getRequestDispatcher("/page_service/updatePromotion.jsp").forward(req, resp);
    }
}
