 <%@page import="java.io.*,javax.servlet.*,javax.servlet.http.*" %>
 <%
  String message = "";
  String filename=request.getParameter("file");
  if(filename != null){
    try{
      String contentType = request.getParameter("type");
      if(contentType == null)contentType = "application/octet-stream";
      File f=new File(filename);
      int length=0;
      ServletOutputStream outStream=response.getOutputStream();
      response.setContentType(contentType);

      //System.out.println("content len = " + f.length() + " and buffer size = " + response.getBufferSize());
      response.setContentLength((int)f.length());
      filename = filename.replace(" ", "_");
      response.setHeader("Content-Disposition","attachment;filename=" + filename);
      
      //for IE8, errors out on attachments that aren't cached
      response.setHeader("Cache-Control", "private, max-age=15"); // HTTP 1.1

      //clear the buffer so no extra data gets written, clears leading CRLF characters
      response.resetBuffer();
      
      //complete file downloading using buffering
      byte[] bbuf=new byte[1024];
      FileInputStream inStream=new FileInputStream(f);
      
      //write the file to the response output stream
      while((inStream!=null)&&((length=inStream.read(bbuf))!=-1))
      {
        outStream.write(bbuf,0,length);
      }
      inStream.close();
      outStream.close();
      f.delete();
    }
    catch(NullPointerException e)
    {
       throw e;
    }
     catch(IllegalStateException e)
    {
       throw e;
    }
     catch(IOException e)
    {
      throw e;
    }

  }
%>
