
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
    <head>
        <style>
            /* General form styling */
            /* General styling for the body */
            body {
                font-family: 'Helvetica Neue', Arial, sans-serif;
                background-color: #f9fafb;
                color: #333;
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            /* Form container styling */
            form {
                max-width: 700px;
                margin: 20px;
                padding: 25px;
                border-radius: 8px;
                background-color: #ffffff;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                border: 1px solid #e1e4e8;
            }

            /* Fieldset and label styling for better grouping */
            fieldset {
                border: none;
                padding: 0;
                margin: 0 0 15px 0;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            /* Styling for input and select elements */
            select, input[type="text"], input[type="date"] {
                width: 100%;
                padding: 12px;
                margin-top: 5px;
                margin-bottom: 15px;
                border: 1px solid #d1d5da;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
                background-color: #f6f8fa;
                transition: border-color 0.2s;
            }

            select:focus, input[type="text"]:focus, input[type="date"]:focus {
                border-color: #0366d6;
                outline: none;
            }

            /* Styling for table */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: #ffffff;
            }

            table, th, td {
                border: 1px solid #e1e4e8;
            }

            th, td {
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #f6f8fa;
                font-weight: bold;
            }

        </style>
        <script type="text/javascript">
            function addRow(cal, doctorId, scheduleDate) {
                console.log("Adding row with " + cal + ", doctorId=" + doctorId + ", scheduleDate=" + scheduleDate);
                var t = document.getElementById("doctorCalendarBody");
                var r = t.insertRow(-1);
                r.setAttribute("data-id", cal.appointmentId);
                var cell1 = r.insertCell(0);
                var cell2 = r.insertCell(1);
                var cell3 = r.insertCell(2);
                cell1.innerHTML = cal.timeSlot;
                if (cal.appointmentId != null) {
                    cell2.innerHTML = cal.patient.label;
                    cell3.innerHTML = "<a href='javascript:editAppt(" + cal.appointmentId + ");'>Edit</a>";
                } else {
                    cell2.innerHTML = "";
                    cell2.innerHTML = "<a href=\"javascript:addAppt(" + doctorId + ", '" + scheduleDate + "', '" + cal.timeSlot + "');\">Add</a>";
                }
                return true;
            }

            function deleteAllRows() {
                var table = document.getElementById("doctorCalendarBody");
                const tableRowCount = table.rows.length;
                for (var x = 0; x < tableRowCount; x++) {
                    table.deleteRow(0);
                }
            }

            function getDoctorCalendar() {
                const doctorId = document.getElementById("doctor").value;
                const scheduleDate = document.getElementById("scheduleDate").value;
                if (scheduleDate != '' && doctorId != 0) {
                    console.log("Proceed with Ajax");
                    deleteAllRows();
                    const formData = new FormData();

                    formData.append('doctorId', doctorId);
                    formData.append('scheduleDate', scheduleDate);
                    formData.append('${_csrf.parameterName}', '${_csrf.token}');
                    // Set up options for the fetch request
                    const options = {
                        method: 'POST',
                        body: formData
                    };
                    // Make the fetch request with the provided options
                    fetch('ajaxGetDoctorCalendar.htm', options)
                            .then(response => {
                                // Check if the request was successful
                                if (!response.ok) {
                                    throw new Error('Ajax call failed');
                                }
                                // Parse the response as JSON
                                return response.json();
                            })

                            .then(data => {
                                // Handle the JSON data
                                const calendarList = data;

                                for (var x = 0; x < calendarList.length; x++) {
                                    addRow(calendarList[x], doctorId, scheduleDate, );
                                }
                            })
                            .catch(error => {
                                // Handle any errors that occurred during the fetch
                                console.error('Fetch error:', error);
                            });
                }
            }

            function editAppt(apptId) {
                document.getElementById("appointmentId").value = apptId;
                document.getElementById("editAppointmentForm").submit();
            }

            function addAppt(doctorId, scheduleDate, timeSlot) {
                document.getElementById("varDoctorId").value = doctorId;
                document.getElementById("varScheduleDate").value = scheduleDate;
                document.getElementById("varTimeSlot").value = timeSlot;
                document.getElementById("addAppointmentForm").submit();
            }


        </script>
    </head>
    <body>
        <form name="viewDoctorSchedule">
            Doctor : <select id="doctor" name="doctor" onchange="getDoctorCalendar();"><option value="0">Please select Dr</option><c:forEach items="${doctorList}" var="d"><option value="${d.id}">${d.label}</option></c:forEach></select><br/><br/>
                Schedule date : <input id="scheduleDate" name="scheduleDate" onchange="getDoctorCalendar();"/><br/><br/><br/>
                Doctor Calendar
                <table border="1">
                    <thead>
                        <tr>
                            <th>Start time</th>
                            <th>Patient</th>
                            <th>Edit</th>
                        </tr>
                    </thead>
                    <tbody id="doctorCalendarBody">

                    </tbody>
                </table>
                <br/><br/>
            </form>
            <form name="editAppointmentForm" id="editAppointmentForm" method="POST" action="showEditAppointment.htm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="appointmentId" id="appointmentId"/>
        </form>
        <form name="addAppointmentForm" id="addAppointmentForm" method="POST" action="addAppointmentFromCalendar.htm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="doctorId" id="varDoctorId"/>
            <input type="hidden" name="scheduleDate" id="varScheduleDate"/>
            <input type="hidden" name="timeSlot" id="varTimeSlot"/>
        </form>

    </body>
</html>

