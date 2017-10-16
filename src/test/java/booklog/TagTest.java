package booklog;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml"})
public class TagTest {
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Test
	public void addTagGroupTest() throws Exception {
		System.out.println(tagService.getClass().getName());
		System.out.println(tagService.addTagGroup(Const.Category.BOOKLOG, 10000, new ArrayList<Tag>()));
	}
}
