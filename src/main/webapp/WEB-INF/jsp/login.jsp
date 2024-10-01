<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #12372A;
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                width: 300px;
                margin: 0 auto;

                -webkit-box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
                -moz-box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
                box-shadow: 0px 0px 105px -3px rgba(124,186,120,1);
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            span{
                text-align: center;
                font-size: xx-large;
                font-weight: bolder;
                color:white;
                margin: 50px 0;
                border-bottom: 3px solid #98E4FF;
                width: 10%;
            }
        </style>
    </head>
    <body>
        <span>cLINIc</span>
        <form name="loginForm" id="loginForm" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
            Username: <input type="text" name="username" id="username" /><br/><br/>
            Password: <input type="password" name="password" id="password" /><br/><br/>
            <input type="submit" value="Login"/>
        </form>
    </body>
</html>
