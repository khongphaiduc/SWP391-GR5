package MyService;

import Models.JobCategory;
import java.util.ArrayList;

public class JobCategoryProvider {

    public static ArrayList<JobCategory> getJobCategories() {
        ArrayList<JobCategory> list = new ArrayList<>();

        list.add(new JobCategory(1, "CNTT - IT"));
        list.add(new JobCategory(2, "Kế toán - Tài chính"));
        list.add(new JobCategory(3, "Marketing - Truyền thông"));
        list.add(new JobCategory(4, "Giáo dục - Đào tạo"));
        list.add(new JobCategory(5, "Xây dựng - Kiến trúc"));
        list.add(new JobCategory(6, "Bán hàng - Kinh doanh"));
        list.add(new JobCategory(7, "Nhân sự - Hành chính"));
        list.add(new JobCategory(8, "Chăm sóc khách hàng"));
        list.add(new JobCategory(9, "Sản xuất - Vận hành"));
        list.add(new JobCategory(10, "Thiết kế - Mỹ thuật"));
        list.add(new JobCategory(11, "Điện - Điện tử - Điện lạnh"));
        list.add(new JobCategory(12, "Cơ khí - Ô tô - Tự động hóa"));
        list.add(new JobCategory(13, "Ngân hàng - Chứng khoán - Bảo hiểm"));
        list.add(new JobCategory(14, "Logistics - Xuất nhập khẩu"));
        list.add(new JobCategory(15, "Du lịch - Nhà hàng - Khách sạn"));
        list.add(new JobCategory(16, "Y tế - Dược phẩm"));
        list.add(new JobCategory(17, "Pháp lý - Luật"));
        list.add(new JobCategory(18, "Báo chí - Biên tập - Xuất bản"));
        list.add(new JobCategory(19, "Bảo trì - Sửa chữa"));
        list.add(new JobCategory(20, "An ninh - Bảo vệ"));

        return list;
    }
}
