package net.cr.abrand.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import net.cr.abrand.util.XSSFilterRequestWrapper;


public class XSSFilter implements Filter {

	private FilterConfig filterConfig;
	 @Override
	 public void destroy() {
	  if(this.filterConfig != null) this.filterConfig = null;
	 }
	 
	 @Override
	 public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
			 filterChain.doFilter(new XSSFilterRequestWrapper((HttpServletRequest)request), response); // filtering
	 }
	 
	 @Override
	 public void init(FilterConfig filterConfig) throws ServletException {
		 this.filterConfig = filterConfig;
	 }
}
