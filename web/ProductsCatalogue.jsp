<%@page import="java.util.List"%>
<%@page import="project.dme.beans.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <title>Products | Deals Made Easy</title>
        <myTags:headscriptnstyle/>
        <style>
            .shortdesc {
                display: block;
                height: 100px;
                overflow-y: scroll;
            }
            .prdimg {
                display: block;
                height : 200px;
                width: 253px;
            }
            .prdimg img {
                max-height: 200px;
                max-width: 253px;
                width: auto;
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
                            String search = (String) request.getAttribute("search");
                            if (search != null) {
                        %>
                        <div class="features_items">
                            <h4>Search result for <b>"<%=search%>"</b></h4>
                        </div>
                        <%
                            }
                            List<Product> products = (List<Product>) request.getAttribute("products");
                            if (products != null) {
                        %>
                        <div class="features_items"><!--features_items-->
                            <br/>
                            <%
                                  for (Product product : products) {
                            %>
                            <div class="col-sm-3">
                                <div class="product-image-wrapper">
                                    <div class="single-products">
                                        <div class="productinfo text-center">
                                            <div class="prdimg">
                                                <img src="image/thumbnails/<%= product.getThumbnail()%>" onerror="if (this.src != 'image/thumbnails/missing.png') this.src = 'image/thumbnails/missing.png';"/>
                                            </div>
                                            <div  class="shortdesc">
                                                <h4><%= product.getName()%></h4>
                                                <h5>₹ <%= product.getPrice()%></h5>
                                                <p><%= product.getShortDesc()%></p>
                                                <%
                                                    String brand = "Brand";
                                                    if(product.getCategory().equalsIgnoreCase("BOOK")) {
                                                        brand = "Author";
                                                    }
                                                %>
                                                <p><%=brand%> : <%= product.getMaker()%></p>
                                                <p>Condition : <%= product.getCondition()%></p>
                                            </div>
                                            <br/>
                                            <a href="ShowProduct?pid=<%=product.getProductID()%>" class="btn btn-default add-to-cart">View Product Details</a>
                                        </div>
                                    </div>
                                </div>
                            </div><!--features_items-->
                                <%
                                }
                                %>
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
