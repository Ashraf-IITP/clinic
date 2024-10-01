<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                display: flex;
                flex-direction: column;
            }


            nav {
                overflow: hidden;
                background-color: #333;
                display: flex;
                justify-content: space-evenly;
                align-items: center;
                padding: 10px;
            }

            nav a {
                color: white;
                text-decoration: none;
                padding: 10px 20px;
                transition: background-color 0.3s;
                border-radius: 8px;
            }

            nav a:hover {
                background-color: #555;
            }

            nav div {
                color: white;
                font-weight: bold;
                padding: 10px 20px;
            }

            div.container {
                display: flex;
                align-items: center;
                margin: 0px;
                gap: 2px;
                overflow: scroll;
            }

            div.authorities {
                background-color: #ddd;
                padding: 10px;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <sec:authentication property="principal" var="curUser" scope="request"/>
        <nav>
            <div>Welcome, ${curUser.name}</div>
            <a href="index.htm">Home</a>
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER')">
                <a href="addUser.htm">Add User</a>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER')">
                <a href="listUser.htm">Show User List</a>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER','ROLE_BF_MANAGE_PATIENT')">
                <a href="addPatient.htm">Add Patient</a>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER','ROLE_BF_MANAGE_PATIENT')">
                <a href="listPatient.htm">Show Patient List</a>
            </sec:authorize> 
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER','ROLE_BF_MANAGE_PATIENT')">
                <a href="searchPatient.htm">Search Patient</a>
            </sec:authorize> 
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER','ROLE_BF_MANAGE_PATIENT','ROLE_BF_DR_SCHEDULE')">
                <a href="addDoctorSchedule.htm">Manage Dr schedule</a>&nbsp;&nbsp;
            </sec:authorize> 
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER','ROLE_BF_MANAGE_PATIENT','ROLE_BF_MANAGE_APPT')">
                <a href="addAppointment.htm">Add Appointment</a>&nbsp;&nbsp;
            </sec:authorize> 
            <sec:authorize access="hasAnyRole('ROLE_BF_MANAGE_USER','ROLE_BF_MANAGE_PATIENT','ROLE_BF_MANAGE_APPT')">
                <a href="viewDoctorCalendar.htm">View Calendar</a>&nbsp;&nbsp;
            </sec:authorize> 
            <a href="logout">Logout</a>
        </nav>
        <div class="container">
            <c:forEach items="${curUser.authorities}" var="auth">
                <div class="authorities">${auth}</div>
            </c:forEach>
        </div>

        <!--</div>-->
    </body>
</html>
