<?php
error_reporting(0);
require_once $_SERVER['DOCUMENT_ROOT'].'/nomina/ajax/reportes/prepareExcel.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/nomina/ajax/clases/Asistencias.php';


class ReporteAsistenciaFaltas extends PrepareExcel
{
    public function __construct()
    {
        parent::__construct();
        $this->creaEmptySheet('Reporte de Asistencia',1);
    }

    public function formateaFechaGUION($fecha){
        $arr = explode("-",$fecha);
        $fechaNueva = $arr[2]."/".$arr[1]."/".$arr[0];
        return $fechaNueva;	
    }

    public function preparaReporte( $listadoAsistencias, $fechas)
    {
        extract( $fechas );
        $i = 6;
        $fechaInicio = $fechaInicio==''?date('d/m/Y'):$fechaInicio;
        $fechaFin = $fechaFin==''?date('d/m/Y'):$fechaFin;
        $this->libro->setActiveSheetIndex(1);
        $this->putLogo("A1",0,70);
        $this->libro->getActiveSheet()->mergeCells("A3:U3");;
        $this->libro->getActiveSheet()->setCellValue("A3","Lista de asistencias del ".$fechaInicio." al ".$fechaFin);
        $this->libro->getActiveSheet()->getStyle("A3")->applyFromArray($this->centrarTexto);
        $this->libro->getActiveSheet()->getStyle("A3")->applyFromArray($this->labelBold);

        $this->libro->getActiveSheet()->setCellValue("A5", "NIP"); 
        $this->libro->getActiveSheet()->setCellValue("B5", "Sucursal"); 
        $this->libro->getActiveSheet()->setCellValue("C5", "Departamento");
        $this->libro->getActiveSheet()->setCellValue("D5", 'Puesto');
        $this->libro->getActiveSheet()->setCellValue("E5", "Nombre");
        $this->libro->getActiveSheet()->setCellValue("F5", "Fecha"); 
        $this->libro->getActiveSheet()->setCellValue("G5", "Hora");  
        $this->libro->getActiveSheet()->setCellValue("H5", "Tipo");
        $this->libro->getActiveSheet()->setCellValue("I5", "Incidencia");

        $this->libro->getActiveSheet()->getStyle("A5:I5")->applyFromArray($this->centrarTexto);
        $this->libro->getActiveSheet()->getStyle("A5:I5")->applyFromArray($this->labelBold);
        $this->libro->getActiveSheet()->getStyle("A5:I5")->applyFromArray($this->setColorText('000000',11));
        $this->libro->getActiveSheet()->getStyle("A5:I5")->getFill()->applyFromArray( $this->setColorFill("dddddd")  );
        $this->libro->getActiveSheet()->setAutoFilter("A5:I5");
        
        
        $arrExcel = array();
        foreach ($listadoAsistencias as $trabajador) {
            //$arrIncidencias = array_merge($trabajador['asistencias'], $trabajador['faltas'], $trabajador['retardos']);
            foreach ($trabajador['asistencia'] as $fechaA => $itemA) {
                $arrExcel[] = array('nip'=>$trabajador['nip'],
                                    'sucursal'=>$trabajador['sucursal'],
                                    'depto'=>$trabajador['depto'],
                                    'puesto'=>$trabajador['puesto'],
                                    'nombre'=>$trabajador['nombre'],
                                    'fecha'=>$this->formateaFechaGUION($fechaA),
                                    'hora'=>$itemA['hora'],
                                    'tipo'=>$itemA['tipo'],
                                    'incidencia'=>'Asistencia');
            }
            foreach ($trabajador['faltas'] as $fechaA => $itemA) {
                $arrExcel[] = array('nip'=>$trabajador['nip'],
                                    'sucursal'=>$trabajador['sucursal'],
                                    'depto'=>$trabajador['depto'],
                                    'puesto'=>$trabajador['puesto'],
                                    'nombre'=>$trabajador['nombre'],
                                    'fecha'=>$this->formateaFechaGUION($fechaA),
                                    'hora'=>$itemA['hora'],
                                    'tipo'=>$itemA['tipo'],
                                    'incidencia'=>'Falta');
            }
            foreach ($trabajador['retardos'] as $fechaA => $itemA) {
                $arrExcel[] = array('nip'=>$trabajador['nip'],
                                    'sucursal'=>$trabajador['sucursal'],
                                    'depto'=>$trabajador['depto'],
                                    'puesto'=>$trabajador['puesto'],
                                    'nombre'=>$trabajador['nombre'],
                                    'fecha'=>$this->formateaFechaGUION($fechaA),
                                    'hora'=>$itemA['hora'],
                                    'tipo'=>$itemA['tipo'],
                                    'incidencia'=>'Retardo');
            }
        }

        foreach($arrExcel as $row){
            $this->libro->setActiveSheetIndex(1);
            $this->libro->getActiveSheet()->setCellValue("A$i", $row['nip']);
            $this->libro->getActiveSheet()->setCellValue("B$i", $row['sucursal']);
            $this->libro->getActiveSheet()->setCellValue("C$i", $row['depto']);
            $this->libro->getActiveSheet()->setCellValue("D$i", $row['puesto']);
            $this->libro->getActiveSheet()->setCellValue("E$i", $row['nombre']);
            $this->libro->getActiveSheet()->setCellValue("F$i", $row['fecha']);
            $this->libro->getActiveSheet()->setCellValue("G$i", $row['hora']);
            $this->libro->getActiveSheet()->setCellValue("H$i", $row['tipo']);
            $this->libro->getActiveSheet()->setCellValue("I$i", $row['incidencia']);
            $i++;
        }

        $this->libro->getActiveSheet()->getColumnDimension("A")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("B")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("C")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("D")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("E")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("F")->setAutoSize(true);
        $this->libro->getActiveSheet()->getColumnDimension("G")->setAutoSize(true);

        $reporteTerminado = new PHPExcel_Writer_Excel2007( $this->libro);
        $reporteTerminado->save('Reporte de Asistencia.xlsx');
        return 'Reporte de Asistencia.xlsx';
    }

}

$reporte = new ReporteAsistenciaFaltas;
echo $reporte->preparaReporte(json_decode($_POST['data'],true), array('fechaInicio' => $_POST['fechaInicio'],'fechaFin' => $_POST['fechaFin'] ) ); 
//$reporte->preparaReporte($reporte->generaFaltasRetardos($_GET['fechaInicio'],$_GET['fechaFin']), array('fechaInicio' => date('Y-m-1'),'fechaFin' => date('Y-m-15') ) ); 

    //$reporte->enviarReporte( $configCorreo);