package common;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.service.CommonService;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml" })

public class commonTest {

	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;
	
	private User user = new User();
	private Book book = new Book();
	private Reply reply = new Reply();
	private Like like = new Like();
	private Grade grade = new Grade();
	private List<Reply> listReply = new ArrayList<Reply>();

	/*@Test*/
	public void addReplyTest() {
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		reply.setContent("에베베베베");
		
		commonService.addReply(user, book.getIsbn(), Const.Category.BOOK, reply);
	}
	
	//똑같은 내용을 가진 reply일 경우 동시 삭제됨
	/*@Test*/
	public void deleteReplyTest() {
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874977");
		reply.setContent("addBookListTest");
		
		commonService.deleteReply(user, book.getIsbn(), Const.Category.BOOK, reply);
	}
	
	@Test
	public void getReplyListTest() {
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		
		listReply = (List<Reply>) commonService.getReplyList(user, book.getIsbn(), Const.Category.BOOK);
		
		System.out.println(listReply);
	}
	
	public void deleteLikeTest() {

	}

	public void addLikeTest() {

	}
	
	public void getLikeTest() {
		
	}
	
	public void addGradeTest() {

	}
	
	public void getGradeTest() {
		
	}
}
