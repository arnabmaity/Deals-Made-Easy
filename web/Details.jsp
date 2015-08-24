<%@page import="project.dme.beans.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <title>User Details | Deals Made Easy</title>
        <myTags:headscriptnstyle/>
    </head>
    <body>
        <myTags:header/>
        <section>
            <div class="container">
                <div class="col-sm-9 pull-right row">
                    <% User user = (User)session.getAttribute("user");%>
                    <div class="col-sm-6 pull-left">
                        <span>Username : <%= user.getUsername()%></span>
                        <br/>
                        <span>Name : <%= user.getName()%></span>
                        <br/>
                    </div>
                    <div class="col-sm-6 pull-left">
                        <span>Date of Birth : <%= user.getDOB()%></span>
                        <br/>
                        <span>Sex : <%= user.getSex()%></span>
                        <br/>
                        <span>Contact No. : <%= user.getContactNo()%></span>
                        <br/>
                    </div>
                </div>
            </div>
        </section>
        <myTags:footer/>
        <myTags:postscripts/>
    </body>
</html>
