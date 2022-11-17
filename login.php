<?php
session_start();
if(!isset($_SESSION['titulo']))
	header("Location: ../../index.php");
require_once("ajax/mysql.php");
$procesoactivacion = 0;
if(isset($_GET['acticode'])){
	$codigo = $_GET['acticode'];
	$query = "UPDATE usuarios SET status=1 WHERE codigo='".$_GET['acticode']."'";
	$sql = $conexion->query($query);
	if($sql){
		$procesoactivacion = 1;
		$query0 = "SELECT * FROM usuarios WHERE codigo='".$_GET['acticode']."'";
		$sql0 = $conexion->query($query0);
		while($row0 = $sql0->fetch_assoc()){
			$query1 = "INSERT INTO expedientes (pnombre,pemail,peso,talla,fecha,hora,idusuario) VALUES ('".$row0['nombre']."','".$row0['username']."',".$row0['peso'].",".$row0['altura'].",NOW(),NOW(),'".$row0['username']."')";	
			$sql1 = $conexion->query($query1);
		}
	}
}
?>
<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    <title>Sistema para Timbrado de N&oacute;mina</title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes"> 
    
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="css/font-awesome.css" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/pages/signin.css" rel="stylesheet" type="text/css">
</head>

<body>
	
	<div class="navbar navbar-fixed-top">
	
	<div class="navbar-inner" style="background: #<?=$_SESSION['background']?> !important">
		
		<div class="container">
			
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			
			<a class="brand">
				<i class="icon-book"></i>&nbsp;<?=$_SESSION['titulo']?>			
			</a>		
			
			<div class="nav-collapse">
				<ul class="nav pull-right">
					
					<li class="">						
						<a href="javascript: salirGlobal()">Cerrar sesi&oacute;n</a>						
					</li>
					
					<!--<li class="">						
						<a href="index.html" class="">
							<i class="icon-chevron-left"></i>
							Regresar
						</a>
						
					</li>-->
				</ul>
				
			</div><!--/.nav-collapse -->	
	
		</div> <!-- /container -->
		
	</div> <!-- /navbar-inner -->
	
</div> <!-- /navbar -->



<div class="account-container">
	
	<div class="content clearfix">
		

		
			<h1>Accesar</h1>		
			
			<div class="login-fields">
				<br>
                <?php
					if($procesoactivacion == 1){
				?>
				<p>Su cuenta ha sido activada. Ahora puede ingresar.</p>
                <?php
					}
				?>
				
				<div class="field">
					<label for="username">Username</label>
					<input type="text" id="username" name="username" value="" placeholder="Nombre de Usuario" class="login username-field" />
				</div> <!-- /field -->
				
				<div class="field">
					<label for="password">Password:</label>
					<input type="password" id="password" name="password" value="" placeholder="Contrase&ntilde;a" class="login password-field"/>
				</div> <!-- /password -->
				
			</div> <!-- /login-fields -->
			
			<div class="row">
					<input type="button" class="button btn btn-success btn-large" value="Entrar" onClick="validar()" />
			</div> <!-- .actions -->
			
			
			

		
	</div> <!-- /content -->
	
</div> <!-- /account-container -->



<!--<div style="padding:0px; margin:0px; text-align:center; padding-top:20px">
	<a href="#"><img src="recursos/disponibleapp.png" /></a>
</div> <!-- /login-extra -->


<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/signin.js"></script>
<script type="text/javascript">
	
	$("#username").keypress(function(e){
		if(e.keyCode == 13)
			validar();
	});
	
	$("#password").keypress(function(e){
		if(e.keyCode == 13)
			validar();
	});

	function salirGlobal(){
		$.post("ajax/ajaxlogin.php?op=salirGlobal","",function(resp){
			if(resp>0)
				document.location = "/index.php";
		});
	}
	
	function validar(){
		var username = $("#username").val();
		var password = $("#password").val();
		var params = "username="+username+"&password="+password;
		$.post("ajax/ajaxlogin.php?op=validaUsuario", params, function(resp){
			//alert(resp);
			if(resp == 1)
				document.location = "index.php";
			if(resp == 0)
				alert("Usuario y/o contraseña incorrecta");	
			if(resp == 2)
				alert("El usuario aun no ha sido activado");
			if(resp == 3)
				document.location = "empleados.php";
		});
	}
	
</script>
</body>

</html>
