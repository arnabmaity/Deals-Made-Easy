package project.dme.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.User;
import project.dme.beans.LoginBean;

public class Login extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LoginBean loginBean = new LoginBean();
        User user = new User();
        Boolean b = (Boolean) request.getSession().getAttribute("loggedIn");
        if (b == null || !b) {
            Cookie cookies[] = request.getCookies();
            boolean loggedInFlag = false;
            Cookie username = null;
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().equalsIgnoreCase("username")) {
                        username = c;
                        break;
                    }
                }
            }
            loginBean.setUsername(request.getParameter("username"));
            loginBean.setPassword(request.getParameter("password"));
            if (username != null) {
                loginBean.setUsername(username.getValue());
                loggedInFlag = true;
            }
            if (loggedInFlag || (loginBean.getUsername() != null && loginBean.getPassword() != null && loginBean.validateLogin())) {
                request.getSession();
                if (request.getParameter("rememberMe") != null) {
                    if (request.getParameter("rememberMe").equalsIgnoreCase("true")) {
                        Cookie u;
                        u = new Cookie("username", loginBean.getUsername());
                        u.setMaxAge(30 * 24 * 60 * 60);
                        response.addCookie(u);
                    }
                }
                request.getSession().setAttribute("loggedIn", true);
                if (user.injectUserData(loginBean.getUsername())) {
                    request.getSession().setAttribute("user", user);
                    try (PrintWriter writer = response.getWriter()) {
                        response.setContentType("text/html;UTF-8");
                        writer.write("{\"success\": true,\"obj\": {\"firstName\": \"" + user.getName().split(" ")[0] + "\"}}");
                    }
                } else {
                    request.getSession().invalidate();
                    try (PrintWriter writer = response.getWriter()) {
                        writer.write("{\"success\": false, \"message\":\"Failed to login due to some technical issues. please try later.\"}");
                    }
                }
            } else {
                loginBean.setUsername(null);
                loginBean.setPassword(null);
                response.setContentType("text/html;UTF-8");
                try (PrintWriter writer = response.getWriter()) {
                    writer.write("{\"success\": false, \"message\":\"Invalid Credentials\"}");
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(405);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
