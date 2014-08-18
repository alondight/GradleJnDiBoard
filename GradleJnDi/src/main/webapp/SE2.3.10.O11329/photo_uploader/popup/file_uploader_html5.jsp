<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.*"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
private String getNewFileName() {
	long millis = System.currentTimeMillis();
	return "file_" + millis + "_";
}
%>
<%

	String sFileInfo = "";
	String filename = request.getHeader("file-name");
	String filecount = request.getHeader("file-count");
	int fileSize = Integer.parseInt(request.getHeader("file-size"));
	String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
	filename_ext = filename_ext.toLowerCase();
	
	String[] allow_file = {"jpg","png","bmp","gif"};
	 
    //파일 사이즈 검사 10MB 이하의 파일만 등록
    boolean fileSizeChk = true;
    if(fileSize > 10*1000*1000){
    	fileSizeChk = false;               	
    }
	
	
	//돌리면서 확장자가 이미지인지 
	int cnt = 0;
	for(int i=0; i<allow_file.length; i++) {
	    if(filename_ext.equals(allow_file[i])){
	        cnt++;
	    }
	}
	
	if(cnt == 0 || fileSizeChk == false) {
	    out.println("NOTALLOW_"+filename);
	
	} else {
		//파일이름생성 및 저장 위치설정
		String newFileName = this.getNewFileName()+filecount;
		String savedPath = application.getRealPath("/file/" + newFileName);
		
		//디렉토리 확인 후 저장
		File f = new File(application.getRealPath("/file/"));
		if(!f.exists()) {
		    f.mkdirs();
		}
		

		///////////////// 서버에 파일쓰기 ///////////////// 
		DataInputStream fos    = new DataInputStream(request.getInputStream());
		OutputStream os = new FileOutputStream(savedPath);
		int data;
		while((data = fos.read()) != -1){
		    os.write(data);
		    os.flush();
		}
		if(fos != null) {
			fos.close();
		}
		os.close();
		///////////////// 서버에 파일쓰기 /////////////////
		 
		
		
		// 정보 출력
		sFileInfo += "&bNewLine=true";
		sFileInfo += "&sFileName="+ filename;;
		sFileInfo += "&sFileURL="+application.getContextPath()+"/file/" + newFileName;
		out.println(sFileInfo);
	}
%>