<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
long currTime = 0;
int count = 0;

synchronized private String getNewFileName() {
	long millis = System.currentTimeMillis();
	if (currTime != millis) {
		count = 0;
	}
	return "file_" + millis + "_" + (++count);
}
%>    
<%
String return1="";
String return2="";
String return3="";
if (ServletFileUpload.isMultipartContent(request)){
	//common에서 제공하는 파일업로드
    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
    uploadHandler.setHeaderEncoding("UTF-8");
    List<FileItem> items = uploadHandler.parseRequest(request);
   
    for (FileItem item : items) {
        if(item.getFieldName().equals("callback")) {
            return1 = item.getString("UTF-8");
        
        } else if(item.getFieldName().equals("callback_func")) {
            return2 = "?callback_func="+item.getString("UTF-8");
        
        } else if(item.getFieldName().equals("Filedata")) {
        	
            if(item.getSize() > 0) {
                String name = item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
                String filename_ext = name.substring(name.lastIndexOf(".")+1);
                filename_ext = filename_ext.toLowerCase();
                String[] allow_file = {"jpg","png","bmp","gif"};
                
                //파일 사이즈 검사 10MB 이하의 파일만 등록
                boolean fileSizeChk = true;
                if(item.getSize() > 10*1000*1000){
                	fileSizeChk = false;               	
                }
                
                //파일 확장자 검사
                int cnt = 0;
                for(int i=0; i<allow_file.length; i++) {
                    if(filename_ext.equals(allow_file[i])){
                        cnt++;
                    }
                }
                if(cnt == 0 || fileSizeChk == false ) {
                    return3 = "&errstr="+name;
                } else {
                	
 					//파일이름생성 및 저장 위치설정
            		String newFileName = this.getNewFileName();
            		String savedPath = application.getRealPath("/file/" + newFileName);
            		
            		//디렉토리 확인 후 저장
            		File f = new File(application.getRealPath("/file/"));
            		if(!f.exists()) {
            		    f.mkdirs();
            		}
            		
            		item.write(new File(savedPath));
                	
                    //리턴 값 설정
                    return3 += "&bNewLine=true";
                    return3 += "&sFileName="+ name;
                    return3 += "&sFileURL="+application.getContextPath()+"/file/" + newFileName;
                }
            }else {
                  return3 += "&errstr=error";
            }
        }
    }
}


//out.println(return1+return2+return3);
response.sendRedirect(return1+return2+return3);
%>










