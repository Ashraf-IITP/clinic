<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
    <head>
        <style>
            /* General form styling */
            body{
                background: #538392;
            }
            form {
                max-width: 600px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 10px;
                background-color: #f4f4f4;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Input, select, and button styling */
            input[type = "text"], input[type = "date"], select {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-sizing: border - box;
                font-size: 16px;
            }

            input[type = "button"], input[type = "submit"] {
                width: 100px;
                padding: 10px;
                margin: 10px 5px 0 0;
                border: none;
                border-radius: 5px;
                background-color: #007bff;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background - color 0.3s ease;
            }

            input[type = "button"]:hover, input[type = "submit"]:hover {
                background-color: #0056b3;
            }

            /* Table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #f0f0f0;
                font-weight: bold;
            }

            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            /* Error message styling */
            #timeError {
                color: #ff0000;
                font-size: 14px;
                margin-left: 10px;
            }
        </style>
        <script type="text/JavaScript" src="https://MomentJS.com/downloads/moment-with-locales.js"></script>
        <script type="text/JavaScript" src="https://cdn.jsdelivr.net/npm/moment-range@4.0.2/dist/moment-range.min.js"></script>
        <!--<script type="text/JavaScript" src="https://cdnjs.cloudflare.com/ajax/libs/moment-range/4.0.2/moment-range.js" integrity="sha512-XKgbGNDruQ4Mgxt7026+YZFOqHY6RsLRrnUJ5SVcbWMibG46pPAC97TJBlgs83N/fqPTR0M89SWYOku6fQPgyw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>-->

        <script>
            var rowNo = 0;
            var doctorScheduleList = [];

            function tableToArray() {
                var table = document.getElementById("scheduleTimeTableBody");
                var rows = table.getElementsByTagName('tr');
                var result = [];

                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
//                    var cells = row.getElementsByTagName('td');
                    var startCell = row.getElementsByTagName('td')[0].innerHTML;
                    var stopCell = row.getElementsByTagName('td')[1].innerHTML;
                    console.log(startCell)
                    console.log(stopCell)
                    var obj = {
                        "startTime": startCell,
                        "stopTime": stopCell
                    };

//                    for (var j = 0; j < cells.length; j++) {
//                        var cell = cells[j];
//                        var propName = 'column' + j; // You can customize property names
//                        obj[propName] = cell.innerText.trim();
//                    }

                    result.push(obj);
                }

                return result;
            }


            function validateData() {
                doctorScheduleList = tableToArray();
                var startTime = document.getElementById("startTime").value;
                var stopTime = document.getElementById("stopTime").value;
                var startArray = startTime.split(":");
                var stopArray = stopTime.split(":");
                const startHr = Number(startArray[0]);
                const startMin = Number(startArray[1]);
                const stopHr = Number(stopArray[0]);
                const stopMin = Number(stopArray[1]);
                var validated = scheduleOverlappingValidation(startTime, stopTime)

                return validated;
            }

            function scheduleOverlappingValidation(start, stop) {
                var scheduleDate = moment(document.getElementById("scheduleDate").value, "YYYY-MM-DD");
                var startTime = moment(start, "HH:mm");
                var stopTime = moment(stop, "HH:mm");
                var result = [false, ""]

                //------> time should not be empty
                if (start === "" || stop === "") {
                    result = [true, "fields should not be empty."];
                    return result;
                }


                //------> older dates are not allowed
                if (scheduleDate.isBefore(moment()) && start != "" && stop != "") {
                    console.log("older dates schedule can not be modify.")
                    result = [true, "older dates schedule can not be modify."];
                    return result;
                }


                //------>startTime before stopTime check
                if (startTime.isAfter(stopTime)) {
                    console.log("start time should be before stop time")
                    console.log(startTime.isAfter(stopTime))
                    result = [true, "start time should be before stop time"];
                    return result;
                }

                //------> minimum 30 min check
                var diffInMin = stopTime.diff(startTime, 'minutes')
                if (diffInMin <= 30) {
                    console.log("Stop time should be atleast 30min more than Start time")
                    result = [true, "Stop time should be atleast 30min more than Start time"];
                    return result
                }

                //------>overlapping check    
                console.log(startTime)
                console.log(stopTime)

                const isOverlapping = doctorScheduleList.every(interval => {
                    const start = moment(interval.startTime, "HH:mm");
                    const stop = moment(interval.stopTime, "HH:mm");
//                    console.log("start")
//                    console.log(start)
//                    console.log("stop")
//                    console.log(stop)
                    if ((startTime.isAfter(start) || startTime.isSame(start)) && startTime.isBefore(stop)) {
                        console.log("start time should not be in between existing schedule time")
                        result = [true, "start time should not be in between existing schedule time"];
                        return true;
                    } else if (stopTime.isAfter(start) && (stopTime.isBefore(stop) || stopTime.isSame(stop))) {
                        console.log("stop time should not be in between existing schedule time")
                        result = [true, "stop time should not be in between existing schedule time"];
                        return true;
                    } else if (startTime.isBefore(start) && stopTime.isAfter(stop)) {
                        console.log("start time and stop time should not cover existing schedule time")
                        result = [true, "start time and stop time should not cover existing schedule time"];
                        return true;
                    } else if (startTime.isSame(start) && stopTime.isSame(stop)) {
                        console.log("this time schedule already exist")
                        result = [true, "this time schedule already exist"];
                        return true;
                    }
                    return false;
                })

//                console.log("isOverlapping " + isOverlapping)
                console.log(result)
                return result;

            }


            function addData() {
                const validation = validateData();
                if (!validation[0]) {
                    document.getElementById("timeError").innerHTML = "";
                    return addRow(document.getElementById("startTime").value, document.getElementById("stopTime").value);
                } else {
                    document.getElementById("timeError").innerHTML = validation[1];
                    return true;
                }
            }

            function addRow(startTime, stopTime) {
                var t = document.getElementById("scheduleTimeTableBody");
                var r = t.insertRow(-1);
                r.setAttribute("data-id", rowNo);
                var cell1 = r.insertCell(0);
                var cell2 = r.insertCell(1);
                var cell3 = r.insertCell(2);
                var cell4 = r.insertCell(3);
                cell1.innerHTML = startTime;
                cell2.innerHTML = stopTime;
                cell3.innerHTML = "<a href='javascript:editRow(" + rowNo + ");'>Edit</a>";
                cell4.innerHTML = "<a href='javascript:deleteRow(" + rowNo + ");'>Delete</a>";
                document.getElementById("startTime").value = "";
                document.getElementById("stopTime").value = "";
                rowNo++;
                return true;
            }

            function editRow(varRowNo) {
                var table = document.getElementById("scheduleTimeTableBody");
                for (var x = 0; x < table.rows.length; x++) {
                    var r = table.rows[x];
                    var id = r.getAttribute("data-id");
                    if (varRowNo == id) {
                        document.getElementById("startTime").value = r.cells[0].innerHTML;
                        document.getElementById("stopTime").value = r.cells[1].innerHTML;
                        table.deleteRow(x);
                        break;
                    }
                }
            }

            function deleteAllRows() {
                var table = document.getElementById("scheduleTimeTableBody");
                const tableRowCount = table.rows.length
                for (var x = 0; x < tableRowCount; x++) {
                    table.deleteRow(0);
                }
                rowNo = 0;
            }

            function deleteRow(varRowNo) {
                var table = document.getElementById("scheduleTimeTableBody");
                for (var x = 0; x < table.rows.length; x++) {
                    var r = table.rows[x];
                    var id = r.getAttribute("data-id");
                    if (varRowNo == id) {
                        table.deleteRow(x);
                        break;
                    }
                }
            }

            function buildScheduleJson() {
                var table = document.getElementById("scheduleTimeTableBody");
                var jsonString = "[";
                for (var x = 0; x < table.rows.length; x++) {
                    var r = table.rows[x];
                    jsonString += "{'startTime':'" + r.cells[0].innerHTML + "', 'stopTime':'" + r.cells[1].innerHTML + "'},";
                }
                if (jsonString.length != 1) {
                    jsonString = jsonString.substring(0, jsonString.length - 1);
                }
                jsonString += "]";
                document.getElementById("scheduleJson").value = jsonString;
                return true;
            }

            function getDrScheduleTimes() {
                deleteAllRows();
                const formData = new FormData();
                formData.append('doctorId', document.getElementById("doctor").value);
                formData.append('scheduleDate', document.getElementById("scheduleDate").value);
                formData.append('${_csrf.parameterName}', '${_csrf.token}');
                // Set up options for the fetch request
                const options = {
                    method: 'POST',
                    body: formData
                };
                fetch('ajaxGetDoctorSchedules.htm', options)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Ajax call failed');
                            }
                            return response.json();
                        })

                        .then(data => {
                            const scheduleTimeList = data;
//                            doctorScheduleList = data;
                            for (var x = 0; x < scheduleTimeList.length; x++) {
                                addRow(scheduleTimeList[x].startTime, scheduleTimeList[x].stopTime);
                            }
                        })
                        .catch(error => {
                            console.error('Fetch error:', error);
                        });
            }

        </script>

    </head>
    <body>
        <form:form name="addDoctorSchedule" modelAttribute="doctorSchedule" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="scheduleJson" id="scheduleJson" value=""/>
            Doctor : <form:select path="doctor" onchange="getDrScheduleTimes();"><form:option value="0">Please select Dr</form:option><form:options items="${doctorList}" itemValue="id" itemLabel="label"/></form:select><br/><br/>
            Schedule date : <form:input path="scheduleDate" id="scheduleDate" onchange="getDrScheduleTimes();"/><br/><br/><br/>

            Start time : <input type="text" name="startTime" id="startTime"/><br/>
            Stop time : <input type="text" name="stopTime" id="stopTime"/><span id="timeError"></span><br/>
            <input type="button" value="Add" onclick="addData();"/>
            <br/><br/>
            <table border="1">
                <thead>
                    <tr>
                        <th>Start time</th>
                        <th>Stop time</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody id="scheduleTimeTableBody">

                </tbody>
            </table>
            <br/><br/>
            <input type="submit" name="submit" value="Submit" onclick="buildScheduleJson();"/>
            <br/><br/>

        </form:form>
    </body>
</html>
