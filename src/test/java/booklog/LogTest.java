package booklog;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Log;
import com.bookbox.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml"})
public class LogTest {
	
	@Test
	public void logTest() {
		User user = new User();
		user.setNickname("메리프메에");
		Log log = new Log(user, new Date(100000000), "홍길동", 0, 1);
		
		System.out.println(log.toString());
	}
}
