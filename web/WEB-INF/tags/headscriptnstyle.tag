<style>
    #modal-overlay {
        display: none;
        width: 100%;
        height: 100%;
        position: fixed;
        top: 0px;
        left: 0px;
        z-index: 5000;
        background: rgba(10, 10, 10, 0.4);
    }
    #cart_items {
        display : none;
        background : rgba(25,25,25,0.5);
        position : fixed;
        z-index : 99999;
        left : 200px;
        margin-top: 30px;
    }
    #cart_items .container {
        width : 950px;
        height : 500px;
    }
    #cart_items #cart_info {
        height : 460px;
        overflow-y : scroll;
        overflow-x : hidden;
        margin : 20px 0px 20px 0px;
        background : #FFFFFF;
    }
    #cart_items #cart_info::-webkit-scrollbar{
        width:3px;
        background-color:#FE980F;
    } 
    #cart_items #cart_info::-webkit-scrollbar-thumb{
        background-color:#BD8539;
        border-radius:10px;
    }
    #cart_items #cart_info::-webkit-scrollbar-thumb:hover{
        background-color:#BF4649;
        border:1px solid #333333;
    }
    #cart_items #cart_info::-webkit-scrollbar-thumb:active{
        background-color:#A6393D;
        border:1px solid #333333;
    }


    #loginform {
        display : none;
        position : fixed;
        left : 80px;
        z-index : 99999;
        background : rgba(25, 25, 25, 0.5);
        padding : 20px;
        margin-top: 30px;
    }
    #loginform .container {
        overflow-y : auto;
        height : 450px;
        background :#FFFFFF;
        padding-top: 20px;
        padding-bottom: 20px;
    }

    loginform .container::-webkit-scrollbar-thumb:active{
        background-color:#A6393D;
        border:1px solid #333333;
    }

    loginform .container::-webkit-scrollbar-thumb:hover{
        background-color:#BF4649;
        border:1px solid #333333;
    }

    loginform .container::-webkit-scrollbar-thumb{
        background-color:#BD8539;
        border-radius:10px;
    }

    loginform .container::-webkit-scrollbar{
        width:3px;
        background-color:#FE980F;
    } 

    #li, #reg {
        padding : 20px;
    }
    .col-sm-offset-1 {
        margin-left : 2%;
    }
    #loginform .col-sm-4 {
        width: 40%;
    }
    .popup-close-button {
        float : right;
        margin-right : 1.5%;
    }
    #cart-popup-close, #login-popup-close {
        font-size : 24pt;
    }
    #login-popup-close {
        position: absolute;
        top: 30px;
        left: 1130px;
    }
    .overlay-header {
        width : 100%;
        height : 10%;
    }
    .overlay-content {
        background : #FE980F;
    }
    .product-overlay {
        background : rgba(25,25,25,0.5);
    }
    header, footer {
        clear : both;
        background : #FFF;
    }
    .footer-bottom {
        background : #FFF;
    }
    .error-message {
        background: #ebcccc;
        display: block;
        margin-top: 20px;
        padding: 5px;
        border: solid 1px;
        border-color: #CE3C2D;
    }
    #cart-waiting, #empty-cart-message {
        display: block;
        position: absolute;
        top: 220px;
        left: 400px;
        height: 120px;
        width: 120px;
        text-align: center;
        vertical-align: central;
    }
    #cart, .order {
        display : table;
        border-spacing: 30px;
        width : 100%;
        position: relative;
    }
    #cart {
        top: 50px;
    }
    #cart .cart-item, .order .cart-item {
        display: table-row;
        width: 100%;
    }
    #cart .cart-item div, .order .cart-item div {
        display : table-cell;
        text-align: center;
    }
    #checkout-btn{
        padding: 5px;
        float : right;
        margin-right : 20px;
        margin-top: 7px;
        background: #ebebeb;
        color: #333;
        display: block;
        text-align: center;
    }
    #checkout-btn:hover {
        background: #FE980F;
        color: #FFFFFF;
        cursor: pointer;
    }
    #cart-total, #cart-shipping-charge {
        padding: 5px;
        float : right;
        margin-right : 20px;
        margin-top: 7px;
        display: block;
        text-align: center;
    }
    #cart-header {
        border-bottom: solid #FFCE99 1px;
        position: absolute;
        width: 900px;
        margin-left: 10px;
        padding: 12px 3px 3px 3px;
        z-index: 999
    }
    .orders{
        padding-top: 25px;
        height: 250px;
        overflow-y: scroll;
    }
</style>

