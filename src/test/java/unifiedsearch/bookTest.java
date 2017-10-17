package unifiedsearch;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Search;
import com.bookbox.service.unifiedsearch.BookSearchDAO;
import com.bookbox.service.unifiedsearch.BookService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml" })

public class bookTest {

	@Autowired
	@Qualifier("bookSearchKakaoAladinDAOImpl")
	private BookSearchDAO bookSearchDAO;

	@Autowired
	@Qualifier("bookServiceImpl")
	private BookService bookService;

	/*@Test*/
	public void bookListSearchTest() throws Exception {
		Search search = new Search();
		
		search.setKeyword("8996991341");
		search.setCondition("도서");
		search.setCategory(Category.BOOK);

		bookSearchDAO.getBookList(search);
	}
	
	@Test
	public void getBookTest() throws Exception {
		
		bookSearchDAO.getRecommendBookList();
	}
}
