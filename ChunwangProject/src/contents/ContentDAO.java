package contents;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class ContentDAO {
	public int write (ContentDTO cntDTO) {
		String sql = "INSERT INTO "+ cntDTO.getboardDivide() + " VALUES (NULL, ?, ?, ?, ?, 0, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cntDTO.getUserID().replaceAll("<", "&alt;").replaceAll(">", "&gt;").replaceAll("/r/n", "<br>"));
			pstmt.setString(2, cntDTO.getTopicName().replaceAll("<", "&alt;").replaceAll(">", "&gt;").replaceAll("/r/n", "<br>"));
			pstmt.setString(3, cntDTO.getContentName().replaceAll("<", "&alt;").replaceAll(">", "&gt;").replaceAll("/r/n", "<br>"));
			pstmt.setString(4, cntDTO.getTime().replaceAll("<", "&alt;").replaceAll(">", "&gt;").replaceAll("/r/n", "<br>"));
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return -1;
	}
	
	public ArrayList<ContentDTO> getList (String boardType, String searchType, String search, int pageNumber) {
		ArrayList<ContentDTO> contentList = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "SELECT * FROM " + boardType + " ORDER BY writeID DESC LIMIT " + (pageNumber-1) * 10  + "," + pageNumber * 10; 
			
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			contentList = new ArrayList<ContentDTO>();
			
			while(rs.next()) {
				ContentDTO content = new ContentDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						boardType,
						rs.getInt(6),
						rs.getInt(7)
				);
				contentList.add(content);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return contentList;
	}
	
	public int targetPage(int countindex,String boardType) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(writeID) FROM " + boardType + " WHERE writeID < ?";
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, countindex);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int tmp = 0;
				return rs.getInt(1);
			} 
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.clearBatch();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		// 오류가 발생하였을 때
		return 0;
	}
	
	public ContentDTO getContent(String boardType, int idx) {
		ContentDTO cntdto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM " + boardType + " WHERE writeID = ?";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String tmpstr = rs.getString(4);
				tmpstr = tmpstr.replaceAll("′","'"); // 치환된 작은따옴표 원래 작은따옴표로 환원처리
				tmpstr = tmpstr.replaceAll("\r\n","<br>"); // 줄바꿈처리
				tmpstr = tmpstr.replaceAll("\u0020","&nbsp;"); // 스페이스바로 띄운 공백처리
				
				cntdto = new ContentDTO(
						idx,
						rs.getString(2),
						rs.getString(3),
						tmpstr,
						rs.getString(5),
						boardType,
						rs.getInt(6),
						rs.getInt(7)
				);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return cntdto;
	}
	
	public boolean Delete(String boardType, int writeID) {
		String content_dsql = "DELETE FROM " + boardType + " WHERE writeID = ?";
		String comment_dsql = "DELETE FROM " + boardType + "_Comment WHERE writeID = ?";
		String like_dsql = "DELETE FROM likeDB WHERE boardType = ? AND writeID = ?";
		
		Connection conn = null;;
		PreparedStatement pstmt = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			// 게시글을 지우는 데이터베이스 질의문
			pstmt = conn.prepareStatement(content_dsql);
			pstmt.setInt(1, writeID);
			pstmt.executeUpdate();
			
			// 게시글의 댓글을 지우는 데이터베이스 질의문
			pstmt = conn.prepareStatement(comment_dsql);
			pstmt.setInt(1, writeID);
			pstmt.executeUpdate();
			
			// 게시길의 좋아요를 지우는 데이터베이스 질의문
			pstmt = conn.prepareStatement(like_dsql);
			pstmt.setString(1, boardType);
			pstmt.setInt(2, writeID);
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
	
	public boolean SearchUp(String boardType, int writeID) {
		String sql = "UPDATE " + boardType + " SET searchCount = searchCount + 1 WHERE writeID = ? ";
		Connection conn = null;;
		PreparedStatement pstmt = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, writeID);
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
}
