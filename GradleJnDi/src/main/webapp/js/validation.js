//일반 submit
function checkForm(frm) {
	if ( checkFormValidationNull(frm) ) {
		frm.submit();
	}
}
// 폼체크
function checkFormValidationNull(f){
	var fLen = f.elements.length;
	var fObj;	// 폼 요소
	var fTyp;	// 폼 요소 Type
	var fVal;	// 폼 요소 Value
	var fMsg;	// 경고 메시지 속성

	for (i=0;i<fLen;i++) {
		fObj = f.elements[i];
		fTyp = toUpperCase(fObj.type);
		fVal = fObj.getAttribute("value");
		if(fVal=="" || fVal==null) fVal = fObj.value;
		fMsg = fObj.getAttribute("msg");		// 경고 메시지
		fNum = fObj.getAttribute("chknum");		// 숫자만 기입 가능하도록
		fEmail = fObj.getAttribute("chkemail");	// 이메일 형식 맞는지 체크

		if (fMsg != null && (fTyp == "TEXT" || fTyp == "TEXTAREA" || fTyp == "PASSWORD") && fVal.replace(/ /gi,"") == "") {
			alert(fMsg + " 입력해 주세요");
			if (fTyp != "HIDDEN") {fObj.focus();}
			return false;
		}
		if (fMsg != null && fTyp == "SELECT-ONE" && fVal =="") {
			alert(fMsg + " 선택해 주세요");
			fObj.focus(); return false;
		}
		if (fMsg != null && (fTyp == "RADIO" || fTyp == "CHECKBOX") && checkChecked(fObj) == false) {
			alert(fMsg + " 선택해 주세요");
			fObj.focus(); return false;
		}			
		if (fMsg != null && fTyp == "FILE" && fVal =="") {
			
			alert(fMsg + " 선택해 주세요");
			fObj.focus(); return false;
		}
		if (fNum != null && isNaN(fVal)) {
			alert("숫자로만 입력해 주세요");
			fObj.value="";
			fObj.focus(); return false;
		}

		 if(fEmail != null && chkEmail(fVal)=="ERR") {
			alert('이메일 주소가 유효하지 않습니다');
			fObj.focus(); return false;
		}


	}
	return true;
}

 function chkEmail(strValue) {
	var t = escape(strValue);
	if (t.match(/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/) == null) {

    return "ERR";   // error
  } else {
    return "OK";    // ok
  }
}

// 숫자체크
function f_is_num(obj,lbl)
{
	var nLen = obj.value.length; 
	for( i = 0 ; i < nLen ; i++)
	{
		temp = obj.value.substring(i,i+1);
		if( temp < '0' || temp > '9' )
		{
			alert(lbl + ' 숫자만 입력할 수 있습니다.');
			obj.value="";
			obj.select();
			return true;
		}     
	}
	return false;
}

// 배열 요소일 경우 checked 된것이 있는지 확인
function checkChecked(obj) {
	var objnm = obj.name;
	var oElem = eval("document.all."+objnm);
	//var oElem = eval(fname+"."+objnm);
	var ret = false;

	if (typeof(oElem.length) == "undefined") {
		if (oElem.checked) {
			ret = true;
		}
	} else {
		for (var i=0;i<oElem.length;i++) {
			if (oElem[i].checked) {
				ret = true;
			}
		}
	}
	return ret;
}

// 문자 길이 반환 (영문 1byte, 한글 2byte 계산)
function getLen(str) {
	var len;
    var temp;

    len = str.length;
    var tot_cnt = 0;

    for(k=0;k < len;k++){
    	temp = str.charAt(k);
    	if(escape(temp).length > 4)
    		tot_cnt += 2;
    	else
    		tot_cnt++;
    }
    return tot_cnt;
}

// 대문자 변환 ex) toUpperCase(문자)
function toUpperCase(str) {
	var ret;
	str != null ? ret = str.toUpperCase() : ret = "";
	return ret;
}

//ajax
function getHTTPobject() {
	var xmlhttp = false;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		try {
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch (e) {
				xmlhttp = false;
			}
		}
	}
	return xmlhttp;
}
