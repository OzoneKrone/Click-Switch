package model;

import java.sql.SQLException;

import java.util.Collection;

public interface UserOrderDAO<T> {
	public void doSave(T bean) throws SQLException;

	public boolean doDelete(String username) throws SQLException;

	public T doRetrieveByKey(String username) throws SQLException;
	
	public Collection<T> doRetrieveAll(String order) throws SQLException;

	public Collection<T> doRetrieveByUsername(String order, String username) throws SQLException;
}
