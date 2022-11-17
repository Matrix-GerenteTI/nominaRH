	<?php	
	session_start();
	require_once("mysql.php");
	require_once $_SERVER['DOCUMENT_ROOT']."/intranet/modelos/nomina/trabajadores.php";
	//die($_SERVER['DOCUMENT_ROOT']."/intranet/modelos/nomina/trabajadores.php");
	//conexion();
	$op = isset($_GET['op']) ? $_GET['op'] : $_POST['op'];
	
	switch($op){
		case "calculaTiempo":{
			$fecha = formateaFechaSLASH($_POST['fecha']);
			if($_POST['tipo']=="edad"){
				$result = CalculaEdad($fecha);
			}
			if($_POST['tipo']=="antiguedadSAT"){
				$result = CalculaAntiguedadSAT($fecha);
			}
			if($_POST['tipo']=="antiguedad"){
				$result = CalculaAntiguedad($fecha);
			}
			echo $result;
			break;
		}
		
		case "buslista":{
			$departamento = $_POST['departamento'];
			$nombre = $_POST['nombre'];
			$estado = $_POST['estado'];
			$array = array();
			$n = 0;
			$query = "SELECT 	e.nip AS nip,
								e.nombre AS nombre,
								IFNULL((SELECT d.descripcion FROM pcontrato c INNER JOIN cdepartamento d ON c.iddepartamento=d.id WHERE c.nip=e.nip LIMIT 1),'') AS departamento
					  FROM 		pempleado e 
					  WHERE 	e.nombre LIKE '%".$nombre."%' 
					  AND		e.status='".$estado."'
					  ORDER BY  e.nombre";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				if($departamento=='%'){
					$array[$n]['nip'] = $row['nip'];
					$array[$n]['nombre'] = $row['nombre'];
					$array[$n]['departamento'] = $row['departamento'];
					$n++;
				}elseif($departamento==$row['departamento']){
					$array[$n]['nip'] = $row['nip'];
					$array[$n]['nombre'] = $row['nombre'];
					$array[$n]['departamento'] = $row['departamento'];
					$n++;
				}
			}
			echo json_encode($array);
			break;
		}
		
		case "buslistaUsuario":{
			$tipousuario = $_POST['tipousuario'];
			$array = array();
			$n = 0;
			$query = "SELECT 	u.username as idusuario,
								u.nombre as nombre,
								t.descripcion as tipousuario
					  FROM 		pusuarios u 
					  INNER JOIN ctipousuario t ON u.tipo=t.id
					  WHERE 	t.id LIKE '".$tipousuario."'
					  AND		u.status=1
					  ORDER BY  u.nombre";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$array[$n]['idusuario'] = $row['idusuario'];
				$array[$n]['nombre'] = $row['nombre'];
				$array[$n]['tipousuario'] = $row['tipousuario'];
				$n++;
			}
			echo json_encode($array);
			break;
		}

		case 'checaPermiso':{
			$tipo = $_POST['tipo'];
			echo $_SESSION['permisos'][4][$tipo];
			break;
		}
		
		case "cargaPermisos":{
			$usuario = $_POST['idusuario'];
			$array = array();
			$n = 0;
			$arrModulos = array();
			$q1 = "SELECT m.*,p.descripcion as seccion,m.id as id FROM cmodulos m INNER JOIN cmodulo p ON m.idpadre=p.id WHERE p.status=1 AND m.status=1 ORDER BY m.idpadre,m.id";
			$s1 = $conexion->query($q1);
			while($r1 = $s1->fetch_assoc()){
				$array[$n]['idmodulo'] = $r1['id'];
				$array[$n]['modulo'] = $r1['title'];
				$array[$n]['seccion'] = $r1['seccion'];
				$n1 = 0;
				$query = "SELECT 	* 
						FROM		rusuariomodulo
						WHERE 		usuario='".$usuario."'
						AND 		idmodulo=".$r1['id'];
				$sql = $conexion->query($query);
				while($row = $sql->fetch_assoc()){
					$array[$n]['acceso'] = 1;
					$array[$n]['guardar'] = $row['guardar'];
					$array[$n]['actualizar'] = $row['actualizar'];
					$array[$n]['borrar'] = $row['borrar'];
					$array[$n]['ver'] = $row['ver'];
					$array[$n]['imprimir'] = $row['imprimir'];
					$n1++;
				}
				if($n1==0){
					$array[$n]['acceso'] = 0;
					$array[$n]['guardar'] = 0;
					$array[$n]['actualizar'] = 0;
					$array[$n]['borrar'] = 0;
					$array[$n]['ver'] = 0;
					$array[$n]['imprimir'] = 0;
				}
				$n++;
			}
			
			echo json_encode($array);
			break;
		}

		case 'guardarPermisos':{
			$idusuario = $_POST['usuario'];
			//echo $_POST['arreglo'];
			$arreglo = json_decode($_POST['arreglo']);
			//Borramos todo lo de ese usuario primero
			$q1 = "DELETE FROM rusuariomodulo WHERE usuario='".$idusuario."'";
			$s1 = $conexion->query($q1);
			$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','BORRA PERMISOS','PERMISOS','".base64_encode($q1)."',NOW(),NOW(),3)");
			foreach($arreglo as $idx => $row){				
				if($row->acceso==1){
					$q2 = "INSERT INTO rusuariomodulo (usuario,idmodulo,guardar,borrar,ver,imprimir) VALUES ('".$row->usuario."','".$row->idmodulo."','".$row->guardar."','".$row->borrar."','".$row->ver."','".$row->imprimir."')";
					$s2 = $conexion->query($q2);					
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','AGREGA PERMISOS','PERMISOS','".base64_encode($q2)."',NOW(),NOW(),3)");
				}
			}

			break;
		}
		
		case "comboCatalogo":{
			$catalogo = $_POST['catalogo'];
			//$scatalogo = $_POST['scatalogo'];
			$prefijo = '';
			if(isset($_POST['prefijo']))
				$prefijo = $_POST['prefijo'];
			
			if($_POST['tipo']==3){
				$echo = "<option value='%'>TODOS...</option>";
			}else{
				$echo = "";
			}
			if(isset($_POST['scatalogo'])){
				$query = "SELECT * FROM c".$_POST['scatalogo']." WHERE id".$catalogo." LIKE '".$_POST['id']."' AND status=1 ORDER BY descripcion";
			}else{
				$query = "SELECT * FROM c".$catalogo." WHERE status=1 ORDER BY descripcion";
			}
			//echo $query;
			//die();
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				if($prefijo=='percepciones_'){
					if($row['id']!='019' && $row['id']!='022' && $row['id']!='023' && $row['id']!='025' && $row['id']!='039' && $row['id']!='044'){
						$echo.= '<option value="'.$row['id'].'">'.strtoupper($row['descripcion']).'</option>';
					}
				}
				if($prefijo=='jubilaciones_'){
					if($row['id']=='039' || $row['id']=='044'){
						$echo.= '<option value="'.$row['id'].'">'.strtoupper($row['descripcion']).'</option>';
					}
				}
				if($prefijo=='separaciones_'){
					if($row['id']=='022' || $row['id']=='023' || $row['id']=='025'){
						$echo.= '<option value="'.$row['id'].'">'.strtoupper($row['descripcion']).'</option>';
					}
				}
				if($prefijo!='percepciones_' && $prefijo!='jubilaciones_' && $prefijo!='separaciones_'){
					$echo.= '<option value="'.$row['id'].'">'.strtoupper($row['descripcion']).'</option>';
				}
			}
			echo $echo;
			break;
		}
		
		case "cargar":{
			$nip = $_POST['nip'];
			$q2a = "SELECT COUNT(*) as CANT FROM pdireccion WHERE nip='".$nip."'";
			$s2a = $conexion->query($q2a);
			$r2a = $s2a->fetch_assoc();
			if($r2a['CANT']>0){
				$qdireccion = "SELECT id FROM pdireccion WHERE nip='".$nip."'";
				$sdireccion = $conexion->query($qdireccion);
				$rdireccion = $sdireccion->fetch_assoc();
				$direccion = $rdireccion['id'];	
			}else{
				$query2 = "INSERT INTO pdireccion 	(nip,
													calle,
													numext,
													numint,
													colonia,
													municipio,
													cp,
													idestado,
													status)
											VALUES ('".$nip."',
													'',
													'',
													'',
													'',
													'',
													'',
													'CHP',
													1)";
				$sql2 = $conexion->query($query2);
				$direccion = $conexion->insert_id;
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREACION DE DIRECCION','EMPLEADOS','".base64_encode($query2)."',NOW(),NOW(),2)");
				
			}
			$q3a = "SELECT COUNT(*) as CANT FROM pcontrato WHERE nip='".$nip."'";
			$s3a = $conexion->query($q3a);
			$r3a = $s3a->fetch_assoc();
			if($r3a['CANT']==0){
				$query3 = "INSERT INTO pcontrato 	(nip,
													iddireccion,
													iddepartamento,
													idpuesto,
													idtipocontrato,
													idtiempocontrato,
													idtipojornada,
													fechainiciolab,
													sindicalizado,
													idtiporegimen,
													idriesgopuesto,
													idperiodicidadpago,
													salariobase,
													salariodiario,
													idbanco,
													cuentabancaria,
													subrfc,
													subporcentaje,
													status,
													fecha_ingreso,
													sueldobruto)
											VALUES ('".$nip."',
													'".$direccion."',
													'1',
													'1',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													'',
													1,
													'',															
													'')";
													
				$sql3 = $conexion->query($query3);	
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREACION DE CONTATO','EMPLEADOS','".base64_encode($query4)."',NOW(),NOW(),2)");
				
			}
			$query = "SELECT 	*,
								e.nip as nip,
								d.idestado as estado,
								a.descripcion as departamento,
								p.descripcion as puesto,
								e.idsucursal as idsucursal,
								u.username as username,
								e.nombre as nombre,
								u.password as password,
								u.tipo as tipo,
								e.status as status
					  FROM 		pempleado e 
					  INNER JOIN pcontrato c ON c.nip=e.nip
					  INNER JOIN pdireccion d ON e.nip=d.nip 
					  INNER JOIN cdepartamento a ON a.id=c.iddepartamento 
					  LEFT JOIN cpuesto p ON p.id=c.idpuesto
					  LEFT JOIN pusuarios u ON e.nip=u.idempleado
					  WHERE 	e.nip='".$nip."'";
			//
			$sql = $conexion->query($query);
			$row =$sql->fetch_assoc();
			//echo json_encode($row);
			if ( is_array( $row )  ) {
				//Calculando la antigueadad laboral del trabajador
				$fechcaInicioLaborar = date_create( $row['fechainiciolab']  );
				$fechaActual = date_create( date("Y-m-d")  );
				$row['permisos'] = $_SESSION['permisos'][4];
				$row['nombre'] = mb_convert_encoding( $row['nombre'] , "UTF-8" );
				$row['numint'] = mb_convert_encoding( $row['numint'] , "UTF-8" );
				$diferencia = date_diff($fechcaInicioLaborar, $fechaActual);
				$row['antiguedad']= "$diferencia->y Año(s),$diferencia->m Mes(es) y $diferencia->d Día(s)";
				$row['vacaciones'] = $diferencia->y > 0 ? true : false;
				//Numero de días de vacaciones de acuardo a su antiguedad
				if( $diferencia->y == 0){
					$row['diasVacaciones'] = 0;
				}elseif ( $diferencia->y == 1) {
					$row['diasVacaciones'] = 6;
				} else if( $diferencia->y == 2) {
					$row['diasVacaciones'] = 10;
				}else if ( $diferencia->y == 3) {
					$row['diasVacaciones'] = 12;
				}elseif ( $diferencia->y == 4 ) {
					$row['diasVacaciones'] = 10;
				}elseif ( $diferencia->y >= 5 && $diferencia->y <= 9 ) {
					$row['diasVacaciones'] = 14;
				}elseif ( $diferencia->y >= 10 && $diferencia->y <= 14 ) {
					$row['diasVacaciones'] = 16;
				}elseif ( $diferencia->y >= 15 && $diferencia->y <= 19) {
					$row['diasVacaciones'] = 18;
				}elseif ( $diferencia->y >= 20 && $diferencia->y <= 24) {
					$row['diasVacaciones'] = 20;
				}elseif ( $diferencia->y >= 25 && $diferencia->y <= 29) {
					$row['diasVacaciones'] = 22;
				}else{
					$row['diasVacaciones'] = 24;
				}
				
				//obteniendo la url de la foto del trabajador
				$formatos = ['jpg','jpeg'];
				$rand = rand(0,100);
				$txtrnd = date('Ymdhis').$rand;
				foreach ($formatos as $i => $formato) {
					if( file_exists( $_SERVER['DOCUMENT_ROOT']."/intranet/Empresa/foto_empleado/".$nip.".".$formato)  ){
						$row['foto'] = "/intranet/Empresa/foto_empleado/".$nip.".".$formato."?".$txtrnd;
					break;
					}else{
						$row['foto'] = "assets/images/person-icon.png";
					}
				}

				
				//obtenemos sus vacaciones programadas en el año actual
				$modeloTrabajador = new Trabajador;
				
				$row['listaVacaciones'] = $modeloTrabajador->getVacacionesProgramadas(  $nip  );
			}

			
			echo json_encode($row);
			break;
		}
		
		case 'updateAdscripcion':{
			//actualiza la adscripcion del empleado y al realizar el update ejecuta un disparador que inserte en la tabla cambios_adscripcion
			$sucursal = $_POST['sucursal'];
			$depto = $_POST['departamento'];
			$puesto = $_POST['puesto'];
			$idempleado = $_POST['empleado'];
			$fechaCambio = $_POST['fecha'];
			$tipoMovto = $_POST['tipo'];

			$queryCambioAdscripcion = "UPDATE pempleado set idsucursal='$sucursal' WHERE nip = '$idempleado'  " ;
			//obteniendo datos de la contratación del empleado
			$queryContratoEmpleado = "SELECT pempleado.nip,pempleado.idsucursal,pcontrato.iddepartamento, pcontrato.idpuesto
														FROM pempleado
														INNER JOIN pcontrato on pcontrato.nip = pempleado.nip
														WHERE pempleado.nip = $idempleado ";
														
			$exeContratoEmpleado = $conexion->query( $queryContratoEmpleado);
			$datosContratacion = $exeContratoEmpleado->fetch_all( MYSQLI_ASSOC );

			$exeCambioAdscripcion = $conexion->query( $queryCambioAdscripcion);
			
			if ( $exeCambioAdscripcion ) {
					$datosContratacion = $datosContratacion[0];
					//en caso de que se cambie unicamente  de sucursal también se actualiza su puesto
					$queryCambiaPuesto = "UPDATE pcontrato set idpuesto ='" .$_POST['puesto']."' WHERE nip = '$idempleado'  ";
					$exeCambioAdscripcion = $conexion->query( $queryCambiaPuesto);

					$splittedDate = explode( '/', $fechaCambio );
					$fechaCambio = $splittedDate[2].'-'.$splittedDate[1].'-'.$splittedDate[0];
					//haciendo la insercion en la tabla cambio de adscripcion
					$queryRegistraCambio = "INSERT INTO cambios_adscripcion(sucursal_salida_id,sucursal_llegada_id,puesto_id,fecha,trabajador_id,tipo_movto) 
					VALUES(".$datosContratacion['idsucursal'].",$sucursal,".$datosContratacion['idpuesto'].",'$fechaCambio',$idempleado,'$tipoMovto')";
					$exeRegistraCambio = $conexion->query( $queryRegistraCambio);
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CAMBIO DE ADSCRIPCION','EMPLEADOS','".base64_encode($queryRegistraCambio)."',NOW(),NOW(),2)");
					if ( $exeRegistraCambio) {
						echo 1;
					}else{
						echo -1;
					}
				
			} else {
				
				echo 0;
			}
			break;
		}
		
		case "existuser":{
			$n = 0;
			$nip = $_POST['nip'];
			$username = $_POST['username'];
			$qu = "SELECT idempleado,COUNT(*) as CANT FROM pusuarios WHERE username='".$username."'";
			$su = $conexion->query($qu);
			while($ru = $su->fetch_assoc()){
				if($ru['idempleado']!=$nip && $ru['CANT']>0)
					echo 0;
				else
					echo 1;
				$n++;
			}
			if($n==0){
				echo 1;
			}
			break;
		}
		
		case "guardar":{
			$nipT = $_POST['nip'];			
			$nip = $_POST['nip'];
			$conexion->autocommit(false);
			try{
				$query = "SELECT COUNT(*) as registros FROM pempleado WHERE nip='".$nip."'";
				$sql = $conexion->query($query);
				$row = $sql->fetch_assoc();
				if($row['registros']>0){

					$_POST['nHijo'] = $_POST['nHijo'] != '' ? $_POST['nHijo'] : 0;
					$_POST['nHija'] = $_POST['nHija'] != '' ? $_POST['nHija'] : 0;
					$hijos = $_POST['nHijo']."-".$_POST['nHija'];
					$asegurado = $_POST['seguro'] == 1 ? 's' : 'n';
					$alergias = $_POST['alergias'];
					
					$query1 = "UPDATE pempleado SET rfc='".$_POST['rfc']."',
													nombre='".$_POST['nombre']."',
													curp='".$_POST['curp']."',
													nss='".$_POST['nss']."',
													fechanac='".formateaFechaSLASH($_POST['fecnac'])."',
													edocivil='".$_POST['edocivil']."',
													sexo='".$_POST['sexo']."',
													email='".$_POST['email']."',
													telefono='".$_POST['telefono']."',
													celular='".$_POST['celular']."',
													idsucursal='".$_POST['sucursal']."',
													tiposangre='". $_POST['tipoSangre']."',
													nivelestudios='".$_POST['escolaridad']."',
													religion='".$_POST['religion']."',
													numhijos='$hijos',
													asegurado='$asegurado',
													alergias= '$alergias'
											  WHERE nip='".$nip."'";
					//die(formateaFechaSLASH($_POST['fecnac']));
					$sql1 = $conexion->query($query1);
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA DATOS DE EMPLEADO','EMPLEADOS','".base64_encode($query1)."',NOW(),NOW(),3)");
					$qu = "SELECT COUNT(*) as CANT FROM pusuarios WHERE idempleado='".$nip."' AND username='".$_POST['username']."' AND password='".$_POST['password']."'";
					$su = $conexion->query($qu);
					$ru = $su->fetch_assoc();
					if($ru['CANT']==0){
						$qu = "SELECT COUNT(*) as CANT FROM pusuarios WHERE idempleado='".$nip."'";
						$su = $conexion->query($qu);
						$ru = $su->fetch_assoc();
						if($ru['CANT']>0){
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
								$queryu = "UPDATE pusuarios SET 	username='".$_POST['username']."',
																password='".$_POST['password']."',
																nombre='".$_POST['nombre']."',
																tipo='".$_POST['tipo']."'
														WHERE idempleado='".$nip."'";
								$sqlu = $conexion->query($queryu);
								$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA USUARIO','EMPLEADOS','".base64_encode($queryu)."',NOW(),NOW(),3)");
							}else{
								$nipT = -1;
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
								$queryu = "INSERT INTO pusuarios 	(username,
																	password,
																	nombre,
																	email,
																	tipo,
																	idempleado,
																	status)
															VALUES ('".$_POST['username']."',
																	'".$_POST['password']."',
																	'".$_POST['nombre']."',
																	'".$_POST['email']."',
																	'".$_POST['tipo']."',
																	'".$nip."',
																	1)";
								$sqlu = $conexion->query($queryu);
								$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREACION DE USUARIO','EMPLEADOS','".base64_encode($queryu)."',NOW(),NOW(),3)");
							}else{
								$nipT = -1;
							}
						}
					}
					
					$query2 = "UPDATE pdireccion SET 	calle='".$_POST['calle']."',
														numext='".$_POST['numext']."',
														numint='".$_POST['numint']."',
														colonia='".$_POST['colonia']."',
														municipio='".$_POST['municipio']."',
														cp='".$_POST['cp']."',
														idestado='".$_POST['estado']."'
												WHERE nip='".$nip."'";
					$sql2 = $conexion->query($query2);
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA DIRECCION','EMPLEADOS','".base64_encode($query2)."',NOW(),NOW(),3)");
				
					$query3 = "UPDATE pcontrato SET	 	 iddepartamento='".$_POST['departamento']."',
														idpuesto='".$_POST['puesto']."',
														idtipocontrato='".$_POST['tipocontrato']."',
														idtipocontrato='".$_POST['tipocontrato']."',
														idtiempocontrato='".$_POST['tiempocontrato']."',
														fechainiciolab='".formateaFechaSLASH($_POST['iniciolaboral'])."',
														sindicalizado='".$_POST['sindicalizado']."',
														idtiporegimen='".$_POST['tiporegimen']."',
														idriesgopuesto='".$_POST['riesgopuesto']."',
														idperiodicidadpago='".$_POST['periodicidadpago']."',
														salariobase='".$_POST['salariobase']."',
														salariodiario='".$_POST['salariodiario']."',
														sueldobruto='".$_POST['sueldobruto']."',
														idbanco='".$_POST['banco']."',
														cuentabancaria='".$_POST['cuentabancaria']."',
														subrfc='".$_POST['subrfc']."',
														subporcentaje='".$_POST['subporcentaje']."'
												WHERE 	 nip='".$nip."'";
					$sql3 = $conexion->query($query3);
					$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA CONTRATO','EMPLEADOS','".base64_encode($query3)."',NOW(),NOW(),3)");
					
					$qcontrato = "SELECT id FROM pcontrato WHERE nip='".$nip."'";
					$scontrato = $conexion->query($qcontrato);
					$rcontrato = $scontrato->fetch_assoc();
					$idcontrato = $rcontrato['id'];					
					$diast = 15;
					$fechaac = explode("/",$_POST['iniciolaboral']);
					$diaac = $fechaac[0]*1;
					$mesac = $fechaac[1]*1;
					if($mesac == (date("m")*1)){
						if($diaac>15){
							$diast = 30 - $diaac;
						}else{
							$diast = 15 - $diaac;
						}
						$diast = $diast + 1;
					}
					
					$sueldoquincenal = $_POST['salariodiario'] * $diast;
					$delpercepcion = "DELETE FROM ppercepciones WHERE idcontrato=".$idcontrato;
					//$sqldelpercepcion = $conexion->query($delpercepcion);
					$qpercepcion = "INSERT INTO ppercepciones (idtipopercepcion,gravado,excento,valormercado,preciootorgarse,status,idcontrato) VALUES ('001',".number_format($sueldoquincenal,0,".","").",0,0,0,1,".$idcontrato.")";
					//$sqlqpercepcion = $conexion->query($qpercepcion);
				}else{
					$rnip = 0;					
					$query = "SELECT * FROM pempleado WHERE curp='".$_POST['curp']."'";
					$sql = $conexion->query($query);
					while($row = $sql->fetch_assoc()){
						$rnip = $row['nip'];
					}
					if($rnip==0){
						$_POST['nHijo'] = $_POST['nHijo'] != '' ? $_POST['nHijo'] : 0;
						$_POST['nHija'] = $_POST['nHija'] != '' ? $_POST['nHija'] : 0;
						$hijos = $_POST['nHijo']."-".$_POST['nHija'];
						$religion = $_POST['religion'];
						$escolaridad = $_POST['escolaridad'];
						$seguro =  $_POST['seguro'];
						$tipoSangre = $_POST['tipoSangre'];
						$alergias = $_POST['alergias'];
						$asegurado = $_POST['seguro'] == 1 ? 's' : 'n';

						$query = "INSERT INTO pempleado   (rfc, 
														nombre,
														curp,
														nss,
														fechanac,
														edocivil,
														sexo,
														email,
														telefono,
														celular,
														idpatron,
														idsucursal,
														status,
														tiposangre,
														nivelestudios,
														numhijos,
														religion,
														alergias,
														asegurado)
													VALUES ('".$_POST['rfc']."',
														'".$_POST['nombre']."',
														'".$_POST['curp']."',
														'".$_POST['nss']."',
														'".formateaFechaSLASH($_POST['fecnac'])."',
														'".$_POST['edocivil']."',
														'".$_POST['sexo']."',
														'".$_POST['email']."',
														'".$_POST['telefono']."',
														'".$_POST['celular']."',
														1,
														'".$_POST['sucursal']."',
														1,'$tipoSangre','$escolaridad','$hijos','$religion','$alergias', '$asegurado' )";
						$sql = $conexion->query($query);
						$nip = $conexion->insert_id;
						$nipT = $conexion->insert_id;
						$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREACION DE EMPLEADO','EMPLEADOS','".base64_encode($query)."',NOW(),NOW(),2)");

						$fechaHisto = formateaFechaSLASH($_POST['iniciolaboral']);
						$puestoHist = $_POST['puesto'];
						$sucursalHist = $_POST['sucursal'];
						$queryHistorialAdscripcion = "INSERT INTO cambios_adscripcion(sucursal_salida_id,sucursal_llegada_id,puesto_id,fecha,trabajador_id,tipo_movto,sueldo) 
						VALUES($sucursalHist, -1, $puestoHist,'$fechaHisto', $nip, 'ingreso','0')";
						$conexion->query($queryHistorialAdscripcion);
						
						$queryConcat = " SELECT COUNT(*) AS registros FROM pusuarios ua WHERE ua.username='".$_POST['username']."'";
						$sqlConexions = $conexion->query($queryConcat);
						$rowConexions = $sqlConexions->fetch_assoc();
						if($rowConexions['registros']==0){
							$queryu = "INSERT INTO pusuarios 	(username,
																password,
																nombre,
																email,
																tipo,
																idempleado,
																status)
														VALUES ('".$_POST['username']."',
																'".$_POST['password']."',
																'".$_POST['nombre']."',
																'".$_POST['email']."',
																'".$_POST['tipo']."',
																'".$nip."',
																1)";
							$sqlu = $conexion->query($queryu);
							$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREACION DE USUARIO','EMPLEADOS','".base64_encode($queryu)."',NOW(),NOW(),2)");
						}else{
							$nipT = -1;
						}
						
						$query2 = "INSERT INTO pdireccion 	(nip,
															calle,
															numext,
															numint,
															colonia,
															municipio,
															cp,
															idestado,
															status)
													VALUES ('".$nip."',
															'".$_POST['calle']."',
															'".$_POST['numext']."',
															'".$_POST['numint']."',
															'".$_POST['colonia']."',
															'".$_POST['municipio']."',
															'".$_POST['cp']."',
															'".$_POST['estado']."',
															1)";
						$sql2 = $conexion->query($query2);
						$direccion = $conexion->insert_id;
						$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREACION DE DIRECCION','EMPLEADOS','".base64_encode($query2)."',NOW(),NOW(),2)");						
						$query3 = "INSERT INTO pcontrato 	(nip,
															iddireccion,
															iddepartamento,
															idpuesto,
															idtipocontrato,
															idtiempocontrato,
															idtipojornada,
															fechainiciolab,
															sindicalizado,
															idtiporegimen,
															idriesgopuesto,
															idperiodicidadpago,
															salariobase,
															salariodiario,
															idbanco,
															cuentabancaria,
															subrfc,
															subporcentaje,
															status,
															fecha_ingreso,
															sueldobruto)
													VALUES ('".$nip."',
															'".$direccion."',
															'".$_POST['departamento']."',
															'".$_POST['puesto']."',
															'".$_POST['tipocontrato']."',
															'".$_POST['tiempocontrato']."',
															'".$_POST['tipojornada']."',
															'".formateaFechaSLASH($_POST['iniciolaboral'])."',
															'".$_POST['sindicalizado']."',
															'".$_POST['tiporegimen']."',
															'".$_POST['riesgopuesto']."',
															'".$_POST['periodicidadpago']."',
															'".$_POST['salariobase']."',
															'".$_POST['salariodiario']."',
															'".$_POST['banco']."',
															'".$_POST['cuentabancaria']."',
															'".$_POST['subrfc']."',
															'".$_POST['subporcentaje']."',
															1,
															'".formateaFechaSLASH($_POST['iniciolaboral'])."',															
															'".$_POST['sueldobruto']."')";
															
						$sql3 = $conexion->query($query3);	
						$idcontrato = $conexion->insert_id;
						$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CREACION DE CONTRATO','EMPLEADOS','".base64_encode($query3)."',NOW(),NOW(),2)");
						

						$diast = 15;
						$fechaac = explode("/",$_POST['iniciolaboral']);
						$diaac = $fechaac[0]*1;
						$mesac = $fechaac[1]*1;
						if($mesac == (date("m")*1)){
							if($diaac>15){
								$diast = 30 - $diaac;
							}else{
								$diast = 15 - $diaac;
							}
							$diast = $diast + 1;
						}
						
						$sueldoquincenal = $_POST['salariodiario'] * $diast;
						$qpercepcion = "INSERT INTO ppercepciones (idtipopercepcion,gravado,excento,valormercado,preciootorgarse,status,idcontrato) VALUES ('001',".number_format($sueldoquincenal,2,".","").",0,0,0,1,".$idcontrato.")";
						$sqlqpercepcion = $conexion->query($qpercepcion);

						// $queryPermisosAchivos = "INSERT INTO 
						// 							precursos SELECT path,permisos,'".$nip."',NOW() FROM precursos 
						// 						WHERE path LIKE 'C:/wamp/www/intranet/Empresa/Recursos/RH/OTROS/Documentos_RH%' 
						// 						AND empleado_nip = 1";
						// $conexion->query($queryPermisosAchivos);
					}else{
						$nipT = $rnip;
					}
				}
				$conexion->commit();
				echo $nipT;
			}catch(Exception $e){
				$conexion->rollback();
				echo 0;
			}
			break;
		}
		
		case "eliminar":{
			$nip = $_POST['nip'];
			$query = "SELECT COUNT(*) as registros FROM pempleado WHERE nip='".$nip."'";
			$sql = $conexion->query($query);
			$row = $sql->fetch_assoc();
			if($row['registros']>0){
				$query = "UPDATE pempleado SET status=99 WHERE nip='".$nip."'";
				$sql = $conexion->query($query);
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ELIMINA EMPLEADO','EMPLEADOS','".base64_encode($query)."',NOW(),NOW(),3)");
				if(!$sql)
					echo 0;
				else
					echo 1;
			}else
				echo 2;
			break;
		}

		case "reingreso":{
			$nip = $_POST['nip'];
			$sucursal = $_POST['sucursal'];
			$puesto = $_POST['puesto'];
			$salario = $_POST['salariodiario'];
			$fecha = $_POST['iniciolaboral'];
			$query = "UPDATE pempleado SET status=1 WHERE nip='".$nip."'";
			$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','REINGRESO DE EMPLEADO','EMPLEADOS','".base64_encode($query)."',NOW(),NOW(),2)");
			$sql = $conexion->query($query);
			if(!$sql){
				echo 0;
			}else{
				//Actualizamos los datos de contrato
				$query3 = "UPDATE pcontrato SET	 	 iddepartamento='".$_POST['departamento']."',
														idpuesto='".$_POST['puesto']."',
														idtipocontrato='".$_POST['tipocontrato']."',
														idtiempocontrato='".$_POST['tiempocontrato']."',
														fechainiciolab='".formateaFechaSLASH($_POST['iniciolaboral'])."',
														sindicalizado='".$_POST['sindicalizado']."',
														idtiporegimen='".$_POST['tiporegimen']."',
														idriesgopuesto='".$_POST['riesgopuesto']."',
														idperiodicidadpago='".$_POST['periodicidadpago']."',
														salariobase='".$_POST['salariobase']."',
														salariodiario='".$_POST['salariodiario']."',
														idbanco='".$_POST['banco']."',
														cuentabancaria='".$_POST['cuentabancaria']."',
														subrfc='".$_POST['subrfc']."',
														subporcentaje='".$_POST['subporcentaje']."'
												WHERE 	 nip='".$nip."'";
				$sql3 = $conexion->query($query3);
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ACTUALIZA CONTRATO','EMPLEADOS','".base64_encode($query3)."',NOW(),NOW(),2)");

				//haciendo la insercion en la tabla cambio de adscripcion
				$queryRegistraCambio = "INSERT INTO cambios_adscripcion(sucursal_salida_id,sucursal_llegada_id,puesto_id,fecha,trabajador_id,tipo_movto) 
				VALUES('-',".$sucursal.",".$puesto.",'".formateaFechaSLASH($fecha)."',$nip,'reingreso')";
				$exeRegistraCambio = $conexion->query( $queryRegistraCambio);
				
				echo 1;
			}
			break;
		}

		case 'baja':{
				$idempleado = $_POST['empleado'];
				$fechaBaja = $_POST['fecha'];
				$tipoMovto = $_POST['tipo'];
				$observaciones = $_POST['observaciones'];

				if ( strpos($fechaBaja , "/" ) !== false ) {
					$fechaBaja = formateaFechaSLASH( $fechaBaja );
				}
				$q1 = "INSERT INTO pempleadoingresobaja (nip,tipo,fechabaja,fecha,hora,usuario,observaciones,status) VALUES (".$idempleado.",2,'".$fechaBaja."',NOW(),NOW(),'".$_SESSION['userid']."','".$observaciones."',1)";
				$conexion->query($q1);
				$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','BAJA DE EMPLEADO','EMPLEADOS','".base64_encode($q1)."',NOW(),NOW(),3)");
				$queryBaja = "UPDATE pempleado SET status=99 ,fecha_baja='$fechaBaja' WHERE nip='$idempleado' ";
				$exeBaja = $conexion->query( $queryBaja);
				if ( $exeBaja ) {
								//obteniendo datos de la contratación del empleado
				$queryContratoEmpleado = "SELECT pempleado.nip,pempleado.idsucursal,pcontrato.iddepartamento, pcontrato.idpuesto
				FROM pempleado
				INNER JOIN pcontrato on pcontrato.nip = pempleado.nip
				WHERE pempleado.nip = $idempleado ";
				
				$exeContratoEmpleado = $conexion->query( $queryContratoEmpleado);
				$datosContratacion = $exeContratoEmpleado->fetch_all( MYSQLI_ASSOC );

				$datosContratacion = $datosContratacion[0];
				//haciendo la insercion en la tabla cambio de adscripcion
				$queryRegistraCambio = "INSERT INTO cambios_adscripcion(sucursal_salida_id,sucursal_llegada_id,puesto_id,fecha,trabajador_id,tipo_movto) 
				VALUES(".$datosContratacion['idsucursal'].",'-',".$datosContratacion['idpuesto'].",'$fechaBaja',$idempleado,'$tipoMovto')";
				$exeRegistraCambio = $conexion->query( $queryRegistraCambio);





					 echo 1;
				} else {
					echo 0;
				}
				
			break;
		}
		
		case 'getDoctos':{
			
			$nip = $_POST['nip'];		
			$echo = "";
			
			$qu = "SELECT 	d.id as id, d.file as file, td.descripcion as tipo 
				   FROM 	pdocumentos d
				   INNER JOIN ctipodoc td ON d.idtipo=td.id
				   WHERE 	d.idempleado=".$nip." 
				   AND 		d.status=1 
				   ORDER BY td.descripcion";
			$su = $conexion->query($qu);
			while($ru = $su->fetch_assoc()){
				$echo.= '<div style="padding:10px; font-size: 10px; width: 150px; height:130px; margin:5px; display: inline-block; background: #FFF; border: #AAA 1px solid; text-align:center">';
				$echo.= '	<a href="./ajax/documentos/'.$ru['file'].'" target="blank" >';
				$echo.= '		<img src="/nomina/ajax/doc.png" style="height:90px; max-width: 130px; max-height:90px" border="0" />';
				$echo.= '	</a>';
				$echo.= '	<br>';
				$echo.= '	<b>'.$ru['tipo'].'</b>';
				$echo.= '	<div style="text-align:right"><a href="javascript:delImg(\''.$ru['id'].'\')">';
				//if($_SESSION['sucursal']==$_POST['sucursal'] || $_SESSION['nivelT']=='ADMINISTRADOR')
					$echo.= '		<img src="/nomina/ajax/delete.png" height="15px" width="13" />';
				//else
				//	$echo.= '		&nbsp;';
				$echo.= '	</a></div>';
				$echo.= '</div>';
			}
			
											
			echo $echo;
			break;
		}

		case 'saveFoto':{
			$foto = $_FILES['foto'];
			$file_name = $foto["name"];
        	$extension = pathinfo( $foto["name"] );
            //die($_SERVER['DOCUMENT_ROOT']."/intranet/Empresa/foto_empleado/". $nip.".".$extension['extension']);
            $guardado = move_uploaded_file($foto["tmp_name"],$_SERVER['DOCUMENT_ROOT']."/intranet/Empresa/foto_empleado/". $nip.".".$extension['extension']);
			$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','CARGA FOTO DE EMPLEADO','EMPLEADOS','". $nip.".".$extension['extension']."',NOW(),NOW(),2)");
            if ( $guardado) {
               echo 1;
            }

            echo 0;
			break;
		}
		
		case 'deldocto':{
			$query = "UPDATE pdocumentos SET status=99 WHERE id=".$_POST['id'];
			$sql = $conexion->query($query);
			$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','ELIMINA DOCUMENTO','EMPLEADOS','".base64_encode($query)."',NOW(),NOW(),3)");
			//$imagen = $_POST['id'];
			//unlink($imagen);
			break;
		}
		
		case "calculaSalarios":{
			$sbd = $_POST['sueldobrutodiario'];
			$fil = formateaFechaSLASH($_POST['fechainiciolaboral']);
			//Obtenemos prima vacacional, días de aguinaldo, dias del mes para calculo
			$query = "SELECT * FROM cparametros";
			$sql = $conexion->query($query);
			$row = $sql->fetch_assoc();
			$diasaguinaldo = $row['diasaguinaldo'];
			$primavacacional = $row['primavacacional'];
			$diasmes = $row['diasmes'];
			$sueldominimo = $row['sueldominimo'];
			if($sbd>=$sueldominimo){
				//Obtenemos la antigüedad en años
				$aniosvacaciones = CalculaEdad($fil);
				
				//Obtenemos el sueldo diario Sueldobruto mensual / diasmes
				$sueldodiariobruto = $sbd;
				
				//Obtenemos el sueldo anual Sueldodiariobruto * 365
				$sueldoanual = $sueldodiariobruto * 365;
				//echo $sueldoanual;
				//Obtenemos el pago de aguinaldo
				$aguinaldo = $sueldodiariobruto * $diasaguinaldo;

				//Obtenemos prima vacacional (Sueldodiariobruto * diasdevacacionescorrespondientes) * primavacacional
				$factorintegracion = 1.0452;
				$diasvacaciones = 6;
				$query2 = "SELECT * FROM cdiasvacaciones";
				$sql2 = $conexion->query($query2);
				while($row2 = $sql2->fetch_assoc()){
					if($aniosvacaciones>=$row2['limiteinferior'] && $aniosvacaciones<=$row2['limitesuperior']){
						$factorintegracion = $row2['factorintegracion'];
						$diasvacaciones = $row2['dias'];
					}
				}
				$primavacacional = ($diasvacaciones * $sueldodiariobruto) * $primavacacional;

				//Obtenemos el SBC (Salario Base de Cotización y Salario Diario Integrado)
				$sbc = number_format(($sueldoanual + $aguinaldo + $primavacacional)/365,2,'.','');
				echo trim($sbc);
			}else{
				echo 0;
			}
		}
	}