<script>
    var isOverlayVisible = false;
    function toggleOverlay() {
        if (!isOverlayVisible) {
            $('#modal-overlay').fadeIn("slow");
            isOverlayVisible = true;
        } else {
            $('#modal-overlay').fadeOut("slow");
            isOverlayVisible = false;
        }
    }
    function addToCart(productID, quantity) {
        $.ajax({
            url: "AddToCart",
            type: "GET",
            data: {pid: productID, qty: quantity},
            success: function (responseData) {
                $('#empty-cart-message').remove();
                parseCart(responseData);
                $('#cartview').click();
            }
        });
    }

    function checkOut() {
        $.ajax({
            type: "GET",
            url: "IsLoggedIn",
            success: function (responseData) {
                data = $.parseJSON(responseData);
                if (data.loggedIn) {
                    window.location.href = "PrepareOrder";
                } else {
                    $('#login a#lilink').click();
                }
            }
        });
    }

    function parseCart(responseData) {
        $('#checkout-btn, #cart, #cart-total').remove();
        var checkOutBtn = "<a href=\"PrepareOrder\"><div id=\"checkout-btn\">Check Out</div></a>\n";
        var data = $.parseJSON(responseData);
        if (data.length > 0) {
            var cart = "<div id=\"cart\">\n";
            var totalAmount = 0.0;
            for (i = 0; i < data.length; i++) {
                totalAmount = totalAmount + (data[i].price);
                var cartItem = "<div class=\"cart-item\">\n"
                        + "<div class=\"cart-item-image\">"
                        + "<img src=\"image/thumbnails/" + data[i].thumbnail + "\" height=\"150px\" onerror=\"if (this.src != \'image/thumbnails/missing.png\') this.src = \'image/thumbnails/missing.png\';\"/>\n"
                        + "</div>\n"
                        + "<div class=\"cart-item-description\">\n"
                        + "<a href=\"Product?pid=" + data[i].productID + "\"><h4>" + data[i].name + "</h4></a>\n"
                        + "<h5>" + data[i].maker + "</h5>\n"
                        + "</div>\n"
                        + "<div class=\"cart-item-price\">\n"
                        + "<h5>Rs. " + data[i].price + "/-</h5>\n"
                        + "</div>\n"
                        + "<div class=\"cart-item-remove\">\n"
                        + "<a href=\"#?pid=" + data[i].productID + "\" class=\"remove-from-cart-btn\" id=\"cart-product_" + data[i].productID + "\"><i class=\"fa fa-times\"></i></a>\n"
                        + "</div>\n"
                        + "</div>\n";
                cart = cart + cartItem;
            }
            var totalAmountDiv = "<div id=\"cart-total\"><h4>Total : Rs. " + (totalAmount) + "/-</h4></div>\n";
            cart = cart + "</div>\n";
            $('#cart-header').append(checkOutBtn + totalAmountDiv);
            $('#cart_info').append(cart);
            $('#checkout-btn').click(function (evt) {
                evt.preventDefault();
                checkOut();
            });
            $('.remove-from-cart-btn').click(function (evt) {
                var productID = this.id.split("_")[1];
                evt.preventDefault();
                $.ajax({
                    url: "AddToCart",
                    type: "GET",
                    data: {pid: productID, remove: "on"},
                    success: function (responseData) {
                        parseCart(responseData);
                    }
                });
            });
        } else {
            var emptyCartMessage = "<div id=\"empty-cart-message\"><h3>Sorry! Your cart is empty!</h3></div>\n";
            $('#cart_info').append(emptyCartMessage);
        }
    }
    function refreshCart() {
        $.ajax({
            type: "GET",
            url: "AddToCart",
            data: {},
            beforeSend: function () {
                var cartWaiting = "<img id=\"cart-waiting\" src=\"image/animations/waiting.gif\"/>\n";
                $('#checkout-btn, #cart, #cart-total, #empty-cart-message').remove();
                $('#cart_info').append(cartWaiting);
            },
            complete: function () {
                $('#cart-waiting').remove();
            },
            success: function (responseData) {
                parseCart(responseData);
            }
        });
    }
    function isValidDate(s) {
        var bits = s.split('-');
        var y = bits[0], m = bits[1], d = bits[2];
        if (y < 1 || m < 1 || d < 1)
            return false;
        var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if ((!(y % 4) && y % 100) || !(y % 400)) {
            daysInMonth[1] = 29;
        }
        return d <= daysInMonth[--m];
    }
    function checkSpecialCharacter(s) {
        splctr = false;
        splctrs = ['\'', '\"', ';', ':', '|', '%', '^', '+', '-', '*', '/', '\\', '`', '&', '[', ']', '{', '}', '(', ')'];
        for (i = 0; i < splctrs.length; i++) {
            if (s.indexOf(splctrs[i]) !== -1) {
                splctr = true;
                break;
            }
        }
        return splctr;
    }

    function checkPasswordFields() {
        ret = false;
        pass = $("#reg-password").val();
        cpass = $("#reg-cpassword").val();
        fg_color = "#696763";
        bg_color = "#F0F0E9";
        if (pass.length != 0 && cpass.length != 0) {
            if (pass.length < 8 || pass.length > 16) {
                fg_color = "#FF2525";
                bg_color = "#FB8080";
                $('#pass-error-msg').empty();
                $('#pass-error-msg').css("color", "#FF2525");
                $('#pass-error-msg').append("<img src=\"image/icons/error.png\" height=\"20\" width=\"20\"/> Password must be 8 - 16 character long.");
            } else if (pass !== cpass) {
                fg_color = "#FF2525";
                bg_color = "#FB8080";
                $('#pass-error-msg').empty();
                $('#pass-error-msg').css("color", "#FF2525");
                $('#pass-error-msg').append("<img src=\"image/icons/error.png\" height=\"20\" width=\"20\"/> Both password fields must match.");
            } else if (checkSpecialCharacter(pass)) {
                fg_color = "#FF2525";
                bg_color = "#FB8080";
                $('#pass-error-msg').empty();
                $('#pass-error-msg').css("color", "#FF2525");
                $('#pass-error-msg').append("<img src=\"image/icons/error.png\" height=\"20\" width=\"20\"/> Password must not contain special characters ('\'', '\"', ';', ':', '|', '%', '^', '+', '-', '*', '/', '\\', '`', '&', '[', ']', '{', '}', '(', ')').");
            } else if (pass === cpass) {
                fg_color = "#3BA915";
                bg_color = "#C0FFAA";
                $('#pass-error-msg').empty();
                ret = true;
            }
        } else
            $('#pass-error-msg').empty();
        $('#reg-password, #reg-cpassword').css("background-color", bg_color);
        $('#reg-password, #reg-cpassword').css("color", fg_color);
        return ret;
    }
    function checkDateValidity() {
        ret = false;
        dt = $("#reg-dob").val();
        fg_color = "#696763";
        bg_color = "#F0F0E9";
        if (isValidDate(dt)) {
            fg_color = "#3BA915";
            bg_color = "#C0FFAA";
            $('#date-error-msg').empty();
            ret = true;
        } else if (dt.length > 0) {
            fg_color = "#FF2525";
            bg_color = "#FB8080";
            $('#date-error-msg').empty();
            $('#date-error-msg').css("color", "#FF2525");
            $('#date-error-msg').append("<img src=\"image/icons/error.png\" height=\"20\" width=\"20\"/> The date is either invalid or not in proper format.");
        } else
            $('#date-error-msg').empty();
        $('#reg-dob').css("background-color", bg_color);
        $('#reg-dob').css("color", fg_color);
        return ret;
    }

    function checkEmailSyntaxValidity(email) {
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }

    function validateEmail() {
        var color;
        var bg_color;
        email = $('#reg-username').val();
        ret = checkEmailSyntaxValidity(email);
        $('#email-msg, #reg-username').css('color', "#696763");
        $('#reg-username').css("background-color", "#F0F0E9");
        if (ret) {
            $.ajax({
                type: "POST",
                url: "CheckUsernameAvailability",
                data: {username: email},
                beforeSend: function () {
                    $('#email-msg').empty();
                    $('#email-msg').append('<span><img src=\"image/icons/waiting.gif\" height=\"20\" width=\"20\"/> Checking availability...</span>');
                },
                datatype: "json",
                success: function (responseData) {
                    data = $.parseJSON(responseData);
                    $('#email-msg').empty();
                    ret = ret && data.usable;
                    if (data.usable) {
                        $('#email-msg').append('<span><img src=\"image/icons/ok.gif\" height=\"20\" width=\"20\"/> Available for use.</span>');
                        color = "#3BA915";
                        bg_color = "#C0FFAA";
                    } else {
                        $('#email-msg').append('<span><img src=\"image/icons/error.png\" height=\"20\" width=\"20\"/> Unavailable.</span>');
                        color = "#FF2525";
                        bg_color = "#FB8080";
                    }
                    $('#email-msg, #reg-username').css('color', color);
                    $('#reg-username').css('background-color', bg_color);
                }
            });
        } else {
            if (email.length > 0) {
                $('#email-msg').empty();
                $('#email-msg').append('<span><img src=\"image/icons/error.png\" height=\"20\" width=\"20\"/> E-mail syntax is wrong.</span>');
                color = "#FF2525";
                bg_color = "#FB8080";
            } else {
                $('#email-msg').empty();
            }
            $('#email-msg, #reg-username').css('color', color);
            $('#reg-username').css('background-color', bg_color);
        }
        return ret;
    }

    function validateRegistrationFields() {
        ret = true;
        fn = $('#name').val();
        if (fn.length == 0) {
            $('#name-error-msg').empty();
            $('#name-error-msg').css("color", "#FF2525");
            $('#name-error-msg').append("<img src=\"image/icons/error.png\" height=\"20\" width=\"20\"/> Name is a required field.");
            ret = false;
        } else
            $('#name-error-msg').empty();
        return checkDateValidity() && checkPasswordFields() && validateEmail() && ret;
    }

    $(document).ready(function () {
        var cartUpdated = false;
        var isHeaderAnimationRunning = false;
        $('#show_orders_link').click(function (event) {
            event.preventDefault();
            $.ajax({
                type: "GET",
                url: "IsLoggedIn",
                success: function (responseData) {
                    data = $.parseJSON(responseData);
                    if (data.loggedIn) {
                        window.location.href = "ShowOrders";
                    } else {
                        $('#login a#lilink').click();
                    }
                }
            });
        });
        $('#reg-username').focusout(function () {
            validateEmail();
        });
        $('#reg-password, #reg-cpassword').focusout(function () {
            checkPasswordFields();
        });
        $('#reg-dob').focusout(function () {
            checkDateValidity();
        });
        $('#reg-submit').click(function (event) {
            valid = validateRegistrationFields();
            if (!valid) {
                event.preventDefault();
            }
        });
        $('#cartview').click(function (event) {
            event.preventDefault();
            $.ajax({
                type: "GET",
                url: "IsLoggedIn",
                success: function (responseData) {
                    data = $.parseJSON(responseData);
                    if (data.loggedIn) {
                        if (!isHeaderAnimationRunning) {
                            isHeaderAnimationRunning = true;
                            $('#cart_items').slideToggle("slow", function () {
                                isHeaderAnimationRunning = false;
                            });
                            toggleOverlay();
                        }
                        if (!cartUpdated) {
                            refreshCart();
                            cartUpdated = true;
                        }
                    } else {
                        $('#login a#lilink').click();
                    }
                }
            });
        });
        $('#login a#lilink').click(function (event) {
            event.preventDefault();
            if (!isHeaderAnimationRunning) {
                isHeaderAnimationRunning = true;
                $('#loginform').slideToggle("slow", function () {
                    isHeaderAnimationRunning = false;
                });
                toggleOverlay();
            }
        });
        $('#cart-popup-close').click(function (event) {
            event.preventDefault();
            if (!isHeaderAnimationRunning) {
                isHeaderAnimationRunning = true;
                $('#cart_items').slideUp("slow", function () {
                    isHeaderAnimationRunning = false;
                });
                toggleOverlay();
            }
        });
        $('#login-popup-close').click(function (event) {
            event.preventDefault();
            if (!isHeaderAnimationRunning) {
                isHeaderAnimationRunning = true;
                $('#loginform').slideUp("slow", function () {
                    isHeaderAnimationRunning = false;
                });
                toggleOverlay();
            }
        });
        $('#form-login').keyup(function () {
            $('.login-form .error-message').remove();
        });
        $('#form-login').submit(function (evt) {
            evt.preventDefault();
            var uname = $('#login-username').val();
            var pass = $('#login-password').val();
            var remMe = $('#login-rememberMe').is(':checked');
            var loginForm, loginFormParent;
            $.ajax({
                type: "POST",
                url: "Login",
                data: {username: uname, password: pass, rememberMe: remMe},
                beforeSend: function () {
                    var waitingAnimation = "<p id=\"waiting\"><img src=\"image/animations/waiting.gif\" /></p>";
                    $('#form-login').after(waitingAnimation);
                    loginFormParent = $('#form-login').parent();
                    loginForm = $('#form-login').detach();
                    $('.login-form .error-message').remove();
                },
                complete: function () {
                    $('#waiting').remove();
                },
                datatype: "json",
                success: function (responseData) {
                    var data = $.parseJSON(responseData);
                    if (!data.success) {
                        var message = "<p class=\"error-message\"><img src=\"image/icons/error.png\" height=\"20px\"/> " + data.message + "</p>";
                        loginFormParent.append(loginForm);
                        $('#form-login').after(message);
                    }
                    else {
                        var navBar = $('#login').parent();
                        var loggedIn = "<li><a href=\"ShowUserDetails\"><i class=\"fa fa-user\"></i> Hello " + data.obj.firstName + " !</a></li>"
                                + "<li><a href=\"Logout\">Log Out</a></li>";
                        $('#loginform').slideUp("slow", function () {
                            $('#login').remove();
                            navBar.append(loggedIn);
                        });
                        toggleOverlay();
                        refreshCart();
                    }
                }
            });
        });
    });
</script>