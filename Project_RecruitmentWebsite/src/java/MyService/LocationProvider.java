/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package MyService;

import java.util.ArrayList;

/**
 *
 * @author PC
 */
public class LocationProvider {
    public static ArrayList<String> getLocations() {
        ArrayList<String> list = new ArrayList<>();

        list.add("Hà Nội");
        list.add("TP Hồ Chí Minh");
        list.add("Đà Nẵng");
        list.add("Hải Phòng");
        list.add("Cần Thơ");
        list.add("Khác");
       
        return list;
    }
}
