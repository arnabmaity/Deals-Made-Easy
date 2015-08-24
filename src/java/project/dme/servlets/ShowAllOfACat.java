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

public class ShowAllOfACat extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cat = request.getParameter("pcat");
        if (cat != null && cat.length() != 0) {
            String sql = "SELECT * FROM PRODUCTS WHERE CATEGORY = '";
            if(cat.equalsIgnoreCase("BOOK"))
                sql = sql + "BOOK";
            else if(cat.equalsIgnoreCase("COMP"))
                sql = sql + "COMP";
            else if(cat.equalsIgnoreCase("MOBILE"))
                sql = sql + "MOBILE";
            else if(cat.equalsIgnoreCase("COMP_ACC"))
                sql = sql + "COMP_ACC";
            else if(cat.equalsIgnoreCase("ELEC"))
                sql = sql + "ELEC";
            sql = sql + "'";
            System.out.println(sql);
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
                request.setAttribute("products", products);
                request.getRequestDispatcher("ProductsCatalogue.jsp").forward(request, response);
            } catch(SQLException ex) {
                ex.printStackTrace();
                response.sendError(502);
            }
        } else {
            response.sendError(400);
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
