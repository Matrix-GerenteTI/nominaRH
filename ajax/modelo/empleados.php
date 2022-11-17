<?php 

require_once $_SERVER['DOCUMENT_ROOT']."/nomina/ajax/clases/DB.php";


class Empleados extends DB 
{
    public function getEmpleadosActivos( $departamento, $puesto, $nombre)
    {

        $queryEmpleados = "SELECT   pempleado.nip, 
                                    pempleado.nombre as nombre,
                                    cdepartamento.descripcion as departamento,
                                    cpuesto.descripcion as puesto
                           FROM     pempleado
                           INNER JOIN pcontrato on pcontrato.nip = pempleado.nip
                           INNER JOIN csucursal on csucursal.id = pempleado.idsucursal
                           INNER JOIN cdepartamento on cdepartamento.id = pcontrato.iddepartamento
                           WHERE   pempleado.status = 1
                           AND     csucursal.id LIKE '%$sucursal%'
                           AND     cdepartamento.id LIKE '%$departamentoId%'
                           AND     cpuesto.id LIKE '%$puesto%'
                           AND     pempleado.nombre LIKE '%$nombre%' 
                           ORDER BY csucursal.descripcion,cdepartamento.descripcion,cpuesto.descripcion,pempleado.nombre ";

        return $this->select( $queryEmpleados );
    }

    public function getEmpleadoByDepartamento( $nombreTrabajador, $departamentoId)
    {

        $queryEmpleados = "SELECT pempleado.nip, pempleado.nombre,cdepartamento.descripcion as departamento
                                            FROM pempleado
                                            INNER JOIN pcontrato on pcontrato.nip = pempleado.nip
                                            INNER JOIN cdepartamento on cdepartamento.id = pcontrato.iddepartamento
                                            WHERE (pempleado.nombre LIKE '%$nombreTrabajador%'  OR  pempleado.nombre = '$nombreTrabajador' ) AND pempleado.status = 1
                                            AND  cdepartamento.id LIKE '$departamentoId' ";

        return $this->select( $queryEmpleados );
    }

    public function getPersonalDataEmpleado($empleado)
    {
        $queryEmpleado = "SELECT pempleado.nip,pempleado.nombre,pempleado.fechanac,pempleado.edocivil,cestado.descripcion as estado,
                                    pdireccion.calle, pdireccion.numext,pdireccion.numint,pdireccion.colonia,pdireccion.municipio,pdireccion.cp
                                    FROM pempleado
                                    INNER JOIN pdireccion ON pdireccion.nip = pempleado.nip
                                    INNER JOIN cestado ON pdireccion.idestado=cestado.id
                                    WHERE  (pempleado.nip ='$empleado' || pempleado.nombre LIKE '%$empleado%'  ) AND pempleado.status = 1";
        return $this->select( $queryEmpleado );
    }

    public function registraFamiliarEmpleado( $query )
    {
        $queryFamiliar = "INSERT INTO cfamiliares_empleados VALUES $query ";
        echo $queryFamiliar;
        return $this->insert( $queryFamiliar );
    }
    public function actualizaDatosPersonales( $parametros )
    {
        extract( $parametros );
        $queryDatosPersonales = "UPDATE pempleado SET nombre='$empleado' ,
                                        fechanac='$fechaNac',edocivil='$edoCivil'  
                                        WHERE nip = $nip";
        return $this->update( $queryDatosPersonales );
    }

    public function actualizaDireccionTrabajador( $parametros )
    {
        extract( $parametros );
        $querySetDireccion = "UPDATE  pdireccion SET calle='$calle',numext='$numExt',
                                    numint='$numInt',colonia='$colonia', municipio='$municipio',cp='$cp'
                                    WHERE  nip = $nip ";
        return $this->update( $querySetDireccion );
    }

    public function agregaLugarNacimiento( $parametros )
    {
        extract( $parametros );
        $queryNacimiento = "INSERT INTO pevaluacion_socioeconomico VALUES(1,$socioeconomico,'$lugarNac') ";
        // echo $queryNacimiento;
        return $this->insert( $queryNacimiento);
    }

