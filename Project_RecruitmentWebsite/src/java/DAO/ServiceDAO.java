/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Service;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import java.util.Arrays;

public class ServiceDAO extends DBContext {

    public List<Service> getAllService() {
        List<Service> list = new ArrayList<>();

        String sql = "SELECT * FROM Service";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("Service_ID"));
                service.setServiceName(rs.getString("Service_Name"));
                service.setPrice(rs.getDouble("Price"));

                String desc = rs.getString("Description");
                service.setDescription(desc);

                // Cắt từng mục mô tả nếu dùng dấu ; hoặc xuống dòng
                if (desc != null) {
                    List<String> descList = Arrays.asList(desc.split("[;\n]"));
                    service.setDescriptionList(descList);
                }
                service.setDuration(rs.getInt("Duration"));

//                int promoId = rs.getInt("Promotion_ID");
//                // Nếu Promotion_ID là NULL, getInt trả về 0. Phải kiểm tra isNull
//                if (rs.wasNull()) {
//                    service.setPromotionId(null);
//                } else {
//                    service.setPromotionId(promoId);
//                }

                service.setIsVisible(rs.getBoolean("Is_Visible"));
                list.add(service);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //for employer
    public List<Service> getVisibleServicesForEmployer() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE Is_Visible = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("Service_ID"));
                service.setServiceName(rs.getString("Service_Name"));
                service.setPrice(rs.getDouble("Price"));

                String desc = rs.getString("Description");
                service.setDescription(desc);

                // Tách mô tả bằng dấu ; hoặc xuống dòng
                if (desc != null && !desc.trim().isEmpty()) {
                    List<String> descList = Arrays.asList(desc.split("[;\n]"));
                    service.setDescriptionList(descList);
                }

                service.setDuration(rs.getInt("Duration"));

//                int promoId = rs.getInt("Promotion_ID");
//                if (rs.wasNull()) {
//                    service.setPromotionId(null);
//                } else {
//                    service.setPromotionId(promoId);
//                }

                //  Vì chỉ lấy Is_Visible = 1 nên mặc định set true
                service.setIsVisible(true);

                list.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean insertService(Service service) {
        String sql = "INSERT INTO Service (Service_Name, Price, Description, Duration) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Nếu descriptionList có giá trị, gộp lại thành 1 chuỗi mô tả duy nhất (cách nhau bằng ;)
            if (service.getDescription() == null && service.getDescriptionList() != null) {
                service.setDescription(String.join("; ", service.getDescriptionList()));
            }

            ps.setString(1, service.getServiceName());
            ps.setDouble(2, service.getPrice());
            ps.setString(3, service.getDescription());
            ps.setInt(4, service.getDuration());

//            if (service.getPromotionId() != null) {
//                ps.setInt(5, service.getPromotionId());
//            } else {
//                ps.setNull(5, java.sql.Types.INTEGER);
//            }

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }

    /**
     * Cập nhật thông tin một gói dịch vụ
     *
     * @param service Đối tượng Service đã chứa dữ liệu cập nhật
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    public boolean updateService(Service service) {
        String sql = "UPDATE Service SET Service_Name = ?, Price = ?, Description = ?, Duration = ? WHERE Service_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Nếu descriptionList có giá trị, gộp lại thành 1 chuỗi mô tả duy nhất (cách nhau bằng ;)
            if (service.getDescription() == null && service.getDescriptionList() != null) {
                service.setDescription(String.join("; ", service.getDescriptionList()));
            }
            ps.setString(1, service.getServiceName());
            ps.setDouble(2, service.getPrice());
            ps.setString(3, service.getDescription());
            ps.setInt(4, service.getDuration());

//            if (service.getPromotionId() != null) {
//                ps.setInt(5, service.getPromotionId());
//            } else {
//                ps.setNull(5, java.sql.Types.INTEGER);
//            }

            ps.setInt(5, service.getServiceId());

            int updated = ps.executeUpdate();
            return updated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa một gói dịch vụ theo ID
     *
     * @param id ID của dịch vụ cần xóa
     * @return true nếu xóa thành công, false nếu thất bại
     */
    public boolean deleteService(int serviceId) {
        String sql = "DELETE FROM Service WHERE Service_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tìm danh sách dịch vụ theo ID hoặc tên gần đúng
     *
     * @param keyword chuỗi cần tìm (có thể là số hoặc từ khoá tên dịch vụ)
     * @return danh sách dịch vụ khớp
     */
    public List<Service> searchService(String keyword) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE CAST(Service_ID AS NVARCHAR) LIKE ? OR Service_Name LIKE ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("Service_ID"));
                service.setServiceName(rs.getString("Service_Name"));
                service.setPrice(rs.getDouble("Price"));
                service.setDescription(rs.getString("Description"));
                service.setDuration(rs.getInt("Duration"));

