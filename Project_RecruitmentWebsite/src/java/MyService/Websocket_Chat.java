package MyService;

import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.io.StringReader;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/websocket_Chat")
public class Websocket_Chat {

    private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
    private static final Map<String, Session> userSessions = new ConcurrentHashMap<>();
    private static final Map<Session, String> sessionToUser = new ConcurrentHashMap<>();

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
                String image = json.getString("image");
                String from = sessionToUser.get(sender);
                Session receiver = userSessions.get(to);

                if (receiver != null && receiver.isOpen()) {
                    receiver.getBasicRemote().sendText(Json.createObjectBuilder()
                            .add("from", from)
                            .add("message", msg)
                            .add("image", image)
                            .build().toString());
                } else {
                    sender.getBasicRemote().sendText(Json.createObjectBuilder()
                            .add("from", "system")
                            .add("message", "️Người dùng '" + to + "' không online.")
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
        clients.remove(session);
        String username = sessionToUser.remove(session);
        if (username != null) {
            userSessions.remove(username);
            System.out.println(username + " đã ngắt kết nối.");
        }
        System.out.println("Client disconnected: " + session.getId());
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("️ Error for client " + session.getId() + ": " + throwable.getMessage());
    }
}
