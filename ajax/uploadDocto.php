<?php
if(!isset($_SESSION)){
    session_start(); 
}
require_once("mysql.php");
$return = array('ok'=>TRUE);

$nip = $_POST['nip'];
$tipo = $_POST['tipo'];

$nombre_archivo = $_FILES['archivo']['name'];
$tipo_archivo = $_FILES['archivo']['type'];
$tamano_archivo = $_FILES['archivo']['size'];
$tmp_archivo = $_FILES['archivo']['tmp_name'];

$fecha = date("Ydm");
$hora = date("hms");

$extencion = explode('.',$nombre_archivo);
foreach($extencion as $ext)

$nombre = $_SESSION['rfc']."_".$nip.'_'.$fecha.$hora.".".$ext;

$archivador = './documentos/'.$nombre;

if (!move_uploaded_file($tmp_archivo, $archivador)) {
	$return = array('ok' => FALSE, 'msg' => 'Ocurrio un error al subir el archivo. No pudo guardarse.', 'status' => 'error');
	echo 0;
}else{
	$query = "INSERT INTO pdocumentos (file,idtipo,idempleado) VALUES ('".$nombre."',".$tipo.",".$nip.")";
	$sql = $conexion->query($query);
	$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','SUBIR DOCUMENTO','EMPLEADOS','".base64_encode($query)."',NOW(),NOW(),2)");
	if($sql)
		echo 1;
	else
		echo 2;
}
?>