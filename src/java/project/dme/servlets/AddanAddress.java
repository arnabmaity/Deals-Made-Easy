package project.dme.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.Address;
import project.dme.beans.User;

public class AddanAddress extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Boolean loggedIn = (Boolean) request.getSession().getAttribute("loggedIn");
        if (loggedIn != null && loggedIn) {
            Address address = new Address();
            address.setName(request.getParameter("name"));
            address.setAddress(request.getParameter("address"));
            address.setState(request.getParameter("state"));
            address.setZIP(request.getParameter("ZIP"));
            address.setCountry(request.getParameter("country"));
            User user = (User) request.getSession().getAttribute("user");
            if (user.addAddress(address)) {
                request.setAttribute("addresses", user.getAddresses());
                request.getRequestDispatcher("PrepareOrder").forward(request, response);
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
