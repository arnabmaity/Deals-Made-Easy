package project.dme.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.User;

public class ShowOrders extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean loggedIn = (Boolean)request.getSession().getAttribute("loggedIn");
        if(loggedIn) {
            User user = (User)request.getSession().getAttribute("user");
            request.setAttribute("orders", user.getOrders());
            request.getRequestDispatcher("ShowOrders.jsp").forward(request, response);
        } else {
            response.sendError(401);
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