//                int promoId = rs.getInt("Promotion_ID");
//                if (rs.wasNull()) {
//                    service.setPromotionId(null);
//                } else {
//                    service.setPromotionId(promoId);
//                }

                services.add(service);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public Service getServiceById(int id) {
        String sql = "SELECT * FROM Service WHERE Service_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Service s = new Service();
                s.setServiceId(rs.getInt("Service_ID"));
                s.setServiceName(rs.getString("Service_Name"));
                s.setPrice(rs.getDouble("Price"));
                s.setDescription(rs.getString("Description"));
                s.setDuration(rs.getInt("Duration"));

//                int promoId = rs.getInt("Promotion_ID");
//                s.setPromotionId(rs.wasNull() ? null : promoId);

                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Kiểm tra xem một gói dịch vụ với các thông tin tương tự đã tồn tại hay
     * chưa (dựa vào tên, giá, mô tả, thời hạn, khuyến mãi)
     *
     * @param service Đối tượng Service cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    public boolean isServiceExists(Service service) {
        String sql = "SELECT COUNT(*) FROM Service WHERE Service_Name = ? AND Price = ? AND Description = ? AND Duration = ? ";

//        AND (Promotion_ID = ? OR (Promotion_ID IS NULL AND ? IS NULL))
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getServiceName());
            ps.setDouble(2, service.getPrice());
            ps.setString(3, service.getDescription());
            ps.setInt(4, service.getDuration());

//            if (service.getPromotionId() != null) {
//                ps.setInt(5, service.getPromotionId());
//                ps.setInt(6, service.getPromotionId()); // để so sánh vế IS NULL
//            } else {
//                ps.setNull(5, java.sql.Types.INTEGER);
//                ps.setNull(6, java.sql.Types.INTEGER);
//            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    //
    public boolean updateServiceVisibility(int serviceId, boolean visible) {
        String sql = "UPDATE Service SET Is_Visible = ? WHERE Service_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, visible);
            ps.setInt(2, serviceId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //
    public boolean getVisibilityByServiceId(int serviceId) {
        String sql = "SELECT Is_Visible FROM Service WHERE Service_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("Is_Visible");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        // Tạo đối tượng DAO
        ServiceDAO dao = new ServiceDAO();
        List<Service> list = dao.getAllService();
        for (Service s : list) {
            System.out.println(s);
        }
//
//        // Tạo gói dịch vụ mẫu
//        Service ecoService = new Service(1, "Eco", 20, "mmmmmm", null, 5);
//
//        // Gọi DAO để insert vào database
//        boolean isInserted = dao.insertService(ecoService);
////        List<Service> list = dao.getAllService();
////        for (Service s : list){
////            System.out.println(s);
////        }
//        // In kết quả ra console
//        if (isInserted) {
//            System.out.println("Thêm gói Eco thành công!");
//            List<Service> list = dao.getAllService();
//            for (Service s : list) {
//                System.out.println(s);
//            }
//        } else {
//            System.out.println("Thêm gói Eco thất bại!");
//        }
        // Tìm theo tên
//        List<Service> list = dao.searchService("eco");
//
//        // Hoặc tìm theo ID
//        // List<Service> list = dao.searchService("2");
//        for (Service s : list) {
//            System.out.println(s);
//        }
    }
}
