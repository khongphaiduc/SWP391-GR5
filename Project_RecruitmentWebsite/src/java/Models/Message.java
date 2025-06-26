
package Models;

public class Message {

    public String from;
    public String to;
    public String message;
    public String image;
    public String time;

    public Message(String from, String to, String message, String image) {
        this.from = from;
        this.to = to;
        this.message = message;
        this.image = image;
       
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public void setTo(String to) {
        this.to = to;
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

    public String getTo() {
        return to;
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
        return "Message{" + "from=" + from + ", to=" + to + ", message=" + message + ", image=" + image + ", time=" + time + '}';
    }



}
