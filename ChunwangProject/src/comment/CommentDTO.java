package comment;

public class CommentDTO {
	private int commentID;
	private int writeID;
	private int preComment;
	private String userID;
	private String commentContent;
	private String commentTime;
	private String boardType;
	
	public CommentDTO() { }
	public CommentDTO(int commentID, int writeID, int preComment, String userID, String commentContent,
			String commentTime, String boardType) {
		super();
		this.commentID = commentID;
		this.writeID = writeID;
		this.preComment = preComment;
		this.userID = userID;
		this.commentContent = commentContent;
		this.commentTime = commentTime;
		this.boardType = boardType;
	}
	
	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
	public int getWriteID() {
		return writeID;
	}
	public void setWriteID(int writeID) {
		this.writeID = writeID;
	}
	public int getPreComment() {
		return preComment;
	}
	public void setPreComment(int preComment) {
		this.preComment = preComment;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(String commentTime) {
		this.commentTime = commentTime;
	}
	public String getboardType() {
		return boardType;
	}
	public void setboardType(String boardType) {
		this.boardType = boardType;
	}
}
