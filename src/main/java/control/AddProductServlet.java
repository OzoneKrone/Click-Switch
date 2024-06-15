package control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.ProductBean;
import model.ProductDAODataSource;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProduct")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
	    maxFileSize = 1024 * 1024 * 10,       // 10 MB
	    maxRequestSize = 1024 * 1024 * 15     // 15 MB
	)

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
		Part filePart = request.getPart("image");
		
		if (name == null || price == 0 || description == null || quantity == 0 ||
	            name.trim().isEmpty() || description.trim().isEmpty() || filePart == null
	            || filePart.getSize() == 0) {
	            request.setAttribute("error", "Tutti i campi obbligatori devono essere compilati");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }
		
		String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        if (!uploadDir.exists()) {
            if (uploadDir.mkdir()) {
                System.out.println("Directory created: " + uploadPath);
            } else {
                System.out.println("Failed to create directory: " + uploadPath);
            }
        }
        
        String fileName = filePart.getSubmittedFileName();
        String filePath = uploadPath + File.separator + fileName;
        
        System.out.println("Uploading file to: " + filePath);

        try {
            filePart.write(filePath);
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore durante il caricamento del file.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addProduct.jsp");
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
		product.setImageUrl("images/" + fileName); // Imposta il percorso dell'immagine
		
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
