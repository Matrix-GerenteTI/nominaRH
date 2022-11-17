<?php
	session_start();
	require_once("mysql.php");
	//conexion();
	$op = $_GET['op'];
	switch($op){
		
		case "carga":{
			$udn = $_POST['udn']=='%'?0:$_POST['udn'];
			$depto = $_POST['depto']=='%'?0:$_POST['depto'];
			$puesto = $_POST['puesto']=='%'?0:$_POST['puesto'];
			$empleado = $_POST['empleado']=='%'?0:$_POST['empleado'];
			$n = 0;
			$arr = array();
			$query = "SELECT 	*
					  FROM 		cparametrosasistencia p
					  WHERE 	p.idsucursal=".$udn."
					  AND 		p.iddepartamento=".$depto."
					  AND 		p.idpuesto=".$puesto."
					  AND 		p.idempleado=".$empleado."
					  AND 		p.status=1 
					  ORDER BY 	p.diasemana";
			$sql = $conexion->query($query);
			while($row1 = $sql->fetch_assoc()){
				$arr[] = $row1;
				$n++;
			}
			if($n==0){
				$np = 0;
				$queryp = "SELECT 	*
						FROM 		cparametrosasistencia p
						WHERE 	p.idsucursal=".$udn."
						AND 		p.iddepartamento=".$depto."
						AND 		p.idpuesto=".$puesto."
						AND 		p.idempleado=0
						AND 		p.status=1 
						ORDER BY 	p.diasemana";
				$sqlp = $conexion->query($queryp);
				while($rowp = $sqlp->fetch_assoc()){
					$arr[] = $rowp;
					$np++;
				}
				if($np==0){
					$nd = 0;
					$queryd = "SELECT 	*
							FROM 		cparametrosasistencia p
							WHERE 	p.idsucursal=".$udn."
							AND 		p.iddepartamento=".$depto."
							AND 		p.idpuesto=0
							AND 		p.idempleado=0
							AND 		p.status=1 
							ORDER BY 	p.diasemana";
					$sqld = $conexion->query($queryd);
					while($rowd = $sqld->fetch_assoc()){
						$arr[] = $rowd;
						$nd++;
					}
					if($nd==0){
						$ns = 0;
						$querys = "SELECT 	*
								FROM 		cparametrosasistencia p
								WHERE 	p.idsucursal=".$udn."
								AND 		p.iddepartamento=0
								AND 		p.idpuesto=0
								AND 		p.idempleado=0
								AND 		p.status=1 
								ORDER BY 	p.diasemana";
						$sqls = $conexion->query($querys);
						while($rows = $sqls->fetch_assoc()){
							$arr[] = $rows;
							$ns++;
						}
						if($ns==0){
							$nt = 0;
							$queryt = "SELECT 	*
									FROM 		cparametrosasistencia p
									WHERE 	p.idsucursal=0
									AND 		p.iddepartamento=0
									AND 		p.idpuesto=0
									AND 		p.idempleado=0
									AND 		p.status=1 
									ORDER BY 	p.diasemana";
							$sqlt = $conexion->query($queryt);
							while($rowt = $sqlt->fetch_assoc()){
								$arr[] = $rowt;
								$nt++;
							}
							if($nt==0)
								echo 0;
							else
								echo json_encode($arr);
						}else{
							echo json_encode($arr);
						}
					}else{
						echo json_encode($arr);
					}
				}else{
					echo json_encode($arr);
				}
			}else{
				echo json_encode($arr);
			}
			break;
		}
		
		//Autor Ing. Manuel Alavazarez
		//Obtener las sucursales para llenar el combobox
		case "cmbSucursal":{
			$html = "<option value='%'>TODAS</option>";
			$query = "SELECT id, descripcion FROM csucursal WHERE status=1 ORDER BY descripcion";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['id']."'>".$row['descripcion']."</option>";
			echo $html;
			break;
		}

		case "cmbDepartamento":{
			$html = "<option value='%'>TODOS</option>";
			$query = "SELECT * FROM cdepartamento WHERE status=1 ORDER BY descripcion";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['id']."'>".$row['descripcion']."</option>";
			echo $html;
			break;
		}

		case "cmbPuesto":{
			$html = "<option value='%'>TODOS</option>";
			$query = "SELECT * FROM cpuesto WHERE iddepartamento='".$_POST['iddepartamento']."' AND status=1 ORDER BY descripcion";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['id']."'>".$row['descripcion']."</option>";
			echo $html;
			break;
		}

		case "cmbEmpleado":{
			$html = "<option value='%'>TODOS</option>";
			$query = "SELECT 	e.nip,e.nombre 
					  FROM 		pempleado e 
					  INNER JOIN pcontrato c ON e.nip=c.nip
					  WHERE		e.status=1
					  AND 		e.idsucursal LIKE '".$_POST['idsucursal']."'
					  AND 		c.idpuesto LIKE '".$_POST['idpuesto']."'
					  ORDER BY e.nombre";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['nip']."'>".$row['nombre']."</option>";
			echo $html;
			break;
		}
		
		case "guardar":{
			$udn = $_POST['sucursal']=='%'?0:$_POST['sucursal'];
			$depto = $_POST['departamento']=='%'?0:$_POST['departamento'];
			$puesto = $_POST['puesto']=='%'?0:$_POST['puesto'];
			$empleado = $_POST['empleado']=='%'?0:$_POST['empleado'];
			$n = 0;
			$q = "SELECT * FROM cparametrosasistencia WHERE idsucursal='".$udn."' AND iddepartamento='".$depto."' AND idpuesto='".$puesto."' AND idempleado='".$empleado."'";		
			$s =  $conexion->query($q);
			while($r = $s->fetch_assoc()){
				$n++;
			}
			if($n>0){
				$band = 0;
				for($i=0;$i<=6;$i++){
					$query1 = "UPDATE cparametrosasistencia SET entrada='".$_POST['entrada'.$i]."',
															entradai='".$_POST['entradai'.$i]."',
															salidai='".$_POST['salidai'.$i]."',
															salida='".$_POST['salida'.$i]."',
															tolerancia='".$_POST['tolerancia']."',
															retardospfalta='".$_POST['retardos']."',
															faltaspdescuento='".$_POST['faltas']."',
															montodescuento='".$_POST['monto']."',
															status='".$_POST['status'.$i]."'
													  WHERE idsucursal='".$udn."' 
													  AND 	iddepartamento='".$depto."' 
													  AND 	idpuesto='".$puesto."' 
													  AND 	idempleado='".$empleado."'
													  AND 	diasemana=".$i;
					$sql1 = $conexion->query($query1);
					$band = $sql1?$band+1:$band;
				}
				
				if($band==7){
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA HORARIOS','HORARIOS','".base64_encode($q)."',NOW(),NOW(),2)");
					echo 1;
				}else{
					echo 0;
				}
			}else{
				$band = 0;
				for($i=0;$i<=6;$i++){
					$query1 = "INSERT INTO cparametrosasistencia (entrada,
																entradai,
																salidai,
																salida,
																tolerancia,
																retardospfalta,
																faltaspdescuento,
																montodescuento,
																idsucursal,
																iddepartamento,
																idpuesto,
																idempleado,
																diasemana,
																status)
														VALUES 	 ('".$_POST['entrada'.$i]."',
																'".$_POST['entradai'.$i]."',
																'".$_POST['salidai'.$i]."',
																'".$_POST['salida'.$i]."',
																'".$_POST['tolerancia']."',
																'".$_POST['retardos']."',
																'".$_POST['faltas']."',
																'".$_POST['monto']."',
																'".$udn."',
																'".$depto."',
																'".$puesto."',
																'".$empleado."',
																'".$i."',
																'".$_POST['status'.$i]."')";
					//die($query1);
					$sql1 = $conexion->query($query1);
					$band = $sql1?$band+1:$band;
				}
				
				if($band==7){
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREA HORARIOS','HORARIOS','".base64_encode($q)."',NOW(),NOW(),2)");
					echo 1;
				}else{
					echo 0;
				}
			}
			
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