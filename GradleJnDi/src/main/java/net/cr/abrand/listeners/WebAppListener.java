package net.cr.abrand.listeners;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class WebAppListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent event) {}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		ServletContext sc = event.getServletContext();
		sc.setAttribute("rootPath", sc.getContextPath());
		sc.setAttribute("rootRealPath", sc.getRealPath("/"));
	}

}
