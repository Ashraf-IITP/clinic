<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <script type="text/javascript">
            function editPatient(patientId) {
                document.getElementById("patientId").value = patientId;
                document.getElementById("editForm").submit();
            }
        </script>
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            fieldset {
                border: 1px solid #ccc;
                padding: 10px;
                margin-bottom: 20px;
            }

            legend {
                font-weight: bold;
                font-size: 1.2em;
            }

            form {
                margin-bottom: 10px;
            }

            input[type="text"], input[type="submit"] {
                padding: 5px;
                margin-right: 10px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 8px;
                text-align: left;
                background-color: #f2f2f2;
            }

            th {
                font-weight: bold;
            }

            a {
                text-decoration: none;
                color: blue;
            }

            .error {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%@ include file="./index.jsp" %>
        <fieldset>
            <legend>Search Patient</legend>
            <form id="searchPatient" name="searchPatient" method="GET">
                Search patient <input type="text" name="searchString" id="searchString" value="${searchString}"/> <input type="submit" value="Search"/>
            </form>           
            <table border="1">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Mobile</th>
                        <th>Email Id</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${patientList}" var="p">
                        <tr>
                            <td>${p.name}</td>
                            <td>${p.mobile}</td>
                            <td>${p.emailId}</td>
                            <td>${p.age}</td>
                            <td>${p.gender.label}</td>
                            <td><a href="javascript:editPatient(${p.patientId});">Edit</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br/><br/>
            ${msg}${param.msg}
            <form name="editForm" id="editForm" method="POST" action="showEditPatient.htm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="hidden" name="patientId" id="patientId"/>
            </form>
        </fieldset>
    </body>
</html>

