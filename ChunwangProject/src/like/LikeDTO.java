package like;

public class LikeDTO {
	int writeID = 0;
	String userID = null;
	String boardType = null;
	
	public LikeDTO() { }
	public LikeDTO(int writeID, String userID, String boardType) {
		super();
		this.writeID = writeID;
		this.userID = userID;
		this.boardType = boardType;
	}
	
	public int getWriteID() {
		return writeID;
	}
	public void setWriteID(int writeID) {
		this.writeID = writeID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
}
