package com.mycompany.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.web.dto.Ch06Board;


@Controller
@RequestMapping("/ch06")
public class Ch06Controller {
	private static final Logger logger= LoggerFactory.getLogger(Ch06Controller.class);

	@RequestMapping("/content")
	public String content() {
		return "ch06/content";
	}
	
	@PostMapping("/login")
	public String login(String mid, String mpassword, HttpSession session) {
		String loginResult = "";
		if(mid.equals("admin")) {
			if(mpassword.equals("iot12345")) {
				loginResult="success";
		}else {
			loginResult = "wrongMpassword";
			}
		}else {
			loginResult = "wrongMid";
		}
		
		session.setAttribute("loginResult", loginResult);
		
		return "redirect:/ch06/content";
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginResult");
		return "redirect:/ch06/content";
		
	}
	
	@RequestMapping("/fileDownload")
	public void fileDownload(String fname, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug(fname);
		
		//Response Header에 추가
		ServletContext application = request.getServletContext();
		String mimeType = application.getMimeType(fname);
		
		//response.setHeader("Content-Type",mimeType);
		response.setContentType(mimeType);
		logger.debug("###"+mimeType);
		String userAgent = request.getHeader("User-Agent");
		String downloadName;
		logger.debug(userAgent);
		if(userAgent.contains("Trident/7.0") || userAgent.contains("MSIE")) {
			downloadName = URLEncoder.encode(fname,"UTF-8");
		}else {
			downloadName = new String(fname.getBytes("UTF-8"),"ISO-8859-1");
		}
		logger.debug(downloadName);
		response.setHeader("Content-Disposition", "attachment; filename=\""+downloadName+"\"");
		String realPath = application.getRealPath("/resources/image/"+fname);
		File file = new File(realPath);
		response.setHeader("Content-Length", file.length()+"");	
		
		OutputStream os = response.getOutputStream();
		
		logger.debug(realPath);
		
		InputStream is = new FileInputStream(realPath);
		
		byte[] buffer = new byte[1024];
		while(true) {
			int readByte = is.read(buffer);
			if(readByte==-1) break;
			os.write(buffer,0,readByte);
		}
		os.flush();
		os.close();
		is.close();
	}

	@RequestMapping("/jsonDownload1")
	public String jsonDownload1(Model model) {
		Ch06Board board = new Ch06Board();
		board.setBno(100);
		board.setBtitle("공부하고 싶다.");
		board.setBcontent("까짓것 하면 되겠지...열공!");
		board.setWriter("감못잡아");
		board.setDate(new Date());
		board.setHitcount(1);
		
		model.addAttribute("board",board);
		
		return "ch06/jsonDownload1";
	}
	@RequestMapping("/jsonDownload2")
	public void jsonDownload2(HttpServletResponse response) throws Exception {
		Ch06Board board = new Ch06Board();
		board.setBno(300);
		board.setBtitle("나는 오타쟁이");
		board.setBcontent("오타는 나의 인생,오타 내는 것은 당연");
		board.setWriter("감못잡아");
		board.setDate(new Date());
		board.setHitcount(1);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("bno",board.getBno());
		jsonObject.put("btitle",board.getBtitle());
		jsonObject.put("writer",board.getWriter());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		jsonObject.put("date",sdf.format(board.getDate()));
		jsonObject.put("hitcount",board.getHitcount());
		String json = jsonObject.toString();
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.write(json);
		pw.flush();
		pw.close();
}
}
