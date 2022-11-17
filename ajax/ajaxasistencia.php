<?php
	require_once $_SERVER['DOCUMENT_ROOT']."/intranet/modelos/nomina/trabajadores.php";
	require_once $_SERVER['DOCUMENT_ROOT']."/intranet/modelos/nomina/incidencias.php";

	//error_reporting(E_ALL);
	//ini_set('display_errors', '1');
	if(!isset($_SESSION))
		session_start();
	require_once("mysql.php");
	//conexion();
	$op = $_GET['op'];
	switch($op){

		case 'quitaIncidenciasViejas':
			$diasDelMes = $número = cal_days_in_month(CAL_GREGORIAN, date("m"), date("Y") );
			$mes = date('m')+1;
			$quincena = date('d') < 16  ? date("Y-m-01") : date("Y-$mes-01");
			$updateInicidencia  = "UPDATE pdeducciones set status = '0' where fechaCargo < '$quincena' and vencimiento is  null  ";

				echo $updateInicidencia;

			$sql = $conexion->query($updateInicidencia);	
			$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','QUITA INCIDENCIAS','ASISTENCIA','".base64_encode($updateInicidencia)."',NOW(),NOW(),3)");
		break;
		
		case "lista":{
			$modeloTrabajador = new Trabajador;
			$sucursal = $_POST['sucursal'];
			$departamento = $_POST['departamento'];
			$puesto = $_POST['puesto'];
			$nombre = $_POST['nombre'];
			$_POST['fecIni']!=''?$fecini = $_POST['fecIni']:$fecini = date("d/m/Y");
			$_POST['fecFin']!=''?$fecfin = $_POST['fecFin']:$fecfin = date("d/m/Y");
			

			$inicio = $_POST['inicio'];
			$cantidad = $_POST['cantidad'];
			//echo $dias."<br>".json_encode($arrDays);
			//die();
			$trabajadores = array();
			$n = 0;
			//Sacamos los empleados activos
			$arr = $modeloTrabajador->getEmpleadosActivos($sucursal,$departamento,$puesto,$nombre); 
			foreach($arr as $row){
				$trabajadores[$n]['nip'] = $row['nip'];
				$trabajadores[$n]['sucursal'] = utf8_decode($row['sucursal']);
				$trabajadores[$n]['depto'] = $row['departamento'];
				$trabajadores[$n]['puesto'] = $row['puesto'];
				$trabajadores[$n]['nombre'] = $row['nombre'];
				$trabajadores[$n]['parametros'] = array();
				$trabajadores[$n]['asistencia'] = array();
				$trabajadores[$n]['retardos'] = array();
				$trabajadores[$n]['faltas'] = array();
				$trabajadores[$n]['sinregistro'] = array();
				$trabajadores[$n]['registros'] = array();
				$trabajadores[$n]['asistenciaTotal'] = 0;
				$trabajadores[$n]['retardosTotal'] = 0;
				$trabajadores[$n]['faltasTotal'] = 0;
				
				//SACAMOS EL ARREGLO DE PARAMETROS DE ASISTENCIA
				$udn = $row['idsucursal'];
				$depto = $row['iddepartamento'];
				$puesto = $row['idpuesto'];
				$empleado = $row['nip'];
				$arr = array();
				$bandera = 0;
				$ne = 0;
				//Sacamos sus parametros de asistencia
				$query = "SELECT 	*
						FROM 		cparametrosasistencia p
						WHERE 	p.idsucursal=".$udn."
						AND 		p.iddepartamento=".$depto."
						AND 		p.idpuesto=".$puesto."
						AND 		p.idempleado=".$empleado."
						ORDER BY 	p.diasemana";
				$sql = $conexion->query($query);
				while($row1 = $sql->fetch_assoc()){
					$trabajadores[$n]['parametros'][$row1['diasemana']] = $row1;
					$ne++;
				}
				if($ne==0){
					$np = 0;
					$queryp = "SELECT 	*
							FROM 		cparametrosasistencia p
							WHERE 	p.idsucursal=".$udn."
							AND 		p.iddepartamento=".$depto."
							AND 		p.idpuesto=".$puesto."
							AND 		p.idempleado=0
							ORDER BY 	p.diasemana";
					$sqlp = $conexion->query($queryp);
					while($rowp = $sqlp->fetch_assoc()){
						$trabajadores[$n]['parametros'][$rowp['diasemana']] = $rowp;
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
								ORDER BY 	p.diasemana";
						$sqld = $conexion->query($queryd);
						while($rowd = $sqld->fetch_assoc()){
							$trabajadores[$n]['parametros'][$rowd['diasemana']] = $rowd;
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
									ORDER BY 	p.diasemana";
							$sqls = $conexion->query($querys);
							while($rows = $sqls->fetch_assoc()){
								$trabajadores[$n]['parametros'][$rows['diasemana']] = $rows;
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
										ORDER BY 	p.diasemana";
								$sqlt = $conexion->query($queryt);
								while($rowt = $sqlt->fetch_assoc()){
									$trabajadores[$n]['parametros'][$rowt['diasemana']] = $rowt;
									$nt++;
								}
								if($nt==0)
									$bandera = 0;
								else
									$bandera = 1;
							}else{
								$bandera = 1;
							}
						}else{
							$bandera = 1;
						}
					}else{
						$bandera = 1;
					}
				}else{
					$bandera = 1;
				}
				$n++;
			}
			
			//Generamos el arreglo del calendario
			$arrCalendario = array();
			$qCalendario = "SELECT 	*
						FROM 	pcalendario
						WHERE 	fecha>='".formateaFechaSLASH($fecini)."' AND fecha<='".formateaFechaSLASH($fecfin)."'
						AND 	status=1";					
			$sCalendario = $conexion->query($qCalendario);
			while($rCalendario = $sCalendario->fetch_assoc()){
				$arrCalendario[$rCalendario['fecha']][] = $rCalendario;
			}
			//var_dump($arrCalendario);

			//Generamos el arreglo de las fechas
			$fecha1= new DateTime(formateaFechaSLASH($fecini));
			$fecha2= new DateTime(formateaFechaSLASH($fecfin));
			$diff = $fecha1->diff($fecha2);
			$diasdif = $diff->days;
			$arrFechasRango = array();
			for($i=0;$i<=$diasdif;$i++){
				if($i==0)
					$arrFechasRango[] = formateaFechaSLASH($fecini);
				else
					$arrFechasRango[] = date("Y-m-d",strtotime($arrFechasRango[count($arrFechasRango)-1]."+ 1 days"));
			}
			if(count($arrFechasRango)==0)
				$arrFechasRango[] = formateaFechaSLASH($fecini);

			//Generamos el arreglo de las checadas en el rango de fechas
			$arrChecks = array();
			$qAsistencia = "SELECT 	a.idempleado as idempleado,
								a.fecha as fecha, 
								a.hora as hora,
								s.id as idsucursal,
								c.idpuesto as idpuesto,
								c.iddepartamento as iddepartamento,
								a.latitud as latitud,
								a.longitud as longitud,
								a.foto as imagen
						FROM 	asistencia a
						INNER JOIN pempleado e ON a.idempleado=e.nip
						INNER JOIN csucursal s ON e.idsucursal=s.id
						INNER JOIN pcontrato c ON c.nip=e.nip
						WHERE 	a.fecha>='".formateaFechaSLASH($fecini)."' AND a.fecha<='".formateaFechaSLASH($fecfin)."'
						AND 	a.status=1 
						ORDER BY fecha,hora ASC";
			
			$sAsistencia = $conexion->query($qAsistencia);
			while($rAsistencia = $sAsistencia->fetch_assoc()){
				$arrChecks[$rAsistencia['idempleado']][$rAsistencia['fecha']][] = $rAsistencia;
			}

			//Sacamos las ubicaciones de las sucursales
			$arrUbicaciones = array();
			$queryUbi = "SELECT * FROM csucursal WHERE status=1";
			$sqlUbi = $conexion->query($queryUbi);
			while($rowUbi = $sqlUbi->fetch_assoc()){
				$arrUbicaciones[] = $rowUbi;
			}

			/* 	CORRECCIÓN, ESTABAS HACIENDOLO MAL. 
				Tienes que crear un arreglo de las fechas del rango seleccionado.
				1.- Recorrer arreglo de trabajadores
				2.- Dentro del foreach de trabajadores correr el foreach de las fechas del rango
				3.- Dentro del foreach de las fechas del rango correr el foreach de asistencias de esa fecha
				4.- Dentro del foreach de asistencias checamos los parametros segun el dia de la semana y comparamos con los campos (entrada,salidai,entradai,salida) que no sean vacios.
				5.- Terminando el foreach de las asistencias según la fecha validamos si tuvo entrada, salidai, entradai y salida para guardar su incidencia.
			*/

			//RANGO EN SEGUNDOS DE CHECADO ANTES Y DESPUES
			$rangoAD = 60;

			foreach($trabajadores as $idxTrabajador => $val){ //Recorremos el arreglo de trabajadores
				
				$trabajadores[$idxTrabajador]['asistenciaTotal'] = 0;
				$trabajadores[$idxTrabajador]['retardosTotal'] = 0;
				$trabajadores[$idxTrabajador]['faltasTotal'] = 0;
				foreach($arrFechasRango as $fechaIterada){
					$bander = 0;
					if(isset($arrCalendario[$fechaIterada])){
						foreach($arrCalendario[$fechaIterada] as $calendarItem){
							if($calendarItem['tipo']==1){	
								$bander=1;									
							}
						}
					}
					if($bander>0)
						continue;
					
					//echo $fechaIterada."\n";
					$diasemanaAsist = date("w",strtotime($fechaIterada));
					if($val['parametros'][$diasemanaAsist]['status']==1){
						$tt = 0;
						//Creamos arreglo de las incidencias que se usaran
						$arrIncidencias = array('entrada'=>array(),'salidai'=>array('check'=>'','img'=>''),'entradai'=>array('check'=>'','img'=>''),'salida'=>array('check'=>'','img'=>''), 'faltas'=>0,'retardos'=>0,'asistencia'=>0);
						if(isset($arrChecks[$val['nip']][$fechaIterada])){
							foreach($arrChecks[$val['nip']][$fechaIterada] as $rowCheck){
								$fotoChck = "/nomina/assets/images/sinimagen.jpg";
								//obteniendo la url de la foto del trabajador
								if(file_exists( $_SERVER['DOCUMENT_ROOT'].$rowCheck['imagen'])  ){
									$fotoChck = $rowCheck['imagen'];
								}
								//parametros generales de la asistencia
								$tolerancia = $val['parametros'][$diasemanaAsist]['tolerancia'];
								//$tolerancia = $val['parametros'][$diasemanaAsist]['toleranciafalta'];
								$checado= "1990/01/01 ".$rowCheck['hora'];
								$paramEntrada = $val['parametros'][$diasemanaAsist]['entrada']!=''?"1990/01/01 ".$val['parametros'][$diasemanaAsist]['entrada']:0;
								$paramSalidai = $val['parametros'][$diasemanaAsist]['salidai']!=''?"1990/01/01 ".$val['parametros'][$diasemanaAsist]['salidai']:0;
								$paramEntradai = $val['parametros'][$diasemanaAsist]['entradai']!=''?"1990/01/01 ".$val['parametros'][$diasemanaAsist]['entradai']:0;
								$paramSalida = $val['parametros'][$diasemanaAsist]['salida']!=''?"1990/01/01 ".$val['parametros'][$diasemanaAsist]['salida']:0;
								//Revisamos Calendario
								if(isset($arrCalendario[$fechaIterada])){
									foreach($arrCalendario[$fechaIterada] as $calendarItem){
										if($calendarItem['tipo']==2){			
											$paramEntrada = "1990/01/01 ".$calendarItem['entrada'].":00";
											$paramSalida = "1990/01/01 ".$calendarItem['salida'].":00";
										}
									}
								}
								$dife = $paramEntrada!=0?(strtotime($checado)-(strtotime($paramEntrada)+($tolerancia*60)))/60:99999;
								$difsi = $paramEntrada!=0?(strtotime($checado)-strtotime($paramSalidai))/60:99999;
								$difei = $paramEntrada!=0?(strtotime($checado)-(strtotime($paramEntradai)+($tolerancia*60)))/60:99999;
								$difs = $paramEntrada!=0?(strtotime($checado)-strtotime($paramSalida))/60:99999;
								$sttc = strtotime($checado);
								$stte = strtotime($paramEntrada)+($tolerancia*60);
								$sttea = strtotime($paramEntrada)-(30*60);
								$stted = strtotime($paramEntrada)+(30*60);
								$sttsi = strtotime($paramSalidai);
								$sttsia = strtotime($paramSalidai)-(30*60);
								$sttsid = strtotime($paramSalidai)+(30*60);
								$sttei = strtotime($paramEntradai)+($tolerancia*60);
								$stteia = strtotime($paramEntradai)-(30*60);
								$stteid = strtotime($paramEntradai)+(30*60);
								$stts = strtotime($paramSalida);
								$sttsa = strtotime($paramSalida)-(30*60);
								$sttsd = strtotime($paramSalida)+(30*60);
								
								$arrParamsCheck = array('entrada'=>$dife,'salidai'=>$difsi,'entradai'=>$difei,'salida'=>$difs);
								

								//Validamos si fue registrado en alguna sucursal
								$chckSuc = '<a href="https://maps.google.com/?q='.$rowCheck['latitud'].','.$rowCheck['longitud'].'" target="_blank">FDR</a>';
								$chckUbica = 'FDR';
								foreach($arrUbicaciones as $ubicacion){
									if($rowCheck['latitud']!='null'){
										$ubiCheck = distance($rowCheck['latitud'],$rowCheck['longitud'],$ubicacion['latitud'],$ubicacion['longitud']);
									}else{
										$ubiCheck = $ubicacion['rango'] * 2;
									}
									if($ubiCheck <= $ubicacion['rango']){
										$chckSuc = '<a href="https://maps.google.com/?q='.$rowCheck['latitud'].','.$rowCheck['longitud'].'" target="_blank">'.$ubicacion['descripcion'].'</a>';
										$chckUbica = $ubicacion['descripcion'];
										//echo '-- ['.$ubiCheck.'] '.$ubicacion['descripcion'];
									}
									//echo '-- ['.$ubiCheck.'] '.$ubicacion['descripcion'];
								}
								//TEMPORAL MIENTRAS SE COMPONE LO DE LA IMAGEN
								//$rowCheck['imagen'] = '';
								$baneraRegistrado = 0;
								$tipoderegistro = 'sinregistro';
								//ENTRADA
								if($dife<=0){//Que haya checado antes y este dentro del rango permitido
									if($chckUbica!='FDR'){
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entrada';
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $dife;
										$baneraRegistrado++;
										$tipoderegistro = 'entrada';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $dife;
										$tt++;
										continue;
									}else{
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entrada';
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $dife;
										$baneraRegistrado++;
										$tipoderegistro = 'entrada';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $dife;
										$tt++;
										continue;
									}
								}elseif($dife>0 && abs($dife)<=$rangoAD){//Si checó despues y este dentro del rango permitido									
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entrada';
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $dife;
									$baneraRegistrado++;
									$tipoderegistro = 'entrada';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $dife;
									$tt++;
									continue;
								}

								//SALIDA INTERMEDIA
								if($difsi<0 && abs($difsi)<=$rangoAD){//Que haya checado antes y este dentro del rango permitido
									if($chckUbica!='FDR'){
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'salidai';
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difsi;
										$baneraRegistrado++;
										$tipoderegistro = 'salidai';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difsi;
										$tt++;
										continue;
									}else{
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'salidai';
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difsi;
										$baneraRegistrado++;
										$tipoderegistro = 'salidai';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difsi;
										$tt++;
										continue;
									}
								}elseif($difsi>=0 && abs($difsi)<=$rangoAD){//Si checó despues y este dentro del rango permitido									
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'salidai';
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difsi;
									$baneraRegistrado++;
									$tipoderegistro = 'salidai';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difsi;
									$tt++;
									continue;
								}

								//ENTRADA INTERMEDIA
								if($difei<=0 && abs($difei)<=$rangoAD){//Que haya checado antes y este dentro del rango permitido
									if($chckUbica!='FDR'){
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entradai';
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difei;
										$tt++;
										$baneraRegistrado++;
										$tipoderegistro = 'entradai';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difei;
										continue;
									}else{
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entradai';
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difei;
										$tt++;
										$baneraRegistrado++;
										$tipoderegistro = 'entradai';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difei;
										continue;
									}
								}elseif($difei>0 && abs($difei)<=$rangoAD){//Si checó despues y este dentro del rango permitido									
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entradai';
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
									$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difei;
									$tt++;
									$baneraRegistrado++;
									$tipoderegistro = 'entradai';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difei;
									continue;
								}

								//SALIDA
								if($difs<0 && abs($difs)<=$rangoAD){//Que haya checado antes y este dentro del rango permitido
									if($chckUbica!='FDR'){
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'salida';
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difs;
										$tt++;
										$baneraRegistrado++;
										$tipoderegistro = 'salida';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difs;
										continue;
									}else{
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'salida';
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difs;
										$tt++;
										$baneraRegistrado++;
										$tipoderegistro = 'salida';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difs;
										continue;
									}
								}elseif($difs>=0 ){//Si checó despues y este dentro del rango permitido									
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'salida';
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = $difs;
									$tt++;
									$baneraRegistrado++;
									$tipoderegistro = 'salida';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = '';
									continue;
								}

								if($baneraRegistrado==0){
									$trabajadores[$idxTrabajador]['sinregistro'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['sinregistro'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'fueraderango';
									$trabajadores[$idxTrabajador]['sinregistro'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['sinregistro'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
									$trabajadores[$idxTrabajador]['sinregistro'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['sinregistro'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = '';

									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = $rowCheck['hora'];
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = $tipoderegistro;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = $chckSuc;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '';
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
									$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = '';
									$tt++;
								}							

							}

							//CREAMOS EL REGISTRO SI NO TIENE ESA FECHA UNA ENTRADA
							$sihayentrada = 0;
							if(isset($trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
								foreach($trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))] as $idx0 => $rowEntradas0){
									if($rowEntradas0['tipo']=='entrada')
										$sihayentrada++;
								}
							}
							
							if($sihayentrada==0){
								$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = '00:00:00';
								$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entrada';
								$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = 'SIN REGISTRO';
								$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = $fotoChck;
								$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
								$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = 1;
								//$trabajadores[$idxTrabajador]['faltasTotal'] = $trabajadores[$idxTrabajador]['faltasTotal'] + 1;	
								$tt++;
							}

							$arrTMP = array('asistencia','retardos','faltas');
							foreach($arrTMP as $rowTMP){
								$identradaMax = -1;
								$difentradaMax = -1;
								$difentradaMin = 99999;
								$idsalidaiMax = -1;
								$difsalidaiMax = -1;
								$difsalidaiMin = 99999;
								$identradaiMax = -1;
								$difentradaiMax = -1;
								$difentradaiMin = 99999;
								$idsalidaMax = -1;
								$difsalidaMax = -1;
								$difsalidaMin = 99999;
								if(isset($trabajadores[$idxTrabajador][$rowTMP][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
									foreach($trabajadores[$idxTrabajador][$rowTMP][str_replace('/','-',formateaFechaGUION($fechaIterada))] as $idx => $rowEntradas){
										if($rowTMP=='retardo' && $rowEntradas['diferencia']<0){											
											if($rowEntradas['tipo']=='entrada'){
												if($rowEntradas['diferencia']>$difentradaMax){
													$identradaMax = $idx;
													$difentradaMax = $rowEntradas['diferencia'];
												}
											}
											if($rowEntradas['tipo']=='salidai'){
												if($rowEntradas['diferencia']>$difsalidaiMax){
													$idsalidaiMax = $idx;
													$difsalidaiMax = $rowEntradas['diferencia'];
												}
											}
											if($rowEntradas['tipo']=='entradai'){
												if($rowEntradas['diferencia']>$difentradaiMax){
													$identradaiMax = $idx;
													$difentradaiMax = $rowEntradas['diferencia'];
												}
											}
											if($rowEntradas['tipo']=='salida'){
												if($rowEntradas['diferencia']>$difsalidaMax){
													$idsalidaMax = $idx;
													$difsalidaMax = $rowEntradas['diferencia'];
												}
											}
										}else{											
											if($rowEntradas['tipo']=='entrada'){
												if($difentradaMin<0){
													if($rowEntradas['diferencia']>$difentradaMin){
														$identradaMax = $idx;
														$difentradaMin = $rowEntradas['diferencia'];
													}
												}else{
													if($rowEntradas['diferencia']<$difentradaMin){
														$identradaMax = $idx;
														$difentradaMin = $rowEntradas['diferencia'];
													}
												}
											}
											if($rowEntradas['tipo']=='salidai'){
												if($rowEntradas['diferencia']<$difsalidaiMin){
													$idsalidaiMax = $idx;
													$difsalidaiMin = $rowEntradas['diferencia'];
												}
											}
											if($rowEntradas['tipo']=='entradai'){
												if($difentradaiMin<0){
													if($rowEntradas['diferencia']<$difentradaiMin){
														$identradaiMax = $idx;
														$difentradaiMin = $rowEntradas['diferencia'];
													}
												}else{
													if($rowEntradas['diferencia']<$difentradaiMin){
														$identradaiMax = $idx;
														$difentradaiMin = $rowEntradas['diferencia'];
													}
												}
											}
											if($rowEntradas['tipo']=='salida'){
												if($rowEntradas['diferencia']<$difsalidaMin){
													$idsalidaMax = $idx;
													$difsalidaMin = $rowEntradas['diferencia'];
												}
											}
										}
									}
									foreach($trabajadores[$idxTrabajador][$rowTMP][str_replace('/','-',formateaFechaGUION($fechaIterada))] as $idx2 => $rowEntradas2){
										if($rowEntradas2['tipo']=='entrada'){
											if($idx2==$identradaMax){
												//$trabajadores[$idxTrabajador][$rowTMP.'Total'] = $trabajadores[$idxTrabajador][$rowTMP.'Total'] + $rowEntradas2['cuenta'];	
											}else{
												unset($trabajadores[$idxTrabajador][$rowTMP][str_replace('/','-',formateaFechaGUION($fechaIterada))][$idx2]);
											}
										}
										if($rowEntradas2['tipo']=='salidai'){
											if($idx2==$idsalidaiMax){
												//$trabajadores[$idxTrabajador][$rowTMP.'Total'] = $trabajadores[$idxTrabajador][$rowTMP.'Total'] + $rowEntradas2['cuenta'];	
											}else{
												unset($trabajadores[$idxTrabajador][$rowTMP][str_replace('/','-',formateaFechaGUION($fechaIterada))][$idx2]);
											}
										}
										if($rowEntradas2['tipo']=='entradai'){
											if($idx2==$identradaiMax){
												//$trabajadores[$idxTrabajador][$rowTMP.'Total'] = $trabajadores[$idxTrabajador][$rowTMP.'Total'] + $rowEntradas2['cuenta'];	
											}else{
												unset($trabajadores[$idxTrabajador][$rowTMP][str_replace('/','-',formateaFechaGUION($fechaIterada))][$idx2]);
											}
										}
										if($rowEntradas2['tipo']=='salida'){
											if($idx2==$idsalidaMax){
												//$trabajadores[$idxTrabajador][$rowTMP.'Total'] = $trabajadores[$idxTrabajador][$rowTMP.'Total'] + $rowEntradas2['cuenta'];	
											}else{
												unset($trabajadores[$idxTrabajador][$rowTMP][str_replace('/','-',formateaFechaGUION($fechaIterada))][$idx2]);
											}
										}
									}
								}
							}
							
						}							

						if(isset($trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
							foreach($trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))] as $idxA => $valA){
								if($valA['tipo']=='entrada'){
									if(isset($trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
										foreach($trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))] as $idxB => $valB){
											if($valB['tipo']=='entrada'){
												unset($trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$idxB]);
											}
										}
									}
									if(isset($trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
										foreach($trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))] as $idxC => $valC){
											if($valC['tipo']=='entrada'){
												unset($trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$idxC]);
											}
										}
									}
								}
							}							
						}
						


						//Despues de que lleno todas las fechas con checks, agregamos un registro de sin registro a los que no tuvieron
						if(!isset($trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
							if(!isset($trabajadores[$idxTrabajador]['asistencia'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
								if(!isset($trabajadores[$idxTrabajador]['retardos'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
									if(!isset($trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))])){
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = '00:00:00';
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entrada';
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = 'SIN REGISTRO';
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '/nomina/assets/images/sinimagen.jpg';
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 1;
										$trabajadores[$idxTrabajador]['faltas'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = 1;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['hora'] = '00:00:00';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['tipo'] = 'entrada';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['ubicacion'] = 'SIN REGISTRO';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['imagen'] = '/nomina/assets/images/sinimagen.jpg';
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['cuenta'] = 0;
										$trabajadores[$idxTrabajador]['registros'][str_replace('/','-',formateaFechaGUION($fechaIterada))][$tt]['diferencia'] = '';
										$tt++;
									}
								}
							}
						}	
					}
				}		
					
				$arrTMP2 = array('asistencia','retardos','faltas');
				foreach($arrTMP2 as $rowTMP2){
					if(isset($trabajadores[$idxTrabajador][$rowTMP2])){
						foreach($trabajadores[$idxTrabajador][$rowTMP2] as $idx1 => $val1){
							foreach($val1 as $idx2 => $val2){
								//echo 'trabajadores['.$idxTrabajador.']['.$rowTMP2."][cuenta] = ".$val2['cuenta']."\n";
								$trabajadores[$idxTrabajador][$rowTMP2.'Total'] = $trabajadores[$idxTrabajador][$rowTMP2.'Total'] + $val2['cuenta'];
							}
						}
					}
				}		
			}			
			echo json_encode($trabajadores);
			break;
		}
		
		case "listaP":{
			$departamento = $_POST['depto'];
			$nombre = $_POST['nombre'];
			$fecini = $_POST['fecIni'];
			$fecfin = $_POST['fecFin'];
			$array = array();
			$query = "SELECT 	COUNT(*) as cantidad								
					  FROM 		pempleado e 
					  INNER JOIN pcontrato c ON c.nip=e.nip
					  INNER JOIN cdepartamento d ON c.iddepartamento=d.id  
					  INNER JOIN ptimbrado t ON c.id=t.idcontrato
					  WHERE 	e.nombre LIKE '%".$nombre."%' 
					  AND 		d.id LIKE '%".$departamento."%'";
			if($fecini!="" && $fecfin!="")
				$query.= "AND		t.fechaPago>='".formateaFechaSLASH($fecini)."' AND t.fechaPago<='".formateaFechaSLASH($fecfin)."'";	
			$query.= "AND		e.status>0
					  AND		t.status<>0";
			$sql = $conexion->query($query);
			$row = $sql->fetch_assoc();
			echo $row['cantidad'];
			break;
		}

		case "guardaAsistencia":{
			$fechaInicio = $_POST['fechaIni'];
			$fechaFin = $_POST['fechaFin'];
			$listaAsistencia = json_decode($_POST['data'],true);
			$arrExcel = array();
			foreach ($listaAsistencia as $trabajador) {
				$queryA = "SELECT 	e.*,
									e.idsucursal as sucursal,
									d.id as depto,
									p.id as puesto,
									c.id as idcontrato,
									c.sueldobruto as sueldobruto
						FROM 		pempleado e 
						INNER JOIN pcontrato c ON c.nip=e.nip
						INNER JOIN cdepartamento d ON c.iddepartamento=d.id
						INNER JOIN cpuesto p ON d.id=p.iddepartamento
						WHERE 	e.nip=".$trabajador['nip'];
				$sqlA = $conexion->query($queryA);
				$rowA = $sqlA->fetch_assoc();

				
				//Sacamos sus parametros de asistencia
                $diasemanaAsist = date("w",strtotime($rAsistencia['fecha']));
                $retardospfalta = 0;
                $faltaspdescuento = 0;
                $montodescuento = 0;
                $notieneP = 0;
                $arrParametros = array();
				$ne = 0;
                $query = "SELECT 	*
                        FROM 		cparametrosasistencia p
                        WHERE 	p.idsucursal=".$rowA['sucursal']."
                        AND 		p.iddepartamento=".$rowA['depto']."
                        AND 		p.idpuesto=".$rowA['puesto']."
                        AND 		p.idempleado=".$rowA['nip']."
						AND 		p.status=1";
                $sql = $conexion->query($query);
                while($row1 = $sql->fetch_assoc()){
                    $retardospfalta = $row1['retardospfalta'];
                    $faltaspdescuento = $row1['faltaspdescuento'];
                    $montodescuento = $row1['montodescuento'];
                    $ne++;
                }
                if($ne==0){
                    $np = 0;
                    $queryp = "SELECT 	*
                            FROM 		cparametrosasistencia p
                            WHERE 	p.idsucursal=".$rowA['sucursal']."
                            AND 		p.iddepartamento=".$rowA['depto']."
                            AND 		p.idpuesto=".$rowA['puesto']."
                            AND 		p.idempleado=0
							AND 		p.status=1";
                    $sqlp = $conexion->query($queryp);
                    while($rowp = $sqlp->fetch_assoc()){
                        $retardospfalta = $rowp['retardospfalta'];
                        $faltaspdescuento = $rowp['faltaspdescuento'];
                        $montodescuento = $rowp['montodescuento'];
                        $np++;
                    }
                    if($np==0){
                        $nd = 0;
                        $queryd = "SELECT 	*
                                FROM 		cparametrosasistencia p
                                WHERE 	p.idsucursal=".$rowA['sucursal']."
                                AND 		p.iddepartamento=".$rowA['depto']."
                                AND 		p.idpuesto=0
                                AND 		p.idempleado=0
								AND 		p.status=1";
                        $sqld = $conexion->query($queryd);
                        while($rowd = $sqld->fetch_assoc()){
                            $retardospfalta = $rowd['retardospfalta'];
                            $faltaspdescuento = $rowd['faltaspdescuento'];
                            $montodescuento = $rowd['montodescuento'];
                            $nd++;
                        }
                        if($nd==0){
                            $ns = 0;
                            $querys = "SELECT 	*
                                    FROM 		cparametrosasistencia p
                                    WHERE 	p.idsucursal=".$rowA['sucursal']."
                                    AND 		p.iddepartamento=0
                                    AND 		p.idpuesto=0
                                    AND 		p.idempleado=0";
                            $sqls = $conexion->query($querys);
                            while($rows = $sqls->fetch_assoc()){
                                $retardospfalta = $rows['retardospfalta'];
                                $faltaspdescuento = $rows['faltaspdescuento'];
                                $montodescuento = $rows['montodescuento'];
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
										AND 		p.status=1";
                                $sqlt = $conexion->query($queryt);
                                while($rowt = $sqlt->fetch_assoc()){
                                    $retardospfalta = $rowt['retardospfalta'];
                                    $faltaspdescuento = $rowt['faltaspdescuento'];
                                    $montodescuento = $rowt['montodescuento'];
                                    $nt++;
                                }
                            }
                        }
                    }
                }
                
                $TotalAsistencia = 0;
                $faltas = 0;
                $retardos = 0;
				foreach ($trabajador['asistencia'] as $fechaA => $itemA) {
					foreach($itemA as $iA){
						$arrExcel[] = array('nip'=>$trabajador['nip'],
											'sucursal'=>$trabajador['sucursal'],
											'depto'=>$trabajador['depto'],
											'puesto'=>$trabajador['puesto'],
											'nombre'=>$trabajador['nombre'],
											'fecha'=>formateaFechaGUION($fechaA),
											'hora'=>$iA['hora'],
											'tipo'=>$iA['tipo'],
											'incidencia'=>'Asistencia');
					}
				}
				foreach ($trabajador['faltas'] as $fechaA => $itemA) {
					foreach($itemA as $iA){
						$arrExcel[] = array('nip'=>$trabajador['nip'],
											'sucursal'=>$trabajador['sucursal'],
											'depto'=>$trabajador['depto'],
											'puesto'=>$trabajador['puesto'],
											'nombre'=>$trabajador['nombre'],
											'fecha'=>formateaFechaGUION($fechaA),
											'hora'=>$iA['hora'],
											'tipo'=>$iA['tipo'],
											'incidencia'=>'Falta');
						$faltas++;
					}
				}
				foreach ($trabajador['retardos'] as $fechaA => $itemA) {
					foreach($itemA as $iA){
						$arrExcel[] = array('nip'=>$trabajador['nip'],
											'sucursal'=>$trabajador['sucursal'],
											'depto'=>$trabajador['depto'],
											'puesto'=>$trabajador['puesto'],
											'nombre'=>$trabajador['nombre'],
											'fecha'=>formateaFechaGUION($fechaA),
											'hora'=>$iA['hora'],
											'tipo'=>$iA['tipo'],
											'incidencia'=>'Retardo');
						$retardos++;
					}
				}

				if($retardospfalta>0)
					$faltas = $faltas + floor($retardos/$retardospfalta);
				$descuentoFaltas = 0;
				if($montodescuento>0){
					if($faltaspdescuento>0)
						$descuentoFaltas = floor($faltas/$faltaspdescuento) * $montodescuento;
				}else{
					if($faltaspdescuento>0)
						$descuentoFaltas = floor($faltas/$faltaspdescuento) * $rowA['sueldobruto'];
				}
				if($descuentoFaltas>0){
					$qch0 = "DELETE FROM pdeducciones WHERE idtipodeduccion='020' AND idcontrato='".$rowA['idcontrato']."' AND fechaCargo='".formateaFechaSLASH($fechaFin)."'";
					$sch0 = $conexion->query($qch0);
					$conexion->query("INSERT INTO pdeducciones (idtipodeduccion,importe,status,idcontrato,fechaCargo) VALUES ('020',".$descuentoFaltas.",1,".$rowA['idcontrato'].",'".formateaFechaSLASH($fechaFin)."')");
				}
			
			}

			foreach($arrExcel as $row){
				$qch = "DELETE FROM pasistencia WHERE nip='".$row['nip']."' AND fecha='".$row['fecha']."' AND tipo='".$row['tipo']."'";
				$sch = $conexion->query($qch);
				$query = "INSERT INTO pasistencia (nip,fecha,hora,tipo,incidencia,usuario) VALUES ('".$row['nip']."','".$row['fecha']."','".$row['hora']."','".$row['tipo']."','".$row['incidencia']."','".$_SESSION['userid']."')";
				$conexion->query($query);
			}
			$sql = $conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','GUARDA ASISTENCIA','ASISTENCIA','".base64_encode($query.'...')."',NOW(),NOW(),3)");
			if(!$sql)
				echo 0;
			else
				echo 1;
			break;
		}
		
	}


 function calculaFaltas( $fechaInicio , $fechaFin , $itemTrabajador, $detalleTrabajador = null  )
{
	$modeloTrabajador = new Trabajador;
	$modeloIncidencia = new Incidencias;

	$incioExplode = explode('/', $fechaInicio);
	$finExplode = explode('/', $fechaFin);
	$mesInicio = $incioExplode[1]/1;
	$mesFin = $finExplode[1]/1;
	$diaInicio = $incioExplode[0] /1;
	$diaFin = $finExplode[0] / 1;

			for ($i= $mesInicio; $i <= $mesFin ; $i++) { 
				$mes = $i < 10 ? '0'.$i : $i;
				if ( $mesInicio !=  $i) {
					$diaInicio = 1;
				}
				if ( $mesFin != $i) {
					$diaFin = cal_days_in_month(CAL_GREGORIAN, $i, $incioExplode[2]);
				}
										
				for ($j= $diaInicio; $j <= $diaFin ; $j++) { 
					$dia =  $j < 10 ? '0'.$j : $j;
					 
					if (strftime("%a", strtotime($mes."/".$dia."/".$incioExplode[2])) != "Sun" ) {
						
						if ( ! in_array($dia.'/'.$mes.'/'.$incioExplode[2], $itemTrabajador['historialAsistencia']) ) {
							$itemTrabajador['faltas'] += 1;
							
									//Se le hace el registro en base de datos de la fecha con la hora en: 00:00:00
									$modeloTrabajador->setEntradaSalidaReloj( [
										'idempleado' => $itemTrabajador['id'],
										'timecheck' => $incioExplode[2]."-$mes"."-$dia 00:00:00",
										'idreloj' => -1
								]);
									//Obteniendo la fecha y buscar la falta en pregistros que no tenga una incidencia aplicada
									$faltaObtenida = $modeloTrabajador->getFaltaSinIncidenciaAplicada( $itemTrabajador['id'] , $incioExplode[2]."-$mes"."-$dia 00:00:00" );
									$montoFalta = 0;
									$idIncidencia = -1;

									if ( $faltaObtenida[0]['aplicaIncidencia'] == -1 ) { //entonces se le hace el cargo por el total de su salario diario x 3 días 
										
										$idIncidencia = $modeloIncidencia->setIncidencia([
											'tipoDeduccion' => '0005',
											'monto'  => ( $detalleTrabajador['salariobase'] * 2  ),
											'contratoId' =>  $detalleTrabajador['contratoId'],
											'fechaAplicacion' => $incioExplode[2]."-$mes"."-$dia",
											'observaciones' => "Aplicación automatica de incidencia por falta"
										]);
										$detalleTrabajador['aplicaIncidencia'] = $idIncidencia;
										$montoFalta = ( $detalleTrabajador['salariobase'] * 2 );

										//Asignando  al registro de la falta
										$modeloTrabajador->updateAplicacionIncidencia( $itemTrabajador['id'] , $idIncidencia , $incioExplode[2]."-$mes"."-$dia 00:00:00" );
										
									}else{
										$idIncidencia = $faltaObtenida[0]['aplicaIncidencia'] ;
										$montoFalta = $modeloIncidencia->getDetalleIncidencia( $idIncidencia )[0]['importe'];
									}
									
									array_push( $itemTrabajador['diasFaltas'] , array( 'fecha' =>$dia.'/'.$mes.'/'.$incioExplode[2] , 'aplicaIncidencia' => $idIncidencia, 'monto' => $montoFalta ) );
																								
						}							
					}else{
						if($j<=(date("d")*1))
							array_push( $itemTrabajador['historialAsistencia'] , array( $dia.'/'.$mes.'/'.$incioExplode[2]) );
					}

				}
		}
		return $itemTrabajador;
}

function CalculaEdad( $fecha ) {
    list($Y,$m,$d) = explode("-",$fecha);
    return( date("md") < $m.$d ? date("Y")-$Y-1 : date("Y")-$Y );
}

function CalculaAntiguedadSAT( $fecha, $fechaFinal ) {
    $fecha1 = new DateTime($fecha);
	$fecha2 = new DateTime($fechaFinal);
	$fecha = $fecha1->diff($fecha2);
	$anio = $fecha->y;
	$mes = $fecha->m;
	$dia = $fecha->d;
	$return = "P";
	if($anio>0)
		$return.= $anio."Y";
	if($mes>0)
		$return.= $mes."M";
	$return.= $dia."D";
	return $return;
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

function formateaFecha($fecha){
	$arr = explode("-",$fecha);
	$fechaNueva = $arr[2]."-".$arr[1]."-".$arr[0];
	return $fechaNueva;	
}

function calculaDias($fechaI, $fechaF)
{
    $fecha1= explode("/",$fechaI); // convierte la fecha de formato mm/dd/yyyy a marca de tiempo
    $dia1=$fecha1[0]; // día del mes en número
    $mes1=$fecha1[1]; // número del mes de 01 a 12
    $anio1=$fecha1[2];
    
    $fecha2= explode("/",$fechaF); // convierte la fecha de formato mm/dd/yyyy a marca de tiempo
    $dia2=$fecha2[0]; // día del mes en número
    $mes2=$fecha2[1]; // número del mes de 01 a 12
    $anio2=$fecha2[2];
    
    $fecha1a=mktime(0,0,0,$mes1,$dia1,$anio1);
    $fecha2a=mktime(0,0,0,$mes2,$dia2,$anio2);
 
    $diferencia = $fecha2a - $fecha1a;
    $dias=$diferencia/(60*60*24);
    $dias=floor($dias)+1;
    
    return $dias; 
}

function calculaMinutos($hora1,$hora2){ 
    $h1=explode(':',$hora1); 
    $h2=explode(':',$hora2); 

	$h1 = ($h1[0]*60)+$h1[1]; 
	$h2 = ($h2[0]*60)+$h2[1]; 
	$total_minutos_trasncurridos = $h2 - $h1; 
	return($total_minutos_trasncurridos); 
}

function formateaDigitos($numero){
	if($numero<10)
		return '0'.$numero;
	else
		return $numero;
}

function distance($lat1, $lon1, $lat2, $lon2) { 
	$pi80 = M_PI / 180; 
	$lat1 *= $pi80; 
	$lon1 *= $pi80; 
	$lat2 *= $pi80; 
	$lon2 *= $pi80; 
	$r = 6372.797; // mean radius of Earth in km 
	$dlat = $lat2 - $lat1; 
	$dlon = $lon2 - $lon1; 
	$a = sin($dlat / 2) * sin($dlat / 2) + cos($lat1) * cos($lat2) * sin($dlon / 2) * sin($dlon / 2); 
	$c = 2 * atan2(sqrt($a), sqrt(1 - $a)); 
	$km = $r * $c; 
	$mts = floor($km*1000); 
	return $mts; 
}

?>