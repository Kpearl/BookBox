package booklog;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Location;
import com.bookbox.common.domain.Search;
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
	
//	@Test
	public void addPostingTest() throws Exception{
		User user = new User();
		user.setEmail("wndhks@naver.com");
		
		Posting posting = new Posting();
		posting.setPostingTitle("오번째으로 서비스로 올리는 포슽잉");
		posting.setPostingContent("다섯번째 포스팅은 위치를 포함했지");
		posting.setUser(user);
		Location location = new Location();
		location.setLocationName("우리집");
		location.setLocationLatitude(37.367795);
		location.setLocationLongitude(127.161255);
		List<Location> locationList = new ArrayList<Location>();
		locationList.add(location);
		
		posting.setPostingLocationList(locationList);
		
		postingService.addPosting(user, posting);
	}

	@Test
	public void getPostingTest() throws Exception{
		
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		Posting posting = new Posting();
		posting.setPostingNo(8);
		
		System.out.println(postingService.getPosting(user, posting));
	}
	
//	@Test
	public void getPostingListTest() throws Exception{
		Search search = new Search();
		search.setCondition("booklog");
		search.setKeyword("xptmxm@nate.com");
		
		System.out.println(postingService.getPostingList(search));
	}
	
}