    public function getContrato($empleado)
    {
        
        //Sacamos el HTML del formato
        $qFormato = "SELECT * FROM pformatos WHERE idformato=1";
        $rFormato = $this->select($qFormato);
        $html = base64_decode($rFormato[0]['texto']);
        $arrCampos = array();
        //Sacamos la información del contrato
        $qContrato = "SELECT 	e.nombre as empleado_nombre,
                                TIMESTAMPDIFF(YEAR,e.fechanac,CURDATE()) as empleado_edad,
                                e.edocivil as empleado_edocivil,
                                e.nss as empleado_nss,
                                d.calle as empleado_calle,
                                d.numext as empleado_numext,
                                d.numint as empleado_numint,
                                d.colonia as empleado_colonia,
                                d.municipio as empleado_municipio,
                                edo.descripcion as empleado_estado,
                                d.cp as empleado_cp,
                                e.curp as empleado_curp,
                                e.rfc as rfc,
                                e.nip as empleado_nip,
                                c.fechainiciolab as contrato_fechainiciolab,
                                a.descripcion as contrato_departamento,
                                p.descripcion as contrato_puesto,
                                tc.descripcion as contrato_tipocontrato,
                                CASE pp.id 
                                    WHEN '01' THEN (c.sueldobruto) 
                                    WHEN '02' THEN (c.sueldobruto*7) 
                                    WHEN '03' THEN (c.sueldobruto*14)
                                    WHEN '04' THEN (c.sueldobruto*15)
                                    WHEN '05' THEN (c.sueldobruto*30)
                                    WHEN '06' THEN (c.sueldobruto*60)
                                    WHEN '10' THEN (c.sueldobruto*10)
                                END as contrato_sueldoquincenal,
                                pp.descripcion as contrato_periodicidadpago
                    FROM 		pempleado e 
                    INNER JOIN pcontrato c ON c.nip=e.nip
                    INNER JOIN ctipocontrato tc ON c.idtipocontrato=tc.id
                    INNER JOIN cperiodicidadpago pp ON c.idperiodicidadpago=pp.id
                    INNER JOIN pdireccion d ON e.nip=d.nip 
                    INNER JOIN cestado edo ON d.idestado=edo.id
                    INNER JOIN cdepartamento a ON a.id=c.iddepartamento 
                    LEFT JOIN cpuesto p ON p.id=c.idpuesto
                    LEFT JOIN pusuarios u ON e.nip=u.idempleado
                    WHERE 	e.nip='".$empleado."'";
        $rContrato = $this->select($qContrato);
        foreach($rContrato as $idx => $rowC){
            $arrCampos = $rowC;
        }
        $this->insert("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','IMPRIME CONTRATO','EMPLEADOS','".base64_encode($arrCampos['empleado_nombre'])."',NOW(),NOW(),2)");
        //Sacamos la información del contrato
        $qEmpresa = "SELECT 	d.calle as empresa_calle,
                                d.numext as empresa_numext,
                                d.numint as empresa_numint,
                                d.colonia as empresa_colonia,
                                d.municipio as empresa_municipio,
                                edo.descripcion as empresa_estado,
                                d.cp as empresa_cp
                    FROM 		ppatron e 
                    INNER JOIN pdireccion d ON e.iddireccion=d.id
                    INNER JOIN cestado edo ON d.idestado=edo.id";
        $rEmpresa = $this->select($qEmpresa);
        $arrCampos['empresa_calle'] = $rEmpresa[0]['empresa_calle'];
        $arrCampos['empresa_numext'] = $rEmpresa[0]['empresa_numext'];
        $arrCampos['empresa_numint'] = $rEmpresa[0]['empresa_numint'];
        $arrCampos['empresa_colonia'] = $rEmpresa[0]['empresa_colonia'];
        $arrCampos['empresa_municipio'] = $rEmpresa[0]['empresa_municipio'];
        $arrCampos['empresa_estado'] = $rEmpresa[0]['empresa_estado'];
        //Sacamos los badges del formato
        $qBadges = "SELECT b.* FROM cbadgets b INNER JOIN rformatobadget fb ON b.id=fb.idbadget WHERE fb.idformato=1";
        $rBadges = $this->select($qBadges);
        foreach($rBadges as $idx1 => $rowB){
            $pos = strpos($rowB['campo'], ' ');
            if ($pos === false) {
                switch($rowB['campo']){
                    case 'fecha_texto':{
                        $html = str_replace('{{'.$rowB['campo'].'}}',$this->fechaCastellano(date('Y-m-d')),$html);
                        break;
                    }
                    case 'contrato_fechainiciolab':{
                        $html = str_replace('{{'.$rowB['campo'].'}}',date('d/m/Y',strtotime($arrCampos[$rowB['campo']])),$html);
                        break;
                    }
                    default:{
                        $html = str_replace('{{'.$rowB['campo'].'}}',$arrCampos[$rowB['campo']],$html);
                    }
                }
            }else{
                $exp = explode(' ',$rowB['campo']);
                $pos2 = strpos($exp[1], '_');
                if ($pos2 === false) {
                    switch($exp[1]){
                        case 'importeEnLetras':{
                            $html = str_replace('{{'.$rowB['campo'].'}}',strtoupper($this->num2letras($arrCampos[$exp[0]])),$html);
                            break;
                        }
                    }
                }else{
                    $exp2 = explode('_',$exp[1]);
                    switch($exp2[0]){
                        case 'sumaFecha':{
                            $expDateOp = str_replace('.',' ',$exp2[1]);
                            $html = str_replace('{{'.$rowB['campo'].'}}',date('d/m/Y',strtotime($arrCampos[$exp[0]].'+ '.$expDateOp)),$html);
                            break;
                        }
                    }
                }
            }
        }

        return $html;
    }

