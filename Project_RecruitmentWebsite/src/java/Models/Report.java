/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Report {
    public String feedBackReportId;
    public String  id;
    public String role ;
    public String phone;
    public String title;
    public String content;
    public Date dateSend;
    public String status;
    public String urlImage;
    public Report(String feedBackReportId, String id, String role, String phone, String title, String content, Date dateSend, String status) {
        this.feedBackReportId = feedBackReportId;
        this.id = id;
        this.role = role;
        this.phone = phone;
        this.title = title;
        this.content = content;
        this.dateSend = dateSend;
        this.status = status;
    }

    public Report(String feedBackReportId, String id, String role, String phone, String title, String content, Date dateSend, String status, String urlImage) {
        this.feedBackReportId = feedBackReportId;
        this.id = id;
        this.role = role;
        this.phone = phone;
        this.title = title;
        this.content = content;
        this.dateSend = dateSend;
        this.status = status;
        this.urlImage = urlImage;
    }
    
    

    public void setFeedBackReportId(String feedBackReportId) {
        this.feedBackReportId = feedBackReportId;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setDateSend(Date dateSend) {
        this.dateSend = dateSend;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFeedBackReportId() {
        return feedBackReportId;
    }

    public String getId() {
        return id;
    }

    public String getRole() {
        return role;
    }

    public String getPhone() {
        return phone;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public Date getDateSend() {
        return dateSend;
    }

    public String getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "Report{" + "feedBackReportId=" + feedBackReportId + ", id=" + id + ", role=" + role + ", phone=" + phone + ", title=" + title + ", content=" + content + ", dateSend=" + dateSend + ", status=" + status + ", urlImage=" + urlImage + '}';
    }

 

    
    
   
}
