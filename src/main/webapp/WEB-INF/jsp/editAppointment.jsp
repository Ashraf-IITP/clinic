<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
    <head>
        <script type="text/javascript">
            var rowNo = 0;

            function getDrAvailableSlots() {
                var startTime = document.getElementById("startTime");
                startTime.length = 0;
                const formData = new FormData();
                formData.append('doctorId', document.getElementById("doctor").value);
                formData.append('scheduleDate', document.getElementById("scheduleDate").value);
                formData.append('${_csrf.parameterName}', '${_csrf.token}');
                // Set up options for the fetch request
                const options = {
                    method: 'POST',
                    body: formData
                };
                // Make the fetch request with the provided options
                fetch('ajaxGetDrAvailableSlots.htm', options)
                        .then(response => {
                            // Check if the request was successful
                            if (!response.ok) {
                                throw new Error('Ajax call failed');
                            }
                            // Parse the response as JSON
                            console.log(response);
                            return response.json();
                        })

                        .then(data => {
                            // Handle the JSON data
                            const availableSlots = data;
                            console.log(availableSlots.length)
                            for (var x = 0; x < availableSlots.length; x++) {
                                console.log(availableSlots[x]);
                                var opt = document.createElement('option');
                                opt.value = availableSlots[x];
                                opt.innerHTML = availableSlots[x];
                                startTime.appendChild(opt);
                            }
                        })
                        .catch(error => {
                            // Handle any errors that occurred during the fetch
                            console.error('Fetch error:', error);
                        });
            }
        </script>
    </head>
    <body>
        <form:form name="editAppointment" modelAttribute="appointment" method="POST" action="editAppointment.htm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <form:input type="hidden" path="appointmentId"/>

            Patient: <form:select path="patient" onchange=""><form:option value="${appointment.patient.id}">${appointment.patient.label}</form:option></form:select><br/><br/>
            Doctor : <form:select path="doctor" onchange="getDrAvailableSlots();"><form:options items="${doctorList}" itemValue="id" itemLabel="label"/></form:select><br/><br/>
            Schedule date : <form:input path="scheduleDate" onchange="getDrAvailableSlots();"/><br/><br/>
            Start time : <form:select path="startTime" items="${availableSlots}"/><br/><br/>
            <input type="submit" name="submit" value="Submit"/>
        </form:form>
        <br/><br/>
        ${msg}${param.msg}
    </body>
</html>

