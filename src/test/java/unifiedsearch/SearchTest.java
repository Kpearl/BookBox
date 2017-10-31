package unifiedsearch;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml",
		"classpath:config/context-mail.xml" })

public class SearchTest {

	public SearchTest() {
		// TODO Auto-generated constructor stub
	}

	// id를 입력하지 않아도 insert 가능(POST 방식)
	/* @Test */
	public void insertTest() throws Exception {
		String query = "http://localhost:9200/bookbox/book";
		String json = "{\"data\":\"name\", \"test\":\"test  비트 캠프22\"}";

		URL url = new URL(query);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setConnectTimeout(5000);
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		conn.setRequestMethod("POST");

		OutputStream os = conn.getOutputStream();
		os.write(json.getBytes("UTF-8"));
		os.close();

		// read the response
		InputStream in = new BufferedInputStream(conn.getInputStream());
		String result = IOUtils.toString(in, "UTF-8");
		JSONObject jsonObject = new JSONObject(result);

		in.close();
		conn.disconnect();

		System.out.println(jsonObject.toString());
	}

	// ID를 입력해야함 (GET 방식)
	/* @Test */
	public void updateTest() throws Exception {
		String query = "http://localhost:9200/bookbox/book/1111111111111";
		String json = "{\"data\":\"name\", \"test\":\"test33\"}";

		URL url = new URL(query);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setConnectTimeout(5000);
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		conn.setRequestMethod("PUT");

		OutputStream os = conn.getOutputStream();
		os.write(json.getBytes("UTF-8"));
		os.close();

		// read the response
		InputStream in = new BufferedInputStream(conn.getInputStream());
		String result = IOUtils.toString(in, "UTF-8");
		JSONObject jsonObject = new JSONObject(result);

		in.close();
		conn.disconnect();

		System.out.println(jsonObject.toString());
	}

	// ID 입력하면 해당 데이터 삭제
	/* @Test */
	public void deleteTest() throws Exception {
		String query = "http://localhost:9200/bookbox/book/AV9qvqpXtAGS8-AVRSbh";

		URL url = new URL(query);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setConnectTimeout(5000);
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		conn.setRequestMethod("DELETE");

		// read the response
		InputStream in = new BufferedInputStream(conn.getInputStream());
		String result = IOUtils.toString(in, "UTF-8");
		JSONObject jsonObject = new JSONObject(result);
		conn.disconnect();

		System.out.println(jsonObject.toString());
	}

	// 키워드를 통해 검색한다.
	@Test
	public void analyzeTest() throws Exception {
		String query = "http://localhost:9200/test/_search";
		String text = "도스";
		String json = "{\"query\":{\"multi_match\":{ \"fields\":[\"title\", \"content\"], \"query\":\"" +text+ "\"}}}";
		
		URL url = new URL(query);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setConnectTimeout(5000);
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		conn.setRequestMethod("POST");

		OutputStream os = conn.getOutputStream();
		os.write(json.getBytes("UTF-8"));
		os.close();

		// read the response
		InputStream in = new BufferedInputStream(conn.getInputStream());
		String result = IOUtils.toString(in, "UTF-8");
		JSONObject jsonObject = new JSONObject(result);

		in.close();
		conn.disconnect();

		System.out.println(jsonObject.toString());
	}
}
