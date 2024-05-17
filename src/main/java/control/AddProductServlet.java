package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductBean;
import model.ProductDAODataSource;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProduct")
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		float price = Float.parseFloat(request.getParameter("price"));
		String description = request.getParameter("description");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		if (name == null || price == 0 || description == null || quantity == 0 ||
	            name.trim().isEmpty() || description.trim().isEmpty()) {
	            request.setAttribute("error", "Tutti i campi obbligatori devono essere compilati");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }
		
		ProductDAODataSource productDAO = new ProductDAODataSource();
		ProductBean product = new ProductBean();
		
		product.setName(name);
		product.setPrice(price);
		product.setDescription(description);
		product.setQuantity(quantity);
		product.setIsAvailable(true);
		
		try {
            productDAO.doSave(product);
            response.sendRedirect("listaProdotti.jsp"); // Reindirizza alla pagina di login dopo la registrazione
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore durante la registrazione. Riprova.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addProduct.jsp");
            dispatcher.forward(request, response);
        }
	}

}
