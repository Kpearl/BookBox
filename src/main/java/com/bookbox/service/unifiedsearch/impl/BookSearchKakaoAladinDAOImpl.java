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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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

	private Book book;
	private List<Book> bookList;

	public BookSearchKakaoAladinDAOImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public List<Book> getBookList(Search search) throws Exception {

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

		jsonParser(response.toString());

		return bookList;
	}

	@Override
	public Book getBook(String isbn) throws Exception {
		String text = URLEncoder.encode(isbn, "UTF-8");
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

		jsonParser(response.toString());

		// Console 확인
		System.out.println(response.toString());
		
		return book;
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

	@SuppressWarnings("unchecked")
	public void jsonParser(String str) throws Exception {

		JSONParser jsonParser = new JSONParser();
		bookList = new ArrayList<Book>();

		// JSON데이터를 넣어 JSON Object 로 만들어 준다.
		JSONObject jsonObject = (JSONObject) jsonParser.parse(str);

		// books의 배열을 추출
		JSONArray bookInfoArray = (JSONArray) jsonObject.get("documents");

		if(bookInfoArray.size() < 2) { }
		
		for (int i = 0; i < bookInfoArray.size(); i++) {

			JSONObject bookObject = (JSONObject) bookInfoArray.get(i);

			if (bookObject.get("isbn").equals(null) == false) {
				if (((String) bookObject.get("isbn")).length() > 13) {
					book = new Book();

					book.setIsbn((String) bookObject.get("isbn"));
					book.setTitle((String) bookObject.get("title"));
					book.setAuthors((List<String>) bookObject.get("authors"));
					book.setPrice((Long) bookObject.get("price"));
					book.setPublisher((String) bookObject.get("publisher"));
					book.setDatetime((String) bookObject.get("datetime"));
					book.setThumbnail((String) bookObject.get("thumbnail"));
					book.setContents((String) bookObject.get("contents"));
					book.setUrl((String) bookObject.get("url"));
					book.setTranslators((List<String>) bookObject.get("translators"));
					
					bookList.add(book);
				}
			}
		}
	}
}
