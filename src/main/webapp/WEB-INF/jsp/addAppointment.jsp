<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
    <head>
        <style>

            /* General form styling */
            form {
                max-width: 500px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                background-color: #f9f9f9;
            }

            /* Form element margins */
            form > div {
                margin-bottom: 15px;
            }

            /* Input and select elements */
            input[type="text"], input[type="date"], select {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }

            /* Label styling */
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

            /* Submit button */
            input[type="submit"] {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 4px;
                background-color: #28a745;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #218838;
            }

            /* Form fieldset to group form elements */
            fieldset {
                border: none;
                margin-bottom: 20px;
            }

            /* Add some spacing and differentiation for optional messages */
            .message {
                text-align: center;
                font-size: 14px;
                color: #ff0000;
                margin-top: 20px;
            }

        </style>
        <script type="text/javascript">
            var rowNo = 0;

            function getDrAvailableSlots() {
                var startTime = document.getElementById("startTime");
                startTime.length = 1;
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
        <form:form name="addAppointment" modelAttribute="appointment" method="POST" action="addAppointment.htm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            Patient: <form:select path="patient" onchange=""><form:option value="0">Please select Patient</form:option><form:options items="${patientList}" itemValue="patientId" itemLabel="name"/></form:select><br/><br/>
            Doctor : <form:select path="doctor" onchange="getDrAvailableSlots();"><form:option value="0">Please select Dr</form:option><form:options items="${doctorList}" itemValue="id" itemLabel="label"/></form:select><br/><br/>
            Schedule date : <form:input path="scheduleDate" onchange="getDrAvailableSlots();"/><br/><br/>
            Start time : <form:select path="startTime" ><form:option value="">Please select a Slot</form:option><form:options items="${availableSlots}"/></form:select><br/><br/>
                    <input type="submit" name="submit" value="Submit"/>
        </form:form>
        <br/><br/>
        ${msg}${param.msg}
    </body>
</html>

