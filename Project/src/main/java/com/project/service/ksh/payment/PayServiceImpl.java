package com.project.service.ksh.payment;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

@Service
public class PayServiceImpl implements PayService {
	String impKey = "6208485383120734";
	String impSecret = "LhGS6esknLSY3r3YH0Dtvh65MXPpP27VLL8F6FKcavXsrJKrmkuvUcjUxjLWYTTvZLeCxAMJXSjSaHcU";

	@Override
	public String getToken() throws Exception {
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/users/getToken");
		conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JSONObject json = new JSONObject();

		json.put("imp_key", impKey);
		json.put("imp_secret", impSecret);

		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		System.out.println(json.toString());
		bw.write(json.toString());
		bw.flush();
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		System.out.println(br.toString());
		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();

		String token = gson.fromJson(response, Map.class).get("access_token").toString();
		
		br.close();
		conn.disconnect();

		int resCode = conn.getResponseCode();
		System.out.println(conn.getResponseMessage());
		System.out.println(conn.getContent().toString());

		return token;

	}

}
