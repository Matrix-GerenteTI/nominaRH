<?php
	ini_set('max_execution_time', 0);
	session_start();
	require_once("mysql.php");
	// conexion();
	$incomingData = isset($_GET['op']) ? $_GET['op'] : ( json_decode(file_get_contents('php://input'), true) );
	$op = isset($_GET['op']) ? $_GET['op'] : $incomingData['op'];
	switch($op){
		
		case "comboSelected":{
			$catalogo = $_POST['catalogo'];
			//$scatalogo = $_POST['scatalogo'];
			$echo = "";
			if(isset($_POST['padre']))
				$query = "SELECT * FROM c".$catalogo." WHERE id".$_POST['padre']."=".$_POST['valorpadre']." AND status=1";
			else
				$query = "SELECT * FROM c".$catalogo." WHERE status=1";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				if($_POST['valor']==$row['id'])
					$echo.= '<option value="'.$row['id'].'" selected>'.strtoupper($row['descripcion']).'</option>';
				else
					$echo.= '<option value="'.$row['id'].'">'.strtoupper($row['descripcion']).'</option>';
			echo $echo;
			break;
		}
		
		case "listaDeptos":{
			$query = "SELECT 	*,".$_SESSION['permisos'][2]['guardar']." as permiso								
					  FROM 		cdepartamento
					  WHERE 		status=1
					  ORDER BY descripcion ASC";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[] = $row;
			}
			echo json_encode($array);
			break;
		}
		
		case 'listaSucursales':{
			 $querySucursales = "SELECT * FROM csucursal WHERE status = 1 ";
			 $exeSucursales = $conexion->query( $querySucursales );
			 
			 echo json_encode( $exeSucursales->fetch_all(MYSQLI_ASSOC) );

			break;
		}

		case "listaUdns":{
			$query = "SELECT 	u.*,z.descripcion as zona								
					  FROM 		csucursal u 
					  INNER JOIN czona z ON u.zona=z.id
					  WHERE 		u.status=1
					  ORDER BY z.descripcion,u.descripcion ASC";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[] = $row;
			}
			echo json_encode($array);
			break;
		}

		case "listaZonas":{
			$query = "SELECT 	*								
					  FROM 		czona
					  WHERE 		status=1
					  ORDER BY descripcion ASC";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[] = $row;
			}
			echo json_encode($array);
			break;
		}

		case "listaPuestos":{
			$query = "SELECT 	p.id as id,
								p.descripcion as puesto,
								d.descripcion as departamento,".$_SESSION['permisos'][2]['guardar']." as permiso
					  FROM 		cpuesto p
					  INNER JOIN cdepartamento d ON p.iddepartamento=d.id
					  AND 		p.status=1 
					  ORDER BY d.descripcion,p.descripcion ASC";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[] = $row;
			}
			echo json_encode($array);
			break;
		}
		
		case "guardaDepto":{
			$id = $_POST['id'];
			$departamento = $_POST['descripcion'];
			if($id>0){
				$query = "UPDATE cdepartamento SET descripcion='".$departamento."' WHERE id='".$id."'";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA DEPARTAMENTO','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}else{
				$query = "INSERT INTO cdepartamento (idpatron,descripcion,status,idpadre) VALUES (1,'".$departamento."',1,0)";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREA DEPARTAMENTO','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}
			$sql = $conexion->query($query);
			if(!$sql)
				echo 0;
			else
				echo 1;
			break;
		}
		
		case "guardaPuesto":{
			$id = $_POST['id'];
			$departamento = $_POST['iddepartamento'];
			$puesto = $_POST['descripcion'];
			if($id>0){
				$query = "UPDATE cpuesto SET iddepartamento='".$departamento."',descripcion='".$puesto."' WHERE id='".$id."'";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA PUESTO','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}else{
				$query = "INSERT INTO cpuesto (iddepartamento,descripcion,status,idpadre) VALUES ('".$departamento."','".$puesto."',1,0)";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREA PUESTO','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}
			$sql = $conexion->query($query);
			if(!$sql)
				echo 0;
			else
				echo 1;
			break;
		}

		case "guardaZona":{
			$id = $_POST['id'];
			$zona = $_POST['zona'];
			if($id>0){
				$query = "UPDATE czona SET descripcion='".$zona."' WHERE id='".$id."'";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA ZONA','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}else{
				$query = "INSERT INTO czona (descripcion) VALUES ('".$zona."')";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREA ZONA','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}
			$sql = $conexion->query($query);
			if(!$sql)
				echo 0;
			else
				echo 1;
			break;
		}

		case "guardaUdn":{
			$id = $_POST['id'];
			$udn = $_POST['udn'];
			$zona = $_POST['zona'];
			$lat = $_POST['lat'];
			$long = $_POST['long'];
			$rango = $_POST['rango'];
			if($id>0){
				$query = "UPDATE csucursal SET descripcion='".$udn."',zona=".$zona.",latitud='".$lat."',longitud='".$long."',rango=".$rango." WHERE id=".$id;
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA UDN','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}else{
				$query = "INSERT INTO csucursal (descripcion,zona,latitud,longitud,rango) VALUES ('".$udn."',".$zona.",'".$lat."','".$long."',".$rango.")";
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREA UDN','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			}
			$sql = $conexion->query($query);
			if(!$sql)
				echo 0;
			else
				echo 1;
			break;
		}		

		case "agregaEvento":{
			$fecha = $_POST['fecha'];
			$tipo = $_POST['tipo'];
			$entrada = $_POST['entrada'];
			$salida = $_POST['salida'];
			$evento = $_POST['evento'];
			$descripcion = $_POST['descripcion'];
			//Validar horario especial y suspensión
			$qf = "SELECT * FROM pcalendario WHERE fecha='".$fecha."' AND tipo='".$tipo."'";
			$sf = $conexion->query($qf);
			$hay = 0;
			while($rf = $sf->fetch_assoc()){
				$hay++;
			}
			if($hay==0){
				$query = "INSERT INTO pcalendario (fecha,tipo,entrada,salida,etiqueta,descripcion) VALUES ('".$fecha."',".$tipo.",'".$entrada."','".$salida."','".$evento."','".$descripcion."')";
				$sql = $conexion->query($query);
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','AGREGA EVENTO','CALENDARIO','".base64_encode($query)."',NOW(),NOW(),2)");
				if(!$sql)
					echo 0;
				else
					echo 1;
			}else{
				echo 2;
			}
			break;
		}	
		
		case "eliminaEvento":{
			$id = $_POST['id'];
			$query = "UPDATE pcalendario SET status=99 WHERE id='".$id."'";
			$sql = $conexion->query($query);
			$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ELIMINA EVENTO','CALENDARIO','".base64_encode($query)."',NOW(),NOW(),3)");
			if(!$sql)
				echo 0;
			else
				echo 1;
			break;
		}
		
		case "eliminaItem":{
			$tabla = $_POST['tabla'];
			$id = $_POST['id'];
			$query = "UPDATE c".$tabla." SET status=99 WHERE id='".$id."'";
			$sql = $conexion->query($query);
			$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ELIMINA ".$tabla."','EMPRESA','".base64_encode($query)."',NOW(),NOW(),2)");
			if(!$sql)
				echo 0;
			else
				echo 1;
			break;
		}
		
		case "carga":{
			$query = "SELECT 	*, s.id as estado
					  FROM 		ppatron e
					  INNER JOIN pdireccion d ON d.id=e.iddireccion
					  INNER JOIN cestado s ON s.id=d.idestado
					  WHERE 	e.status=1";
			$sql = $conexion->query($query);
			$row = $sql->fetch_assoc();
			echo json_encode($row);
			break;
		}

		case "cargaDepto":{
			$query = "SELECT 	*
					  FROM cdepartamento
					  WHERE 	status=1
					  AND 		id=".$_POST['id'];
			$sql = $conexion->query($query);
			echo json_encode($sql->fetch_assoc());
			break;
		}

		case "cargaPuesto":{
			$query = "SELECT 	*
					  FROM cpuesto
					  WHERE 	status=1
					  AND 		id=".$_POST['id'];
			$sql = $conexion->query($query);
			echo json_encode($sql->fetch_assoc());
			break;
		}

		case "cargaUDN":{
			$query = "SELECT 	u.*, z.id as zona
					  FROM 		csucursal u
					  INNER JOIN czona z ON u.zona=z.id
					  WHERE 	u.status=1
					  AND 		u.id=".$_POST['id'];
			$sql = $conexion->query($query);
			echo json_encode($sql->fetch_assoc());
			break;
		}

		case "cargaZona":{
			$query = "SELECT 	*
					  FROM 		czona z
					  WHERE 	z.status=1
					  AND 		z.id=".$_POST['id'];
			$sql = $conexion->query($query);
			echo json_encode($sql->fetch_assoc());
			break;
		}
		
		case "guardar":{			
			$query1 = "UPDATE ppatron SET 	rfc='".$_POST['rfc']."',
											nombre_razsoc='".$_POST['nombre']."',
											curp='".$_POST['curp']."',
											registropatronal='".$_POST['registropatronal']."',
											idregimenfiscal='".$_POST['regimenfiscal']."',
											telefono='".$_POST['telefono']."',
											email='".$_POST['email']."'
									  WHERE id='1'";
			$sql1 = $conexion->query($query1);
			if(!$sql1){
				echo 0;
			}else{
				$query2 = "UPDATE pdireccion SET 	calle='".$_POST['calle']."',
													numext='".$_POST['numext']."',
													numint='".$_POST['numint']."',
													colonia='".$_POST['colonia']."',
													municipio='".$_POST['municipio']."',
													cp='".$_POST['cp']."',
													idestado='".$_POST['estado']."'
											  WHERE id='1'";
				$sql2 = $conexion->query($query2);
				if(!$sql2){
					echo 0;
				}else{
					echo 1;
				}
			}
			break;
		}

		case 'getCalendario':{
			$tipos = array(1=>'inhabil',2=>'especial',3=>'otro');
			$backgrounds = array(1=>'rgba(241,0,117,.25)',2=>'rgba(253,126,20,.25)',3=>'rgba(91,71,251,.2)');
			$bordercolors = array(1=>'#f10075',2=>'#fd7e14',3=>'#5b47fb');
			$fontcolors = array(1=>'#000000',2=>'#000000',3=>'#000000');
			$arr = array('inhabil'=>array(),'especial'=>array(),'otro'=>array());
			$query = "SELECT 	*,
								CASE tipo 
									WHEN 1 THEN 'Suspensión de labores'
									WHEN 2 THEN 'Horario especial' 
									WHEN 3 THEN 'Evento' 
								END as tipotxt
						FROM 	pcalendario
						WHERE 	status=1 
						ORDER BY tipo";
			$sql = $conexion->query($query);
			$n=0;
			$tipo = 1;
			while($row = $sql->fetch_assoc()){
				if($tipo!=$row['tipo']){
					$tipo = $row['tipo'];
					$n = 0;
				}
				$arr[$tipos[$row['tipo']]]['id'] = $row['tipo'];
				$arr[$tipos[$row['tipo']]]['backgroundColor'] = $backgrounds[$row['tipo']];
				$arr[$tipos[$row['tipo']]]['borderColor'] = $bordercolors[$row['tipo']];
				$arr[$tipos[$row['tipo']]]['textColor'] = $fontcolors[$row['tipo']];
				$arr[$tipos[$row['tipo']]]['events'][$n]['id'] = $row['id'];
				$arr[$tipos[$row['tipo']]]['events'][$n]['start'] = $row['fecha'];
				$arr[$tipos[$row['tipo']]]['events'][$n]['end'] = $row['fecha'];
				$arr[$tipos[$row['tipo']]]['events'][$n]['title'] = $row['etiqueta'];
				if($row['tipo']==2)
					$arr[$tipos[$row['tipo']]]['events'][$n]['description'] = '<p><b>[ '.$row['tipotxt'].' ]</b></p>'.'<p><b>[ '.$row['entrada'].' - '.$row['salida'].' ]</b></p>'.$row['descripcion'];
				else
					$arr[$tipos[$row['tipo']]]['events'][$n]['description'] = '<p><b>[ '.$row['tipotxt'].' ]</b></p>'.$row['descripcion'];
				$n++;
			}
			echo json_encode($arr);
			break;
		}

		case 'listaPuestoDepartamento':
			$departamento = $_GET['departamento'];
			$queryPuestosDepa = "SELECT 	p.* 
								 from 		cpuesto p 
								 INNER JOIN pcontrato c ON c.idpuesto=p.id
								 where 		p.iddepartamento = $departamento 
								 and 		p.status=1
								 AND 		c.status=1 
								 GROUP BY 	p.id 
								 ORDER BY  p.descripcion";
			$exePuesto = $conexion->query($queryPuestosDepa);
			echo json_encode ($exePuesto->fetch_all(MYSQLI_ASSOC)) ;
			break;
		
		case "listaDeptosOrg":{
			$query = "SELECT 	d.*								
					  FROM 		cdepartamento d
					  INNER JOIN pcontrato c ON c.iddepartamento=d.id
					  WHERE 	d.status=1
					  AND 	c.status=1
					  GROUP BY d.id
					  ORDER BY d.descripcion ASC";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[] = $row;
			}
			echo json_encode($array);
			break;
		}

		case "listaPuestosOrg":{
			$query = "SELECT 	p.id as id,
								p.descripcion as puesto,
								d.descripcion as departamento
					  FROM 		cpuesto p
					  INNER JOIN cdepartamento d ON p.iddepartamento=d.id
					  INNER JOIN pcontrato c ON c.idpuesto=d.id
					  AND 		p.status=1 
					  AND 		c.status=1
					  GROUP BY p.id
					  ORDER BY d.descripcion,p.descripcion ASC";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[] = $row;
			}
			echo json_encode($array);
			break;
		}

		case 'addPuestoSuperior':
		
			$puesto['dptoSup'] = $incomingData['dptoSup'];
			$puesto['puestoSup'] = $incomingData['puestoSup'];
			$puesto['dptoDep'] = $incomingData['dptoDep'];
			$puesto['puestoDep'] = $incomingData['puestoDep'];
			$puesto['sucursal'] = $incomingData['sucursal'] == -1 ?  "NULL" : $incomingData['sucursal'];

			$abstraccion = implode(',', $incomingData['abstraccion']);
			
			if ( esPuestoHijoDe($conexion, $puesto, $incomingData['sucursal']) === 0 ) {
				$queryInsertaPuestoHijo = "INSERT INTO porganigrama VALUES('',".$puesto['puestoDep'] .",".$puesto['dptoDep'].",".$puesto['sucursal'].",".$puesto['puestoSup'].",".$puesto['dptoSup'].",'$abstraccion', 1)";
				
				$conexion->query( $queryInsertaPuestoHijo);
				if( $conexion->affected_rows ){
					echo json_encode( estructuraOrganigrama($conexion) );
				}
				else{
					echo json_encode( array());
				}
			}else{
				echo "Somos familia :(";
			}
			break;
		
			case 'getOrganigrama':
				echo json_encode( estructuraOrganigrama($conexion) );
			break;
		
			case 'eliminarNodoOrganigrama':
				$idNodo = $_GET['nodo'];
				$queryEliminarNodo = "DELETE FROM porganigrama where id=$idNodo";
				
				$exeEliminanodo = $conexion->query( $queryEliminarNodo);

				echo  $conexion->affected_rows;
				break;
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

 function esPuestoHijoDe($conexion, $puesto, $sucursal = -1)
{
	extract( $puesto );
	$condicionSucursal = "";
	if ( $sucursal != -1 ) {
		$condicionSucursal = " AND idsucursal = $sucursal";
	}
	//comprueba si el puesto que se quiere jerarquizar no sea padre del puesto hijo
	$queryHijo = "SELECT idhijo,idpadre FROM porganigrama WHERE (idhijo=$puestoSup AND iddepa_hijo=$dptoSup )AND (idpadre=$puestoDep AND iddepa_padre=$dptoDep) $condicionSucursal";
	if ( $puestoSup == NULL || $puestoSup == '') {
		$queryHijo ="SELECT idhijo,idpadre FROM porganigrama WHERE idhijo is null  AND idpadre=$puestoDep AND iddepa_padre=$dptoDep";
	}
	// echo $queryHijo."<br>";
	$exeHijo = $conexion->query( $queryHijo );
	$puestoPadre = $exeHijo->fetch_all(MYSQLI_ASSOC);
	// var_dump( $puestoPadre);
	// echo "<br>";
	if ( sizeof($puestoPadre) == 0) {
		
		$queryGetPadre = "SELECT idpadre,id,iddepa_padre FROM porganigrama  WHERE idhijo=$puestoDep AND iddepa_hijo=$dptoDep $condicionSucursal";
		if ( $puestoSup == null || $puestoSup == '') {
			$queryGetPadre = "SELECT idpadre,id,iddepa_padre FROM porganigrama  WHERE idhijo is  null ";
		}
		// echo "$queryGetPadre <br>";
		$exePadre = $conexion->query( $queryGetPadre );
		$padre = $exePadre->fetch_all( MYSQLI_ASSOC);


		if ( sizeof($padre) == 0) {
			return 0;
			// esPuestoHijoDe($conexion, $puesto, $padre[0]['idpadre']);
		}else{
			
			if ( ($padre[0]['idpadre'] == $puestoSup) && ($padre[0]['iddepa_padre'] == $puestoSup) ) {
				// echo "nta? $puestoDep  $dptoDep  ---- ".$padre[0]['idpadre']."  ".$padre[0]['iddepa_padre'];
				return 1;
			}
			// if ( $padre[0]['idpadre'] === NULL) {
			// 	echo "AAAAAAAAAAAAA";
			// 	return -1;
			// }
			// if ( $padre[0]['idpadre'] == null) {
			// 	echo "ENTREEEEE";

			// 	return "NO";
			// }		
			$puesto['puestoSup'] = $padre[0]['idpadre'] ;
			$puesto['dptoSup'] = $padre[0]['iddepa_padre'];
			return esPuestoHijoDe($conexion, $puesto, $sucursal);
		}
	}else{
		
		return 1;
	}
}

 function estructuraOrganigrama($conexion)
{
	$queryOrganigrama = "SELECT porganigrama.id,cpuesto.descripcion as puestoHijo,porganigrama.idhijo,puesto.descripcion as puestoPadre,porganigrama.idpadre,".$_SESSION['permisos'][2]['borrar']." as permiso 
												FROM porganigrama
												INNER JOIN cpuesto ON porganigrama.idhijo = cpuesto.id
												LEFT JOIN cpuesto AS puesto On puesto.id = porganigrama.idpadre 
												ORDER BY porganigrama.idpadre,cpuesto.descripcion";
	$exeOrganigrama = $conexion->query( $queryOrganigrama);
	return $exeOrganigrama->fetch_all(MYSQLI_ASSOC);
}
?>