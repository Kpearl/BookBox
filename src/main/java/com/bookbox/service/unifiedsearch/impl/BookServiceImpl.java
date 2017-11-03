package com.bookbox.service.unifiedsearch.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.Search;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookSearchDAO;
import com.bookbox.service.unifiedsearch.BookService;

/**
 * @file com.bookbox.service.unifiedsearch.impl.BookServiceImpl.java
 * @brief BookServiceImpl
 * @detail
 * @author JJ
 * @date 2017.10.20
 */

@Service("bookServiceImpl")
public class BookServiceImpl implements BookService {

	@Autowired
	@Qualifier("bookSearchKakaoAladinDAOImpl")
	private BookSearchDAO bookSearchDAO;

	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;

	private Map<String, Object> map;

	public BookServiceImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public List<Book> getBookList(Search search) throws Exception {
		return bookSearchDAO.getBookList(search);
	}

	@Override
	public Book getBook(User user, Book book) throws Exception {
		return bookSearchDAO.getBook(book.getIsbn());
	}

	@Override
	public List<String> getRecommendBookList() throws Exception {
		return bookSearchDAO.getRecommendBookList();
	}

	@Override
	public void addBookLike(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		commonDAO.addLike(map);
	}

	@Override
	public void deleteBookLike(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);		
		commonDAO.deleteLike(map);
	}

	@Override
	public List<Reply> getBookReplyList(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		return commonDAO.getReplyList(map);
	}

	@Override
	public void addBookReply(User user, Book book, Reply reply) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		map.put("reply", reply);
		commonDAO.addReply(map);
	}

	@Override
	public void deleteBookReply(User user, Book book, Reply reply) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		map.put("reply", reply);
		commonDAO.deleteReply(map);
	}

	@Override
	public void addBookGrade(User user, Book book, Grade grade) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		map.put("grade", grade);
		commonDAO.addGrade(map);
	}

	@Override
	public Grade getBookGrade(Book book, User user) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		return commonDAO.getGrade(map);
	}

	@Override
	public Like getBookLike(Book book, User user) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		return commonDAO.getLike(map);
	}

	@Override
	public Map<String, Map<String, Integer>> getBookStatistics(Book book) {
		Map<String, Map<String, Integer>> resultMap = new HashMap<String, Map<String, Integer>>();
		map = new HashMap<String, Object>();
		map.put("targetNo", book.getIsbn());
		map.put("gender", "남");
		
		resultMap.put("men", commonDAO.getBookStatics(map).get(0));
		
		map.put("gender", "여");
		
		resultMap.put("women", commonDAO.getBookStatics(map).get(0));
		
		return resultMap; 
	}
}
