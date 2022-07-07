package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBPKG.DBConnection;

public class MemberDAO {
	private Connection con = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	public MemberDAO() {
		try {
			con = new DBConnection().getConnection();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<MemberDTO> getMemberList() {
		ArrayList<MemberDTO> memberList = new ArrayList<>();
		MemberDTO memberDTO = null;
		String sql = "select * from member_tbl_02 order by custno";
		
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				memberDTO = new MemberDTO();
				
				memberDTO.setCustno(rs.getInt("custno"));
				memberDTO.setCustname(rs.getString("custname"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setJoindate(rs.getDate("joindate"));
				memberDTO.setGrade(rs.getString("grade"));
				memberDTO.setCity(rs.getString("city"));
				
				memberList.add(memberDTO);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return memberList;
	}
	
	public MemberDTO getMemberDetail(int custno) {
		MemberDTO memberDTO = null;
		String sql = "select * from member_tbl_02 where custno = ?";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, custno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				memberDTO = new MemberDTO();
				
				memberDTO.setCustno(rs.getInt("custno"));
				memberDTO.setCustname(rs.getString("custname"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setJoindate(rs.getDate("joindate"));
				memberDTO.setGrade(rs.getString("grade"));
				memberDTO.setCity(rs.getString("city"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return memberDTO;
	}
	
	public int getNewCustno() {
		int newCustno = 0;
		String sql = "select nvl(max(custno), 100000) + 1 newCustno from member_tbl_02";
		
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				newCustno = rs.getInt("newCustno");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return newCustno;
	}
	
	public int registMember(MemberDTO memberDTO) {
		int result = 0;
		String sql = "insert into member_tbl_02(custno, custname, phone, address, joindate, grade, city)"
				 + " values(?, ?, ?, ?, ?, ?, ?)";
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setObject(1, memberDTO.getCustno());
			ps.setObject(2, memberDTO.getCustname());
			ps.setObject(3, memberDTO.getPhone());
			ps.setObject(4, memberDTO.getAddress());
			ps.setObject(5, new java.sql.Date(memberDTO.getJoindate().getTime()));
			ps.setObject(6, memberDTO.getGrade());
			ps.setObject(7, memberDTO.getCity());
			
			result = ps.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int modifyMember(MemberDTO memberDTO) {
		int result = 0;
		String sql = "update member_tbl_02 set custname = ?"
				+ ", phone = ?"
				+ ", address = ?"
				+ ", joindate = ?"
				+ ", grade = ?"
				+ ", city = ?"
				+ " where custno = ?";
		
		try {
			ps = con.prepareStatement(sql);

			ps.setObject(1, memberDTO.getCustname());
			ps.setObject(2, memberDTO.getPhone());
			ps.setObject(3, memberDTO.getAddress());
			ps.setObject(4, new java.sql.Date(memberDTO.getJoindate().getTime()));
			ps.setObject(5, memberDTO.getGrade());
			ps.setObject(6, memberDTO.getCity());
			ps.setObject(7, memberDTO.getCustno());
			
			result = ps.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
