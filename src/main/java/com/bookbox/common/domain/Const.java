package com.bookbox.common.domain;

public class Const {

	public class Category{
		public static final int CREATION = 1;
		public static final int WRITING = 2;
		public static final int FUNDING = 3;
		public static final int BOOKLOG = 4;
		public static final int POSTING = 5;
		public static final int BOARD = 6;
		public static final int CAM_CHAT = 7;
		public static final int CAST = 8;
		public static final int BOOK = 9;
		public static final int UNIFIED_SEARCH = 10;
	}
	
	public class Behavior{
		public static final int GET = 1;
		public static final int JOIN = 2;
		public static final int PAY = 3;
		public static final int ADD = 4;
		public static final int SEARCH = 5;
		public static final int UPDATE = 6;
		public static final int RECOMMEND = 7;
		public static final int DELETE = 8;
	}
	
	public class AddBehavior{
		public static final int NONE = 0;
		public static final int LIKE = 1;
		public static final int SUBSCRIBE = 2;
	}
	
}