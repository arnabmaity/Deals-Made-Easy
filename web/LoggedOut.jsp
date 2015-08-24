<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <myTags:head/>
        <myTags:headscriptnstyle/>
        <title>Logged Out | Deals Made Easy</title>
    </head>
    <body>
        <myTags:header/>
        <c:choose>
            <c:when test="${sessionScope.loggedIn == null}">
                <h1 class="title text-center">Logged Out successfully!</h1>
            </c:when>
            <c:otherwise>
                <h1 class="title text-center">Failed to Logout!</h1>
            </c:otherwise>
        </c:choose>
        <myTags:footer/>
        <myTags:postscripts/>
    </body>
</html>
