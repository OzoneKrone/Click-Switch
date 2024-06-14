package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ProductBean;
import control.ProductDAODataSource;

/**
 * Servlet implementation class ViewCartServlet
 */
@WebServlet("/ViewCartServlet")
public class ViewCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewCartServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        ProductDAODataSource productDAO = new ProductDAODataSource();
        Map<ProductBean, Integer> productsInCart = new HashMap<>();

        try {
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                ProductBean product = productDAO.doRetrieveByKey(entry.getKey());
                if (product != null) {
                    productsInCart.put(product, entry.getValue());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("productsInCart", productsInCart);
        request.getRequestDispatcher("/viewCart.jsp").forward(request, response);
    }
}
