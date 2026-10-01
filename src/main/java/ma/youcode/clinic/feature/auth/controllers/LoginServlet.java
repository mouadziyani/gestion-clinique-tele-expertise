package ma.youcode.clinic.feature.auth.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.clinic.feature.auth.service.AuthService;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.UserRole;
import java.util.UUID;
import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private AuthService authService ;

    @Override
    public void init() throws ServletException {

        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String csrfToken= UUID.randomUUID().toString();
        req.getSession().setAttribute("csrfToken", csrfToken);
        req.setAttribute("csrfToken", csrfToken);
        req.getRequestDispatcher("/auth/login.jsp").forward(req , resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tokenForm = req.getParameter("csrfToken");
        String tokenSession = (String) req.getSession().getAttribute("csrfToken");

        if (tokenForm == null || tokenSession == null || !tokenForm.equals(tokenSession)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        req.getSession().removeAttribute("csrfToken");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = authService.login(username, password);

        if(user == null){
            req.setAttribute("error", "Username ou password incorrect");

            String csrfToken = UUID.randomUUID().toString();
            req.getSession().setAttribute("csrfToken", csrfToken);
            req.setAttribute("csrfToken", csrfToken);

            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
            return;
        }

        req.getSession().setAttribute("user", user);

        if (user.getRole() == UserRole.GENERALIST) {
            resp.sendRedirect(req.getContextPath() + "/generalist/home");
        } else if (user.getRole() == UserRole.NURSE) {
            resp.sendRedirect(req.getContextPath() + "/nurse/home");
        }
    }
}
