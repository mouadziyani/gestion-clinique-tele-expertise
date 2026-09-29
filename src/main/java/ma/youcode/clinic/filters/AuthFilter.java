package ma.youcode.clinic.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest reqs = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = reqs.getRequestURI();
        String context = reqs.getContextPath();
        String path = uri.substring(context.length());
        HttpSession session = reqs.getSession(false);

        boolean isLoggedIn  = session != null && session.getAttribute("user") != null;

        boolean isPublic = path.equals("/auth/login");

        if (isLoggedIn || isPublic) {
            chain.doFilter(request , response);
        } else {
            res.sendRedirect(context + "/auth/login");
        }
    }
}
