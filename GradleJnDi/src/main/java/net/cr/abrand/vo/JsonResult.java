package net.cr.abrand.vo;

public class JsonResult {
	private String status;
	private Object data;

	public String getStatus() {
		return status;
	}
	public JsonResult setStatus(String status) {
		this.status = status;
		return this;
	}
	public Object getData() {
		return data;
	}
	public JsonResult setData(Object data) {
		this.data = data;
		return this;
	}
}
