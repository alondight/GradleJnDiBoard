package net.cr.abrand.services;

import net.cr.abrand.vo.Board;


public interface BoardService {
	int writeBoard(Board b) throws Exception;
	Board viewBoard(int bno) throws Exception;
	int updateBoard(Board b) throws Exception;
	int deleteBoard(int bno) throws Exception;
}














