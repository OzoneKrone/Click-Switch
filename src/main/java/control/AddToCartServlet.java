package control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ProductBean;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();

        // Recupera il carrello dalla sessione, se esiste, altrimenti crea uno nuovo
        @SuppressWarnings("unchecked")
		Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        // Aggiungi il prodotto al carrello
        if (cart.containsKey(productId)) {
            cart.put(productId, cart.get(productId) + 1);
        } else {
            cart.put(productId, 1);
        }

        // Salva il carrello nella sessione
        session.setAttribute("cart", cart);

        // Reindirizza alla pagina del carrello
        response.sendRedirect("viewCart.jsp");
    }
}
