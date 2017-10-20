package com.bookbox.service.unifiedsearch.impl;

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
	public void getRecommendBookList() throws Exception {
		bookSearchDAO.getRecommendBookList();
	}

	@Override
	public void addBookLike(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		commonDAO.addLike(user, map);
	}

	@Override
	public void deleteBookLike(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		commonDAO.deleteLike(user, map);
	}

	@Override
	public List<Reply> getBookReplyList(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		return commonDAO.getReplyList(user, map);
	}

	@Override
	public void addBookReply(User user, Book book, Reply reply) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		map.put("reply", reply);
		commonDAO.addReply(user, map);
	}

	@Override
	public void deleteBookReply(User user, Book book, Reply reply) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		map.put("reply", reply);
		commonDAO.deleteReply(user, map);
	}

	@Override
	public void addBookGrade(User user, Book book, Grade grade) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		map.put("grade", grade);
		commonDAO.addGrade(user, map);
	}

	@Override
	public Grade getBookGrade(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		return commonDAO.getGrade(user, map);
	}

	@Override
	public Like getBookLike(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn());
		return commonDAO.getLike(user, map);
	}
}
