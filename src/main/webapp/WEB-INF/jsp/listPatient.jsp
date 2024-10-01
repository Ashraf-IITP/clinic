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
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            a {
                text-decoration: none;
                color: #007bff;
            }
            a:hover {
                text-decoration: underline;
            }
            fieldset {
                margin: 20px;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
            }
            legend {
                font-weight: bold;
                font-size: 1.2em;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 8px;
                border: 1px solid #ccc;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            .edit-link {
                color: #007bff;
                cursor: pointer;
            }
            .edit-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <%@ include file="./index.jsp" %>
        <fieldset>
            <legend>Search Patient</legend>
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
