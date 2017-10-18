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
import com.bookbox.common.util.CommonUtil;
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

	/* @Test */
	public void addReplyTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		reply.setContent("으버ㅓㅂ버버벙");

		commonService.addReply(user, CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn()), reply);
	}

	// 똑같은 내용을 가진 reply일 경우 동시 삭제됨
	 /*@Test */
	public void deleteReplyTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874970");
		reply.setContent("에베베베베");

		commonService.deleteReply(user, CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn()), reply);
	}

	/*@Test*/
	public void getReplyListTest() {
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		
		listReply = (List<Reply>) commonService.getReplyList(user,CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn()));
		
		System.out.println(listReply.toString());
	}

	/*@Test*/
	public void addGradeTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		grade.setUserCount(5);
		
		commonService.addGrade(user, CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn()), grade);
	}
	
	/*@Test*/
	public void getGradeTest() {
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		
		System.out.println(commonService.getGrade(user, CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn())));
	}

	/*@Test*/
	public void addLikeTest() {
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		like.setDoLike(true);

		commonService.addLike(user, CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn()), like);
	}	
	
	@Test
	public void getLikeTest() {
		
		user.setEmail("test@test.com");
		book.setIsbn("9788954874970");

		System.out.println(commonService.getLike(user, CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn())));
	}
}
