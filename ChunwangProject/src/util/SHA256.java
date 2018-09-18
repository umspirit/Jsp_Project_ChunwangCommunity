package util;

import java.security.MessageDigest;

// 이메일을 인증하기 위해서 사용자가 링크를 타고 인증을 할 수 있도록 하는 함수
public class SHA256 {
	
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			// 솔트는 악의적인 공격을 막히 위함
			byte[] salt = "Hellow! THis is Salt.".getBytes();
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			
			for(int i=0; i< chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) // 한자리일 경우 뒤에 0을 붙여서 2자리로 만들어준다.
					result.append("0");
				result.append(hex);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			
		}
		
		return result.toString();
	}
}
