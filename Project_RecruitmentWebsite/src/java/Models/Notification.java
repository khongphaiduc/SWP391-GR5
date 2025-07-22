/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;

/**
 *
 * @author PC
 */
public class Notification {

    private int id;
    private String title;
    private String content;
    private Timestamp createdAt;
    private String roleTarget; // 'Candidate', 'Employer', 'Admin', 'All'

    public Notification() {
    }

    public Notification(int id, String title, String content, Timestamp createdAt, String roleTarget) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.roleTarget = roleTarget;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getRoleTarget() {
        return roleTarget;
    }

    public void setRoleTarget(String roleTarget) {
        this.roleTarget = roleTarget;
    }

}
