package project.dme.servlets;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.User;

public class AddToCart extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pid = request.getParameter("pid");
        String remove = request.getParameter("remove");
        response.setContentType("text/html;UTF-8");
        Gson gson = new Gson();
        Boolean b = (Boolean) request.getSession().getAttribute("loggedIn");
        if (b != null && b) {
            User user = (User) request.getSession().getAttribute("user");
            if (pid != null) {
                if (remove != null && remove.equalsIgnoreCase("on")) {
                    user.removeCartItem(pid);
                } else {
                    user.addCartItem(pid);
                }
            }
            try (PrintWriter writer = response.getWriter()) {
                writer.write(gson.toJson(user.getCart()));
                writer.close();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
