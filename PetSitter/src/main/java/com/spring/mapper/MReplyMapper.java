package com.spring.mapper;

import java.util.List;

import com.spring.petsitter.board.MReplyVO;

public interface MReplyMapper {
	public int replyCount() throws Exception;
	public List<MReplyVO> readReply(int bno) throws Exception; // ��� �б�
	public int writeReply(MReplyVO vo) throws Exception;  // ��� �ۼ�
	public int updateReply(MReplyVO vo) throws Exception; // ��� ����
	public int deleteReply(int rno) throws Exception; // ��� ����
}
