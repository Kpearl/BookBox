package com.bookbox.web.creation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.FundingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.PayInfo;
import com.bookbox.service.domain.User;


/**
 * @file com.bookbox.web.creation.CreationRestController.java
 * @brief 창작공간 RestController
 * @detail
 * @author HJ
 * @date 2017.10.24
 */
@RestController
@RequestMapping("/creation/rest/*")
public class CreationRestController {

	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;

	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Autowired
	@Qualifier("fundingServiceImpl")
	private FundingService fundingService;
	
	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource;
		
	/**
	 * @brief Constructor
	 */
	public CreationRestController() {
		System.out.println("CreationRestController :: "+getClass().getName());
	}
	
	
	/**
	 * @brief addCreationSubscribe/구독신청                           
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="doCreationSubscribe", method=RequestMethod.GET )
	public boolean doCreationSubscribe(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		System.out.println("CreationRestController :: /creation/rest/doCreationSubscribe : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));

		Creation creation = creationService.getCreation(map);
		creationService.doCreationSubscribe((User)session.getAttribute("user"), creation);

		System.out.println("CreationRestController :: /creation/rest/doCreationSubscribe : GET ===> END\n\n");
		
		return creationService.doCreationSubscribe((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief deleteCreationSubscribe/구독신청 취소                          
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="deleteCreationSubscribe", method=RequestMethod.GET )
	public boolean deleteCreationSubscribe(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		
		System.out.println("CreationRestController :: /creation/rest/deleteCreationSubscribe : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));

		Creation creation = creationService.getCreation(map);
		creationService.deleteCreationSubscribe((User)session.getAttribute("user"), creation);

		System.out.println("CreationRestController :: /creation/rest/deleteCreationSubscribe : GET ===> END\n\n");
		return creationService.deleteCreationSubscribe((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief addCreationSubscribe/구독신청                           
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="addCreationLike", method=RequestMethod.GET )
	public boolean addLike(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		System.out.println("CreationRestController :: /creation/rest/addCreationLike : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));
		Creation creation = creationService.getCreation(map);

		System.out.println("CreationRestController :: /creation/rest/addCreationLike : GET ===> END\n\n");
	
		return creationService.addCreationLike((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief deleteCreationLike/좋아요 취소                          
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="deleteCreationLike", method=RequestMethod.GET )
	public boolean deleteCreationLike(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		System.out.println("CreationRestController :: /creation/rest/deleteCreationLike : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));
		Creation creation = creationService.getCreation(map);

		System.out.println("CreationRestController :: /creation/rest/deleteCreationLike : GET ===> END\n\n");
		
		return creationService.deleteCreationLike((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief getTag/태그자동완성                           
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="getTagList", method=RequestMethod.POST )
	public List<Tag> getTag(@RequestBody Tag tag,
																		HttpSession session) throws Exception {
		
		tagService.getTagList(tag);
		
		return null;
	}
	
	/**
	 * @brief addCreation/ 창작작품 등록
	 * @details POST
	 * @param 
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="addCreation", method=RequestMethod.POST)
	public Map<String, Object> addCreation(@RequestParam("creation") String json, 
																					HttpServletRequest request,
																					@RequestParam(value="file", required=false) MultipartFile multipartFile,
																					HttpSession session) throws Exception{
		// TODO addCreation
		System.out.println("CreationRestController :: /creation/rest/addCreation : POST ===> START");
		
		User user = (User)session.getAttribute("user");
		System.out.println("addCreation :: "+user.getEmail());
	
		Creation creation = new ObjectMapper().readValue(json.toString(), Creation.class);
		System.out.println("restController :: addCreation :: creation ::"+creation);
		
		String path = request.getServletContext().getRealPath("/resources/upload_files/images/");
		
		UploadFile uploadFile = creationService.saveFile(multipartFile, path);
		creation.setCreationFileName(uploadFile.getFileName());
		creation.setCreationOriginName(uploadFile.getOriginName());
		
		List<Tag> tagList = new ArrayList<>();
		String[] dbTag = request.getParameterValues("tag");
		
		for (String tag : dbTag) {
			if (!tag.equals("")) {
				tagList.add(new Tag(tag));
			}
		}	
		
		creation.setTagList(tagList);
		creation.setCreationAuthor(user);
		
		if (creation.getCreationNo() == 0) {
			creationService.addCreation(user, creation);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("user", session.getAttribute("user"));
		List<Creation> creationList =creationService.getCreationList(map);
		
		map.put("creationList", creationList);
		map.put("creation", creation);
		
		System.out.println("CreationRestController :: /creation/rest/addCreation ==> END");
		
		return map;
	}
	
	/**
	 * @brief getCreation/ 창작작품 정보조회
	 * @details GET
	 * @param Creation
	 * @throws Exception
	 * @return Creation
	 */
	@RequestMapping(value="getCreation", method=RequestMethod.GET)
	public Creation getCreation(@RequestParam("creationNo") int creationNo,
															HttpSession session) throws Exception{
		System.out.println("CreationRestController :: /creation/rest/getCreation : GET ===> START");
		// TODO getCreation
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));
		Creation creation = creationService.getCreation(map);
		
		List<Tag> tagList =tagService.getTagGroupList(Const.Category.CREATION, creation.getCreationNo());
		creation.setTagList(tagList);

		System.out.println("CreationRestController :: /creation/rest/getCreation : GET ===> END");
		return creation;
	}
	
	/**
	 * @brief addPayInfo/ 펀딩결제정보 등록
	 * @details POST
	 * @param PayInfo, HttpSession
	 * @throws Exception
	 * @return boolean
	 */
	@RequestMapping(value="addPayInfo", method=RequestMethod.POST)
	public boolean addPayInfo(@RequestBody PayInfo payInfo,
													HttpSession session) throws Exception{
		// TODO addCreation
		System.out.println("CreationRestController :: /creation/rest/addPayInfo : POST ===> START");
		
		User user = (User)session.getAttribute("user");
		payInfo.setUser(user);
		fundingService.addPayInfo(payInfo.getUser(), payInfo);
		
		System.out.println("CreationRestController :: /creation/rest/addPayInfo ==> END");
		
		return true;
	}
	
	/**
	 * @brief getPayInfo/ 펀딩결제정보조회
	 * @details GET
	 * @param FundingNo, HttpSesseion
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="getPayInfo", method=RequestMethod.GET)
	public PayInfo getPayInfo(@RequestParam("fundingNo") int fundingNo,
													HttpSession session) throws Exception{
		// TODO addCreation
		System.out.println("CreationRestController :: /creation/rest/getPayInfo : GET ===> START");
		
		User user = (User)session.getAttribute("user");
		PayInfo payInfo = new PayInfo();
		payInfo.setFundingNo(fundingNo);
		payInfo.setUser(user);
		
		payInfo = fundingService.getPayInfo(user, payInfo);
		
		System.out.println("CreationRestController :: /creation/rest/getPayInfo ==> END\n\n");
		
		return payInfo;
	}
	
	
	
	
	
}
