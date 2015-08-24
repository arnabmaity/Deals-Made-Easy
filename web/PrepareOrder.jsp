<%@page import="java.util.List"%>
<%@page import="project.dme.beans.Address"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <title>Check Out | Deals Made Easy</title>
        <myTags:headscriptnstyle/>
        <style>
            .shortdesc {
                display: block;
                height: 400px;
                width: 300px;
            }
            .shortdesc input, .shortdesc textarea {
                background: #F0F0E9;
                border: 0;
                color: #696763;
                padding: 5px;
                width: 100%;
                border-radius: 0;
                resize: none;
            }

        </style>
    </head>
    <body>
        <myTags:header/>
        <section>
            <div class="container">
                <div class="row">

                    <div class="col-sm-12">
                        <%
                            List<Address> addressList = (List<Address>) request.getAttribute("addresses");
                            if (addressList != null) {
                        %>
                        <div class="features_items"><!--features_items-->
                            <h2>Choose an address or add 1</h2>
                            <br/>
                            <%
                                for (Address address : addressList) {
                            %>
                            <form method="post" action="PlaceOrder">
                                <div class="col-sm-4">
                                    <div class="product-image-wrapper">
                                        <div class="single-products">
                                            <div class="productinfo text-center">
                                                <div  class="shortdesc">
                                                    <h4><%= address.getName()%></h4>
                                                    <p><%= address.getAddress()%></p>
                                                    <p><b>State:</b> <%= address.getState()%></p>
                                                    <p><b>ZIP:</b> <%= address.getZIP()%></p>
                                                    <p><b>Country:</b> <%= address.getCountry()%></p>
                                                    <span><label>Select this address: <input type="radio" name="addressID" required value="<%=address.getAddressId()%>"/></label></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <div class="col-sm-4">
                                    <div class="product-image-wrapper">
                                        <div class="single-products">
                                            <div class="productinfo text-center">
                                                <p><b>Contact email: </b><input type="email" name="emailID" required/></p>
                                                <h5>Choose payment method</h5>
                                                <p><b>Cash on Delivery &nbsp;&nbsp;</b><input type="radio" value="COD" name="paymentMethod"/></p>
                                                <p><b>Debit Card &nbsp;&nbsp;</b><input type="radio" value="DC" name="paymentMethod"/></p>
                                                <p><b>Credit Card &nbsp;&nbsp;</b><input type="radio" value="CC" name="paymentMethod"/></p>
                                                <p><b>Internet Banking &nbsp;&nbsp;</b><input type="radio" value="IB" name="paymentMethod"/></p>
                                                <input class="btn btn-default" type="submit" value="Place Order"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <%
                                }
                            %>
                            <div class="col-sm-4">
                                <div class="product-image-wrapper">
                                    <div class="single-products">
                                        <div class="productinfo text-center">
                                            <div  class="shortdesc">
                                                <form action="AddanAddress" method="post">
                                                    <input type="text" name="name" required placeholder="Name"/>
                                                    <br/>
                                                    <br/>
                                                    <textarea rows="5" cols="30" name="address" required placeholder="Full address here"></textarea>
                                                    <br/>
                                                    <br/>
                                                    <input type="text" name="state" required placeholder="State"/>
                                                    <br/>
                                                    <br/>
                                                    <input type="text" name="ZIP" required placeholder="ZIP"/>
                                                    <br/>
                                                    <br/>
                                                    <input type="text" name="country" required placeholder="Country"/>
                                                    <br/>
                                                    <br/>
                                                    <div class="row">
                                                        <div class="col-sm-5">
                                                            <input class="btn btn-default" type="submit" value="Add"/>
                                                        </div>
                                                        <div class="col-sm-5">
                                                            <input class="btn btn-default" type="reset" value="Clear"/>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--features_items-->
                    </div>
                </div>
            </div>
        </section>
        <myTags:footer/>
        <myTags:postscripts/>
    </body>
</html>

