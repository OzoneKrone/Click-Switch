package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class UserDAODataSource implements UserBeanDAO<UserBean>{
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
	
	private static final String TABLE_NAME = "clickswitch.user_account";

	@Override
	public synchronized void doSave(UserBean user) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String insertSQL = "INSERT INTO " + TABLE_NAME + " (USERNAME, EMAIL, HASH_PASSWORD, NAME, ADDRESS, ROLE) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, user.getUsername());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setString(3, user.getPassword());
			preparedStatement.setString(4, user.getName());
			preparedStatement.setString(5, user.getAddress());
			preparedStatement.setString(6, user.getRole());
			
			preparedStatement.executeUpdate();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}

	@Override
	public boolean doDelete(String username) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		int result = 0;
		
		String deleteSQL = "DELETE FROM " + 
				UserDAODataSource.TABLE_NAME + " WHERE USERNAME = ?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, username);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}

	@Override
	public UserBean doRetrieveByKey(String username) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		UserBean bean = new UserBean();
		String selectSQL = "SELECT * FROM " + UserDAODataSource.TABLE_NAME + " WHERE USERNAME = ?";
		try {
			connection = ds.getConnection();	
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				bean.setUsername(rs.getString("USERNAME"));
				bean.setEmail(rs.getString("EMAIL"));
				bean.setPassword(rs.getString("HASH_PASSWORD"));
				bean.setName(rs.getString("NAME"));
				bean.setAddress(rs.getString("ADDRESS"));
				bean.setRole(rs.getString("ROLE"));
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	}

	@Override
	public Collection<UserBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<UserBean> Users = new LinkedList<UserBean>();

		String selectSQL = "SELECT * FROM " + UserDAODataSource.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				UserBean bean = new UserBean();

				bean.setUsername(rs.getString("USERNAME"));
				bean.setEmail(rs.getString("EMAIL"));
				bean.setPassword(rs.getString("HASH_PASSWORD"));
				bean.setName(rs.getString("NAME"));
				bean.setAddress(rs.getString("ADDRESS"));
				bean.setRole(rs.getString("ROLE"));
				Users.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return Users;
	}
}
