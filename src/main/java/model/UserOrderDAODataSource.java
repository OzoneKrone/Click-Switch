package model;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model.UserBean;
import model.UserBeanDAO;
import model.UserOrderBean;
import model.UserOrderDAO;

import java.sql.*;
import java.util.*;
import java.util.Date;

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
	public int doSave(UserOrderBean userOrder) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet generatedKeys = null;

        String insertSQL = "INSERT INTO " + TABLE_NAME + " (date_time, status, total, username) VALUES (?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setTimestamp(1, new java.sql.Timestamp(userOrder.getDateTime().getTime()));
            preparedStatement.setString(2, userOrder.getStatus());
            preparedStatement.setDouble(3, userOrder.getTotal());
            preparedStatement.setString(4, userOrder.getUsername());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating user order failed, no rows affected.");
            }

            generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);
                userOrder.setId(orderId); // Imposta l'ID generato sull'oggetto UserOrderBean
                return orderId;
            } else {
                throw new SQLException("Creating user order failed, no ID obtained.");
            }
        } finally {
            if (generatedKeys != null) {
                generatedKeys.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
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
	public UserOrderBean doRetrieveByKey(int orderId) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		UserOrderBean bean = new UserOrderBean();
		String selectSQL = "SELECT * FROM " + UserOrderDAODataSource.TABLE_NAME + " WHERE id = ?";
		try {
			connection = ds.getConnection();	
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, orderId);
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
	
	public Collection<UserOrderBean> doRetrieveByDateRange(Date startDate, Date endDate) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + UserOrderDAODataSource.TABLE_NAME + " WHERE 1=1";
        if (startDate != null) {
            selectSQL += " AND date_time >= ?";
        }
        if (endDate != null) {
            selectSQL += " AND date_time <= ?";
        }

        List<UserOrderBean> orders = new ArrayList<>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            int paramIndex = 1;
            if (startDate != null) {
                preparedStatement.setDate(paramIndex++, new java.sql.Date(startDate.getTime()));
            }
            if (endDate != null) {
                preparedStatement.setDate(paramIndex++, new java.sql.Date(endDate.getTime()));
            }

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                UserOrderBean bean = new UserOrderBean();
                // Popola il bean con i dati del ResultSet
                bean.setId(rs.getInt("id"));
                bean.setUsername(rs.getString("username"));
                bean.setDateTime(rs.getTimestamp("date_time"));
                bean.setStatus(rs.getString("status"));
                bean.setTotal(rs.getDouble("total"));
                orders.add(bean);
            }

        } finally {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        }
        return orders;
    }

    public Collection<UserOrderBean> doRetrieveByUsernameAndDateRange(String username, Date startDate, Date endDate) throws SQLException {
    	if(username == null || username == "") {
    		return this.doRetrieveByDateRange(startDate, endDate);
    	}
    	
    	Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + UserOrderDAODataSource.TABLE_NAME + " WHERE username = ?";
        if (startDate != null) {
            selectSQL += " AND date_time >= ?";
        }
        if (endDate != null) {
            selectSQL += " AND date_time <= ?";
        }

        List<UserOrderBean> orders = new ArrayList<>();

        try {
            connection = ds. getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, username);

            int paramIndex = 2;
            if (startDate != null) {
                preparedStatement.setDate(paramIndex++, new java.sql.Date(startDate.getTime()));
            }
            if (endDate != null) {
                preparedStatement.setDate(paramIndex++, new java.sql.Date(endDate.getTime()));
            }

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                UserOrderBean bean = new UserOrderBean();
                // Popola il bean con i dati del ResultSet
                bean.setId(rs.getInt("id"));
                bean.setUsername(rs.getString("username"));
                bean.setDateTime(rs.getTimestamp("date_time"));
                bean.setStatus(rs.getString("status"));
                bean.setTotal(rs.getDouble("total"));
                orders.add(bean);
            }

        } finally {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        }
        return orders;
    }
}
