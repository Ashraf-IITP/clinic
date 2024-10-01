<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
    <head>
        <style>
            body {
                margin: 0;
                padding: 0;
            }


            .form-container {
                background-color: #fff;
                padding: 10px 50px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 50%;
                margin: auto;
            }
            .form-container h1 {
                text-align: center;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input[type="text"], input[type="submit"], input[type="button"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            input[type="submit"], input[type="button"] {
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            input[type="submit"]:hover, input[type="button"]:hover {
                background-color: #45a049;
            }
            
            .gender{
                margin: 0 5px;
                display: flex;
                gap: 20px;
            }
        </style>
    </head>
    <body>
        <%@ include file="./index.jsp" %>
        <div class="form-container">
            <h1>Edit Patient</h1>
            <form:form name="editPatient" modelAttribute="patient" method="POST" action="editPatient.htm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <form:hidden path="patientId"/>
                <label>Name: </label><form:input path="name" /><br/><br/>
                <label>Mobile: </label><form:input path="mobile" /><br/><br/>
                <label>Email Id: </label><form:input path="emailId" /><br/><br/>
                <label>Age: </label><form:input path="age" /><br/><br/>
                <div class="gender">
                    <label>Gender: </label><form:radiobuttons path="gender" items="${genderList}" itemLabel="label" itemValue="id"/><br/><br/>
                </div>
                <input type="submit" value="Submit"/>&nbsp;&nbsp;&nbsp;<input type="button" value="Cancel" onclick="window.location.href = 'searchPatient.htm?msg=Cancelled';"/>
            </form:form>
            <br/><br/>
            ${msg}${param.msg}
        </div>
    </body>
</html>

