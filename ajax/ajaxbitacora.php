<?php

	if(!isset($_SESSION))
		session_start();
	require_once("mysql.php");
	//conexion();
	$op = $_GET['op'];
	switch($op){
		case "lista":{
			$usuario = $_POST['usuario'];
			$modulo = $_POST['modulo'];
			$_POST['fecIni']!=''?$fecini = $_POST['fecIni']:$fecini = date("d/m/Y");
			$_POST['fecFin']!=''?$fecfin = $_POST['fecFin']:$fecfin = date("d/m/Y");
			
			$bitacora = array();
			$n = 0;

            $query = "  SELECT 	*
						FROM 	pbitacora
						WHERE 	fecha>='".formateaFechaSLASH($fecini)."' AND fecha<='".formateaFechaSLASH($fecfin)."'
						AND 	usuario LIKE '".$usuario."'  
                        AND     modulo LIKE '".$modulo."' 
						ORDER BY fecha,hora ASC";
			//echo $query;
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc()){
				$bitacora[$n]['id'] = $row['id'];
				$bitacora[$n]['usuario'] = $row['usuario'];
				$bitacora[$n]['modulo'] = $row['modulo'];
				$bitacora[$n]['fecha'] = formateaFechaGUION($row['fecha']);
				$bitacora[$n]['hora'] = $row['hora'];
				$bitacora[$n]['movimiento'] = $row['movimiento'];
				$bitacora[$n]['query'] = $row['query'];
				$n++;
			}
			
			echo json_encode($bitacora);
			break;
		}
		
		case "cmbUsuario":{
			$html = "<option value='%'>Todos...</option>";
			$query = "SELECT * FROM pusuarios WHERE status=1";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['username']."'>".$row['nombre']."</option>";
			echo $html;
			break;
		}
		
		case "cmbModulo":{
			$html = "<option value='%'>Todos...</option>";
			$query = "SELECT * FROM pbitacora GROUP BY modulo";
			$sql = $conexion->query($query);
			while($row = $sql->fetch_assoc())
				$html.="<option value='".$row['modulo']."'>".$row['modulo']."</option>";
			echo $html;
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

?>