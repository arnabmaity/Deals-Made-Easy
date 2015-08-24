<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <myTags:headscriptnstyle/>
        <title>Registration Message | Deals Made Easy</title>
    </head>
    <%
        String regMsg = request.getParameter("regmsg");
    %>
    <body>
        <myTags:header/>
                <h1 class="title text-center"><%=regMsg%></h1>
        <myTags:footer/>
        <myTags:postscripts/>
    </body>
</html>
