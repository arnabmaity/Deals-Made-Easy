package project.dme.beans;

import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class LoginBean {

    private String username, password;
    private static final String PBKDF2_ALGORITHM = "PBKDF2WithHmacSHA512";
    private static final int SALT_BYTE_SIZE = 24;

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return this.username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return this.password;
    }
    
    private String generateSaltedHash(int iterations, byte[] salt, String password) {
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, iterations, SALT_BYTE_SIZE * 8);
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
        return toHex(hash);
    }

    private byte[] fromHex(String hex) {
        byte[] binary = new byte[hex.length() / 2];
        for (int i = 0; i < binary.length; i++) {
            binary[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
        }
        return binary;
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

    public boolean validateLogin() {
        String passwordComponents[] = null;
        String hash = null;
        boolean ret = false;
        try (Connection conn = ConnectionManager.getConnection()) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT PASSWORD FROM USERS WHERE USERNAME = ?");
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                System.out.println(rs.getString(1));
                passwordComponents = rs.getString(1).split(":");
                hash = generateSaltedHash(Integer.parseInt(passwordComponents[0]), fromHex(passwordComponents[1]), password);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (hash != null) {
            ret = hash.equalsIgnoreCase(passwordComponents[2]);
        }
        return ret;
    }
}
