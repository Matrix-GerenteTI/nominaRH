<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/nomina/ajax/reportes/prepareExcel.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/nomina/ajax/clases/Asistencias.php';


class ReporteAsistenciaFaltas extends PrepareExcel
{
    public function __construct()
    {
        parent::__construct();
        $this->creaEmptySheet('Reporte Faltas',1);
        $this->creaEmptySheet("Reporte Retardos",0);
    }

    public function generaFaltasRetardos( $fechaInicio = '', $fechaFin= '')
    {
        if ( $fechaInicio == '' || $fechaFin == '' ) {
            $fechaInicio = date('Y-m-1');
            $diasDelMes = cal_days_in_month(CAL_GREGORIAN, date('m'), date('d'));
            $fechaFin = date('Y-m-'.$diasDelMes);
        }
 
        $objAsistencia = new Asistencia;
        $listadoAsistencias = $objAsistencia->getAsistencia(array(
                'fechaInicio' => $fechaInicio,
                'fechaFin' => $fechaFin,
                'trabajador' => '',
                'puesto' => '',
                'nip' => ''
        ));
        
        $trabajador = array();
        foreach ($listadoAsistencias as  $asistenciaTrabajador) {
            $asistenciaTrabajador['dia'] = $asistenciaTrabajador['dia'] < 10 ? '0'.$asistenciaTrabajador['dia'] : $asistenciaTrabajador['dia'];
            $asistenciaTrabajador['mes'] = $asistenciaTrabajador['mes'] < 10 ? '0'.$asistenciaTrabajador['mes'] : $asistenciaTrabajador['mes'];
            $asistenciaTrabajador['hora'] = $asistenciaTrabajador['hora'] < 10 ? '0'.$asistenciaTrabajador['hora'] : $asistenciaTrabajador['hora'];
            $asistenciaTrabajador['minuto'] = $asistenciaTrabajador['minuto'] < 10 ? '0'.$asistenciaTrabajador['minuto'] : $asistenciaTrabajador['minuto'];

            if ( (isset($trabajador[$asistenciaTrabajador['nip']] ) ) ) {
                array_push( $trabajador[$asistenciaTrabajador['nip']]['asistencias'] ,  $asistenciaTrabajador['dia']."/".$asistenciaTrabajador['mes']."/".$asistenciaTrabajador['anio'] );
                if ( $asistenciaTrabajador['RETARDO'] > 0) {
                    array_push( $trabajador[$asistenciaTrabajador['nip']]['retardos'] ,   array('fecha' =>$asistenciaTrabajador['dia']."/".$asistenciaTrabajador['mes']."/".$asistenciaTrabajador['anio'], 'hora' => $asistenciaTrabajador['hora'].':'.$asistenciaTrabajador['minuto'] ) );
                }
            } else {
                $trabajador[$asistenciaTrabajador['nip']]['nip'] =  $asistenciaTrabajador['nip'];
                $trabajador[$asistenciaTrabajador['nip']]['nombre'] =  $asistenciaTrabajador['nombre'];
                $trabajador[$asistenciaTrabajador['nip']]['depto'] =  $asistenciaTrabajador['departamento'];
                $trabajador[$asistenciaTrabajador['nip']]['puesto'] =  $asistenciaTrabajador['puesto'];
                $trabajador[$asistenciaTrabajador['nip']]['sucursal'] =  $asistenciaTrabajador['sucursal'];
                $trabajador[$asistenciaTrabajador['nip']]['faltas'] =  array();
                $trabajador[$asistenciaTrabajador['nip']]['asistencias'] =  array($asistenciaTrabajador['dia']."/".$asistenciaTrabajador['mes']."/".$asistenciaTrabajador['anio']);
                if ( $asistenciaTrabajador['RETARDO'] > 0) {
                    $trabajador[$asistenciaTrabajador['nip']]['retardos'] =  array( array('fecha' =>$asistenciaTrabajador['dia']."/".$asistenciaTrabajador['mes']."/".$asistenciaTrabajador['anio'], 'hora' => $asistenciaTrabajador['hora'].':'.$asistenciaTrabajador['minuto'] ) );
                } else {
                    $trabajador[$asistenciaTrabajador['nip']]['retardos'] = array();
                }
                
            }
            
        }

        foreach ($trabajador as $nip => $trabajadorAsistencia) {
           $trabajador[$nip] = self::verificaFaltasTrabajador( array( 
                'fechaInicio' => $fechaInicio,
                'fechaFin' => $fechaFin,
                'asistencias' => $trabajadorAsistencia
            ));
        }
        return ($trabajador);
    }

