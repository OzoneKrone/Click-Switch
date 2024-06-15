package control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserBean;
import model.UserDAODataSource;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String address = request.getParameter("address");

        if (username == null || email == null || password == null || name == null ||
            username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || name.trim().isEmpty()) {
            request.setAttribute("error", "Tutti i campi obbligatori devono essere compilati");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
            return;
        }

        UserDAODataSource userDAO = new UserDAODataSource();
        UserBean user = new UserBean();
        user.setUsername(username);
        user.setEmail(email);
        // Crittografa la password prima di salvarla nel database
        String hashedPassword = hashPassword(password);
        user.setPassword(hashedPassword);
        user.setName(name);
        user.setAddress(address);
        user.setRole("user"); // Imposta il ruolo predefinito

        try {
            userDAO.doSave(user);
            response.sendRedirect("login.jsp"); // Reindirizza alla pagina di login dopo la registrazione
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore durante la registrazione. Riprova.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Metodo per crittografare la password utilizzando SHA-512
    private String hashPassword(String password) {
        try {
            java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-512");
            byte[] hash = digest.digest(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder hashString = new StringBuilder();
            for (byte b : hash) {
                hashString.append(String.format("%02x", b));
            }
            return hashString.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
