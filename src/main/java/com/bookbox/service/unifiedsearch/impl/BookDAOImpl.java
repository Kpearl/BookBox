package com.bookbox.service.unifiedsearch.impl;

import java.util.HashMap;
import java.util.Locale.Category;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Reply;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookDAO;

/**
 * @file com.bookbox.service.unifiedsearch.BookDaoImpl.java
 * @brief BookDaoImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */
@Service("bookDAOImpl")
public class BookDAOImpl implements BookDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	private Map<String, Object> map;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public BookDAOImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public void addBookLike(User user, Book book) {
		
		map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("book", book);
		map.put("category", Const.Category.BOOK);
		
		sqlSession.insert("CommonMapper.addBookLike", map);
	}

	@Override
	public void deleteBookLike(User user, Book book) {
		
		map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("isbn", Integer.parseUnsignedInt(book.getIsbn()));
		map.put("category", Const.Category.BOOK);
		
		sqlSession.insert("CommonMapper.deleteBookLike", map);
	}

	@Override
	public void addBookReply(User user, Book book, Reply reply) {
		
		map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("category", Const.Category.BOOK);
		map.put("isbn", book.getIsbn());
		map.put("reply", reply);
		
		sqlSession.insert("CommonMapper.addBookReply", map);
	}
	
	@Override
	public void deleteBookReply(User user, Book book) {
		
		map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("book", book);
		map.put("category", Const.Category.BOOK);
		
		sqlSession.insert("CommonMapper.deleteBookReply", map);
	}
	
	@Override
	public void addBookGrade(User user, Book book) {
		
		map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("book", book);
		map.put("category", Const.Category.BOOK);
		
		sqlSession.insert("CommonMapper.addBookGrade", map);
	}
}
