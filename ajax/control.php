<?php
session_start();
if(isset($_SESSION['rfc'])){
	require_once("mysql.php");
	$_SESSION['permisos'] = [];
	$q1 = "SELECT * FROM rusuariomodulo WHERE usuario='".$_SESSION['userid']."'";
	$s1 = $conexion->query($q1);
	while($row = $s1->fetch_assoc()){
		$_SESSION['permisos'][$row['idmodulo']] = array('usuario'=>$row['usuario'],'idmodulo'=>$row['idmodulo'],'guardar'=>$row['guardar'],'borrar'=>$row['borrar'],'ver'=>$row['ver'],'imprimir'=>$row['imprimir']);
	}
}
if(!isset($_SESSION['username'])){
	header("Location: /nomina/login/index.php");
	die();
}


if(isset($_GET['closeSesion'])){
	session_destroy();
	header("Location: /nomina/login/index.php");	
}


?>
