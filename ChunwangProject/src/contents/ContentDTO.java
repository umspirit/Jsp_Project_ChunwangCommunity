package contents;

public class ContentDTO {
	int writeID;
	String userID;
	String topicName;
	String contentName;
	String time;
	int likeCount;
	int searchCount;
	String boardDivide;
	
	public ContentDTO() { }
	
	public ContentDTO(int writeID, String userID, String topicName, String contentName, String time, String boardDivide, int likeCount, int searchCount) {
		super();
		this.writeID = writeID;
		this.userID = userID;
		this.topicName = topicName;
		this.contentName = contentName;
		this.time = time;
		this.boardDivide = boardDivide;  
		this.likeCount = likeCount;
		this.searchCount = searchCount;
	}
	
	public int getwriteID() {
		return writeID;
	}
	public void setwriteID(int writeID) {
		this.writeID = writeID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getTopicName() {
		return topicName;
	}
	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}
	public String getContentName() {
		return contentName;
	}
	public void setContentName(String contentName) {
		this.contentName = contentName;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getboardDivide() {
		return boardDivide;
	}
	public void setboardDivide(String boardDivide) {
		this.boardDivide = boardDivide;
	}
	public int getSearchCount() {
		return searchCount;
	}
}
