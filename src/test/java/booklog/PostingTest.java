package booklog;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml"})
public class PostingTest {
	
	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService postingService;
	
	@Test
	public void addPostingTest() throws Exception{
		User user = new User();
		user.setEmail("wndhks@naver.com");
		
		Posting posting = new Posting();
		posting.setPostingTitle("세번째으로 서비스로 올리는 포슽잉");
		posting.setPostingContent("세번째라 성공이지만 두근두근두근 거려 미쳐버릴것만 같아 로그가 안남아서 하지만 이제 완성이겠지");
		posting.setUser(user);
		
		postingService.addPosting(user, posting);
	}

}
