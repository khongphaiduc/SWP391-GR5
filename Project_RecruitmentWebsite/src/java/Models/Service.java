/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.List;

/**
 *
 * @author admin
 */
public class Service {

    private int serviceId;
    private String serviceName;
    private double price;
    private String description;
    private Integer promotionId; // vì giá trị có thể null
    private int duration;

    //cải tiến
    private List<String> descriptionList;

    public List<String> getDescriptionList() {
        return descriptionList;
    }

    public void setDescriptionList(List<String> descriptionList) {
        this.descriptionList = descriptionList;
    }

    //thêm
//    private boolean isVisible;
//
//    public boolean isVisible() {
//        return isVisible;
//    }
//
//    public void setIsVisible(boolean isVisible) {
//        this.isVisible = isVisible;
//    }

    public Service() {
    }

    public Service(int serviceId, String serviceName, double price, String description, Integer promotionId, int duration) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.price = price;
        this.description = description;
        this.promotionId = promotionId;
        this.duration = duration;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(Integer promotionId) {
        this.promotionId = promotionId;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    @Override
    public String toString() {
        return "Service{" + "serviceId=" + serviceId + ", serviceName=" + serviceName + ", price=" + price + ", description=" + description + ", promotionId=" + promotionId + ", duration=" + duration + '}';
    }

}
