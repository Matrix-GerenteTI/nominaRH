<?php
	session_start();
	require_once("mysql.php");
	//conexion();
	$op = $_GET['op'];
	switch($op){
		
		case "cargaFormato":{
			$array = array();
			$formato = $_POST['formato'];
			$query = "SELECT * FROM pformatos WHERE idformato='".$formato."'";
			$sql = $conexion->query($query);
			$n=0;
			while($row = $sql->fetch_assoc()){
				$array[$n]['texto'] = base64_decode($row['texto']);
				$n++;
			}
			echo json_encode($array);			
			break;
		}
		
		case "cmbFormatos":{
			$html = "<option value=''>Seleccione...</option>";
			$query = "SELECT id, descripcion FROM cformato WHERE status=1 ORDER BY descripcion";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['id']."'>".$row['descripcion']."</option>";
			echo $html;
			break;
		}
		
		case "getBadgets":{
			$arrColor = array('primary','secondary','success','danger','warning','info','light','dark');
			$formato = $_POST['formato'];
			$array = array();
			$n=0;
			$n2 = 0;
			$query = "SELECT 	b.* 
					  FROM 		cbadgets b 
					  INNER JOIN rformatobadget fb ON b.id=fb.idbadget
					  WHERE 	fb.idformato='".$formato."' 
					  AND 		b.status=1 
					  ORDER BY 	b.campo";
			$sql = $conexion->query($query);
			$arrTabla = array();
			while($row = $sql->fetch_assoc()){
				if(!in_array($row['tabla'],$arrTabla)){
					$n2++;
					$array[$n]['color'] = $arrColor[$n2];
					$arrTabla[] = $row['tabla'];
				}else{
					$array[$n]['color'] = $arrColor[$n2];
				}
				$array[$n]['campo'] = $row['campo'];
				$n++;
			}
			echo json_encode($array);
			break;
		}

		
		case "guardaFormato":{
			//echo json_encode($_POST);
			$formato = $_POST['formato'];
			$texto = $_POST['texto'];
			//echo $texto;
			$n = 0;
			$query = "SELECT * FROM pformatos WHERE idformato='".$formato."'";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$n++;
			}
			if($n>0){
				$q1 = "UPDATE pformatos SET texto='".base64_encode($texto)."' WHERE idformato='".$formato."'";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA FORMATO','FORMATOS','".base64_encode($q1)."',NOW(),NOW(),1)");
			}else{
				$q1 = "INSERT INTO pformatos (idformato,texto) VALUES ('".$formato."','".base64_encode($texto)."')";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREA FORMATO','FORMATOS','".base64_encode($q1)."',NOW(),NOW(),1)");
			}
			$s1 = $conexion->query($q1);
			if(!$s1)		
				echo 0;
			else
				echo 1;
			break;
		}
	}


function formateaFechaSLASH($fecha){
	$arr = explode("/",$fecha);
	$fechaNueva = $arr[2]."-".$arr[1]."-".$arr[0];
	return $fechaNueva;	
}

function formateaFechaGUION($fecha){
	$arr = explode("-",$fecha);
	$fechaNueva = $arr[2]."/".$arr[1]."/".$arr[0];
	return $fechaNueva;	
}
?>