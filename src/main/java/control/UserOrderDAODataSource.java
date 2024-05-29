package control;

import java.sql.Timestamp;
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

import model.UserBean;
import model.UserBeanDAO;
import model.UserOrderBean;
import model.UserOrderDAO;

public class UserOrderDAODataSource implements UserOrderDAO<UserOrderBean>{
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
	
	private static final String TABLE_NAME = "clickswitch.user_order";

	@Override
	public synchronized void doSave(UserOrderBean userOrder) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    String insertSQL = "INSERT INTO " + TABLE_NAME + " (date_time, status, total, username) VALUES (?, ?, ?, ?)";

	    try {
	        connection = ds.getConnection();
	        preparedStatement = connection.prepareStatement(insertSQL);
	        
	        // Converte java.util.Date a java.sql.Timestamp
	        Timestamp timestamp = new Timestamp(userOrder.getDateTime().getTime());
	        preparedStatement.setTimestamp(1, timestamp);
	        preparedStatement.setString(2, userOrder.getStatus());
	        preparedStatement.setDouble(3, userOrder.getTotal());
	        preparedStatement.setString(4, userOrder.getUsername());

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
				UserOrderDAODataSource.TABLE_NAME + " WHERE USERNAME = ?";
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
	public UserOrderBean doRetrieveByKey(String username) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		UserOrderBean bean = new UserOrderBean();
		String selectSQL = "SELECT * FROM " + UserOrderDAODataSource.TABLE_NAME + " WHERE USERNAME = ?";
		try {
			connection = ds.getConnection();	
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				bean.setId(rs.getInt("ID"));
				bean.setDateTime(rs.getDate("date_time"));;
				bean.setStatus(rs.getString("status"));
				bean.setTotal(rs.getDouble("TOTAL"));
				bean.setUsername(rs.getString("USERNAME"));
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
	public Collection<UserOrderBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<UserOrderBean> Orders = new LinkedList<UserOrderBean>();

		String selectSQL = "SELECT * FROM " + UserOrderDAODataSource.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				UserOrderBean bean = new UserOrderBean();

				bean.setId(rs.getInt("ID"));
				bean.setDateTime(rs.getDate("date_time"));;
				bean.setStatus(rs.getString("status"));
				bean.setTotal(rs.getDouble("TOTAL"));
				bean.setUsername(rs.getString("USERNAME"));
				Orders.add(bean);
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
		return Orders;
	}
	
	@Override
	public Collection<UserOrderBean> doRetrieveByUsername(String order, String username) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<UserOrderBean> Orders = new LinkedList<UserOrderBean>();

		String selectSQL = "SELECT * FROM " + UserOrderDAODataSource.TABLE_NAME + " WHERE USERNAME = '"
				+ username +"'";

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				UserOrderBean bean = new UserOrderBean();

				bean.setId(rs.getInt("ID"));
				bean.setDateTime(rs.getDate("date_time"));;
				bean.setStatus(rs.getString("status"));
				bean.setTotal(rs.getDouble("TOTAL"));
				bean.setUsername(rs.getString("USERNAME"));
				Orders.add(bean);
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
		return Orders;
	}
}
