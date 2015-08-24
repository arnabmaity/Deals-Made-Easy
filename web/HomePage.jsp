<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <title>Home | E-Shopper</title>
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
            .circle {
                height: 200px;
                width: 200px;
                border-radius: 100px;
                text-align: center;
                color: #444;
            }
            #circle1 {
                background: #FDB45E;
                padding-top: 70px;
            }
            #circle2 {
                background: #66afe9;
                padding-top: 50px;
            }
            #circle3 {
                background: #6cb86c;
                padding-top: 70px;
            }
            #circle4 {
                background: #e499a0;
                padding-top: 40px;
            }
            #circle5 {
                background: #f6a828;
                padding-top: 50px;
            }
            .circle:hover {
                color: #FFFFFF;
            }
        </style>
    </head>
    <body>
        <myTags:header/>	
        <section id="slider"><!--slider-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <table>
                            <tr>
                                <td>
                                    <a href="ShowAllOfACat?pcat=MOBILE"><div class="circle" id="circle2">
                                        <h3>MOBILES & TABLETS</h3>
                                        </div></a>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <a href="ShowAllOfACat?pcat=BOOK"><div class="circle" id="circle1">
                                        <h3>BOOKS</h3>
                                        </div</a>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <a href="ShowAllOfACat?pcat=COMP"><div class="circle" id="circle3">
                                        <h3>LAPTOPS</h3>
                                        </div></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <a href="ShowAllOfACat?pcat=COMP_ACC"><div class="circle" id="circle4">
                                           <h3>COMPUTER & MOBILE ACCESSORIES</h3>
                                        </div></a>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <a href="ShowAllOfACat?pcat=ELEC"><div class="circle" id="circle5">
                                        <h3>OTHER ELECTRONICS</h3>
                                        </div></a>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </section><!--/slider-->
        <myTags:footer/>
        <myTags:postscripts/>
    </body>
</html>
