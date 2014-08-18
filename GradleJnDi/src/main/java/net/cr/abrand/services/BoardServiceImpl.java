package net.cr.abrand.services;

import net.cr.abrand.dao.BoardDao;
import net.cr.abrand.vo.Board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired BoardDao boardDao;
	
	
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public int writeBoard(Board b) throws Exception {
		int count = boardDao.writeBoard(b);
		return count;
	}


	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public Board viewBoard(int bno) throws Exception {
		boardDao.countBoard(bno);
		Board b = boardDao.viewBoard(bno);
		return b;
	}


	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public int updateBoard(Board b) throws Exception {
		int count = boardDao.updateBoard(b);
		return count;
	}


	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public int deleteBoard(int bno) throws Exception {
		int count = boardDao.deleteBoard(bno);
		return count;
	}
	
}














