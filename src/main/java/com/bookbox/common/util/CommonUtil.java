package com.bookbox.common.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

public class CommonUtil {
	
	private static Properties constProp;
	
	public CommonUtil() {
	}
	
	public static Properties getConstProp() {
		
		if(constProp == null) {
			CommonUtil commonUtil = new CommonUtil();
			try {
				constProp = new Properties();
				constProp.load(new InputStreamReader(commonUtil.getClass().getClassLoader().getResourceAsStream("config/const.properties"),"UTF-8"));
			}catch(FileNotFoundException fnfe) {
				fnfe.printStackTrace();
			}catch(IOException ie) {
				ie.printStackTrace();
			}catch(IllegalArgumentException iae) {
				iae.printStackTrace();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return constProp;
	}
}
