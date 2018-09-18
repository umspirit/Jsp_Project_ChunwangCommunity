package user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;
import util.SHA256;

public class UserDAO {
	
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;
				else
					return 0;
			}
			return -1;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return -2;
	}
	
	public int join(String userID, String userpw, String userName, String userEmail, String time) {
		String sql = "INSERT INTO USER VALUES (?, ?, ?, ?, false, false, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, userpw);
			pstmt.setString(3, userEmail);
			pstmt.setString(4, SHA256.getSHA256(userEmail));
			pstmt.setString(5, userName);
			pstmt.setString(6, userName);
			pstmt.setString(7, time);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}

		return -2;
	}
	
	public int joinCheck(String userID) {
		String sql = "SELECT * FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next() || userID.equals(""))  {
				// 이미 존재하는 아이디
				return 0;
			}
			else {
				// 가입 가능한 아이디
				return 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}

		return -1;
	}
	
	public boolean getUserEmailChecked (String userID) {
		String sql = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return false;
	}
	
	public boolean getExistEmailChecked (String userEmail) {
		String sql = "SELECT userEmailChecked FROM USER WHERE userEmail = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return false;
	}
	
	public String getUserEmail(String userID) {
		String sql = "SELECT userEmail FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return null;
	}
	
	public String isExistEmail(String userEmail) {
		String sql = "SELECT userEmail FROM USER WHERE userEmail = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return null;
	}
	
	public String getNickname(String userID) {
		String sql = "SELECT nickName FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return null;
	}
	
	public boolean setUserEmailChecked (String userID) {
		String sql = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		 try {
			 conn = DatabaseUtil.getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userID);
			 pstmt.executeUpdate();
			 
			 return true;
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
				try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
				try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
				try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		 }
		 
		 return false;
	}
	
	public boolean getAdminCheck (String userID) {
		String sql = "SELECT admincheck FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return false;
	}
	
	public boolean deleteUser(String userID) {
		String sql = "DELETE FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return false;
	}
	
	public boolean changePw(String userID, String userPassword) {
		String sql = "UPDATE USER SET userPassword = ? WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		 try {
			 conn = DatabaseUtil.getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userPassword);
			 pstmt.setString(2, userID);
			 pstmt.executeUpdate();
			 
			 return true;
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
				try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
				try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		 }
		 
		 return false;
	}
	
	public String isExistNickname(String nickName) {
		String sql = "SELECT nickName FROM USER WHERE nickName = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		 try {
			 conn = DatabaseUtil.getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, nickName);
			 rs = 	pstmt.executeQuery();
			 
			 if(rs.next()) {
				 return rs.getString(1);
			 }
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
				try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
				try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		 }
		 
		 return null;
	}
	
	public String getIdFind(String userName, String userEmail) {
		String sql = "SELECT userID FROM USER WHERE userName = ? AND userEmail = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		 try {
			 conn = DatabaseUtil.getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userName);
			 pstmt.setString(2, userEmail);
			 rs = 	pstmt.executeQuery();
			 
			 if(rs.next()) {
				 return rs.getString(1);
			 }
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
				try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
				try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		 }
		 
		 return null;
	}
	
	public int changeNickName(String userID, String nickName) {
		String sql = "UPDATE USER SET nickName = ? WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		 try {
			 conn = DatabaseUtil.getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, nickName);
			 pstmt.setString(2, userID);
			 
			 return pstmt.executeUpdate();
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
				try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
				try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		 }
		 
		 return -2;
	}
	
	public int userDeleteAll(String userEmail) {
		String sql = "DELETE FROM USER WHERE userEmail = ? AND userEmailChecked = false";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		 try {
			 conn = DatabaseUtil.getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userEmail);
			 
			 return pstmt.executeUpdate();
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
				try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
				try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
		 }
		 
		 return -2;
	}
}
