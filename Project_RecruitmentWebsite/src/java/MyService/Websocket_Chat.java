package MyService;

import DAO_Chat.DB_Chat;
import Models.Message;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.io.StringReader;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/websocket_Chat")
public class Websocket_Chat {

    private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
    private static final Map<String, Session> userSessions = new ConcurrentHashMap<>();
    private static final Map<Session, String> sessionToUser = new ConcurrentHashMap<>();

    private static final Map<String, List<Message>> chatLogs = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
        System.out.println("Client connected: " + session.getId());
    }

    @OnMessage
    public void onMessage(String infojon, Session sender) throws IOException {
        JsonObject json = Json.createReader(new StringReader(infojon)).readObject();
        String type = json.getString("type", "broadcast");

        switch (type) {
            case "register": {
                String username = json.getString("username");
                userSessions.put(username, sender);
                sessionToUser.put(sender, username);
                System.out.println(username + " đã đăng ký.");
                break;
            }
            case "private": {
                String to = json.getString("to");
                String msg = json.getString("message");
                String image = json.getString("avatar");
                String from = sessionToUser.get(sender);
                Session receiver = userSessions.get(to);

                if (receiver != null && receiver.isOpen()) {
                    receiver.getBasicRemote().sendText(Json.createObjectBuilder()
                            .add("from", from)
                            .add("message", msg)
                            .add("avatar", image)
                            .build().toString());
                    // lưu tạm thời đoạn chat vào map
                    chatLogs.computeIfAbsent(from + "_" + to, k -> new ArrayList<>()) // kiểm tra key đã tồn hay or chưa , nếu chưa thì tạo mới  và gán cho 1 cái list
                            .add(new Message(from, to, msg, image));  // nếu key đã tồn tại thì thêm vào list của key đấy

                } else {
                    sender.getBasicRemote().sendText(Json.createObjectBuilder()
                            .add("from", "system")
                            .add("message", "️Người dùng '" + to + "' không online.vbkfghjk")
                            .add("avatar", image)
                            .build().toString());
                }
                break;
            }
            case "broadcast": {
                String msg = json.getString("message");
                String from = sessionToUser.get(sender);
                for (Session client : clients) {
                    if (client.isOpen() && !sender.equals(client)) {
                        client.getBasicRemote().sendText(Json.createObjectBuilder()
                                .add("from", from)
                                .add("message", msg)
                                .build().toString());
                    }
                }
                break;
            }
            default: {
                sender.getBasicRemote().sendText(Json.createObjectBuilder()
                        .add("from", "system")
                        .add("message", "Unknown type: " + type)
                        .build().toString());
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);   // xóa user ra khởi danh sách online 
        String username = sessionToUser.remove(session);
        if (username != null) {
            userSessions.remove(username);
            System.out.println(username + " đã ngắt kết nối.");

            // Lưu các cuộc trò chuyện liên quan vào DB
            List<Message> listToSave = new ArrayList<>();  
            for (String key : chatLogs.keySet()) {
                if (key.startsWith(username + "_") || key.endsWith("_" + username)) {
                    listToSave.addAll(chatLogs.get(key));
                }
            }

            if (!listToSave.isEmpty()) {
                DB_Chat dao = new DB_Chat();
                for (Message msg : listToSave) {
                    dao.saveMessage(msg);
                }
                System.out.println("Đã lưu " + listToSave.size() + " tin nhắn của " + username);
                
                chatLogs.keySet().removeIf(key -> key.startsWith(username + "_") || key.endsWith("_" + username)); //  xóa
            }
        }


        System.out.println("Client disconnected: " + session.getId());
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("️ Error for client " + session.getId() + ": " + throwable.getMessage());
    }
}
