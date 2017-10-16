package unifiedsearch;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Search;
import com.bookbox.service.unifiedsearch.impl.BookServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml" })

public class bookTest {

	@Autowired
	@Qualifier("bookServiceImpl")
	private BookServiceImpl bookServiceImpl;

	@Test
	public void bookSearchTest() throws Exception{
		Search search = new Search();

		System.out.println("bookSearchTest start...");
		
		search.setKeyword("눈물은 왜 짠가");
		search.setCondition("도서");
		search.setCategory(Category.BOOK);
		
		bookServiceImpl.getBookList(search);
		
	}
}
