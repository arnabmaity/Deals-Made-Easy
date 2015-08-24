<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="modal-overlay"></div>
<header id="header"><!--header-->
    <div class="header_top"><!--header_top-->
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <div class="contactinfo">
                        <ul class="nav nav-pills">
                            <li><a href="#"><i class="fa fa-phone"></i> +91 95 XX 88 XX1</a></li>
                            <li><a href="#"><i class="fa fa-envelope"></i> admin@dealsmadeeasy.com</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6">
                </div>
            </div>
        </div>
    </div><!--/header_top-->

    <div class="header-middle"><!--header-middle-->
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="logo pull-left companyinfo">
                        <a href="HomePage.jsp">
                            <h2><span>D</span>eals <span>M</span>ade <span>E</span>asy</h2>
                        </a>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="shop-menu pull-right">
                        <ul class="nav navbar-nav">
                            <li><a href="ShowOrders" id="show_orders_link"><i class="fa fa-crosshairs"></i> Orders</a></li>
                            <li><a href="#" id="cartview"><i class="fa fa-shopping-cart"></i> Cart</a>
                                <section id="cart_items">
                                    <div class="container">
                                        <div id="cart_info">
                                            <header id="cart-header">
                                                <div class="popup-close-button"><a href="#" id="cart-popup-close"><i class="fa fa-times"></i></a></div>
                                            </header>
                                        </div>
                                    </div>
                                </section>
                            </li>
                            <c:choose>
                                <c:when test="${sessionScope.loggedIn eq null or sessionScope.loggedIn eq false}">
                                    <li id="login"><a href="#" id="lilink"><i class="fa fa-lock"></i> Login / Sign Up</a>
                                        <section id="loginform"><!--form-->
                                            <div class="container">
                                                <div class="popup-close-button"><a href="#" id="login-popup-close"><i class="fa fa-times"></i></a></div>
                                                <div class="row">
                                                    <div class="col-sm-4 col-sm-offset-1" id="li">
                                                        <div class="login-form"><!--login form-->
                                                            <h2>Login to your account</h2>
                                                            <form action="Login" id="form-login">
                                                                <input type="email" placeholder="Email ID" id="login-username" name="username"/>
                                                                <input type="password" placeholder="Password" id="login-password" name="password"/>
                                                                <span>
                                                                    <input type="checkbox" class="checkbox" id="login-rememberMe" name="rememberMe"> 
                                                                    Keep me signed in
                                                                </span>
                                                                <button type="submit" class="btn btn-default">Login</button>
                                                            </form>
                                                        </div><!--/login form-->
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <h2 class="orIcon">OR</h2>
                                                    </div>
                                                    <div class="col-sm-4" id="reg">
                                                        <div class="signup-form" method="get" action="cart"><!--sign up form-->
                                                            <h2>New User Sign Up!</h2>
                                                            <form action="Register" method="post">
                                                                <input type="text" name="name" id="firstName" placeholder="Name" required/>
                                                                <p id="name-error-msg"></p>
                                                                <input type="email" name="username" id="reg-username" placeholder="Email Address" required/>
                                                                <p id="email-msg"></p>
                                                                <input type="password" name="password" id="reg-password" placeholder="Password" required/>
                                                                <p id="pass-error-msg"></p>
                                                                <input type="password" name="cpassword" id="reg-cpassword" placeholder="Confirm Password" required/>
                                                                <input type="text" name="contactNo" placeholder="Contact No."/>
                                                                <table>
                                                                    <tr>
                                                                        <td><label>Date of Birth (YYYY-MM-DD) </label></td>
                                                                        <td class="field"><input type="text" id="reg-dob" name="DOB" required/></td>
                                                                    </tr>
                                                                    <tr><td colspan="2" id="date-error-msg"><td></tr>
                                                                    <tr>
                                                                        <td><label>SEX</label></td>
                                                                        <td class="field">
                                                                            <select name="sex" id="reg-sex" required>
                                                                                <option value="F">Female</option>
                                                                                <option value="M">Male</option>
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <br/>
                                                                <table>
                                                                    <tr>
                                                                        <td><button type="submit" id="reg-submit" class="btn btn-default">Sign Up</button></td>
                                                                        <td><button type="Reset" class="btn btn-default">Clear</button></td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                        </div><!--/sign up form-->
                                                    </div>
                                                </div>
                                            </div>
                                        </section>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <c:catch>
                                        <li><a href="ShowUserDetails"><i class="fa fa-user"></i> Hello <%
                                            project.dme.beans.User user = (project.dme.beans.User)session.getAttribute("user");
                                            if(user != null)
                                                out.println(user.getName().split(" ")[0]);
                                            else
                                                out.println("guest");
                                        %> !</a></li>
                                        <li><a href="Logout" id="logout-link">Log Out</a></li>
                                        </c:catch>
                                    </c:otherwise>
                                </c:choose>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div><!--/header-middle-->

    <div class="header-bottom"><!--header-bottom-->
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="mainmenu pull-left">
                        <ul class="nav navbar-nav collapse navbar-collapse">
                            <li><a href="HomePage.jsp">Home</a></li>
                            <li><a href="ShowAllOfACat?pcat=BOOK">Books</a></li>
                            <li class="dropdown"><a>Electronics<i class="fa fa-angle-down"></i></a>
                                <ul role="menu" class="sub-menu">
                                    <li><a href="ShowAllOfACat?pcat=COMP">Computers</a></li>
                                    <li><a href="ShowAllOfACat?pcat=MOBILE">Mobile Phones And Tabs</a></li>
                                    <li><a href="ShowAllOfACat?pcat=COMP_ACC">Computer And Mobile Accessories</a></li>
                                    <li><a href="ShowAllOfACat?pcat=ELEC">Other Electronics</a></li>
                                </ul>
                            </li>  
                        </ul>
                    </div>
                </div>
                <div class="search_box col-sm-8">
                    <div class="pull-right">
                        <form method="GET" action="SearchProduct">
                            <table>
                                <tr>
                                    <td>
                                        <select id="srch_catagory" name="scat">
                                            <option value="">Select category</option>
                                            <option value="BOOK">Books</option>
                                            <option value="COMP">Computers</option>
                                            <option value="MOBILE">Mobile Phones And Tabs</option>
                                            <option value="COMP_ACC">Computer And Mobile Accessories</option>
                                            <option value="ELEC">Other Electronics</option>
                                        </select>
                                    </td>
                                    <td>
                                        <select id="srch_condition" name="condition">
                                            <option value="NEW">New</option>
                                            <option value="USED">Used</option>
                                        </select>
                                    </td>
                                    <td><input name="search_key" type="text" placeholder="Search" required/></td>
                                    <td><input type="submit" value="Search" class="btn btn-default"/></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div><!--/header-bottom-->
</header>
