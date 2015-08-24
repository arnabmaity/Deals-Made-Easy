package project.dme.servlets;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.User;

public class Register extends HttpServlet {

    private User user;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = new User();
        String regMsg;
        if (request.getParameter("password").equals(request.getParameter("cpassword"))) {
            user.setUsername(request.getParameter("username"));
            user.setPassword(request.getParameter("password"));
            user.setName(request.getParameter("name"));
            user.setDOB(Date.valueOf(request.getParameter("DOB")));
            user.setSex(request.getParameter("sex").charAt(0));
            user.setContactNo(request.getParameter("contactNo"));
            if (user.registerUser()) {
                regMsg = "Registration is successfull. Log in to continue...";
            } else {
                regMsg = "Sorry, registration failed. Possiblly some invalid data was given. Please check and try again..";
            }
        } else {
            regMsg = "Sorry, registration failed. Passwords do not match. Try again..";
        }
        request.getRequestDispatcher("RegistrationMessage.jsp?regmsg=" + regMsg).forward(request, response);
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
