package com.bookbox.web.unifiedsearch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Reply;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookService;

/**
 * @file com.bookbox.web.unifiedsearch.UnifiredSearchRestCrontroller.java
 * @brief UnifiredSearchRestCrontroller
 * @detail
 * @author JJ
 * @date 2017.11.03
 */

@RestController
@RequestMapping("/unifiedsearch/rest/*")
public class UnifiedsearchRestController {

	@Autowired
	@Qualifier("bookServiceImpl")
	private BookService bookService;

	public UnifiedsearchRestController() {
	}

	@RequestMapping(value = "addReply", method = RequestMethod.POST)
	public void addReply(HttpSession session, @RequestParam("content") String content,
			@RequestParam("isbn") String isbn) {
		System.out.println("/unifiedsearch/rest/addReply : POST");
		User user = (User) session.getAttribute("user");

		if (user == null)
			user = new User();

		Reply reply = new Reply();
		reply.setContent(content);

		Book book = new Book();
		book.setIsbn(isbn);

		bookService.addBookReply(user, book, reply);
	}

	@RequestMapping(value = "addLike", method = RequestMethod.POST)
	public void addLike(HttpSession session, @RequestParam("isbn") String isbn) {
		System.out.println("/unifiedsearch/rest/addLike : GET");
		User user = (User) session.getAttribute("user");
		Book book = new Book();
		book.setIsbn(isbn);

		if (user == null)
			user = new User();

		bookService.addBookLike(user, book);
	}

	@RequestMapping(value = "deleteLike", method = RequestMethod.POST)
	public void deleteLike(HttpSession session, @RequestParam("isbn") String isbn) {
		System.out.println("/unifiedsearch/rest/deleteLike : GET");
		User user = (User) session.getAttribute("user");
		Book book = new Book();
		book.setIsbn(isbn);

		if (user == null)
			user = new User();

		bookService.deleteBookLike(user, book);
	}

	@RequestMapping(value = "addGrade", method = RequestMethod.POST)
	public int getGradeList(HttpSession session, @RequestParam("isbn") String isbn,
			@RequestParam("userCount") String userCount) {
		System.out.println("/unifiedsearch/rest/addGrade : GET");
		User user = (User) session.getAttribute("user");
		Book book = new Book();
		book.setIsbn(isbn);
		Grade grade = new Grade();
		grade.setUserCount(Integer.parseInt(userCount));
		grade.setDoGrade(false);

		if (user == null)
			user = new User();

		bookService.addBookGrade(user, book, grade);

		return bookService.getBookGrade(book, user).getAverage();
	}

	@RequestMapping(value = "recommendBook")
	public List<Book> recommendBookList() throws Exception {
		List<String> list = (List<String>) bookService.getRecommendBookList();
		List<Book> bookList = new ArrayList<Book>();
		Book book = null;

		for (int i = 0; i < list.size(); i++) {
			book = new Book();
			book.setIsbn(list.get(i));
			
			if(i == 4) {
				break;
			}
			
			if(bookService.getBook(new User(), book) != null) {
				bookList.add(bookService.getBook(new User(), book));
			}
		}
		return bookList;
	}
}
