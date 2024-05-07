package model;

import java.io.Serializable;

public class ProductBean implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String name;
	private String description;
	private float price;
	private int quantity;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public float getPrice() {
		return price;
	}
	
	public void setPrice(float price) {
		this.price = price;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String toString() {
		return name + " [" + id + ", " + price + ", " + description + ", " + quantity + "]";
	}
}
