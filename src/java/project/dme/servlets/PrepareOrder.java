package project.dme.servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.User;
import project.dme.beans.Address;

public class PrepareOrder extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Boolean b = (Boolean) request.getSession().getAttribute("loggedIn");
        if(b != null && b) {
            List<Address> addresses = ((User)request.getSession().getAttribute("user")).getAddresses();
            request.setAttribute("addresses", addresses);
            request.getRequestDispatcher("PrepareOrder.jsp").forward(request, response);
        } else
            response.sendError(401);
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
