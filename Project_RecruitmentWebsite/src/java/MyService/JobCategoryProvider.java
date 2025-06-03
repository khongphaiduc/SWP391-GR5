package MyService;

import java.util.ArrayList;

public class JobCategoryProvider {

    public static ArrayList<String> getJobCategories() {
        ArrayList<String> list = new ArrayList<>();


        list.add("IT phần mềm");
        list.add("Marketing");
        list.add("Kinh doanh/Bán hàng");
        list.add("Nhân sự/Hành chính");
        list.add("Tài chính/Kế toán");
        list.add("Mỹ Thuật");
        list.add("Kiểm Toán");
        list.add("Design");
        list.add("Finance");
        
//        list.add("Thiết kế - Mỹ thuật");
//        list.add("Điện - Điện tử - Điện lạnh");
//        list.add("Cơ khí - Ô tô - Tự động hóa");
//        list.add("Ngân hàng - Chứng khoán - Bảo hiểm");
//        list.add("Logistics - Xuất nhập khẩu");
//        list.add("Du lịch - Nhà hàng - Khách sạn");
//        list.add("Y tế - Dược phẩm");
//        list.add("Pháp lý - Luật");
//        list.add("Báo chí - Biên tập - Xuất bản");
//        list.add("Bảo trì - Sửa chữa");
//        list.add("An ninh - Bảo vệ");


        return list;
    }
}
