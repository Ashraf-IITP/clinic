<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <script>
            function updateUser(userId) {
                document.getElementById("userId").value = userId;
                document.getElementById("updateUserForm").submit()
            }
            function deleteUser(employeeId, addressId) {
                document.getElementById("deleteEmployeeId").value = employeeId;
                document.getElementById("deleteAddressId").value = addressId;
                document.getElementById("deleteEmployeeForm").submit();
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
        </style>
    </head>
    <body>
        <%@ include file="./index.jsp" %>
        <fieldset>
            <legend>User list</legend>
            <table border="1">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Username</th>
                        <th>Role</th>
                        <th>Speciality list</th>
                        <th>Active</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${userList}" var="user" >
                        <tr>
                            <td>${user.name}</td>
                            <td>${user.username}</td>
                            <td>${user.role.label}</td>
                            <td>${user.specialityListLabels}</td>
                            <td>${user.active}</td>
                            <th>
                                <a href="javascript:updateUser('${user.userId}');"  >Edit</a>
                            </th>
                        </tr>
                    </c:forEach >
                </tbody>
            </table>
        </fieldset>
        <form name="updateUserForm" id="updateUserForm" method="POST" action="showEditUser.htm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
            <input type="hidden" name="userId" id="userId" value=""/>
        </form>
    </body>

</html>
