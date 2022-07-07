package member;

import java.util.Date;

/** 회원정보 DTO */
public class MemberDTO {
	private int custno = 0;			// 회원정보
	private String custname = "";	// 회원번호
	private String phone = "";		// 회원전화
	private String address = "";	// 주소
	private Date joindate = null;	// 가입일자
	private String grade = "";		// 고객등급
	private String city = "";		// 거주도시
    
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getJoindate() {
		return joindate;
	}
	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
}
