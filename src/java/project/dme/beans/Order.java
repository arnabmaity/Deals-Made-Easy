package project.dme.beans;

import java.util.ArrayList;

public class Order {

    private String orderID, orderStatus, placedOn, expectedDeliveryDate, delivaeredOn;
    private double totalAmount;
    private ArrayList<CartItem> items;
    private Address addres;

    public Address getAddress() {
        return this.addres;
    }

    public void setAddress(Address address) {
        this.addres = address;
    }

    public ArrayList<CartItem> getItems() {
        return this.items;
    }

    public void setItems(ArrayList<CartItem> items) {
        this.items = items;
    }

    public String getOrderID() {
        return this.orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderStatus() {
        return this.orderStatus;
    }

    public void setPlacedOn(String placedOn) {
        this.placedOn = placedOn;
    }

    public String getPlacedOn() {
        return this.placedOn;
    }

    public double getTotalAmount() {
        return this.totalAmount;
    }

    public void setExpectedDeliveryDate(String expectedDeliveryDate) {
        this.expectedDeliveryDate = expectedDeliveryDate;
    }

    public String getExpectedDeliveryDate() {
        return this.expectedDeliveryDate;
    }

    public void setDeliveredOn(String delivaeredOn) {
        this.delivaeredOn = delivaeredOn;
    }

    public String getDeliveredOn() {
        return this.delivaeredOn;
    }
}
