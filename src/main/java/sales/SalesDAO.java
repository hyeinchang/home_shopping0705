package sales;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBPKG.DBConnection;

public class SalesDAO {
	private Connection con = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	public SalesDAO() {
		con = DBConnection.getConnection();
	}
	
	public ArrayList<SalesDTO> getSalesList() {
		ArrayList<SalesDTO> salesList = new ArrayList<>();
		SalesDTO salesDTO = null;
		String sql = "select A.custno, A.custname"
			       + ", (case A.grade when 'A' then 'VIP'"
			       + "	when  'B' then '일반'"
			       + "  when 'C' then '직원' end) grade"
			       + ", sum(B.price) sales "
			       + " from member_tbl_02 A inner join money_tbl_02 B"
			       + " on A.custno = B.custno group by A.custno, A.custname, A.grade"
			       + " order by sales desc";
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				salesDTO = new SalesDTO();
				
				salesDTO.setCustno(rs.getInt("custno"));
				salesDTO.setCustname(rs.getString("custname"));
				salesDTO.setGrade(rs.getString("grade"));
				salesDTO.setSales(rs.getInt("sales"));
				
				salesList.add(salesDTO);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return salesList;
	}
}