    public function preparaReporte( $listadoAsistencias, $fechas)
    {
        extract( $fechas );
        $i = $j = 8;
        
        $this->libro->setActiveSheetIndex(1);
        $this->putLogo("A1",300,200);
        $this->libro->getActiveSheet()->mergeCells("A3:U3");;
        $this->libro->getActiveSheet()->setCellValue("A3","Lista de asistencias del ".str_replace('-','/', $fechaInicio)." al ".str_replace('-','/', $fechaFin));
        $this->libro->getActiveSheet()->getStyle("A3")->applyFromArray($this->centrarTexto);
        $this->libro->getActiveSheet()->getStyle("A3")->applyFromArray($this->labelBold);

        $this->libro->getActiveSheet()->mergeCell("A5:A6");
        $this->libro->getActiveSheet()->setCellValue("A5", "Sucursal"); 

        $this->libro->getActiveSheet()->mergeCell("B5:B6");
        $this->libro->getActiveSheet()->setCellValue("B5", "Departamento");

        $this->libro->getActiveSheet()->mergeCell("C5:C6");
        $this->libro->getActiveSheet()->setCellValue("C5", 'Puesto');

        $this->libro->getActiveSheet()->mergeCell("D5:D6");
        $this->libro->getActiveSheet()->setCellValue("D5","Nombre");

        $this->libro->getActiveSheet()->mergeCell("E5:E6");
        $this->libro->getActiveSheet()->setCellValue("E5", "Fecha"); 

        $this->libro->getActiveSheet()->mergeCell("F5:H5");
        $this->libro->getActiveSheet()->setCellValue("F5", "Entrada");  
        $this->libro->getActiveSheet()->setCellValue("F6", "Hora");  
        $this->libro->getActiveSheet()->setCellValue("G6", "Incidencia");
        $this->libro->getActiveSheet()->setCellValue("H6", "Descuento");

        $this->libro->getActiveSheet()->mergeCell("I5:K5");
        $this->libro->getActiveSheet()->setCellValue("I5", "Salida I.");  
        $this->libro->getActiveSheet()->setCellValue("I6", "Hora");  
        $this->libro->getActiveSheet()->setCellValue("J6", "Incidencia");
        $this->libro->getActiveSheet()->setCellValue("K6", "Descuento");

        $this->libro->getActiveSheet()->mergeCell("L5:N5");
        $this->libro->getActiveSheet()->setCellValue("L5", "Entrada I.");  
        $this->libro->getActiveSheet()->setCellValue("L6", "Hora");  
        $this->libro->getActiveSheet()->setCellValue("M6", "Incidencia");
        $this->libro->getActiveSheet()->setCellValue("N6", "Descuento");

        $this->libro->getActiveSheet()->mergeCell("O5:Q5");
        $this->libro->getActiveSheet()->setCellValue("O5", "Salida");  
        $this->libro->getActiveSheet()->setCellValue("O6", "Hora");  
        $this->libro->getActiveSheet()->setCellValue("P6", "Incidencia");
        $this->libro->getActiveSheet()->setCellValue("Q6", "Descuento");

        $this->libro->getActiveSheet()->setCellValue("R5", "Asistencia"); 
        $this->libro->getActiveSheet()->setCellValue("S5", "Falta"); 
        $this->libro->getActiveSheet()->setCellValue("T5", "Retardos"); 
        $this->libro->getActiveSheet()->setCellValue("U5", "Descuento Total"); 
        $this->libro->getActiveSheet()->getStyle("A5:U6")->applyFromArray($this->centrarTexto);
        $this->libro->getActiveSheet()->getStyle("A5:U6")->applyFromArray($this->labelBold);
        $this->libro->getActiveSheet()->getStyle("A5:U6")->applyFromArray($this->setColorText('000000',11));
        $this->libro->getActiveSheet()->getStyle("A5:U6")->getFill()->applyFromArray( $this->setColorFill("dddddd")  );
        $this->libro->getActiveSheet()->setAutoFilter("A5:E5");
        
        

        foreach ($listadoAsistencias as $nip => $trabajador) {
            
            foreach ($trabajador['faltas'] as $falta) {
                $this->libro->setActiveSheetIndex(1);
                $this->libro->getActiveSheet()->setCellValue("A$i", $i-7);
                $this->libro->getActiveSheet()->getStyle("A$i")->applyFromArray($this->labelBold); 
                $this->libro->getActiveSheet()->setCellValue("B$i", $trabajador['sucursal']);
                $this->libro->getActiveSheet()->setCellValue("C$i", $trabajador['depto']);
                $this->libro->getActiveSheet()->setCellValue("D$i", $trabajador['puesto']);
                $this->libro->getActiveSheet()->setCellValue("E$i", $trabajador['nombre']);
                $this->libro->getActiveSheet()->setCellValue("F$i", $falta['fecha']);
                $this->libro->getActiveSheet()->getRowDimension($i)->setRowHeight(30);
                $this->libro->getActiveSheet()->getStyle("B$i:F$i")->applyFromArray( $this->verticalCenter);
                $i++;
            }

            foreach ($trabajador['retardos'] as $retardo) {
                $this->libro->setActiveSheetIndex(0);
                $this->libro->getActiveSheet()->setCellValue("A$j", $j-7);
                $this->libro->getActiveSheet()->getStyle("A$j")->applyFromArray($this->labelBold); 
                $this->libro->getActiveSheet()->setCellValue("B$j", $trabajador['sucursal']);
                $this->libro->getActiveSheet()->setCellValue("C$j", $trabajador['depto']);
                $this->libro->getActiveSheet()->setCellValue("D$j", $trabajador['puesto']);
                $this->libro->getActiveSheet()->setCellValue("E$j", $trabajador['nombre']);
                $this->libro->getActiveSheet()->setCellValue("F$j", $retardo['fecha']);
                $this->libro->getActiveSheet()->setCellValue("G$j", $retardo['hora']);
                $this->libro->getActiveSheet()->getRowDimension($j)->setRowHeight(30);
                $this->libro->getActiveSheet()->getStyle("B$j:G$j")->applyFromArray( $this->verticalCenter);
                $j++;
            }
        }
        
        $this->libro->getActiveSheet()->getColumnDimension("A")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("B")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("C")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("D")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("E")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("F")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("G")->setAutoSize(true);

        $this->libro->setActiveSheetIndex(1);
        $this->libro->getActiveSheet()->getColumnDimension("A")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("B")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("C")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("D")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("E")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("F")->setAutoSize(true);        
        $reporteTerminado = new PHPExcel_Writer_Excel2007( $this->libro);
        $reporteTerminado->save('Reporte retardos y faltas.xlsx');
        return 'Reporte retardos y faltas.xlsx';
    }

}

$reporte = new ReporteAsistenciaFaltas;
echo $reporte->preparaReporte([], array('fechaInicio' => date('Y-m-1'),'fechaFin' => date('Y-m-15') ) ); 
//$reporte->preparaReporte($reporte->generaFaltasRetardos($_GET['fechaInicio'],$_GET['fechaFin']), array('fechaInicio' => date('Y-m-1'),'fechaFin' => date('Y-m-15') ) ); 

    //$reporte->enviarReporte( $configCorreo);