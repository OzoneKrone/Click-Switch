package model;

import java.sql.SQLException;
import java.util.Collection;

public interface OrderItemDAO<T> {
	public void doSave(T bean) throws SQLException;

	//public boolean doDelete(String username) throws SQLException;

	public Collection<T> doRetrieveOrderItems(int orderId) throws SQLException;

	void doSave(OrderItemBean orderItem) throws SQLException;
}
