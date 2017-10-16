package com.bookbox.service.unifiedsearch.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.unifiedsearch.BookSearchDAO;

/**
 * @file com.bookbox.service.unifiedsearch.BookSearchKakaoAladinDAOImpl.java
 * @brief BookSearchKakaoAladinDAOImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */

@Service("bookSearchKakaoAladinDAOImpl")
public class BookSearchKakaoAladinDAOImpl implements BookSearchDAO {

	public BookSearchKakaoAladinDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void getBookList(Search search) throws Exception {
		
		String text = URLEncoder.encode(search.getKeyword(), "UTF-8");
		String daumOpenAPIURL = "https://dapi.kakao.com/v2/search/book?query=" + text;

		// java API 를 이용 HttpRequest
		URL url = new URL(daumOpenAPIURL);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Authorization", "KakaoAK ac6d1184e1fd2f18d5318e71495354e7");

		// Response Code GET
		int responseCode = con.getResponseCode();

		BufferedReader br = null;

		if (responseCode == 200) {
			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
		} else { // 에러 발생
			br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		}

		// JSON Data 읽기
		String jsonData = "";
		StringBuffer response = new StringBuffer();

		while ((jsonData = br.readLine()) != null) {
			response.append(URLDecoder.decode(jsonData, "UTF-8"));
		}

		br.close();

		// Console 확인
		System.out.println(response.toString());
	}

	@Override
	public void getBook(Book book) {
		// TODO Auto-generated method stub

	}

	@Override
	public void getRecommendBookList() {
		// TODO Auto-generated method stub
		
	}
}
