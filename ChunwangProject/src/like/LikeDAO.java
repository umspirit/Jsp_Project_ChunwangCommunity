package like;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class LikeDAO {
	public int LikeUp(String boardType, int writeID, String userID) {
		String sql = "INSERT INTO LikeDB VALUES(?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardType);
			pstmt.setInt(2, writeID);
			pstmt.setString(3, userID);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		
		return -2;
	}
	
	public int setLikeCount(String boardType, int writeID) {
		String sql = "UPDATE " + boardType + " SET likeCount = likeCount + 1 WHERE writeID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, writeID);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		
		return -2;
	}
}
