<link rel="stylesheet" href="<%=application.getContextPath()%>/css/basic.css">
<script type="text/javascript" src="<%=application.getContextPath()%>/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=application.getContextPath()%>/js/validation.js"></script>
<script type="text/javascript" src="<%=application.getContextPath()%>/SE2.3.10.O11329/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//write에서 사용하는 JS
function delFunc(bno){
	if(confirm("정말 삭제 하시겠습니까?")){
		$.ajax({
			type: "GET",
			url: "delete.do",
			dataType: "json",
			data: "bno="+bno,
			success: function (rtn) {
				if(rtn.status = "ok"){
						alert("삭제되었습니다.");
						location.href="list.do";
				}
			}
		});
	}
}

function writeChk(){
	var frm = document.frm;
	oEditors.getById["bcontent"].exec("UPDATE_CONTENTS_FIELD", []);
	if ( checkFormValidationNull(frm) ) {
		if(frm.bcontent.value == "<p>&nbsp;</p>"){alert("내용을 입력해 주세요.");frm.bcontent.focus();return false;}
		frm.submit();
	}
}


//list에서 사용하는 JS
function searchWord(){
	 var sw = $("#sw").val();
	 var sc = $("#sc").val();
	 location.href="list.do?sw="+sw+"&sc="+sc;
	}
</script>
