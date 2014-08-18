package net.cr.abrand.util;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class XSSFilterRequestWrapper extends HttpServletRequestWrapper {
	 private static Pattern[] patterns = new Pattern[] {
	  // Script fragments
	        Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE),
	        Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
	        Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
	        Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
	        Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
	        Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
	        Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
	        Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL)
	 };
	 
	 private static String[] tagChar = { "<", ">" }; // 잡아서 변환할 태그 목록
	 private static String[] convertChar = { "&lt;", "&gt;" } ; // 변환될 태그의 asc 코드
	 
	 public XSSFilterRequestWrapper(HttpServletRequest request) {
	  super(request);
	 }
	 
	 @Override
	 public String getHeader(String name) {
	  String value = super.getParameter(name);
	  if("bcontent".equalsIgnoreCase(name)) //bcontent 파라미터에 대해서 XSS체크 빠짐
	   return value;
	  if(value == null)
	   return null;
	  return filter(value);
	 }
	 
	 @Override
	 public String getParameter(String name) {
	  String value = super.getParameter(name);
	  if("bcontent".equalsIgnoreCase(name))
		   return value;
	  if(value == null)
	   return null;
	  return filter(value);
	 }
	 
	 @Override
	 public String[] getParameterValues(String name) {
	  String[] values = super.getParameterValues(name);
	  if(values == null)
	   return null;
	  if("bcontent".equalsIgnoreCase(name))
		   return values;
	  String[] encodedValues = new String[values.length];
	  for(int i=0; i<values.length; i++) {
	   encodedValues[i] = filter(values[i]);
	  }
	  return encodedValues;
	 }
	 
	private String filter( String value ) {
	 if(value == null)
	  return null;
	 
	 for(int i=0; i<tagChar.length; i++) {
	  value = value.replace(tagChar[i], convertChar[i]);
	 }
	 for(Pattern scriptPattern : patterns) {
	  value = scriptPattern.matcher(value).replaceAll("");
	 }
	 return value;
	}
	 
	}
