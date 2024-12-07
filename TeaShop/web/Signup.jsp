
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up </title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="colorlib-regform-7/fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="colorlib-regform-7/css/style.css">
</head>
<body>
    <section class="signup">
        <div class="container">
            <div class="signup-content">
                <div class="signup-form">

                    <h4 style="color: red">${errorMessage}</h4>
                    <h2 class="form-title">Sign up</h2>
                    <form action="signup" method="POST" class="register-form" id="register-form">
                        <div class="form-group">
                           
                            <label for="email"><i class="zmdi zmdi-email"></i></label>
                            <input type="email" name="email" value="${email}" id="email" placeholder="Email" required />
                        </div>
                        <div class="form-group">
                            <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                          <input type="password" name="pass" value="${pass}" id="pass" placeholder="Password" required/>
                        </div>
                        <div class="form-group">
                            <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                            <input type="password" name="re_pass" value="${re_pass}" id="re_pass" placeholder="Repeat your password" required/>
                        </div>
                        <div class="form-group">
                            <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="user" value="${user}" id="name" placeholder="Your Name" required/>
                        </div>
                        <div class="form-group">
                            <label for="phone_number"><i class="zmdi zmdi-phone"></i></label>
                            <input type="number" name="phone_number" value="${phone_number}" id="phone_number" placeholder="Phone Number" required/>
                        </div>

                        <div class="form-group">
                            <label for="address"><i class="zmdi zmdi-home"></i></label>
                           <input type="text" name="address" value="${address}" id="address" placeholder="Address" required/>
                        </div>
                        <div>
                            Gender:<input id="rd" type="radio" name="gender" value="Male" required="">Male
                            <input id="rd" type="radio" name="gender" value="Female" required="">Female
                        </div>

                        <div class="form-group">
                            <br><input type="checkbox" id="rd"  required>&emsp;
                            I agree all statements in  Terms of service
                        </div>


                        <div class="form-group form-button">
                            <input type="submit" name="signup" id="signup" class="form-submit" value="Register"/>
                        </div>
                    </form>
                </div>

                <div class="signup-image">
                    <figure><img src="colorlib-regform-7/images/signup-image.jpg" alt="sing up image"></figure>
                    <a href="login.jsp" class="signup-image-link">I am already member</a>
                </div>
            </div>
        </div>
    </section>
</body>

