
package Models;

public class Message {

    public String from;
    public String roleFrom;
    public String to;
    public String roleTo;
    public String message;
    public String image;
    public String time;

    public Message(String from, String roleFrom, String to, String roleTo, String message, String image, String time) {
        this.from = from;
        this.roleFrom = roleFrom;
        this.to = to;
        this.roleTo = roleTo;
        this.message = message;
        this.image = image;
        this.time = time;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public void setRoleFrom(String roleFrom) {
        this.roleFrom = roleFrom;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public void setRoleTo(String roleTo) {
        this.roleTo = roleTo;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getFrom() {
        return from;
    }

    public String getRoleFrom() {
        return roleFrom;
    }

    public String getTo() {
        return to;
    }

    public String getRoleTo() {
        return roleTo;
    }

    public String getMessage() {
        return message;
    }

    public String getImage() {
        return image;
    }

    public String getTime() {
        return time;
    }

    @Override
    public String toString() {
        return "Message{" + "from=" + from + ", roleFrom=" + roleFrom + ", to=" + to + ", roleTo=" + roleTo + ", message=" + message + ", image=" + image + ", time=" + time + '}';
    }


}