function CalculaEdad( $fecha ) {
    list($Y,$m,$d) = explode("-",$fecha);
    return( date("md") < $m.$d ? date("Y")-$Y-1 : date("Y")-$Y );
}

function CalculaAntiguedadSAT( $fecha ) {
    $fecha1 = new DateTime($fecha);
	$fecha2 = new DateTime(date('Y-m-d'));
	$fecha = $fecha1->diff($fecha2);
	return "P".$fecha->y."Y".$fecha->m."M".$fecha->d."D";
}


function CalculaAntiguedad( $fecha ) {
    $fecha1 = new DateTime($fecha);
	$fecha2 = new DateTime(date('Y-m-d'));
	$fecha = $fecha1->diff($fecha2);
	$result = '';
	if($fecha->y>0){
		if($fecha->y>1)
			$result.= $fecha->y." Años ";
		else
			$result.= $fecha->y." Año ";
	}
	if($fecha->m>0){
		if($fecha->m>1)
			$result.= $fecha->m." Meses ";
		else
			$result.= $fecha->m." Mes ";
	}
	if($fecha->d>0){
		if($fecha->d>1)
			$result.= $fecha->d." Días ";
		else
			$result.= $fecha->d." Día ";
	}
	if($fecha->y==0 && $fecha->m==0 && $fecha->d==0)
		$result = 'Sin Antigüedad';
	return $result;
}

function formateaFechaSLASH($fecha){
	$arr = explode("/",$fecha);
	if ( sizeof( $arr ) ) {
		$fechaNueva = $arr[2]."-".$arr[1]."-".$arr[0];
		return $fechaNueva;	
	}
	return $fecha;
}

function formateaFechaGUION($fecha){
	$arr = explode("-",$fecha);
	if ( sizeof( $arr ) ) {
		$fechaNueva = $arr[2]."/".$arr[1]."/".$arr[0];
		return $fechaNueva;	
	}	
	return $fecha;

}

function calculaIMC($peso,$estatura){
	if($estatura>0 && $peso>0)
		$imcnum = $peso/($estatura*$estatura);
	else
		return "";
	if($imcnum<18)
		return "PESO BAJO";
	if($imcnum>=18 && $imcnum<25)
		return "NORMAL";
	if($imcnum>=25 && $imcnum<27)
		return "SOBREPESO";
	if($imcnum>=27)
		return "OBESIDAD";
}
?>