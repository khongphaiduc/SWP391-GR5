package Models;

import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Google {

    private static final String CLIENT_ID = System.getenv("CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("CLIENT_SECRET");
    private static final String REDIRECT_URI = "http://localhost:8080/Project_RecruitmentWebsite/LogWithGoogle";

    // phương thức lấy token từ code mà goole trả về cho tao 
    public String getToken(String code) throws IOException {
        URL url = new URL("https://oauth2.googleapis.com/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");    // gửi thằng method post
        conn.setDoOutput(true);

        String params = "code=" + code
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&redirect_uri=" + REDIRECT_URI
                + "&grant_type=authorization_code";

        OutputStream os = conn.getOutputStream();
        os.write(params.getBytes());
        os.flush();
        os.close();

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine, result = "";
        while ((inputLine = in.readLine()) != null) {
            result += inputLine;
        }
        in.close();

        JsonObject jsonObject = JsonParser.parseString(result).getAsJsonObject();
        return jsonObject.get("access_token").getAsString();
    }

    //  có token rồi gửi lại cho google API để  thằng api nó trả về  các thông tin của gg trong dạng json
    public GoogleInfo getUserInfo(String accessToken) throws IOException {
        URL url = new URL("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken);   // đường dẫn xác thực token của thằng gg
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");   // sử dụng get để gửi token lên cho thằng Google API Console

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine, result = "";
        while ((inputLine = in.readLine()) != null) {
            result += inputLine;
        }
        in.close();

        Gson gson = new Gson();   //  sử dụng đối tượng Gson để chuyển Json thành thằng GoogleInfo 
        return gson.fromJson(result, GoogleInfo.class);
    }

    public static void main(String[] args) {
        String envClientId = System.getenv("CLIENT_ID");
        String hardcoded = "780846937780-ahb5qprjgmul2n1filj1haul2lssonk2.apps.googleusercontent.com";

        System.out.println("ENV: [" + envClientId + "]");
        System.out.println("HARD: [" + hardcoded + "]");
        System.out.println("Equal? " + envClientId.equals(hardcoded));
    }

}
