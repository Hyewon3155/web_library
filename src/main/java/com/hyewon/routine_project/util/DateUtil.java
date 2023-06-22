package com.hyewon.routine_project.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.ognl.ParseException;

public class DateUtil {
  private static SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");

  public static Date parseDate(String dateStr) throws ParseException {
    Date date = null;
	try {
		date = formatter.parse(dateStr);
	} catch (java.text.ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

    return date;
  }
  
  public static String formatDate(Date date) {
    String dateStr = null;
    
    if (date != null) {
      dateStr = formatter.format(date);
    }
    
    return dateStr;
  }
}