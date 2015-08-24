<%@page import="java.util.List"%>
<%@page import="project.dme.beans.User"%>
<%@page import="project.dme.beans.CartItem"%>
<%@page import="project.dme.beans.Order"%>
<%@page import="project.dme.beans.Address"%>
<%@page import="project.dme.beans.CartItem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <title>Orders | Deals Made Easy</title>
        <myTags:headscriptnstyle/>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String ost = (String) request.getAttribute("ost");
            List<Order> orders = user.getOrders();
        %>
        <myTags:header/>
        <section>
            <div class="container">
                <%
                    if (ost != null) {
                %>
                <h2 class="title text-center"><%= ost%></h2>
                <%
                    }
                %>
                <div class="col-sm-12">
                    <%
                        for (Order ob : orders) {
                            List<CartItem> items = ob.getItems();
                            Address ad = ob.getAddress();
                    %>
                    <br/>
                    <br/>
                    <div class="row orders">
                        <div class="col-sm-3">
                            <div class="product-image-wrapper">
                                <div class="single-products">
                                    <h5><%= ob.getOrderID()%></h5>
                                    <p><b>Order placed on : </b><%=ob.getPlacedOn()%></p>
                                    <p><b>Expected delivery date : </b><%=ob.getExpectedDeliveryDate()%></p>
                                    <%
                                        if (ob.getDeliveredOn() != null){
                                    %>
                                    <p><b>Delivered on : </b><%=ob.getDeliveredOn()%></p>
                                    <%
                                        }
                                    %>
                                    <p><b>Shipping address : </b></p>
                                    <p><%=ad.getName()%></p>
                                    <p><%=ad.getState()%></p>
                                    <p><%=ad.getZIP()%></p>
                                    <p><%=ad.getCountry()%></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-9">
                            <div class="order">
                                <%
                                    for (CartItem cib : items) {
                                %>
                                <div class="cart-item">
                                    <div class="cart-item-image"><img src="image/thumbnails/<%=cib.getThumbnail()%>" height="150" onerror="if (this.src != 'image/thumbnails/missing.png') this.src = 'image/thumbnails/missing.png';">
                                    </div>
                                    <div class="cart-item-description">
                                        <a href="Product?pid=<%=cib.getProductID()%>"><h4><%=cib.getName()%></h4></a>
                                        <h5><%=cib.getMaker()%></h5>
                                    </div>
                                    <div class="cart-item-price">
                                        <h5>₹ <%=cib.getPrice()%></h5>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>
        <myTags:footer/>
        <myTags:postscripts/>
    </body>
</html>
