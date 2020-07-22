package com.spring.petsitter.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ProBoardController {
	
	@Autowired
	private ProBoardService proboardService;	
	
	@RequestMapping(value = "proboard.bo") 
	public String getBoardlist(Model model, @RequestParam(value="page", required=false, 
			defaultValue="1") int page) { 
		int limit=6;
		
		SimpleDateFormat new_Format = new SimpleDateFormat("yyyy-MM-dd");

		int listcount=proboardService.getProListCount();
		
		int startrow = (page-1)*6+1;
		int endrow = startrow+limit-1;
		HashMap<String, Integer> hashmap = new HashMap<String, Integer>();
		hashmap.put("startrow", startrow);
		hashmap.put("endrow", endrow);
		
		List<ProBoardVO> boardlist = proboardService.getProBoardList(hashmap); // 다른 타입 2개를 전달해야하므로

		
		for(int i = 0; i < boardlist.size(); i++) {
		boardlist.get(i).setREAL_DATE(new_Format.format(boardlist.get(i).getPRO_DATE()));
		}
		
		//총 페이지 수
   		int maxpage=(int)((double)listcount/limit+0.95); //0.95를 더해서 올림 처리
   		//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
   		int startpage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
   		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30 등...)
   		int endpage = maxpage;
   		
   		if (endpage>startpage+10-1) endpage=startpage+10-1;
   		
		model.addAttribute("page", page);
		model.addAttribute("listcount", listcount);
		model.addAttribute("boardlist", boardlist);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("startpage", startpage);
		model.addAttribute("endpage", endpage);
		
		return "board/proboard";
	}
	

	@RequestMapping(value="/proboard2.bo", produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<ProBoardVO> getBoardlist2(@RequestParam(value="page", required=false, 
			defaultValue="1") int page) { 
		int limit=6;
		

		SimpleDateFormat new_Format = new SimpleDateFormat("yyyy-MM-dd");
		
		int listcount=proboardService.getProListCount();
		
		int startrow = (page-1)*6+1; //7
		int endrow = startrow+limit-1; //12
		HashMap<String, Integer> hashmap = new HashMap<String, Integer>();
		hashmap.put("startrow", startrow);
		hashmap.put("endrow", endrow);

		List<ProBoardVO> boardlist = proboardService.getProBoardList(hashmap); // 다른 타입 2개를 전달해야하므로
		
		for(int i = 0; i < boardlist.size(); i++) {
		boardlist.get(i).setREAL_DATE(new_Format.format(boardlist.get(i).getPRO_DATE()));
		}

		//총 페이지 수
   		int maxpage=(int)((double)listcount/limit+0.95); //0.95를 더해서 올림 처리
   		//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
   		int startpage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
   		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30 등...)
   		int endpage = maxpage;
   		
   		if (endpage>startpage+10-1) endpage=startpage+10-1;
   		

   		boardlist.get(0).setPage2(page);
   		boardlist.get(0).setListcount2(listcount);
   		boardlist.get(0).setMaxpage2(maxpage);
   		boardlist.get(0).setStartpage2(startpage);
   		boardlist.get(0).setEndpage2(endpage);
   		
   		for(int i = 1; i < boardlist.size(); i++) {
   			boardlist.get(i).setPage2(0);
   	   		boardlist.get(i).setListcount2(0);
   	   		boardlist.get(i).setMaxpage2(0);
   	   		boardlist.get(i).setStartpage2(0);
   	   		boardlist.get(i).setEndpage2(0);
   		}


		return boardlist;
	}	
	
	@RequestMapping("/proboardwriteform.bo") 
	public String boardInsertForm() {
		
		return "board/proboard_write";
	}

	@RequestMapping("/proboardwrite.bo") 
	public String proBoardInsert(ProBoardVO vo) throws Exception {
		MultipartFile mf = vo.getPRO_FILE();    
		MultipartFile mf2 = vo.getPRO_FILE02();    
		System.out.println("mf=" + mf);
    	String uploadPath = "C:\\Project156\\upload\\";
    	if(vo.getSECRET_CHECK() == null) {
    		vo.setSECRET_CHECK("N");
    	}
        if(mf.getSize() != 0) {            
           		
    		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
    		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
    		//예외처리 기능 필요함.     
    		
    		//mf.transferTo(new File(uploadPath+"/"+mf.getOriginalFilename())); 
    		mf.transferTo(new File(uploadPath+storedFileName));
    		vo.setPRO_ORG_FILE(mf.getOriginalFilename());
    		vo.setPRO_UP_FILE(storedFileName);
    		
    		if(mf2.getSize() != 0){
    			String originalFileExtension02 = mf2.getOriginalFilename().substring(mf2.getOriginalFilename().lastIndexOf("."));
        		String storedFileName02 = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension02;	
            	
        		mf2.transferTo(new File(uploadPath+storedFileName02));
        		vo.setPRO_ORG_FILE(mf.getOriginalFilename()+","+mf2.getOriginalFilename());
        		vo.setPRO_UP_FILE(storedFileName+","+storedFileName02);

            }	
        }else {
        	vo.setPRO_ORG_FILE("N");
        	vo.setPRO_UP_FILE("N");
        }
        
		
		proboardService.proboardInsert(vo);
		System.out.println("sql완료");
		return "redirect:/proboard.bo";
	}
	
	@RequestMapping("/proboarddetail.bo") 
	@ResponseBody	
	public List<ProBoardVO> getProDetail(@RequestParam(value="num", required=true) int num) {
		List<ProBoardVO> boardlist = proboardService.getProDetail(num);
		SimpleDateFormat new_Format = new SimpleDateFormat("yyyy-MM-dd");
		boardlist.get(0).setREAL_DATE(new_Format.format(boardlist.get(0).getPRO_DATE()));
		
		return boardlist;
	}
	

	@RequestMapping("/promodifyform.bo") 
	public String getProModifyForm(@RequestParam(value="num", required=true) int num, Model model) {
		ProBoardVO board = proboardService.getProModifyForm(num);
		model.addAttribute("board", board);
		return "board/proboard_modify";
	}	

	
	@RequestMapping("/promodifyupdate.bo") 
	public String boardInsert(ProBoardVO vo) throws Exception {
		System.out.println("vo.getFile()=" + vo.getPRO_FILE());
		System.out.println("vo.getFile02()=" + vo.getPRO_FILE02());
		System.out.println("vo.getPRO_ORG_FILE()=" + vo.getPRO_ORG_FILE());
		//System.out.println("vo.getPRO_UP_FILE()=" + vo.getPRO_UP_FILE());
		//System.out.println("vo.getPRO_NUM()=" + vo.getPRO_NUM());
		
		MultipartFile mf = vo.getPRO_FILE();    
		MultipartFile mf2 = vo.getPRO_FILE02();    
		System.out.println("mf=" + mf);
    	String uploadPath = "C:\\Project156\\upload\\";
    	if(vo.getSECRET_CHECK() != null) {
	    		vo.setSECRET_CHECK("Y");
	    }
	    if(vo.getSECRET_CHECK() == null ) {
	    		vo.setSECRET_CHECK("N");
	    }
	    
        if(mf.getSize() != 0) {            
           		
    		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
    		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
    		//예외처리 기능 필요함.     
    		
    		//mf.transferTo(new File(uploadPath+"/"+mf.getOriginalFilename())); 
    		mf.transferTo(new File(uploadPath+storedFileName));
    		vo.setPRO_ORG_FILE(mf.getOriginalFilename());
    		vo.setPRO_UP_FILE(storedFileName);
    		
    		if(mf2.getSize() != 0){
    			String originalFileExtension02 = mf2.getOriginalFilename().substring(mf2.getOriginalFilename().lastIndexOf("."));
        		String storedFileName02 = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension02;	
            	
        		mf2.transferTo(new File(uploadPath+storedFileName02));
        		vo.setPRO_ORG_FILE(mf.getOriginalFilename()+","+mf2.getOriginalFilename());
        		vo.setPRO_UP_FILE(storedFileName+","+storedFileName02);

            }	
        }else {
        	vo.setPRO_ORG_FILE("N");
        	vo.setPRO_UP_FILE("N");
        }
        
		
		proboardService.proModifyUpdate(vo);
		return "redirect:/proboard.bo";
	}	

	
	@RequestMapping("/proboarddelete.bo") 
	public String proboardDelete(@RequestParam(value="num", required=true) int num, HttpSession session) throws Exception {
		String id = (String)session.getAttribute("id");
		
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("num", Integer.toString(num));
		hashmap.put("id", id);
		proboardService.proboardDelete(hashmap);

		return "redirect:/proboard.bo";
	}	
	
	/*신고 controller 시작*/
	@RequestMapping("/proreportform.bo") 
	@ResponseBody	
	public List<ProBoardVO> getProReportForm(@RequestParam(value="num", required=true) int num) {
		List<ProBoardVO> boardlist = proboardService.getProReportForm(num);
		return boardlist;
	}
	
	@RequestMapping("/proreportinsert.bo") 
	public String proReportInsert(ProBoardVO vo) throws Exception {
		proboardService.proReportInsert(vo);
		return "redirect:/proboard.bo";
	}	
	
	@RequestMapping("/proreportreplyform.bo") 
	@ResponseBody	
	public List<ProReplyVO> getProReportReplyForm(@RequestParam(value="bno", required=true) int bno,
	@RequestParam(value="rno", required=true) int rno) {
		System.out.println("bno,rno = " + bno + "," + rno);
		
		ProReplyVO comment = new ProReplyVO();
		comment.setRno(rno);
		comment.setBno(bno);
		List<ProReplyVO> boardlist = proboardService.getProReportReplyForm(comment);
		return boardlist;
	}
	@RequestMapping("/proreportreplyinsert.bo") 
	public String proReportReplyInsert(ProReplyVO vo) throws Exception {
		vo.getB_type();
		System.out.println("vo.getB_type() cont = " + vo.getB_type());
		System.out.println("vo.getReport_reason() cont = " + vo.getReport_reason());
		System.out.println("vo.getWriter_id() cont = " + vo.getWriter_id());
		System.out.println("vo.getWriter_id() cont = " + vo.getWriter_id());
		System.out.println("vo.getWriter_id() cont = " + vo.getWriter_id());
		proboardService.proReportReplyInsert(vo);
		return "redirect:/proboard.bo";
	}		
	
	/*신고 controller 종료*/	
	
    
	/*댓글 Controller 부분 시작*/ 	
	@RequestMapping(value="/read_ProReply.bo", produces="application/json; charset=UTF-8")  //댓글 리스트
	@ResponseBody
	private List<ProReplyVO> proCommentServiceList(@RequestParam int bno, HttpSession session) throws Exception{
	  	List<ProReplyVO> proReplyList = proboardService.readProReply(bno);
	  	System.out.println(proReplyList.size());
	  	return proReplyList;
	}    
	
	@RequestMapping(value="/write_ProReply.bo", produces="application/json; charset=UTF-8") //댓글 작성 
	@ResponseBody
	private int writeProReply(ProReplyVO comment, HttpSession session) throws Exception{
		return proboardService.writeProReply(comment);
	 }
	  
	@RequestMapping(value="/update_ProReply.bo", produces="application/json; charset=UTF-8") //댓글 수정)
	@ResponseBody
	private int updateProReply(@RequestParam int bno, @RequestParam int rno,  @RequestParam String content) throws Exception{
		ProReplyVO comment = new ProReplyVO();
		comment.setRno(rno);
		comment.setBno(bno);
		comment.setContent(content);
	  	
	  	return proboardService.updateProReply(comment);
	  }
	  
	@RequestMapping(value="/delete_ProReply.bo",  produces="application/json; charset=UTF-8") //댓글 삭제
	@ResponseBody
	private int deleteProReply(@RequestParam int rno, @RequestParam int bno) throws Exception {
		ProReplyVO comment = new ProReplyVO();
		comment.setRno(rno);
		comment.setBno(bno);
	return proboardService.deleteProReply(comment);
	}
	
	@RequestMapping(value="/proreplycount.bo",  produces="application/json; charset=UTF-8") //댓글 삭제
	@ResponseBody
	private List<ProReplyVO> proReplyCount(@RequestParam int bno) throws Exception {
		List<ProReplyVO> replycount = proboardService.proReplyCount(bno);
	return replycount;
	} 
	
	/*댓글 Controller 부분 종료*/ 


	
	//파일 다운로드 방식
	@RequestMapping("/profiledownload.bo")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setCharacterEncoding("utf-8");
		
		String num = request.getParameter("num");
		String of = request.getParameter("of"); // 서버에 업로드된 변경된 실제 파일명
	    String of2 = request.getParameter("of2"); // 오리지날 파일명
	    
	    /* //웹사이트 루트디렉토리의 실제 디스크상의 경로 알아내기.
	    String uploadPath = request.getSession().getServletContext().getRealPath("/upload");
	    String fullPath = uploadPath+"/"+of;
	    */
	    String uploadPath = "C:\\Project156\\upload\\";  // 직접 경로 지정
	    String fullPath = uploadPath + of;
	    File downloadFile = new File(fullPath);
	    
	    //파일 다운로드를 위해 컨테츠 타입을 application/download 설정
	    response.setContentType("application/download; charset=UTF-8");
	    //파일 사이즈 지정
	    response.setContentLength((int)downloadFile.length());
	    //다운로드 창을 띄우기 위한 헤더 조작
	    response.setHeader("Content-Disposition", "attachment;filename="
	                                    + new String(of2.getBytes(), "ISO8859_1"));
	    response.setHeader("Content-Transfer-Encoding","binary");
	    
	    FileInputStream fin = new FileInputStream(downloadFile);
	    ServletOutputStream sout = response.getOutputStream();
	
	    byte[] buf = new byte[1024];
	    int size = -1;
	
	    while ((size = fin.read(buf, 0, buf.length)) != -1) {
	        sout.write(buf, 0, size);
	    }
	    fin.close();
	    sout.close();
	}	
	
}
