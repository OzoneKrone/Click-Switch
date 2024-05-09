import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Login")
public class Login {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		String username = request.getParameter("username");
		String password= request.getParameter("password");
		List<String> errors = new ArrayList<>();
		RequestDispatcher dispatcherToLoginPage = request.getRequestDispatcher("login.jsp");
		if(username == null || username.trim().isEmpty()) {
			errors.add("Per favore, inserisci il tuo Username");
		}
		if(password == null || password.trim().isEmpty()) {
			errors.add("Per favore, inserisci la tua Password");
		}
		if(!errors.isEmpty()) {
			request.setAttribute("error", errors);
			dispatcherToLoginPage.forward(request, response);
			return;
		}
		username = username.trim();
		password = password.trim();

	}

	private String toHash(String password) {
		String hashString = null;
		try {
			java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-512");
			byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
			hashString = "";
			for (int i = 0; i < hash.length; i++) {
				hashString += Integer.toHexString((hash[i] & 0xFF) | 0x100).substring(1, 3);
			}
		} catch (java.security.NoSuchAlgorithmException e) {
			System.out.println(e);
		}
		return hashString;
	}
}
