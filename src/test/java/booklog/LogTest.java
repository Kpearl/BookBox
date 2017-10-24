package booklog;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Log;
import com.bookbox.common.service.LogService;
import com.bookbox.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mail.xml"})
public class LogTest {
	
	@Autowired
	@Qualifier("logServiceImpl")
	private LogService logService;
	
//	@Test
	public void addLogTest() {
		Log log = new Log();
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		log.setUser(user);
		log.setCategoryNo(Const.Category.CREATION);
		log.setBehavior(Const.Behavior.ADD);
		log.setAddBehavior(Const.AddBehavior.LIKE);
		log.setTargetNo(2);
		
		logService.addLog(log);
		
	}
	
	@Test
	public void getLogListTest() {
		User user = new User();
		user.setEmail("wndhks@naver.com");
		user.setActive(0);
		
		List<Log> logList = logService.getLogList(user);
		System.out.println(logList);
		
	}
}
