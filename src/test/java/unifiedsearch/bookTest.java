package unifiedsearch;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.service.CommonService;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookSearchDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml" })

public class bookTest {

	@Autowired
	@Qualifier("bookSearchKakaoAladinDAOImpl")
	private BookSearchDAO bookSearchDAO;

	@Autowired
	@Qualifier("bookServiceImpl")
	private CommonService bookService;
	
	@Autowired
	@Qualifier("bookDAOImpl")
	private CommonDAO bookDAO;

	/* @Test */
	public void bookListSearchTest() throws Exception {

		Search search = new Search();

		search.setKeyword("죄와벌");
		search.setCondition("도서");
		search.setCategory(Category.BOOK);

		bookSearchDAO.getBookList(search);
	}

	/* @Test */
	public void bookSearchTest() throws Exception {

		Book book = new Book();
		book.setIsbn("9788954874977");

		bookSearchDAO.getBook(book);
		;
	}

	/* @Test */
	public void getBookTest() throws Exception {

		bookSearchDAO.getRecommendBookList();
	}

	public void deleteBookLike() {
		
	}
	
	public void addBookLike() {
		
	}

	@Test
	public void addBookReply() {
		
		User user = new User();
		Book book = new Book();
		Reply reply = new Reply();
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874977");
		reply.setContent("addBookListTest");
		
		//bookDAO.addBookReply(user, book, reply);
	}

	public void deleteBookReply() {

	}

	public void addBookGrade() {

	}
}
