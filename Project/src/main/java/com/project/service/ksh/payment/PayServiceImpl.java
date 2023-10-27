package com.project.service.ksh.payment;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;



import org.apache.tomcat.util.json.JSONParser;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;

@Service
public class PayServiceImpl implements PayService {
	String impKey = "6208485383120734";
	String impSecret = "LhGS6esknLSY3r3YH0Dtvh65MXPpP27VLL8F6FKcavXsrJKrmkuvUcjUxjLWYTTvZLeCxAMJXSjSaHcU";

	@Override
	public String getToken() throws Exception {


		return null;

	}

}
