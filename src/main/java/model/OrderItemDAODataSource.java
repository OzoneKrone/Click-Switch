package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import model.OrderItemBean;

public class OrderItemDAODataSource {
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
	
	private static final String TABLE_NAME = "clickswitch.order_items";

    public synchronized void doSave(OrderItemBean orderItem) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + TABLE_NAME + " (product_id, order_id, name, price, quantity) VALUES (?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setInt(1, orderItem.getProductId());
            preparedStatement.setInt(2, orderItem.getOrderId());
            preparedStatement.setString(3, orderItem.getName());
            preparedStatement.setDouble(4, orderItem.getPrice());
            preparedStatement.setInt(5, orderItem.getQuantity());

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

    // Altri metodi di accesso ai dati, se necessari, come doRetrieveByOrderId
}
