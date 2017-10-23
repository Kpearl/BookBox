package creation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;
import com.bookbox.service.user.UserService;

@RunWith(SpringJUnit4ClassRunner.class)


//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {"classpath:config/context-common.xml",
																		"classpath:config/context-aspect.xml",
																		"classpath:config/context-mail.xml",
																		"classpath:config/context-mybatis.xml",
																		"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class CreationTest {

	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;

	@Autowired
	@Qualifier("writingServiceImpl")
	private WritingService writingService; 
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Test
	public void testAddWriting() throws Exception {
		
		/////////SET
		User user = new User();
		user.setEmail("wndhks@naver.com");
		user = userService.getUser(user);
		
		
		UploadFile uploadFile = new UploadFile();
		uploadFile.setOriginName("Creation.jsp");
		uploadFile.setFileName(String.valueOf(Calendar.getInstance().getTimeInMillis())
													+uploadFile.getOriginName().substring(uploadFile.getOriginName().lastIndexOf(".")));
		
		String fileName = String.valueOf(Calendar.getInstance().getTimeInMillis())
				+uploadFile.getOriginName().substring(uploadFile.getOriginName().lastIndexOf("."));
	
		Creation creation = new Creation();
		creation.setCreationTitle("창작공간 픽션글 3호");
		creation.setCreationIntro("화요일인데 벌써 피곤피곤하구만 졸려");
		creation.setCreationAuthor(user);
		creation.setCreationHead("논픽션");
		creation.setCreationFile(uploadFile);
		
		List<UploadFile> uploadFileList =new ArrayList<>();
		
		UploadFile uploadFile1 = new UploadFile(fileName,"오리진파일1.jsp");
		uploadFile1.setMainFile(0);
		UploadFile uploadFile2 = new UploadFile(fileName,"오리진파일2.jsp");
		uploadFile2.setMainFile(0);
		UploadFile uploadFile3 = new UploadFile(fileName,"오리진파일3.jsp");
		uploadFile3.setMainFile(0);
		
		uploadFileList.add(uploadFile1);
		uploadFileList.add(uploadFile2);
		uploadFileList.add(uploadFile3);
		
		Writing writing = new Writing();
		writing.setWritingTitle("10월 24일 화요일");
		writing.setWritingContent("테스트 빨리 끝내자아아아아");
		writing.setWritingFileList(uploadFileList);
		
		
		Tag tag = new Tag();
		tag.setTagName("#화요일#우울#졸려#목표치언제채움");
		///////////SET END
				
		List<Tag> tagList = new ArrayList<>();
		String[] dbTag =  tag.getTagName().split("#");
		
		for (int i = 0; i < dbTag.length; i++) {
			tagList.add(new Tag(dbTag[i]));
		}	
		creation.setTagList(tagList);
		
		System.out.println("Creation :: "+creation);
		System.out.println("Writing :: "+writing);
		System.out.println("Tag :: "+tag);
		System.out.println("UploadFile :: "+uploadFile);
		
		////////INSERT
		creationService.addCreation(user, creation);
		writing.setWritingNo(creation.getCreationNo());
		writingService.addWriting(user, writing);
		///////
		
		//==> console 확인
		
		
		//==> API 확인
//		Assert.assertEquals("xptmxm@nate.com", dbuser.getEmail());
//		Assert.assertEquals("간닷", dbuser.getNickname());
//		Assert.assertEquals("xptmxm1234", dbuser.getPassword());
//		Assert.assertEquals("여", dbuser.getGender());
	}

	
	//@Test
	public void testGetUser() throws Exception {
		
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		user.setNickname("간닷");
		user.setPassword("xptmxm1234");
		user.setGender("여");
		
		user = userService.getUser(user);

		//==> console 확인
		System.out.println("testGetUser() :: "+user);
		
		//==> API 확인
				Assert.assertEquals("xptmxm@nate.com", user.getEmail());
				Assert.assertEquals("간닷", user.getNickname());
				Assert.assertEquals("xptmxm1234", user.getPassword());
				Assert.assertEquals("여", user.getGender());
	}
	
	//@Test
	private void testLogin() throws Exception{
	
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		user.setPassword("updatepassword");
		user.setOuterAccount(0);
		
		User dbUser = userService.getUser(user);

	}	
	

	//@Test
	 public void testUpdateUser() throws Exception{
		 
		 User user = new User();
		 user.setEmail("xptmxm@nate.com");
		 
		 User getUser = userService.getUser(user);
		 System.out.println("testUpdateUser()==> getUser() :: "+getUser);
		
		//Assert.assertNotNull(user);
		
		//==> API 확인
		Assert.assertEquals("xptmxm@nate.com", getUser.getEmail());
		Assert.assertEquals("간닷", getUser.getNickname());
		Assert.assertEquals("xptmxm1234", getUser.getPassword());
		Assert.assertEquals("여", getUser.getGender());

		getUser.setPassword("updatepassword");
		getUser.setNickname("수정한닷");
		
		userService.updateUser(getUser);
		
		user = userService.getUser(user);
		Assert.assertNotNull(user);
		
		//==> console 확인
		//System.out.println(user);
			
		//==> API 확인
		Assert.assertEquals("xptmxm@nate.com", user.getEmail());
		Assert.assertEquals("수정한닷", user.getNickname());
		Assert.assertEquals("updatepassword", user.getPassword());
		Assert.assertEquals("여", user.getGender());
	 }
	 
	//@Test
	public void testCheckEmailValidation() throws Exception{

		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
       
        System.out.println("테스트No :: "+joinCode);
		

			User user = new User();
			user.setEmail("xptmxm@nate.com");
		
			userService.checkEmailValidation(user);
		
		//==> console 확인
		System.out.println("testCheckEmailValidation :: "+userService.checkEmailValidation(user));
	 	
		//==> API 확인
		Assert.assertFalse(userService.checkEmailValidation(user));		 	
	}
	
	//@Test
	public void testCheckNicknameValidation() throws Exception{


			User user = new User();
			user.setEmail("xptmxm@nate.com");
			user.setNickname("수정한닷");
		
			userService.checkNicknameValidation(user);
		
		//==> console 확인
			System.out.println("testCheckNicknameValidation :: "+userService.checkNicknameValidation(user));
		 	
			//==> API 확인
			Assert.assertFalse(userService.checkNicknameValidation(user));		 	
		 	
	}	
	
	//@Test
	public void testUpdateActive() throws Exception{

		Map<String, Object> map = new HashMap<>();
		map.put("email", "xptmxm@nate.com");
		map.put("active", 2);
			
		userService.updateActive(map);
	
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		
		//==> API 확인
		Assert.assertTrue(userService.getUser(user)==null);		 	
		 	
	}	
	
}