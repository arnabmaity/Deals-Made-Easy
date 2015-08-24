package project.dme.beans;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Product {

    private String productID, category, name, maker, shortDesc, description, soldBy, sellerName, condition;
    private double price;
    private String thumbnail;
    private List<String> images;

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    public String getSoldBy() {
        return soldBy;
    }

    public void setSoldBy(String soldBy) {
        this.soldBy = soldBy;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getImages() {
        return this.images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public String getMaker() {
        return maker;
    }

    public void setMaker(String maker) {
        this.maker = maker;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public boolean injectData(String pid) {
        boolean ret = false;
        if (pid != null) {
            try (Connection conn = ConnectionManager.getConnection()) {
                Statement stmt1 = conn.createStatement();
                ResultSet rs = stmt1.executeQuery("SELECT"
                        + " PRODUCT_ID, CATEGORY, P.NAME PNAME, MAKER,"
                        + " PRICE, SHORT_STRING, BRIEF_DESC,"
                        + " THUMBNAIL, SOLD_BY, CONDITION, U.NAME UNAME FROM PRODUCTS P,"
                        + " USERS U WHERE PRODUCT_ID = '" + pid + "'"
                        + " AND USERNAME = SOLD_BY");
                if (rs.next()) {
                    this.productID = rs.getString("PRODUCT_ID");
                    this.name = rs.getString("PNAME");
                    this.category = rs.getString("CATEGORY");
                    this.maker = rs.getString("MAKER");
                    this.price = rs.getDouble("PRICE");
                    this.shortDesc = rs.getString("SHORT_STRING");
                    this.thumbnail = rs.getString("THUMBNAIL");
                    this.description = rs.getString("BRIEF_DESC");
                    this.soldBy = rs.getString("SOLD_BY");
                    this.sellerName = rs.getString("UNAME");
                    this.setCondition(rs.getString("CONDITION"));
                    images = new ArrayList<>();
                    try {
                        Statement stmt2 = conn.createStatement();
                        ResultSet img = stmt2.executeQuery("SELECT IMAGE FROM IMAGES WHERE PRODUCT_ID = '" + pid + "'");
                        while (img.next()) {
                            images.add(img.getString("IMAGE"));
                        }
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                    ret = true;
                }
            } catch (SQLException ex) {
                ret = false;
                ex.printStackTrace();
            }
        }
        return ret;
    }
}
