package ma.youcode.clinic.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.UserRole;

import java.io.IOException;

@WebFilter("/*")
public class RoleFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest reqs = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = reqs.getRequestURI();
        String context = reqs.getContextPath();
        String path = uri.substring(context.length());

        boolean isPublic = path.equals("/auth/login");

        if (isPublic) {
            chain.doFilter(request , response);
            return;
        }

        boolean isLogout = path.equals("/auth/logout");
        if (isLogout) {
            chain.doFilter(request , response);
            return;
        }

        HttpSession session = reqs.getSession(false);

        if (session == null) {
            res.sendRedirect(context + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            res.sendRedirect(context + "/auth/login");
            return;
        }

        String role = user.getRole().name();

        if (path.contains("/nurse") && role.equals(UserRole.NURSE.name())) {
            chain.doFilter(request, response);
            return;
        }

        if (path.contains("/generalist") && role.equals(UserRole.GENERALIST.name())) {
            chain.doFilter(request, response);
            return;
        }

        res.sendError(HttpServletResponse.SC_FORBIDDEN);
    }
}
