package net.cr.abrand.dao;

import net.cr.abrand.vo.Board;

public interface BoardDao {
	int writeBoard(Board b) throws Exception;
	Board viewBoard(int bno) throws Exception;
	int updateBoard(Board b) throws Exception;
	int deleteBoard(int bno) throws Exception;
	void countBoard(int bno) throws Exception;
}




