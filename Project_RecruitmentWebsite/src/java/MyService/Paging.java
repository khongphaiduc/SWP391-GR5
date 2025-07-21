/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package MyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author PC
 */
public class Paging {

//    List<CV> paginatedList = PaginationHelper.paginate(request, session, cvList, "pageSize");

    public static <T> List<T> paginate(HttpServletRequest request, HttpSession session, List<T> fullList, String sessionKey) {
        String pageParam = request.getParameter("page");
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

        int pageSize = 5;
        if (session.getAttribute(sessionKey) != null) {
            pageSize = (int) session.getAttribute(sessionKey);
        }
        if (request.getParameter("pageSize") != null) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }
        session.setAttribute(sessionKey, pageSize);

        int totalItems = fullList.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalItems);

        if (fromIndex >= totalItems) {
            fromIndex = 0;
            toIndex = Math.min(pageSize, totalItems);
            page = 1;
        }

        List<T> paginatedList = fullList.subList(fromIndex, toIndex);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        return paginatedList;
    }

}
