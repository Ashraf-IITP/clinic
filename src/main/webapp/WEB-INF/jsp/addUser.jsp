<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #12372A;
                padding: 20px;
            }

            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                width: 300px;
                margin: 0 auto;
                -webkit-box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
                -moz-box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
                box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
            }

            input[type="text"],
            input[type="password"],
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                margin-bottom: 10px;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
            }
            input[type="button"] {
                background-color: #bbb;
                color: white;
                margin-bottom: 10px;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
            }
            .courses{
                display: flex;
                flex-wrap: wrap;
            }

            
            input[type="submit"]:hover,
            input[type="button"]:hover {
                background-color: #45a049;
            }
        </style>

        <script type="text/javascript">
            function showSpecialities() {
                if (document.getElementById("role").value === "ROLE_DOCTOR") {
                    document.getElementById("specialities").style.display = "block";
                } else {
                    document.getElementById("specialities").style.display = "none";
                }
            }
        </script>

    </head>
    <body onload="showSpecialities();">
        <%@ include file="./index.jsp" %>
        <form:form method="POST" name="addUser" modelAttribute="user">
            Name : <form:input path="name"/><br/><br/>
            Username : <form:input path="username" /><br/><br/>
            Role  : <form:select path="role" id="role" items="${roleList}" itemLabel="label" itemValue="id" onchange="showSpecialities();" /><br/><br/><br/>
            <div id="specialities" >
                Specialities: <form:checkboxes  path="specialityList" items="${specialityList}" itemLabel="label" itemValue="id" /><br/><br/>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
            <input type="submit" value="Submit" name="submit" id="submit" />
            <input type="button" value="Cancel" onclick="window.location.href = 'listUser.htm?msg=Cancelled';" name="cancel" id="cancel" />
        </form:form>
        <br/><br/><br/><!-- comment -->
        ${msg}
    </body>   
</html>
