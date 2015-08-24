package project.dme.beans;

import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class User {

    private String username, name, contactNo, password;
    private Date DOB;
    private char sex;

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return this.username;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setDOB(Date DOB) {
        this.DOB = DOB;
    }

    public Date getDOB() {
        return this.DOB;
    }

    public void setSex(char sex) {
        this.sex = sex;
    }

    public char getSex() {
        return this.sex;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getContactNo() {
        return this.contactNo;
    }

    public boolean injectUserData(String username) {
        boolean ret = true;
        try (Connection conn = ConnectionManager.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM USERS WHERE USERNAME = '" + username + "'");
            if (rs.next()) {
                name = rs.getString("NAME");
                DOB = rs.getDate("DOB");
                sex = rs.getString("SEX").charAt(0);
                contactNo = rs.getString("PH_NO");
                this.username = username;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            ret = false;
        }
        return ret;
    }
    private static final String PBKDF2_ALGORITHM = "PBKDF2WithHmacSHA512";
    private static final int SALT_BYTE_SIZE = 24;
    private static final int PBKDF2_ITERATIONS = 1000;

    private String generateSaltedHash(String password) {
        SecureRandom sr = new SecureRandom();
        byte salt[] = new byte[24];
        sr.nextBytes(salt);
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, PBKDF2_ITERATIONS, SALT_BYTE_SIZE * 8);
        SecretKeyFactory skf = null;
        try {
            skf = SecretKeyFactory.getInstance(PBKDF2_ALGORITHM);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        byte[] hash = null;
        try {
            if (skf != null) {
                hash = skf.generateSecret(spec).getEncoded();
            }
        } catch (InvalidKeySpecException e) {
            e.printStackTrace();
        }
        return PBKDF2_ITERATIONS + ":" + toHex(salt) + ":" + toHex(hash);
    }

    private String toHex(byte[] array) {
        BigInteger bi = new BigInteger(1, array);
        String hex = bi.toString(16);
        int paddingLength = (array.length * 2) - hex.length();
        if (paddingLength > 0) {
            return String.format("%0" + paddingLength + "d", 0) + hex;
        } else {
            return hex;
        }
    }

    public boolean registerUser() {
        boolean ret = false;
        try (Connection conn = ConnectionManager.getConnection()) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT USERNAME FROM USERS WHERE USERNAME = ?");
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (!rs.next()) {
                pstmt = conn.prepareStatement("INSERT INTO USERS VALUES (?, ?, ?, ?, ?, ?)");
                pstmt.setString(1, username);
                pstmt.setString(2, name);
                pstmt.setDate(3, DOB);
                pstmt.setString(4, sex + "");
                pstmt.setString(5, contactNo);
                pstmt.setString(6, generateSaltedHash(password));
                if (pstmt.executeUpdate() == 1) {
                    ret = true;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ret;
    }

    public boolean addAddress(Address address) {
        boolean ret = false;
        try (Connection conn = ConnectionManager.getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery("SELECT ('AD' || TRIM(TO_CHAR(ADDRESS_ID_GENERATOR.NEXTVAL, 'XXXXXXXXXXXXXXXX'))) FROM DUAL");
            rs.next();
            String addressID = rs.getString(1);
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO ADDRESSES VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setString(8, username);
            pstmt.setString(1, addressID);
            pstmt.setString(2, address.getName());
            pstmt.setString(3, address.getAddress());
            pstmt.setString(4, address.getState());
            pstmt.setString(6, address.getZIP());
            pstmt.setString(5, address.getCountry());
            pstmt.setString(7, address.getContact());
            address.setAddressId(addressID);
            if (pstmt.executeUpdate() == 1) {
                ret = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ret;
    }

    public List<Address> getAddresses() {
        List<Address> addresses = new ArrayList<>();
        try (Connection conn = ConnectionManager.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM ADDRESSES WHERE USERNAME = '" + username + "'");
            while (rs.next()) {
                Address address = new Address();
                address.setAddressId(rs.getString("ADDRESS_ID"));
                address.setName(rs.getString("NAME"));
                address.setAddress(rs.getString("ADDRESS"));
                address.setState(rs.getString("STATE"));
                address.setZIP(rs.getString("ZIP"));
                address.setCountry(rs.getString("COUNTRY"));
                address.setContact(rs.getString("PH_NO"));
                address.setUsername(rs.getString("USERNAME"));
                addresses.add(address);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return addresses;
    }

    public List<CartItem> getCart() {
        List<CartItem> cart = new ArrayList<>();
        try (Connection conn = ConnectionManager.getConnection()) {
            String sql = "SELECT C.PRODUCT_ID, NAME, MAKER, PRICE, SHORT_STRING, THUMBNAIL"
                    + " FROM PRODUCTS P, CART_ITEMS C"
                    + " WHERE P.PRODUCT_ID = C.PRODUCT_ID AND C.USERNAME = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductID(rs.getString("PRODUCT_ID"));
                item.setName(rs.getString("NAME"));
                item.setMaker(rs.getString("MAKER"));
                item.setShortDesc(rs.getString("SHORT_STRING"));
                item.setPrice(rs.getDouble("PRICE"));
                item.setThumbnail(rs.getString("THUMBNAIL"));
                cart.add(item);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return cart;
    }

    public boolean addCartItem(String pid) {
        boolean ret = false;
        try (Connection conn = ConnectionManager.getConnection()) {
            Statement stmt = conn.createStatement();
            if (stmt.executeUpdate("INSERT INTO CART_ITEMS VALUES ('" + username + "', '" + pid + "')") == 1) {
                ret = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ret;
    }

    public boolean removeCartItem(String productID) {
        boolean ret = false;
        if (productID != null) {
            try (Connection conn = ConnectionManager.getConnection()) {
                Statement stmt = conn.createStatement();
                if (stmt.executeUpdate("DELETE FROM CART_ITEMS WHERE PRODUCT_ID = '" + productID + "' AND USERNAME = '" + username + "'") == 1) {
                    ret = true;
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return ret;
    }

    public List<Order> getOrders() {
        List<Order> orders = new ArrayList<>();
        String lastOrderID = "";
        String orderID;
        try (Connection conn = ConnectionManager.getConnection()) {
            String sql = "SELECT O.ORDER_ID OID, STATUS,"
                    + " PLACED_ON, EXPECTED_DELIVERY_DATE, DELIVERED_ON,"
                    + " P.PRODUCT_ID PID, P.NAME PNAME, MAKER, THUMBNAIL, UNIT_PRICE,"
                    + " SHORT_STRING, A.NAME ANAME, ADDRESS, STATE, COUNTRY, ZIP, PH_NO"
                    + " FROM ORDERS O, ORDER_ITEMS OI, PRODUCTS P, ADDRESSES A WHERE"
                    + " A.ADDRESS_ID = O.ADDRESS_ID AND O.USERNAME = ?"
                    + " AND O.ORDER_ID = OI.ORDER_ID AND OI.PRODUCT_ID = P.PRODUCT_ID"
                    + " ORDER BY O.ORDER_ID DESC, PNAME DESC";
            System.out.println(sql);
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            Order o = null;
            ArrayList<CartItem> items = null;
            while (rs.next()) {
                orderID = rs.getString("OID");
                if (!orderID.equalsIgnoreCase(lastOrderID)) {
                    lastOrderID = orderID;
                    if (items != null && o != null) {
                        o.setItems(items);
                        orders.add(o);
                    }
                    o = new Order();
                    items = new ArrayList<>();
                    o.setOrderID(rs.getString("OID"));
                    o.setOrderStatus(rs.getString("STATUS"));
                    o.setPlacedOn(rs.getString("PLACED_ON"));
                    o.setExpectedDeliveryDate(rs.getString("EXPECTED_DELIVERY_DATE"));
                    o.setDeliveredOn(rs.getString("DELIVERED_ON"));
                    Address shAdd = new Address();
                    shAdd.setName(rs.getString("ANAME"));
                    shAdd.setAddress(rs.getString("ADDRESS"));
                    shAdd.setState(rs.getString("STATE"));
                    shAdd.setCountry(rs.getString("COUNTRY"));
                    shAdd.setZIP(rs.getString("ZIP"));
                    shAdd.setContact(rs.getString("PH_NO"));
                    o.setAddress(shAdd);
                }
                CartItem item = new CartItem();
                item.setProductID(rs.getString("PID"));
                item.setName(rs.getString("PNAME"));
                item.setMaker(rs.getString("MAKER"));
                item.setShortDesc(rs.getString("SHORT_STRING"));
                item.setPrice(rs.getDouble("UNIT_PRICE"));
                item.setThumbnail(rs.getString("THUMBNAIL"));
                if (o != null) {
                    o.setTotalAmount(o.getTotalAmount() + item.getPrice());
                }
                if (items != null) {
                    items.add(item);
                }
            }
            if (o != null && items != null) {
                o.setItems(items);
                orders.add(o);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    public int placeOrder(String addressId) {
        int ret = 0;
        try (Connection conn = ConnectionManager.getConnection()) {
            conn.setAutoCommit(false);
            try {
                Statement stmt = conn.createStatement();
                Statement stmt2 = conn.createStatement();
                String sql = "SELECT C.PRODUCT_ID PID, PRICE, SOLD_BY FROM CART_ITEMS C,"
                        + " PRODUCTS P WHERE C.USERNAME = '" + username + "' AND P.PRODUCT_ID = C.PRODUCT_ID";
                ResultSet rs = stmt.executeQuery(sql);
                System.out.println(sql);
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO ORDERS VALUES (?, ?, ?, ?, SYSDATE, SYSDATE + 7, ?)");
                PreparedStatement pstmt2 = conn.prepareStatement("INSERT INTO ORDER_ITEMS VALUES(?, ?, ?)");
                String soldBy = "";
                String oid = "";
                while (rs.next()) {
                    String nxtSoldBy = rs.getString("SOLD_BY");
                    if (!soldBy.equalsIgnoreCase(nxtSoldBy)) {
                        ResultSet rs2 = stmt2.executeQuery("SELECT ('OD' || TRIM(TO_CHAR(ORDER_ID_GENERATOR.NEXTVAL, 'XXXXXXXXXXXXXXXX'))) FROM DUAL");
                        rs2.next();
                        oid = rs2.getString(1);
                        rs2.close();
                        pstmt.setString(1, oid);
                        pstmt.setString(2, username);
                        pstmt.setString(3, addressId);
                        pstmt.setString(4, "CONFIRMED");
                        pstmt.setDate(5, null);
                        pstmt.addBatch();
                    }
                    pstmt2.setString(1, oid);
                    pstmt2.setString(2, rs.getString("PID"));
                    pstmt2.setDouble(3, rs.getDouble("PRICE"));
                    pstmt2.addBatch();
                }
                rs.close();
                stmt.close();
                stmt2.close();
                pstmt.executeBatch();
                int[] res = pstmt2.executeBatch();
                pstmt.close();
                pstmt2.close();
                for (int x : res) {
                    if (x >= 0) {
                        ret += x;
                    }
                }
                pstmt = conn.prepareStatement("DELETE FROM CART_ITEMS WHERE USERNAME = ?");
                pstmt.setString(1, username);
                pstmt.executeUpdate();
            } catch (SQLException ex) {
                conn.rollback();
                ex.printStackTrace();
            }
            conn.commit();
            conn.setAutoCommit(true);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ret;
    }
}
