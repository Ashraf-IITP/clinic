<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <style>
            /* CSS styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 0;
            }

            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                width: 300px;
                margin: 0 auto;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                -webkit-box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
                -moz-box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
                box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
            }

            input[type="text"],
            input[type="submit"],
            input[type="button"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
            }

            input[type="button"] {
                background-color: #bbb;
                color: white;
                cursor: pointer;
            }

            input[type="submit"]:hover,
            input[type="button"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body> 
        <%@ include file="./index.jsp" %>

        <form:form method="POST" name="addPatient" modelAttribute="patient">
            Name : <form:input path="name"/><br/><br/>
            Mobile : <form:input path="mobile" /><br/><br/>
            Age : <form:input path="age" /><br/><br/>
            Email Id : <form:input path="emailId" /><br/><br/>
            Gender  : <form:select path="gender" id="gender" items="${genderList}" itemLabel="label" itemValue="id" /><br/><br/><br/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
            <input type="submit" value="Submit" name="submit" id="submit" />&nbsp;&nbsp;&nbsp;<input type="button" value="Cancel" onclick="window.location.href = 'listUser.htm?msg=Cancelled';" name="cancel" id="cancel" />
        </form:form>
        <br/><br/><br/><!-- comment -->
        ${msg}${param.msg}
    </body>   
</html>

