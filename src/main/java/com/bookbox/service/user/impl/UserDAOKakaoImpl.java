package com.bookbox.service.user.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserRestDAO;

/**
 * @file com.bookbox.service.user.impl.UserDAOKakaoImpl.java
 * @brief 카카오로그인 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Repository("userDAOKakaoImpl")
public class UserDAOKakaoImpl implements UserRestDAO {

	/**
	 * @brief Kakao LOGIN
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception{
		
		String daumOpenAPIURL = "https://kapi.kakao.com/v1/user/me";
		
		// java API 를 이용 HttpRequest
		URL url = new URL(daumOpenAPIURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", "Bearer "+user.getOuterToken());
		
     // Response Code GET
        int responseCode = con.getResponseCode();
        System.out.println("ResponseCode 확인 : " + responseCode);
 
        BufferedReader br = null;
        
        if(responseCode==200) { 
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        
      //JSON Data 읽기
        String jsonData = "";
        StringBuffer response = new StringBuffer();

        while ((jsonData = br.readLine()) != null) {
            response.append(jsonData);
        }
        
        br.close();
        
         // Console 확인
        System.out.println("response정보 확인 :: "+response.toString());
        
        JSONObject jsonobj = (JSONObject)JSONValue.parse(response.toString());
        
         user.setEmail((String)jsonobj.get("kaccount_email"));
       
         System.out.println("email 정보 확인 :: "+(String)jsonobj.get("kaccount_email"));
      
		
         return user;
	}
	
	/**
	 * @brief Kakao LOGOUT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void logout(User user) throws Exception{
		
	}
}
