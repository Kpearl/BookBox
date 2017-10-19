package booklog;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml"})
public class BooklogTest {
	
	@Autowired
	@Qualifier("booklogServiceImpl")
	private BooklogService booklogService;
	
//	@Test
	public void getBooklogListTest() {
		Search search = new Search();
		
		search.setCondition("nickname");
		search.setKeyword("스");
		
		System.out.println(booklogService.getBooklogList(search));
	}
	
	@Test
	public void getBooklogTest() {
		Booklog booklog = new Booklog();
		User user = new User();
		user.setEmail("wndhks@naver.com");
		booklog.setUser(user);
	
		System.out.println(booklogService.getBooklog(new User(), booklog));
	}
}
