package unifiedsearch;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.ChatRoom;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.Unifiedsearch;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;
import com.bookbox.service.unifiedsearch.UnifiedsearchService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml",
		"classpath:config/context-mail.xml" })

public class SearchTest {

	@Autowired
	@Qualifier("unifiedsearchServiceImpl")
	private UnifiedsearchService unifiedsearchService;

	@Autowired
	@Qualifier("unifiedsearchElasticDAOImpl")
	private UnifiedsearchDAO unifiedsearchDAO;

	private Posting posting = new Posting();
	private Creation creation = new Creation();
	private Board board = new Board();
	private ChatRoom chatroom = new ChatRoom();
	private Search search = new Search();
	private User user = new User();
	private Tag tag = new Tag();

	@Test
	public void serviceTest() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Tag> tagList = new ArrayList<Tag>();
		tag.setTagName("태그다");
		Tag tag2 = new Tag();
		tag2.setTagName("태그2222");

		tagList.add(tag);
		tagList.add(tag2);

		user.setNickname("창작 유저 압데이트");

		creation.setCreationIntro("이것은 창작이다 창작이다");
		creation.setCreationNo(2);
		creation.setCreationTitle("창작 제목");
		creation.setRegDate(new Date(20170101));
		creation.setCreationAuthor(user);
		creation.setTagList(tagList);

		search.setCategory(11);
		search.setKeyword("사회");

		
		System.out.println(unifiedsearchDAO.elasticSearch(search));
		
		// unifiedsearchDAO.elasticDelete(creation);
		//System.out.println(unifiedsearchService.elasticTagSearch(search).toString());
		
		
		
		//Map<String, Object> temp = (Map<String, Object>) map.get("creationList");

		
		
		//System.out.println(temp.get("total").toString());
		//List<Unifiedsearch> search  = (List<Unifiedsearch>)temp.get("result");
		//System.out.println(search.get(0).getTitle());
		//Unifiedsearch unifiedsearch = (Map)map.get("creation");
		
		//unifiedsearch.toString();
/*		for(int i = 0; i < Integer.parseInt((map.get("total").toString())); i++) {
			
			System.out.println(i + "=============================");
			System.out.println("category : " + unifiedsearch.getCategory());
			System.out.println("title : " + unifiedsearch.getTitle());
			System.out.println("content : " + unifiedsearch.getContent());
			System.out.println("nick_name : " + unifiedsearch.getNick_name());
			System.out.println("id : " + unifiedsearch.getId());
			System.out.println("tag : " + unifiedsearch.getTag().toString());
		}
*/	}
}
