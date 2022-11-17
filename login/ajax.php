<?php
error_reporting(E_ALL);
session_start();
$conexion=new mysqli("172.16.0.91","nuevo","M@tr1x2017","dbnomina");
//$db=mysql_select_db("clientes",$conexion);
$opc = $_GET['opc'];
switch($opc)
{
	case 'validaCliente':
	{
		$username = $_POST['username'];
		$password = $_POST['password'];
		$query = "SELECT 	u.*,t.descripcion as tipousuario 
					FROM 	pusuarios u
					INNER JOIN ctipousuario t ON u.tipo=t.id
					WHERE u.username='".$username."' AND u.password='".$password."'";
		$sql = $conexion->query($query);
		$existe = 0;
		while($row = $sql->fetch_assoc()){	
			if($row['status']==0)
				$existe = 2;
			else{
				$query2 = "SELECT * FROM ppatron WHERE id=1";
				$sql2 = $conexion->query($query2);
				$b = 0;
				while($row2 = $sql2->fetch_assoc()){
					$_SESSION['idCliente'] = $row2['id'];
					$_SESSION['rfc'] = $row2['rfc'];
					$_SESSION['titulo'] = $row2['titulo'];
					$_SESSION['background'] = $row2['background'];
					$_SESSION['abreviatura'] = $row2['abreviatura'];
					$_SESSION['template'] = $row2['template'];
					$b = 1;
				}
				
				$_SESSION['permisos'] = array();
				$query3 = "SELECT * FROM rusuariomodulo WHERE usuario='".$username."'";
				$sql3 = $conexion->query($query3);
				while($rowPermisos = $sql3->fetch_assoc()){
					$_SESSION['permisos'][$rowPermisos['idmodulo']] = $rowPermisos;
				}

				if($row['tipo']==1){
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$row['username']."','INGRESO AL SISTEMA','SESION','".base64_encode($query)."',NOW(),NOW(),2)");
					$existe = 1;
					$_SESSION['userid'] = $row['username'];
					$_SESSION['username'] = $row['nombre'];
					$_SESSION['usertype'] = $row['tipousuario'];
					$_SESSION['usernip'] = $row['idempleado'];
				}else{
					$existe = 3;
					$_SESSION['userid'] = $row['username'];
					$_SESSION['username'] = $row['nombre'];
					$_SESSION['usertype'] = $row['tipousuario']; 
					$_SESSION['usernip'] = $row['idempleado'];
				}
			}
		}
		echo $existe;
		// $query = "SELECT * FROM clientes WHERE usuario='".$_POST['cliente']."' AND password='".$_POST['password']."'";
		// $sql = $conexion->query($query);
		// $b = 0;
		// while($row = $sql->fetch_assoc()){
		// 	$_SESSION['idCliente'] = $row['id'];
		// 	$_SESSION['rfc'] = $row['rfc'];
		// 	$_SESSION['titulo'] = $row['nombre'];
		// 	$_SESSION['background'] = $row['url'];
		// 	$_SESSION['abreviatura'] = $row['abreviatura'];
		// 	$_SESSION['template'] = $row['template'];
		// 	$b = 1;
		// }
		
		// if($b>0)
		// 	echo 1;
		// else
		// 	echo 0;
		break;
	}
}
?>