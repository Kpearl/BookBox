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

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.springframework.stereotype.Service;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.ParserAdapter;

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

	private static final String BASE_URL = "http://www.aladin.co.kr/ttb/api/ItemList.aspx?";
	public List<Book> bookList;
	private Book currentItem;
	private boolean inItemElement = false;
	private String tempValue;

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
	public void getBook(Book book) {
		// TODO Auto-generated method stub

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
		
			/*
		parseXml(BASE_URL + sb.toString());

		for(Book book : bookList){
			System.out.println(book.getTitle() + " : " + book.getUrl());
		}*/
		StringBuffer ssb = new StringBuffer();
		URL url = new URL(BASE_URL + sb.toString());

		BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
        String inputLine;

        while ((inputLine = in.readLine()) != null)
            sb.append( inputLine.trim());
        
        in.close();
        
        System.out.println( sb.toString());
        
        org.json.JSONObject jsonObj = XML.toJSONObject( sb.toString());
        System.out.println(jsonObj);
        JSONObject obj = (JSONObject) new XMLSerializer().read( sb.toString());
        System.out.println( obj);


출처: http://starplatina.tistory.com/entry/XML-을-JSON으로 [Clean Code that Works.]
		
	}

	public void startElement(String namespace, String localName, String qName, Attributes atts) {
		if (localName.equals("item")) {
			currentItem = new Book();
			inItemElement = true;
		} else if (localName.equals("title")) {
			tempValue = "";
		} else if (localName.equals("link")) {
			tempValue = "";
		}
	}

	public void characters(char[] ch, int start, int length) throws SAXException {
		tempValue = tempValue + new String(ch, start, length);
	}

	public void endElement(String namespaceURI, String localName, String qName) {
		if (inItemElement) {
			if (localName.equals("item")) {
				bookList.add(currentItem);
				currentItem = null;
				inItemElement = false;
			} else if (localName.equals("title")) {
				currentItem.setTitle(tempValue);
			} else if (localName.equals("link")) {
				currentItem.setUrl(tempValue);
			}
		}
	}

	public void parseXml(String xmlUrl) throws Exception {
		SAXParserFactory spf = SAXParserFactory.newInstance();
		SAXParser sp = spf.newSAXParser();
		ParserAdapter pa = new ParserAdapter(sp.getParser());
		pa.setContentHandler(this);
		pa.parse(xmlUrl);
	}
}
