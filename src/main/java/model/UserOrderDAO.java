package model;

import java.sql.SQLException;

import java.util.Collection;

public interface UserOrderDAO<T> {
	public int doSave(T bean) throws SQLException;

	public boolean doDelete(String username) throws SQLException;

	public T doRetrieveByKey(int orderId) throws SQLException;
	
	public Collection<T> doRetrieveAll(String order) throws SQLException;

	public Collection<T> doRetrieveByUsername(String order, String username) throws SQLException;
}
