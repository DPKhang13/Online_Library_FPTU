<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Page</title>
</head>
<body>
    <h1>JSP Test Page</h1>
    <p>Current time: <%= new java.util.Date() %></p>
    
    <c:if test="${not empty sessionScope.user}">
        <p>User: ${sessionScope.user.name}</p>
        <p>Role: ${sessionScope.user.role}</p>
    </c:if>
    
    <c:if test="${empty sessionScope.user}">
        <p>No user logged in</p>
    </c:if>
    
    <p>Test attributes:</p>
    <ul>
        <li>pageTitle: ${pageTitle}</li>
        <li>activeTab: ${activeTab}</li>
        <li>stats: ${stats}</li>
    </ul>
</body>
</html>
