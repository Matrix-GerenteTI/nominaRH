<?php
	session_start();
	require_once("mysql.php");
	//conexion();
	$op = $_GET['op'];
	switch($op){
		case "lista":{
			$array = array();
			$query = "SELECT 	u.*,t.descripcion as grupo 
					  FROM pusuarios u 
					  INNER JOIN ctipousuario t ON u.tipo=t.id
					  WHERE u.status>0 
					  ORDER BY grupo,nombre";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[] = $row;	
			}
			echo json_encode($array);
			break;
		}
		
		case "cmbTipo":{
			$html = "";
			$query = "SELECT * FROM ctipousuario WHERE status=1";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['id']."'>".$row['descripcion']."</option>";
			echo $html;
			break;
		}
		
		case "cargar":{
			$id = $_POST['id'];
			$query = "SELECT * FROM pusuarios WHERE username='".$id."'";
			$sql = $conexion->query($query);
			$row = $sql->fetch_all(MYSQLI_ASSOC);
			echo json_encode($row[0]);
			break;
		}
		
		case "guardar":{
			$id = $_POST['username'];
			$query = "SELECT COUNT(*) as registros FROM ".$_SESSION['rfc'].".pusuarios WHERE username='".$id."'";
			$sql = $conexion->query($query);
			$row = $sql->fetch_assoc();
			if($row['registros']>0){

				$queryConcat = '';
				$querylogins = "SELECT * FROM logins.clientes WHERE status=1";
				$sqllogins = $conexion->query($querylogins);
				while($rowlogins = $sqllogins->fetch_assoc()){
					$queryConcat.= " SELECT COUNT(*) AS registros FROM ".$rowlogins['rfc'].".pusuarios ua WHERE ua.username='".$_POST['username']."' UNION";
				}
				$queryConcat = substr($queryConcat,0,-5);
				$queryConexions = "SELECT SUM(a.registros) AS registros FROM (".$queryConcat.") AS a";
				$sqlConexions = $conexion->query($queryConexions);
				$rowConexions = $sqlConexions->fetch_assoc();
				if($rowConexions['registros']==0){
					$query = "UPDATE ".$_SESSION['rfc'].".pusuarios SET password='".$_POST['password']."',
												tipo='".$_POST['tipo']."',
												nombre='".$_POST['nombre']."',
												email='".$_POST['email']."',
												idempresa='".$_POST['idempresa']."'
											WHERE username='".$id."'";
					$sql = $conexion->query($query);
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA USUARIO','USUARIOS','".base64_encode($query)."',NOW(),NOW(),2)");
					if(!$sql)
						echo 0;
					else
						echo 1;
				}else{
					echo 2;
				}
			}else{
				$queryConcat = '';
				$querylogins = "SELECT * FROM logins.clientes WHERE status=1";
				$sqllogins = $conexion->query($querylogins);
				while($rowlogins = $sqllogins->fetch_assoc()){
					$queryConcat.= " SELECT COUNT(*) AS registros FROM ".$rowlogins['rfc'].".pusuarios ua WHERE ua.username='".$_POST['username']."' UNION";
				}
				$queryConcat = substr($queryConcat,0,-5);
				$queryConexions = "SELECT SUM(a.registros) AS registros FROM (".$queryConcat.") AS a";
				$sqlConexions = $conexion->query($queryConexions);
				$rowConexions = $sqlConexions->fetch_assoc();
				if($rowConexions['registros']==0){
					$query = "INSERT INTO pusuarios (username,
													password,
													tipo,
													nombre,
													email,
													idempresa)
											VALUES ('".$id."',
													'".$_POST['password']."',
													'".$_POST['tipo']."',
													'".$_POST['nombre']."',
													'".$_POST['email']."',
													'".$_POST['idempresa']."')";
					$sql = $conexion->query($query);
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREA USUARIO','USUARIOS','".base64_encode($query)."',NOW(),NOW(),2)");
					if(!$sql)
						echo 0;
					else
						echo 1;
				}else{
					echo 2;
				}
			}
			break;
		}
		
		case "eliminar":{
			$id = $_POST['username'];
			$query = "SELECT COUNT(*) as registros FROM pusuarios WHERE username='".$id."'";
			$sql = $conexion->query($query);
			$row = $sql->fetch_assoc();
			if($row['registros']>0){
				$query2 = "UPDATE pusuarios SET status=0 WHERE username='".$id."'";
				$sql2 = $conexion->query($query2);
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ELIMINA USUARIO','USUARIOS','".base64_encode($query2)."',NOW(),NOW(),3)");
				if(!$sql2)
					echo 1;
				else
					echo 2;
			}else
				echo 0;
			break;
		}
	}
?>