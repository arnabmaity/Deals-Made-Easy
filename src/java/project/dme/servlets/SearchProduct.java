package project.dme.servlets;

import java.io.IOException;
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
import project.dme.beans.ConnectionManager;
import project.dme.beans.Product;

public class SearchProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchKey = request.getParameter("search_key");
        String scat = request.getParameter("scat");
        String condition = request.getParameter("condition");
        String scCopy = searchKey;
        if (searchKey == null || searchKey.length() == 0) {
            response.sendError(404);
        } else {
            searchKey = searchKey.replaceAll(" ", "|");
            String sql = "SELECT * FROM PRODUCTS WHERE PRODUCT_ID IN ("
                    + "(SELECT PRODUCT_ID FROM PRODUCTS WHERE CATSEARCH(NAME, '" + searchKey + "', '') > 0)"
                    + "UNION"
                    + "(SELECT PRODUCT_ID FROM PRODUCTS WHERE CATSEARCH(SHORT_STRING, '" + searchKey + "', '') > 0)"
                    + ") ";
            if (!(scat == null || scat.length() == 0)) {
                sql = sql + "AND CATEGORY LIKE '" + scat + "%' ";
                scCopy = scCopy + " with Catagory " + scat;
            }
            if (!(condition == null || condition.equalsIgnoreCase(""))) {
                sql = sql + "AND CONDITION = '" + condition + "' ";
                scCopy = scCopy + " and Condition " + condition;
            }
            System.out.println(sql);
            System.out.println(scCopy);
            try(Connection conn = ConnectionManager.getConnection()) {
                List<Product> products = new ArrayList<>();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                while(rs.next()) {
                    Product p = new Product();
                    p.setProductID(rs.getString("PRODUCT_ID"));
                    p.setName(rs.getString("NAME"));
                    p.setCategory(rs.getString("CATEGORY"));
                    p.setShortDesc(rs.getString("SHORT_STRING"));
                    p.setMaker(rs.getString("MAKER"));
                    p.setThumbnail(rs.getString("THUMBNAIL"));
                    p.setPrice(rs.getDouble("PRICE"));
                    p.setCondition(rs.getString("CONDITION"));
                    products.add(p);
                }
                request.setAttribute("search", scCopy);
                request.setAttribute("products", products);
                request.getRequestDispatcher("ProductsCatalogue.jsp").forward(request, response);
            } catch(SQLException ex) {
                ex.printStackTrace();
                response.sendError(502);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