    public function fechaCastellano($fecha) {
        $fecha = substr($fecha, 0, 10);
        $numeroDia = date('d', strtotime($fecha));
        $dia = date('l', strtotime($fecha));
        $mes = date('F', strtotime($fecha));
        $anio = date('Y', strtotime($fecha));
        $dias_ES = array("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo");
        $dias_EN = array("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");
        $nombredia = str_replace($dias_EN, $dias_ES, $dia);
        $meses_ES = array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
        $meses_EN = array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        $nombreMes = str_replace($meses_EN, $meses_ES, $mes);
        return $nombredia." ".$numeroDia." de ".$nombreMes." del ".$anio;
    }

    public function num2letras($num, $fem = false, $dec = true) { 
        $matuni[2]  = "dos"; 
        $matuni[3]  = "tres"; 
        $matuni[4]  = "cuatro"; 
        $matuni[5]  = "cinco"; 
        $matuni[6]  = "seis"; 
        $matuni[7]  = "siete"; 
        $matuni[8]  = "ocho"; 
        $matuni[9]  = "nueve"; 
        $matuni[10] = "diez"; 
        $matuni[11] = "once"; 
        $matuni[12] = "doce"; 
        $matuni[13] = "trece"; 
        $matuni[14] = "catorce"; 
        $matuni[15] = "quince"; 
        $matuni[16] = "dieciseis"; 
        $matuni[17] = "diecisiete"; 
        $matuni[18] = "dieciocho"; 
        $matuni[19] = "diecinueve"; 
        $matuni[20] = "veinte"; 
        $matunisub[2] = "dos"; 
        $matunisub[3] = "tres"; 
        $matunisub[4] = "cuatro"; 
        $matunisub[5] = "quin"; 
        $matunisub[6] = "seis"; 
        $matunisub[7] = "sete"; 
        $matunisub[8] = "ocho"; 
        $matunisub[9] = "nove"; 
     
        $matdec[2] = "veint"; 
        $matdec[3] = "treinta"; 
        $matdec[4] = "cuarenta"; 
        $matdec[5] = "cincuenta"; 
        $matdec[6] = "sesenta"; 
        $matdec[7] = "setenta"; 
        $matdec[8] = "ochenta"; 
        $matdec[9] = "noventa"; 
        $matsub[3]  = 'mill'; 
        $matsub[5]  = 'bill'; 
        $matsub[7]  = 'mill'; 
        $matsub[9]  = 'trill'; 
        $matsub[11] = 'mill'; 
        $matsub[13] = 'bill'; 
        $matsub[15] = 'mill'; 
        $matmil[4]  = 'millones'; 
        $matmil[6]  = 'billones'; 
        $matmil[7]  = 'de billones'; 
        $matmil[8]  = 'millones de billones'; 
        $matmil[10] = 'trillones'; 
        $matmil[11] = 'de trillones'; 
        $matmil[12] = 'millones de trillones'; 
        $matmil[13] = 'de trillones'; 
        $matmil[14] = 'billones de trillones'; 
        $matmil[15] = 'de billones de trillones'; 
        $matmil[16] = 'millones de billones de trillones'; 
        
        //Zi hack
        $float=explode('.',$num);
        $num=$float[0];
     
        $num = trim((string)@$num); 
        if ($num[0] == '-') { 
           $neg = 'menos '; 
           $num = substr($num, 1); 
        }else 
           $neg = ''; 
        while ($num[0] == '0') $num = substr($num, 1); 
        if ($num[0] < '1' or $num[0] > 9) $num = '0' . $num; 
        $zeros = true; 
        $punt = false; 
        $ent = ''; 
        $fra = ''; 
        for ($c = 0; $c < strlen($num); $c++) { 
           $n = $num[$c]; 
           if (! (strpos(".,'''", $n) === false)) { 
              if ($punt) break; 
              else{ 
                 $punt = true; 
                 continue; 
              } 
     
           }elseif (! (strpos('0123456789', $n) === false)) { 
              if ($punt) { 
                 if ($n != '0') $zeros = false; 
                 $fra .= $n; 
              }else 
     
                 $ent .= $n; 
           }else 
     
              break; 
     
        } 
        $ent = '     ' . $ent; 
        if ($dec and $fra and ! $zeros) { 
           $fin = ' coma'; 
           for ($n = 0; $n < strlen($fra); $n++) { 
              if (($s = $fra[$n]) == '0') 
                 $fin .= ' cero'; 
              elseif ($s == '1') 
                 $fin .= $fem ? ' una' : ' un'; 
              else 
                 $fin .= ' ' . $matuni[$s]; 
           } 
        }else 
           $fin = ''; 
        if ((int)$ent === 0) return 'Cero ' . $fin; 
        $tex = ''; 
        $sub = 0; 
        $mils = 0; 
        $neutro = false; 
        while ( ($num = substr($ent, -3)) != '   ') { 
           $ent = substr($ent, 0, -3); 
           if (++$sub < 3 and $fem) { 
              $matuni[1] = 'una'; 
              $subcent = 'as'; 
           }else{ 
              $matuni[1] = $neutro ? 'un' : 'uno'; 
              $subcent = 'os'; 
           } 
           $t = ''; 
           $n2 = substr($num, 1); 
           if ($n2 == '00') { 
           }elseif ($n2 < 21) 
              $t = ' ' . $matuni[(int)$n2]; 
           elseif ($n2 < 30) { 
              $n3 = $num[2]; 
              if ($n3 != 0) $t = 'i' . $matuni[$n3]; 
              $n2 = $num[1]; 
              $t = ' ' . $matdec[$n2] . $t; 
           }else{ 
              $n3 = $num[2]; 
              if ($n3 != 0) $t = ' y ' . $matuni[$n3]; 
              $n2 = $num[1]; 
              $t = ' ' . $matdec[$n2] . $t; 
           } 
           $n = $num[0]; 
           if ($n == 1) { 
              $t = ' ciento' . $t; 
           }elseif ($n == 5){ 
              $t = ' ' . $matunisub[$n] . 'ient' . $subcent . $t; 
           }elseif ($n != 0){ 
              $t = ' ' . $matunisub[$n] . 'cient' . $subcent . $t; 
           } 
           if ($sub == 1) { 
           }elseif (! isset($matsub[$sub])) { 
              if ($num == 1) { 
                 $t = ' mil'; 
              }elseif ($num > 1){ 
                 $t .= ' mil'; 
              } 
           }elseif ($num == 1) { 
              $t .= ' ' . $matsub[$sub] . '?n'; 
           }elseif ($num > 1){ 
              $t .= ' ' . $matsub[$sub] . 'ones'; 
           }   
           if ($num == '000') $mils ++; 
           elseif ($mils != 0) { 
              if (isset($matmil[$sub])) $t .= ' ' . $matmil[$sub]; 
              $mils = 0; 
           } 
           $neutro = true; 
           $tex = $t . $tex; 
        } 
        $tex = $neg . substr($tex, 1) . $fin; 
        //Zi hack --> return ucfirst($tex);
        $end_num=ucfirst($tex).' pesos '.$float[1].'/100 MXN';
        return $end_num; 
     }
}
