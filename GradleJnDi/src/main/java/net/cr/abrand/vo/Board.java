package net.cr.abrand.vo;

import java.io.Serializable;
import java.util.Date;

public class Board implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int bno;
	private String bname;
	private String btitle;
	private String bcontent;
	private int bcount;
	private Date bregdate;
	private Date bupdatedate;
	private Date bdeldate;
	private String bdelflag;

	
	public int getBcount() {
		return bcount;
	}
	public Board setBcount(int bcount) {
		this.bcount = bcount;
		return this;
	}
	public int getBno() {
		return bno;
	}
	public Board setBno(int bno) {
		this.bno = bno;
		return this;
	}
	public String getBname() {
		return bname;
	}
	public Board setBname(String bname) {
		this.bname = bname;
		return this;
	}
	public String getBtitle() {
		return btitle;
	}
	public Board setBtitle(String btitle) {
		this.btitle = btitle;
		return this;
	}
	public String getBcontent() {
		return bcontent;
	}
	public Board setBcontent(String bcontent) {
		this.bcontent = bcontent;
		return this;
	}
	public Date getBregdate() {
		return bregdate;
	}
	public Board setBregdate(Date bregdate) {
		this.bregdate = bregdate;
		return this;
	}
	public Date getBupdatedate() {
		return bupdatedate;
	}
	public Board setBupdatedate(Date bupdatedate) {
		this.bupdatedate = bupdatedate;
		return this;
	}
	public Date getBdeldate() {
		return bdeldate;
	}
	public Board setBdeldate(Date bdeldate) {
		this.bdeldate = bdeldate;
		return this;
	}
	public String getBdelflag() {
		return bdelflag;
	}
	public Board setBdelflag(String bdelflag) {
		this.bdelflag = bdelflag;
		return this;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	
}
















