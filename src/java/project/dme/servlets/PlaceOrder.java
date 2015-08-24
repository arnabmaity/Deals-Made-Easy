package project.dme.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.User;

public class PlaceOrder extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Boolean loggedIn = (Boolean) request.getSession().getAttribute("loggedIn");
        if (loggedIn != null && loggedIn) {
            String addressID = request.getParameter("addressID");
            User user = (User) request.getSession().getAttribute("user");
            int status = -1;
            if (addressID != null) {
                status = user.placeOrder(addressID);
            }
            if (status >= 0) {
                request.setAttribute("ost", "Items are ordered! Check your orders below.");
                request.getRequestDispatcher("ShowOrders").forward(request, response);
            } else {
                response.sendError(502);
            }
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
