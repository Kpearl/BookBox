package com.bookbox.service.unifiedsearch.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.XML;
import org.springframework.stereotype.Service;
import org.xml.sax.helpers.DefaultHandler;

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
public class BookSearchKakaoAladinDAOImpl extends DefaultHandler implements BookSearchDAO {

	public BookSearchKakaoAladinDAOImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
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

		Book book = new Book();
		book.setContents(response.toString());

		List<Book> bookList = new ArrayList<Book>();

		bookList.add(book);

		// Console 확인
		System.out.println(response.toString());
	}

	@Override
	public void getBook(Book book) throws Exception {
		String text = URLEncoder.encode(book.getIsbn(), "UTF-8");
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

		Book bookSearch = new Book();
		bookSearch.setContents(response.toString());

		// Console 확인
		System.out.println(response.toString());
	}

	@Override
	public void getRecommendBookList() throws Exception {

		Map<String, String> hm = new HashMap<String, String>();
		hm.put("output", "xml&Version=20131101");
		hm.put("MaxResults", "10");
		hm.put("start", "1");
		hm.put("SearchTarget", "Book");
		hm.put("QueryType", "Bestseller");
		hm.put("ttbkey", "ttb1015wlswn1921003");

		StringBuffer sb = new StringBuffer();
		Iterator<String> iter = hm.keySet().iterator();

		while (iter.hasNext()) {
			String key = iter.next();
			String val = hm.get(key);
			sb.append(key).append("=").append(val).append("&");
		}

		URL url = new URL("http://www.aladin.co.kr/ttb/api/ItemList.aspx?" + sb.toString());
		BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
		String inputLine;

		while ((inputLine = in.readLine()) != null)
			sb.append(inputLine.trim());
		
		org.json.JSONObject obj = XML.toJSONObject(sb.toString());

		System.out.println(obj.toString());

		in.close();
	}
}
