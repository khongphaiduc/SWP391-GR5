/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class LiveChat {
   public  int messageID;
    public String senderID;
    public String senderRole;
    public String reciverID;
    public String reciverRole;
    public Date date;
    public String content;
    public int isRead;

    public LiveChat() {
    }

    public LiveChat(int messageID,String senderID, String senderRole, String reciverID, String reciverRole, Date date, String content, int isRead) {
        this.senderID = senderID;
        this.senderRole = senderRole;
        this.reciverID = reciverID;
        this.reciverRole = reciverRole;
        this.date = date;
        this.content = content;
        this.isRead = isRead;
        this.messageID=messageID;
    }

    public int getMessageID() {
        return messageID;
    }

    public String getSenderID() {
        return senderID;
    }

    public String getSenderRole() {
        return senderRole;
    }

    public String getReciverID() {
        return reciverID;
    }

    public String getReciverRole() {
        return reciverRole;
    }

    public Date getDate() {
        return date;
    }

    public String getContent() {
        return content;
    }

    public int getIsRead() {
        return isRead;
    }

    public void setMessageID(int messageID) {
        this.messageID = messageID;
    }

    public void setSenderID(String senderID) {
        this.senderID = senderID;
    }

    public void setSenderRole(String senderRole) {
        this.senderRole = senderRole;
    }

    public void setReciverID(String reciverID) {
        this.reciverID = reciverID;
    }

    public void setReciverRole(String reciverRole) {
        this.reciverRole = reciverRole;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setIsRead(int isRead) {
        this.isRead = isRead;
    }

   

  
    
}
