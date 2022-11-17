<?php
	require_once $_SERVER['DOCUMENT_ROOT']."/intranet/modelos/nomina/trabajadores.php";
	require_once $_SERVER['DOCUMENT_ROOT']."/intranet/modelos/nomina/incidencias.php";

	error_reporting(E_ALL);
	ini_set('display_errors', '1');
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

		break;
		
		case "lista":{
			$modeloTrabajador = new Trabajador;
			$departamento = $_POST['departamento'];
			$sucursal = $_POST['sucursal'];
			$nombre = $_POST['nombre'];
			$_POST['fecIni']!=''?$fecini = $_POST['fecIni']:$fecini = date("d/m/Y");

			$ffin = explode( "/" , $_POST['fecFin']  );
			$_POST['fecFin'] = new DateTime( $ffin[2]."-".$ffin[1]."-".$ffin[0] ) > new DateTime( date("Y-m-d") ) ? date("d/m/Y")  : $_POST['fecFin'];
			$_POST['fecFin']!=''?$fecfin = $_POST['fecFin']:$fecfin = date("d/m/Y");
			

			$inicio = $_POST['inicio'];
			$cantidad = $_POST['cantidad'];
			$puesto = $_POST['puesto'];
			
			$dias = calculaDias($fecini,$fecfin);
			
			$date = str_replace("/","-",$fecini);
			$rangoFechas[0] = $date;
			for($d=0;$d<$dias;$d++){
				$mod_date = strtotime($date."+ 1 days");
				$date = date("d-m-Y",$mod_date);
				$rangoFechas[count($rangoFechas)] = $date;
			}

			$infoAsistencia = 
			
			$array = array();
			// $query = "SELECT 	e.nip as nip,
			// 					e.nombre as nombre,
			// 					d.descripcion as departamento,
			// 					p.descripcion as puesto,
			// 					c.id as idcontrato,
			// 					r.timecheck,
			// 					YEAR(r.timecheck) as anio,
			// 					MONTH(r.timecheck) as mes,
			// 					DAY(r.timecheck) as dia,
			// 					HOUR(r.timecheck) as hora,
			// 					MINUTE(r.timecheck) as minuto,
			// 					CASE WHEN TIMEDIFF(TIME(r.timecheck),pa.entrada)>'00:00:59' THEN CASE WHEN(HOUR(TIMEDIFF(TIME(r.timecheck),pa.entrada))*60)+MINUTE(TIMEDIFF(TIME(r.timecheck),pa.entrada))<6 THEN 50 ELSE IF(MINUTE(TIMEDIFF(TIME(r.timecheck),pa.entrada))<11,100,c.salariodiario) END ELSE 0 END AS RETARDO,
			// 					pa.entrada,
			// 					pa.entradai,
			// 					pa.salidai,
			// 					pa.salida,
			// 					pa.tolerancia,
			// 					pa.retardospfalta,
			// 					pa.corrido,
			// 					pa.faltaspdescuento,
			// 					s.descripcion as sucursal
			// 		  FROM 		pregistros r  
			// 		  INNER JOIN pempleado e ON r.idempleado=e.nip 
			// 		  INNER JOIN pcontrato c ON e.nip=c.nip 
			// 		  INNER JOIN cpuesto p ON c.idpuesto=p.id 
			// 		  INNER JOIN cdepartamento d ON c.iddepartamento=d.id  
			// 		  INNER JOIN cparametrosasistencia pa ON p.id=pa.idpuesto 
			// 		  INNER JOIN csucursal s ON e.idsucursal=s.id
			// 		  WHERE 	e.nombre LIKE '%".$nombre."%' 
			// 		  AND 		d.id LIKE '".$departamento."'
			// 		  AND 		s.id LIKE '".$sucursal."' 
			// 		  AND 		p.id LIKE '".$puesto."' ";
			// if($fecini!="" && $fecfin!="")
			// 	$query.= "AND		r.timecheck>='".formateaFechaSLASH($fecini)."' AND r.timecheck<='".formateaFechaSLASH($fecfin)."  23:59:59' ";	
			// $query.= "AND		e.status=1 
			// 		  GROUP BY  d.descripcion,p.descripcion,e.nombre,anio,mes,dia
			// 		  ORDER BY d.descripcion,p.descripcion,e.nombre,r.timecheck ASC";


			$query = "SELECT  pempleado.nombre,csucursal.descripcion AS sucursal,pempleado.nip,pregistros.timecheck,cpuesto.descripcion AS puesto,time( timecheck) AS checado,pcontrato.salariobase,
			cparametrosasistencia.entrada,cparametrosasistencia.tolerancia,date(pregistros.timecheck ) as fecha,pcontrato.id as contratoId,   cdepartamento.descripcion as departamento ,pempleado.nip,pregistros.aplicaIncidencia,pdeducciones.importe                                              
			
			FROM pempleado
			LEFT JOIN pregistros ON pregistros.idempleado = pempleado.nip AND date(pregistros.timecheck ) >= '".formateaFechaSLASH($fecini)."' AND date(pregistros.timecheck ) <= '".formateaFechaSLASH($fecfin)."  23:59:59'  and time(pregistros.timecheck ) != '00:00:00'
			INNER JOIN csucursal ON csucursal.id = pempleado.idsucursal
			INNER JOIN pcontrato ON pcontrato.nip = pempleado.nip
			INNER JOIN cpuesto ON cpuesto.id = pcontrato.idpuesto
			INNER JOIN cdepartamento ON cdepartamento.id = cpuesto.iddepartamento
			INNER JOIN cparametrosasistencia ON cparametrosasistencia.idpuesto = pcontrato.idpuesto
			LEFT JOIN pdeducciones ON pdeducciones.id = pregistros.aplicaIncidencia
			WHERE pempleado.`status` = 1 AND cpuesto.id LIKE '%' AND cdepartamento.id LIKE '$departamento' AND csucursal.id LIKE '$sucursal' AND pempleado.nombre LIKE '%$nombre%' 
			GROUP BY fecha,nombre
			ORDER BY cdepartamento.descripcion,cpuesto.descripcion, timecheck";

			$modeloIncidencia = new Incidencias;

			$sql = $conexion->query($query);
			$asistenciasTrabajadores = $sql->fetch_all(MYSQLI_ASSOC);

			//Primero obtenemos el listado de las asistencias.

			$contadorAsistencia = 0;
			$contadorFaltas = 0;
			$contadorRetardos = 0;
			$trabajador = array();
			
			foreach ($asistenciasTrabajadores as $i => $asistencia) {
				$idIncidencia = -1;
				$monto = 0;
				// $asistencia['mes'] = $asistencia['mes'] < 10 ? "0".$asistencia['mes'] : $asistencia['mes'];
				// $asistencia['dia'] = $asistencia['dia'] < 10  ? "0".$asistencia['dia'] : $asistencia['dia'];
				if( $asistencia['fecha']== null ){
					continue;
				}
				$fechaFormato =  DateTime::createFromFormat("Y-m-d" , $asistencia['fecha'] );


				$checado = strtotime($asistencia['timecheck']);
				$entradaDeseada = strtotime($asistencia['fecha']." ".$asistencia['entrada']);
				$tiempoEntrada = round(($checado - $entradaDeseada) / 60);
				
				if ( $tiempoEntrada <= 0) {
					$asistencia['RETARDO']  = 0;
                }else if( $tiempoEntrada <= ( $asistencia['tolerancia'] + 0.59 ) ){
					$asistencia['RETARDO'] = 0;
                }else{
					$asistencia['RETARDO'] = 1;
					 // en caso de que tenga una deduccion por retardo se obtiene el valor del cargo
					$monto = $asistencia['importe'] > 0 ? $asistencia['importe']  : 0;
					if ( $asistencia['aplicaIncidencia']  == -1 ) { //QUIERE DECIR 	QUE NO SE LE A APLICADO LA INCIDENCIA DEL RETARDO
						$monto = $tiempoEntrada <= $asistencia['tolerancia']  + 5  ? 50 : ( ($tiempoEntrada > $asistencia['tolerancia']  +5)  && ($tiempoEntrada <=  $asistencia['tolerancia']  + 10) )  ? 100 : $asistencia['salariobase'];

						//Se genera una accion correctiva de acuerdo a l tipo de retardo
						$idIncidencia = $modeloIncidencia->setIncidencia([
							'tipoDeduccion' => '0001',
							'monto'  => $monto,
							'contratoId' =>  $asistencia['contratoId'],
							'fechaAplicacion' => $asistencia['fecha'],
							'observaciones' => "Aplicación automatica de incidencia"
						]);
						$modeloTrabajador->updateAplicacionIncidencia( $asistencia['nip'] , $idIncidencia , $asistencia['timecheck']);
					}
				}
				

				if ( isset( $trabajador[$asistencia['nip']] ) ) {
					array_push( $trabajador[$asistencia['nip']]['historialAsistencia'] , $fechaFormato->format("d/m/Y") );
					array_push($trabajador[$asistencia['nip']]['registroAsistencia'] ,array('fecha' => $fechaFormato->format("d/m/Y") , 'hora' => $asistencia['checado'] ) );
					if ( $asistencia['RETARDO'] > 0) {
						$contadorRetardos++;
						// $trabajador[$asistencia['nip']]['nRetardos'] = $contadorRetardos;
						array_push($trabajador[$asistencia['nip']]['diasRetardo'], array( 'fecha' =>$fechaFormato->format("d/m/Y") , 'hora' => $asistencia['checado'] , 'aplicaIncidencia' => $asistencia['aplicaIncidencia'] == -1 ? $idIncidencia : $asistencia['aplicaIncidencia'] , 'monto' => $monto   ) );
						$trabajador[$asistencia['nip']]['nRetardos'] = sizeof( $trabajador[$asistencia['nip']]['diasRetardo']  ) ;
					}
				} else {
					$trabajador[$asistencia['nip']]['historialAsistencia'] = array($fechaFormato->format("d/m/Y") );
					$trabajador[$asistencia['nip']]['registroAsistencia'] = array( array('fecha' => $fechaFormato->format("d/m/Y") , 'hora' => $asistencia['checado']) );
					$trabajador[$asistencia['nip']]['nombre'] = $asistencia['nombre'];
					$trabajador[$asistencia['nip']]['sucursal'] = $asistencia['sucursal'];
					$trabajador[$asistencia['nip']]['depto'] = $asistencia['departamento'];
					$trabajador[$asistencia['nip']]['puesto'] = $asistencia['puesto'];
					$trabajador[$asistencia['nip']]['faltas'] = 0;
					$trabajador[$asistencia['nip']]['id'] = $asistencia['nip'];
					$trabajador[$asistencia['nip']]['diasFaltas'] = array();
					if ( $asistencia['RETARDO'] > 0) {
						$contadorRetardos++;
						$trabajador[$asistencia['nip']]['diasRetardo'] = array( array( 'fecha' =>$fechaFormato->format("d/m/Y") , 'hora' => $asistencia['checado'], 'aplicaIncidencia' => $asistencia['aplicaIncidencia'] == -1 ? $idIncidencia : $asistencia['aplicaIncidencia'] , 'monto' => $monto ) );
						$trabajador[$asistencia['nip']]['nRetardos'] = sizeof( $trabajador[$asistencia['nip']]['diasRetardo']  ) ;
					}else{
						$trabajador[$asistencia['nip']]['nRetardos'] = 0;
						$trabajador[$asistencia['nip']]['diasRetardo'] = array();
					}
				}
				
				//verificando que no el siguiente registro exista y no genere un error
				if ( isset($asistenciasTrabajadores[$i+1]['nip']) ) {
					if ( $asistenciasTrabajadores[$i+1]['nip'] != $asistenciasTrabajadores[$i]['nip'] ) {
						$contadorAsistencia = 0;
						$contadorFaltas = 0;
						$contadorRetardos = 0;						
					}
				}
			}

			$incioExplode = explode('/', $fecini);
			$finExplode = explode('/', $fecfin);
			$mesInicio = $incioExplode[1]/1;
			$mesFin = $finExplode[1]/1;
			$diaInicio = $incioExplode[0] /1;
			$diaFin = $finExplode[0] / 1;

			foreach ($trabajador as $nip => $trabajdorAsistencia) {
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
								
								if ( ! in_array($dia.'/'.$mes.'/'.$incioExplode[2], $trabajdorAsistencia['historialAsistencia']) ) {
									
									$trabajador[$nip]['faltas'] += 1;
									//Se le hace el registro en base de datos de la fecha con la hora en: 00:00:00
									$modeloTrabajador->setEntradaSalidaReloj( [
											'idempleado' => $nip,
											'timecheck' => $incioExplode[2]."-$mes"."-$dia 00:00:00",
											'idreloj' => -1
									]);
									//Obteniendo la fecha y buscar la falta en pregistros que no tenga una incidencia aplicada
									$faltaObtenida = $modeloTrabajador->getFaltaSinIncidenciaAplicada( $nip , $incioExplode[2]."-$mes"."-$dia 00:00:00" );

									$montoFalta = 0;
									$idIncidencia = -1;
									
									if ( $faltaObtenida[0]['aplicaIncidencia'] == -1 ) { //entonces se le hace el cargo por el total de su salario diario x 3 días 
										$idIncidencia = $modeloIncidencia->setIncidencia([
											'tipoDeduccion' => '0005',
											'monto'  => ( $asistencia['salariobase'] * 2 ),
											'contratoId' =>  $asistencia['contratoId'],
											'fechaAplicacion' => $asistencia['fecha'],
											'observaciones' => "Aplicación automatica de incidencia por falta"
										]);
										$asistencia['aplicaIncidencia'] = $idIncidencia;
										$asistencia['importe'] = ( $asistencia['salariobase'] * 2 );
									}
									
									array_push( $trabajador[$nip]['diasFaltas'] , array( 'fecha' =>$dia.'/'.$mes.'/'.$incioExplode[2] , 'aplicaIncidencia' =>  $asistencia['aplicaIncidencia'] ,  'monto' => $asistencia['importe'] ) );
								}							
							}else{
								if($j<=(date("d")*1))
									array_push( $trabajador[$nip]['historialAsistencia'] , array( $dia.'/'.$mes.'/'.$incioExplode[2]) );
							}

						}
				}
				
			}

			// En caso de que se requiera unicamente a los que faltaron o los que tienen retardos
			$listaTrabajadoresActivos = $modeloTrabajador->getNominaActiva();
			//Verificando si el trabajador está en la lista
			foreach ($listaTrabajadoresActivos as $i => $trabajadorActivo) {
				if(!isset( $trabajador[ $trabajadorActivo['nip'] ] ) ){
					$trabajador[$trabajadorActivo['nip']]['historialAsistencia'] = [];
					$trabajador[$trabajadorActivo['nip']]['registroAsistencia'] = [];
					$trabajador[ $trabajadorActivo['nip'] ]['cantAsistencia'] = 0;
					$trabajador[ $trabajadorActivo['nip'] ]['historialAsistencia'] = [];
					$trabajador[ $trabajadorActivo['nip'] ]['nombre'] = $trabajadorActivo['nombre'];
					$trabajador[ $trabajadorActivo['nip'] ]['sucursal'] = $trabajadorActivo['sucursal'];
					$trabajador[ $trabajadorActivo['nip'] ]['depto'] = $trabajadorActivo['departamento'];
					$trabajador[ $trabajadorActivo['nip'] ]['puesto'] = $trabajadorActivo['puesto'];
					$trabajador[ $trabajadorActivo['nip'] ]['faltas'] = 0;
					$trabajador[ $trabajadorActivo['nip'] ]['diasFaltas'] = [];
					$trabajador[ $trabajadorActivo['nip'] ]['diasRetardo'] = [];
					$trabajador[ $trabajadorActivo['nip'] ]['nRetardos'] = sizeof( $trabajador[ $trabajadorActivo['nip'] ]['diasRetardo'] ) ;
					$trabajador[ $trabajadorActivo['nip'] ]['id'] = $trabajadorActivo['nip'];
					//Rellenando  con los datos de inasistencia
					$trabajador[ $trabajadorActivo['nip'] ] = calculaFaltas( $fecini , $fecfin , $trabajador[ $trabajadorActivo['nip'] ] , $trabajadorActivo );
				}else{
					$trabajador[ $trabajadorActivo['nip'] ]['cantAsistencia'] = sizeof( $trabajador[ $trabajadorActivo['nip'] ]['historialAsistencia'] );
				}

				$modeloTrabajador->setCoutFaltasAsistenciaRetardos( [
					'trabajador'  => $trabajadorActivo['nip'],
					'fechaInicio' => formateaFechaSLASH($fecini),
					'fechaFin' => formateaFechaSLASH($fecfin),
					'asistencias' => $trabajador[ $trabajadorActivo['nip'] ]['cantAsistencia'] ,
					'faltas' => $trabajador[ $trabajadorActivo['nip'] ]['faltas'],
					'retardos' => $trabajador[ $trabajadorActivo['nip'] ]['nRetardos'] 
				]);


			}
			//Hay que guardar  los datos de la consulta del periodo en la tabla
			foreach ( $trabajador as $i => $trabajadorItem) {
				$contFaltas = 0;
				$array_faltas = [];
				
				//comprobando que el retardo no se le aplique al trabajador
				foreach ( $trabajadorItem['diasRetardo'] as $j => $asistenciaRetardo) {
					// acá vamos a hacer la separación					
					if ( $asistenciaRetardo['aplicaIncidencia'] == 0 ) {
						// array_push( $trabajador[ $i]['registroAsistencia'], $asistenciaRetardo ) ;
						// array_push( $trabajador[ $i]['historialAsistencia'],  $asistenciaRetardo['fecha'] );
						$trabajador[$i]['nRetardos'] -= 1;
						// $trabajador[ $i ]['cantAsistencia'] += 1;
						
						unset( $trabajador[$i]['diasRetardo'][$j] );
					}			
					
				}
				//Acá comprobar de que la incidencia se haya cargado al empleado
				// //Acá editamos el arreglo que será devuelto al usuario  para hacer las modificaciones correspondientes de las faltas,retardos,asistencia
				// $trabajador[ $i]['faltas'] = sizeof( $array_faltas );
				// $trabajador[ $i]['diasFaltas'] =  $array_faltas ;
			}
			

			// foreach ( $trabajador as $i => $trabajadorAsistencia ) {
			// 	if ( $trabajadorAsistencia['nRetardos'] == 0 && sizeof( $trabajadorAsistencia['diasFaltas']  )  == 0  ){
			// 		unset( $trabajador[$i] );
			// 	} else {
			// 		# code...
			// 	}
				
			// }


			
			echo json_encode($trabajador);
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
    $dias=floor($dias);
    
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

?>