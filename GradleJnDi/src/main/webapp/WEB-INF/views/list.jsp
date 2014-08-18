<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %> 
<%@page import="javax.naming.*"%>
<%@page import="java.util.*" %>
<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try{

	int pg = 1;
	String wheres = " where BDELFLAG = 'N'";
	String sw = "";
	String sc = "";
	if( request.getParameter("pg") != null  && !"".equals(request.getParameter("pg"))){
		pg = Integer.parseInt(request.getParameter("pg"));
		if(pg < 1)pg = 1;
	}
	if( request.getParameter("sw") != null && !"".equals(request.getParameter("sw")) ){
		sw = request.getParameter("sw");
		sc = request.getParameter("sc");
		if("BNAME".equalsIgnoreCase(request.getParameter("sc"))){
			wheres = wheres+" and BNAME like '%"+request.getParameter("sw")+"%' ";
		}else if("BTITLE".equalsIgnoreCase(request.getParameter("sc"))){
			wheres = wheres+" and BTITLE like '%"+request.getParameter("sw")+"%' ";
		}else{
			wheres = wheres+" and (BNAME like '%"+request.getParameter("sw")+"%'  or BTITLE like  '%"+request.getParameter("sw")+"%')";
		}
	}
	
	//paging 설정
	final int page_per_record_cnt = 10;
	final int group_per_page_cnt =10;
	int total_record = 0;
	
	Context ctx = new InitialContext();
	DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/test");
	con = ds.getConnection();
	//con.setAutoCommit(false);

	pstmt = con.prepareStatement("select count(*) as cnt from Board "+wheres);
	rs = pstmt.executeQuery();
	if(rs.next()){
		total_record = rs.getInt("cnt");
	}
	rs.close();
	pstmt.close();
	
	
	pstmt = con.prepareStatement("select * from Board "+wheres+" order by BREGDATE DESC limit ?,?");
	pstmt.setInt(1, page_per_record_cnt*(pg-1));
	pstmt.setInt(2, page_per_record_cnt);	
	rs = pstmt.executeQuery();
	//con.commit();


	
	//paging부분
	int total_page = (int)(total_record / page_per_record_cnt) + (total_record % page_per_record_cnt>0 ? 1 : 0);
	int group_no = pg/group_per_page_cnt+( pg%group_per_page_cnt>0 ? 1:0);
	int page_eno = group_no*group_per_page_cnt;
	int page_sno = page_eno-(group_per_page_cnt-1);
	if(page_eno>total_page){
		page_eno=total_page;
	}
	int prev_pg = page_sno-group_per_page_cnt;
	int next_pg = page_sno+group_per_page_cnt;
	if(prev_pg<1){
		prev_pg=1;
	}
	if(next_pg>total_page){
		next_pg=total_page/group_per_page_cnt*group_per_page_cnt+1;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/Board/common.do"></jsp:include>
<title>BoardList</title>
</head>
<body>

		<div class="topArea">
			<p class="list_num">총 <%=total_record%>건</p>
			<div class="currentLocation">
				<span class="mr5"><a href="/adm_super/"><img src="<%=application.getContextPath()%>/css/images/btn_home.gif" alt="home"></a></span> &gt;
				<span class="ml5">BoardList</span>
			</div>
		</div>


		<table class="listType1">
		<colgroup><col width="10%"><col width="68%"><col width="12%"><col width="10%"></colgroup>
			<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일자</th>
				<th>조회수</th>
			</tr>
			</thead>
		<tbody>
			<%
			int tempNum = total_record -  ((pg-1)*page_per_record_cnt);
			while(rs.next()){ %>
			<tr>
				<td><%=tempNum %></td>
				<td class="title"><a href="write.do?bno=<%=rs.getInt("BNO")%>"><%=rs.getString("BTITLE")%></a></td>
				<td><%=rs.getDate("BREGDATE")%></td>
				<td><%=rs.getInt("BCOUNT")%></td>
			</tr>
			<%
			tempNum--;
			} %>
		</tbody>
		</table>


		<div class="paging">
			<a href="list.do?pg=1&sw=<%=sw%>&sc=<%=sc%>" class="prevPage"><img src="<%=application.getContextPath()%>/css/images/btn_pagePrev2.gif" alt=""></a>
			<a href="list.do?pg=<%=prev_pg%>&sw=<%=sw%>&sc=<%=sc%>" class="prevPage"><img src="<%=application.getContextPath()%>/css/images/btn_pagePrev1.gif" alt=""></a>
			<%
				String lastPg = "";
				for(int i =page_sno;i<=page_eno;i++){%>
				<%
					if (i == page_eno){
						lastPg = "class=\"last\"";
					}
				%>
				<%if(pg == i){ %>
					<em <%=lastPg%> ><%=i %></em>
				<%}else{ %>
					<a <%=lastPg%> href="list.do?pg=<%=i %>&sw=<%=sw%>&sc=<%=sc%>"><%=i %></a>
				<%} %>
			<%} %>
			<a href="list.do?pg=<%=next_pg%>&sw=<%=sw%>&sc=<%=sc%>" class="nextPage"><img src="<%=application.getContextPath()%>/css/images/btn_pageNext1.gif" alt=""></a>
			<a href="list.do?pg=<%=total_page%>&sw=<%=sw%>&sc=<%=sc%>" class="nextPage"><img src="<%=application.getContextPath()%>/css/images/btn_pageNext2.gif" alt=""></a>
		</div>
		
		<!-- 검색 -->
		<div class="searchArea">
			<select id="sc" name="sc" style="width:100px">
				<option value="all"<%if("all".equals(sc) ){out.print(" selected=true");} %>>전체</option>
				<option value="BNAME"<%if("BNAME".equals(sc) ){out.print(" selected=true");} %>>이름</option>
				<option value="BTITLE"<%if("BTITLE".equals(sc) ){out.print(" selected=true");} %>>제목</option>
			</select>
			<input type="text" id="sw" name="sw" value= "<%=sw%>" class="inputText" style="width:250px">
			<a href="#none" onclick="searchWord()"><span class="btn5">검색</span></a>
		</div>
		
		<div class="tac mb20"><a href="write.do"><span class="btn2">글쓰기</span></a></div>

</body>
</html>

<%
	}catch (Exception e){
		e.printStackTrace();
	}finally{
		try {rs.close();} catch (Exception e) {}
		try {pstmt.close();} catch (Exception e) {}
		if (con != null) {
			try{con.close();}catch(Exception e){}
		}
	}
%>