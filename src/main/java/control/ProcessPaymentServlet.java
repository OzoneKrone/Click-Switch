package control;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ProductBean;
import model.ProductDAODataSource;
import model.UserBean;
import model.UserOrderBean;
import model.UserOrderDAODataSource;
import model.OrderItemBean;
import model.OrderItemDAODataSource;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Simula la ricezione dei dati di pagamento dal form
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String cardHolderName = request.getParameter("cardHolderName");

        // Simula la logica di elaborazione del pagamento
        boolean paymentSuccess = true;  // Simula un pagamento sempre riuscito

        if (paymentSuccess) {
            // Ottieni il carrello dalla sessione
            HttpSession session = request.getSession(false);
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            UserBean user = (UserBean) session.getAttribute("currentUser");
            String username = user.getUsername();
            double total = 0.0;

            // Calcola il totale dell'ordine
            ProductDAODataSource productDAO = new ProductDAODataSource();
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();
                try {
                    ProductBean product = productDAO.doRetrieveByKey(productId);
                    total += product.getPrice() * quantity;
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            // Salva l'ordine nella tabella user_order
            UserOrderBean order = new UserOrderBean();
            order.setDateTime(new Timestamp(System.currentTimeMillis()));
            order.setStatus("placed");
            order.setTotal(total);
            order.setUsername(username);

            UserOrderDAODataSource orderDAO = new UserOrderDAODataSource();
            try {
                int orderID = orderDAO.doSave(order);
                // Salva gli articoli dell'ordine nella tabella order_items e aggiorna le quantità dei prodotti
                OrderItemDAODataSource orderItemDAO = new OrderItemDAODataSource();
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    int productId = entry.getKey();
                    int quantity = entry.getValue();
                    ProductBean product = productDAO.doRetrieveByKey(productId);
                    
                    // Salva i dettagli dell'articolo dell'ordine
                    OrderItemBean orderItem = new OrderItemBean();
                    orderItem.setProductId(productId);
                    orderItem.setOrderId(orderID);
                    orderItem.setName(product.getName());
                    orderItem.setPrice(product.getPrice());
                    orderItem.setQuantity(quantity);
                    orderItemDAO.doSave(orderItem);

                    // Aggiorna la quantità del prodotto nel database
                    productDAO.updateQuantity(productId, product.getQuantity() - quantity);
                }

                // Svuota il carrello
                session.removeAttribute("cart");

                // Reindirizza alla pagina di conferma del pagamento
                response.sendRedirect("paymentConfirmation.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("checkout.jsp?error=paymentFailed");
            }
        } else {
            // Gestisci il caso di pagamento fallito (facoltativo)
            response.sendRedirect("checkout.jsp?error=paymentFailed");
        }
    }
}
