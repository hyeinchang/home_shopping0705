package money;

import java.util.Date;

/** 회원매출정보 DTO */
public class MoneyDTO {
	private int custno = 0;		// 회원번호
	private int saleno = 0; 	// 판매번호
	private int pcost = 0; 		// 단가
	private int amount = 0;		// 수량
	private int price = 0; 		// 가격
	private String pcode = "";  // 상품코드
	private Date sdate = null; 	// 판매일자
	
	public int getCustno() {
		return custno;
	}
	public void setCustno(int custno) {
		this.custno = custno;
	}
	public int getSaleno() {
		return saleno;
	}
	public void setSaleno(int saleno) {
		this.saleno = saleno;
	}
	public int getPcost() {
		return pcost;
	}
	public void setPcost(int pcost) {
		this.pcost = pcost;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public Date getSdate() {
		return sdate;
	}
	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}
}
