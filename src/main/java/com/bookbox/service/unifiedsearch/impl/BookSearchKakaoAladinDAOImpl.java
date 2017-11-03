package com.bookbox.service.unifiedsearch.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.bookbox.common.domain.Search;
import com.bookbox.common.util.HttpUtil;
import com.bookbox.service.domain.Book;
import com.bookbox.service.unifiedsearch.BookSearchDAO;

/**
 * @file com.bookbox.service.unifiedsearch.BookSearchKakaoAladinDAOImpl.java
 * @brief BookSearchKakaoAladinDAOImpl
 * @detail
 * @author JJ
 * @date 2017.11.03
 */

@Service("bookSearchKakaoAladinDAOImpl")
public class BookSearchKakaoAladinDAOImpl implements BookSearchDAO {

	public BookSearchKakaoAladinDAOImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public List<Book> getBookList(Search search) throws Exception {

		String text = URLEncoder.encode(search.getKeyword(), "UTF-8");
		String daumOpenAPIURL = "https://dapi.kakao.com/v2/search/book?query=" + text;

		Map<String, String> map = new HashMap<String, String>();
		map.put("Authorization", "KakaoAK ac6d1184e1fd2f18d5318e71495354e7");

		return jsonParser(HttpUtil.requestMethodGet(daumOpenAPIURL, map));
	}

	@Override
	public Book getBook(String isbn) throws Exception {
		String text = URLEncoder.encode(isbn, "UTF-8");
		String daumOpenAPIURL = "https://dapi.kakao.com/v2/search/book?query=" + text;

		Map<String, String> map = new HashMap<String, String>();
		map.put("Authorization", "KakaoAK ac6d1184e1fd2f18d5318e71495354e7");

		return jsonParser(HttpUtil.requestMethodGet(daumOpenAPIURL, map)).get(0);

	}

	@Override
	public List<String> getRecommendBookList() throws Exception {
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
			sb.append(key).append("=").append(hm.get(key)).append("&");
		}
		
		return xmlParser(new URL("http://www.aladin.co.kr/ttb/api/ItemList.aspx?" + sb.toString()));
	}

	public List<Book> jsonParser(String str) throws Exception {

		JSONParser jsonParser = new JSONParser();
		List<Book> bookList = new ArrayList<Book>();
		Book book;

		// JSON데이터를 넣어 JSON Object 로 만들어 준다.
		JSONObject jsonObject = (JSONObject) jsonParser.parse(str);

		// books의 배열을 추출
		JSONArray bookInfoArray = (JSONArray) jsonObject.get("documents");

		for (int i = 0; i < bookInfoArray.size(); i++) {

			JSONObject bookObject = (JSONObject) bookInfoArray.get(i);
			if (bookObject.get("isbn").equals(null) == false) {

				book = parser(bookObject);
				if (book != null) {
					bookList.add(book);
				}
			}
		}
		return bookList;
	}

	@SuppressWarnings("unchecked")
	public Book parser(JSONObject bookObject) {
		Book book = null;

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
		}
		return book;
	}

	public List<String> xmlParser(URL url) throws Exception {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(url.openStream());
		NodeList nodeList = doc.getElementsByTagName("object");
		List<String> list = new ArrayList<String>();

		for (int i = 0; i < nodeList.getLength(); i++) {
			Node mainNode = nodeList.item(i);
			if (mainNode.getNodeType() == Node.ELEMENT_NODE) {
				Element firstElement = (Element) mainNode;
				NodeList forumidNameList = firstElement.getElementsByTagName("item");
				
				for (int j = 0; j < forumidNameList.getLength(); ++j) {
					Element value = (Element) forumidNameList.item(j);
					NodeList conditionList = value.getElementsByTagName("isbn13");
					
					for (int k = 0; k < conditionList.getLength(); ++k) {
                        Element condition = (Element) conditionList.item(k);
                        list.add(condition.getFirstChild().getNodeValue());
                    }
				}
			}
		}
		return list;
	}
}
