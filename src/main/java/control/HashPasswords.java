package control;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class HashPasswords {
    private static DataSource ds;

    static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			
			ds=(DataSource) envCtx.lookup("jdbc/ClickSwitch");
		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}

    public static void main(String[] args) {
        try (Connection connection = ds.getConnection()) {
            // Step 1: Retrieve all users and their passwords
            String selectSQL = "SELECT USERNAME, PASSWORD FROM user_account";
            PreparedStatement selectStmt = connection.prepareStatement(selectSQL);
            ResultSet rs = selectStmt.executeQuery();

            // Step 2: Hash each password and update the database
            String updateSQL = "UPDATE user_account SET PASSWORD = ? WHERE USERNAME = ?";
            PreparedStatement updateStmt = connection.prepareStatement(updateSQL);

            while (rs.next()) {
                String username = rs.getString("USERNAME");
                String password = rs.getString("PASSWORD");
                String hashedPassword = toHash(password);

                updateStmt.setString(1, hashedPassword);
                updateStmt.setString(2, username);
                updateStmt.executeUpdate();
            }

            System.out.println("All passwords have been hashed.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String toHash(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-512");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hashString = new StringBuilder();
            for (byte b : hash) {
                hashString.append(String.format("%02x", b));
            }
            return hashString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
