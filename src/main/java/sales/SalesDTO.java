package sales;

public class SalesDTO {
	private int custno = 0;			// 회원정보
	private String custname = "";	// 회원번호
	private String grade = "";		// 고객등급
	private int sales = 0;			// 매출
	
	public int getCustno() {
		return custno;
	}
	public void setCustno(int custno) {
		this.custno = custno;
	}
	public String getCustname() {
		return custname;
	}
	public void setCustname(String custname) {
		this.custname = custname;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
}