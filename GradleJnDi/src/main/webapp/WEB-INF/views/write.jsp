<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="net.cr.abrand.vo.Board"%>
<%@page import="java.util.*"%>
<%
boolean update = false;
String name = "";
String title = "";
Date regdate = null;
String content = "";
int bno = 0 ;
Board b = (Board)request.getAttribute("board");
if(b != null ) {
	bno = b.getBno();
	name = b.getBname();
	title = b.getBtitle();
	regdate = b.getBregdate();
	content = b.getBcontent();
	update = true;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/Board/common.do"></jsp:include>
<script>
<%if(!update){%>
	$(window).load(function() {
		var d = new Date();
		$("#regdate").val(d.getFullYear()+"-"+(parseFloat(d.getMonth())+1)+"-"+d.getDate());
	});
<%}%>
</script>
<title>BoardWrite</title>
</head>
<body>

		<!-- 쓰기 -->
	<form id="frm" name="frm" <%if(update)out.print("action='update.do'");else out.print("action='write.do'"); %> method="post">
		<input type="hidden" name="bno" value="<%=bno%>">
		<table class="writeType1">
		<colgroup><col width="20%"><col width="80%"></colgroup>
		<tbody>
		<tr>
			<th>이름</th>
			<td>
			<input type="text" id="bname" name="bname"  value="<%=name%>" maxlength="40" msg="이름을"  class="inputText" style="width:150px">
			<input type="text" id="regdate" name="regdate" value="<%=regdate%>" maxlength="10" readonly="readonly"  class="inputText" style="width:104px;margin-left:350px;">
			</td>
		</tr>

		<tr>
			<th>제목</th>
			<td><input type="text" id="btitle" name="btitle" value="<%=title%>" maxlength="200" msg="제목을"  class="inputText" style="width:620px"></td>
		</tr>
		<tr>					
			<th>내용</th>
			<td><textarea id="bcontent" name="bcontent"  class="inputText" rows="10" cols="5"  style="width:630px;height:420px"><%=content%></textarea>
					<script type="text/javascript">
					 var oEditors = [];
					 nhn.husky.EZCreator.createInIFrame({
						 oAppRef: oEditors,
						 elPlaceHolder: "bcontent",
						 sSkinURI: "<%=application.getContextPath()%>/SE2.3.10.O11329/SmartEditor2Skin.html",
						 fCreator: "createSEditor2"
					 });
				</script>
			</td>
		</tr>	
		</tbody>
		</table>
	</form>

	
		<div class="tac mb20">
			<a href="#none" onclick="writeChk();"><span class="btn3">저장</span></a> 			
			<%if(update){%><a href="#none" onclick="delFunc(<%=bno%>)"><span class="btn3">삭제</span></a><%} %>
			<a href="list.do"><span class="btn3">목록</span></a>
			
			
		</div>



</body>
</html>