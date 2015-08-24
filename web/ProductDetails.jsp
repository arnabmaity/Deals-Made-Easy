<%@page import="java.util.List"%>
<%@page import="project.dme.beans.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <%
            Product p = (Product) request.getAttribute("product");
            List<String> images = p.getImages();
            String maker;
            if (p.getCategory().equalsIgnoreCase("BOOK")) {
                maker = "Publisher";
            } else {
                maker = "Brand";
            }
            int i = 0;
        %>
        <title><%= p.getName()%> | Deals Made Easy</title>
        <myTags:headscriptnstyle/>
        <style>
            #product-features {
                border : solid gray 1px;
            }
            .product-img-thumb {
                height : 120px;
                width : 90px;
            }
        </style>
    </head>
    <body>
        <myTags:header/>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12 padding-right">
                        <div class="product-details"><!--product-details-->
                            <div class="col-sm-4">
                                <div class="view-product">
                                    <img id="product-img" src="image/thumbnails/<%= p.getThumbnail()%>" onerror="if (this.src != 'image/thumbnails/missing.png') this.src = 'image/thumbnails/missing.png';" />
                                </div>
                                <div id="similar-product" class="carousel slide" data-ride="carousel">
                                    <!-- Wrapper for slides -->
                                    <div class="carousel-inner">
                                        <div class="item active">
                                            <img class="product-img-thumb" src="image/thumbnails/<%= p.getThumbnail()%>" onerror="if (this.src != 'image/thumbnails/missing.png') this.src = 'image/thumbnails/missing.png';"/>
                                            <%
                                                i = 1;
                                                for (String url : images) {
                                                    if (i == 0) {
                                            %>
                                            <div class="item">
                                                <%
                                                    }
                                                %>
                                                <img class="product-img-thumb" src="image/thumbnails/<%=url%>" onerror="if (this.src != 'image/thumbnails/missing.png') this.src = 'image/thumbnails/missing.png';"/>
                                                <%
                                                    i++;
                                                    if (i == 3) {
                                                %>
                                            </div>
                                            <%
                                                        i = 0;
                                                    }
                                                }
                                                if (i != 0) {
                                            %>
                                        </div>
                                        <%
                                            }
                                        %>

                                    </div>
                                    <!-- Controls -->
                                    <a class="left item-control" href="#similar-product" data-slide="prev">
                                        <i class="fa fa-angle-left"></i>
                                    </a>
                                    <a class="right item-control" href="#similar-product" data-slide="next">
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-sm-7">
                                <div class="product-information"><!--/product-information-->
                                    <h2><%= p.getName()%></h2>
                                    <div class="row">
                                        <div class="col-sm-7">
                                            <p><b>Short Description :</b> <%=p.getShortDesc()%></p>
                                            <p><b>Condition :</b> <%=p.getCondition()%></p>
                                            <span>
                                                <span>₹ <%=p.getPrice()%></span>
                                                <button type="button" class="btn btn-fefault cart" id="add-to-cart-btn">
                                                    <i class="fa fa-shopping-cart"></i>
                                                    Add to cart
                                                </button>
                                            </span>
                                            <p><b><%=maker%>:</b> <%=p.getMaker()%></p>
                                            <p><b>Sold by :</b> <%=p.getSellerName()%>(<%=p.getSoldBy()%>)</p>
                                        </div>
                                        <div class="col-sm-5">
                                            <p><b><%=p.getDescription()%></p>
                                        </div>
                                    </div>
                                </div><!--/product-information-->
                            </div>
                        </div><!--/product-details-->
                    </div>
                </div>
            </div>
        </section>
        <script>
            $(document).ready(function () {
                $('.product-img-thumb').hover(function (event) {
                    newUrl = event.target.src;
                    $('#product-img').attr("src", newUrl);
                });
                $('#add-to-cart-btn').click(function () {
                    $.ajax({
                        type: "GET",
                        url: "IsLoggedIn",
                        success: function (responseData) {
                            data = $.parseJSON(responseData);
                            if (data.loggedIn) {
                                addToCart(<%=p.getProductID()%>, 1);
                            } else {
                                $('#login a#lilink').click();
                            }
                        }
                    });
                });
            });
        </script>
        <myTags:footer/>
        <myTags:postscripts/>
    </body>
</html>
