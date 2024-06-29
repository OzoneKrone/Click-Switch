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

public class OrderItemDAODataSource  implements OrderItemDAO<OrderItemBean>{
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
	
	@Override
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
    
    @Override
	public Collection<OrderItemBean> doRetrieveOrderItems(int orderId) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		Collection<OrderItemBean> items = new LinkedList<OrderItemBean>();
		
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE order_id = ?";
		try {
	        connection = ds.getConnection();    
	        preparedStatement = connection.prepareStatement(selectSQL);
	        preparedStatement.setInt(1, orderId);
	        ResultSet rs = preparedStatement.executeQuery();
	        while (rs.next()) {
	            OrderItemBean bean = new OrderItemBean(); // Creazione di un nuovo bean in ogni iterazione
	            bean.setProductId(rs.getInt("PRODUCT_ID"));
	            bean.setOrderId(rs.getInt("ORDER_ID"));
	            bean.setName(rs.getString("NAME"));
	            bean.setPrice(rs.getFloat("PRICE"));
	            bean.setQuantity(rs.getInt("QUANTITY"));
	            items.add(bean);
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
	    return items;
	}
}
