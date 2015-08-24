package project.dme.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.dme.beans.CartItem;
import project.dme.beans.ConnectionManager;
import project.dme.beans.User;

public class GetPendimgOrders extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Boolean loggedIn = (Boolean) request.getSession().getAttribute("loggedIn");
        if (loggedIn != null && loggedIn) {
            String username = ((User) request.getSession().getAttribute("user")).getName();
            List<CartItem> orders = new ArrayList<>();
            try (Connection conn = ConnectionManager.getConnection()) {
                Statement stmt = conn.createStatement();
                String sql = "SELECT O.ORDER_ID, PLACED_ON, P.PRODUCT_ID, NAME, PRICE"
                        + " FROM ORDERS O, PRODUCTS P, ORDER_ITEMS OI WHERE"
                        + " O.ORDER_ID = OI.ORDER_ID AND P.PRODUCT_ID = OI.PRODUCT_ID"
                        + " AND P.SOLD_BY = '" + username + "'";
                ResultSet rs = stmt.executeQuery(sql);
                request.setAttribute("rs", rs);
                request.getRequestDispatcher("SfowPendingOrders.jsp").forward(request, response);
            } catch (SQLException ex) {
                ex.printStackTrace();
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
