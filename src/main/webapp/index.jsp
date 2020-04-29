<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.min.js"></script>

    <%--获取当前域名--%>
    <% String basePath = request.getRequestURL().toString();%>

    <script type="text/javascript">

        console.log("<%=basePath%>");

            <%--//主域名--%>
        <%--if ("<%=basePath%>" == "http://localhost:8080/") {--%>
            <%--$(document).ready(function () {--%>
                <%--window.location.href = "loginController.do?login";--%>
            <%--});--%>
            <%--//客户A--%>
        <%--} else if ("<%=basePath%>" == "http://cuixiaoyan.utools.club/") {--%>
            <%--$(document).ready(function () {--%>
                <%--window.location.href = "loginController.do?login3";--%>
            <%--});--%>
            <%--//客户B--%>
        <%--} else if ("<%=basePath%>" == "http://cxycxy.utools.club/") {--%>
            <%--$(document).ready(function () {--%>
                <%--window.location.href = "loginController.do?login";--%>
            <%--});--%>
        <%--}--%>

        $(document).ready(function () {
            window.location.href = "loginController.do?login";
        });



    </script>
</head>
<body>
</body>
</html>