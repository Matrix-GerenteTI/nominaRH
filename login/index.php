<?php
if(!isset($_SESSION)){
	session_start();
}
if(isset($_SESSION['titulo'])){
	echo "Si";
	header('Location: /nomina/index.php');
}
?>
<!DOCTYPE html>

<!--
Template Name: NobleUI - HTML Bootstrap 5 Admin Dashboard Template
Author: NobleUI
Website: https://www.nobleui.com
Portfolio: https://themeforest.net/user/nobleui/portfolio
Contact: nobleui123@gmail.com
Purchase: https://1.envato.market/nobleui_admin
License: For each use you must have a valid license purchased only from above link in order to legally use the theme for your project.
-->
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  <meta name="description" content="Responsive HTML Admin Dashboard Template based on Bootstrap 5">
	<meta name="author" content="NobleUI">
	<meta name="keywords" content="nobleui, bootstrap, bootstrap 5, bootstrap5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<title>RR.HH</title>

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet">
  <!-- End fonts -->

	<!-- core:css -->
	<link rel="stylesheet" href="/nomina/assets/vendors/core/core.css">
	<!-- endinject -->

	<!-- Plugin css for this page -->
	<!-- End plugin css for this page -->

	<!-- inject:css -->
	<link rel="stylesheet" href="/nomina/assets/fonts/feather-font/css/iconfont.css">
	<link rel="stylesheet" href="/nomina/assets/vendors/flag-icon-css/css/flag-icon.min.css">
	<!-- endinject -->

  <!-- Layout styles -->  
	<link rel="stylesheet" href="/nomina/assets/css/demo1/style.css">
  <!-- End layout styles -->

  <link rel="shortcut icon" href="/nomina/assets/images/favicon.png" />
</head>
<body>
	<div class="main-wrapper">
		<div class="page-wrapper full-page">
			<div class="page-content d-flex align-items-center justify-content-center">

				<div class="row w-100 mx-0 auth-page">
					<div class="col-md-8 col-xl-6 mx-auto">
						<div class="card">
							<div class="row">
								<div class="col-md-4 pe-md-0" style="border-right: #f9fafb 5px solid">
									<div class="auth-side-wrapper" style="background-image: url(/nomina/assets/images/fondoLogin.png); background-size: cover; background-position: center">
										<div class="row" style="vertical-align: center">
											<div class="col-4 col-sm-12" style="padding:1em; text-align:center">
												<!-- <img src="nomina/assets/images/fondologin.png" style="width:100%; max-width:200px"  class="mx-auto d-block" /> -->
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-8 ps-md-0">
									<div class="auth-form-wrapper px-4 py-5">
										<a href="#" class="noble-ui-logo d-block mb-2">RR.HH<span>Matrix</span></a>
										<h5 class="text-muted fw-normal mb-4">Bienvenido! Ingresa con tu usuario.</h5>
										<form class="forms-sample">
										<div class="mb-3">
											<label for="userEmail" class="form-label">Usuario</label>
											<input type="email" class="form-control" id="username" name="username" placeholder="">
										</div>
										<div class="mb-3">
											<label for="userPassword" class="form-label">Contraseña</label>
											<input type="password" class="form-control" id="password" name="password" autocomplete="current-password" placeholder="">
										</div>
										<div class="mb-3">
											<label for="userConexion" class="form-label">Conexión</label>
											<select class="form-control" id="conexion" name="conexion" >
												<option value="dbnomina_new">Matrix</option>
											</select>
										</div>
										<div class="form-check mb-3">
											<input type="checkbox" class="form-check-input" id="authCheck">
											<label class="form-check-label" for="authCheck">
											Recordarme
											</label>
										</div>
										<div>
											<a href="javascript: validar()" class="btn btn-primary me-2 mb-2 mb-md-0 text-white">Entrar</a>
										</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- core:js -->
	<script src="/nomina/assets/vendors/core/core.js"></script>
	<!-- endinject -->

	<!-- Plugin js for this page -->
	<!-- End plugin js for this page -->

	<!-- inject:js -->
	<script src="/nomina/assets/vendors/feather-icons/feather.min.js"></script>
	<script src="/nomina/js/signin.js"></script>
	<script type="text/javascript">
	$("#username").keypress(function(e){
		if(e.keyCode == 13)
			validar();
	});
	
	$("#password").keypress(function(e){
		if(e.keyCode == 13)
			validar();
	});
	
	function validar(){
		var username = $("#username").val();
		var password = $("#password").val();
		var conexion = $("#conexion").val();
		var params = "username="+username+"&password="+password;
		$.post("ajax.php?opc=validaCliente", "conexion="+conexion+"&username="+username+"&password="+password, function(resp){
			console.log(resp)
			//alert(resp);
			if(resp == 1)
				document.location = "/nomina/index.php";
			if(resp == 0)
				alert("Usuario y/o contraseña incorrecta");	
			if(resp == 2)
				alert("El usuario aun no ha sido activado");
			if(resp == 3)
				document.location = "/nomina/index.php";
		});
	}
	
	</script>
</body>

</html>
