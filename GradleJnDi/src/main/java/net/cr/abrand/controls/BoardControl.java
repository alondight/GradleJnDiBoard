package net.cr.abrand.controls;


import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import net.cr.abrand.services.BoardService;
import net.cr.abrand.vo.Board;
import net.cr.abrand.vo.JsonResult;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/Board")
public class BoardControl {
	@Autowired ServletContext sc;
	@Autowired BoardService boardService;

	@RequestMapping("/common")
	public String header() {
		return "common";
	}	
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String list(String pg ,String sw, String sc, Model m) {
		m.addAttribute("pg", pg);
		m.addAttribute("sw", sw);
		m.addAttribute("sc", sc);
		
		return "list";
	}

	@SuppressWarnings("finally")
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String write(String bno , Model model,HttpServletResponse response) throws  Exception {
		 try{
			 if( bno != null ){
				Board b = boardService.viewBoard(Integer.parseInt(bno));
				SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
				b.setBregdate(Date.valueOf(sdf.format(b.getBregdate())));
				model.addAttribute("board",b);
			 }
		 }catch(Exception e){
			 e.printStackTrace();
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<!DOCTYPE html>");
				out.println("<html>");
				out.println("<script>alert('" + "정상적인 경로로 접근해주세요."+ "');</script>");
				out.println("</html>");
				out.flush();
		 }finally{
			 return "write";
		 }
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String writePost(Board b, HttpServletResponse response) throws Exception {
		try{
			int count = boardService.writeBoard(b);
			if(count > 0 ){
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<!DOCTYPE html>");
				out.println("<html>");
				out.println("<script>alert('" + "등록되었습니다."+ "');</script>");
				out.println("</html>");
				out.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			return "list";
		}
	}
	
	@SuppressWarnings("finally")
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updatePost(Board b, HttpServletResponse response, Model model) throws Exception {
		try{
			int count = boardService.updateBoard(b);
			if(count > 0 ){
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<!DOCTYPE html>");
				out.println("<html>");
				out.println("<script>alert('" + "변경되었습니다."+ "');</script>");
				out.println("</html>");
				out.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			return "list";
		}
	}
	
	
	@SuppressWarnings("finally")
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public Object delete(String bno ,HttpServletResponse response) throws  Exception {
		JsonResult result = new JsonResult(); 
		try{
			 if( bno != null ){
				int count = boardService.deleteBoard(Integer.parseInt(bno));
				if(count > 0 ){
					result.setStatus("ok").setData(count);
				}
			 }
		 }catch(Exception e){
			    e.printStackTrace();
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<!DOCTYPE html>");
				out.println("<html>");
				out.println("<script>alert('" + "정상적인 경로로 접근해주세요."+ "');</script>");
				out.println("</html>");
				out.flush();
		 }finally{
			 return result;
		 }
	}	
	

	
	
}













