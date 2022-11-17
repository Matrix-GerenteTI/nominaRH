<?php
error_reporting(1);
require_once $_SERVER['DOCUMENT_ROOT'].'/nomina/ajax/reportes/prepareExcel.php';


class ReporteNomina extends PrepareExcel
{
    public function __construct()
    {
        parent::__construct();
        $this->creaEmptySheet('Nomina',1);
    }

    public function formateaFechaGUION($fecha){
        $arr = explode("-",$fecha);
        $fechaNueva = $arr[2]."/".$arr[1]."/".$arr[0];
        return $fechaNueva;	
    }

    public function preparaReporte( $listadoNomina, $fechas)
    {
        extract( $fechas );
        $i = 7;
        $fechaInicio = $fechaInicio==''?date('d/m/Y'):$fechaInicio;
        $fechaFin = $fechaFin==''?date('d/m/Y'):$fechaFin;

        $this->libro->setActiveSheetIndex(1);
        $this->putLogo("A1",0,70);
        $this->libro->getActiveSheet()->mergeCells("A3:U3");;
        $this->libro->getActiveSheet()->setCellValue("A3","Nómina del ".$fechaInicio." al ".$fechaFin);
        $this->libro->getActiveSheet()->getStyle("A3")->applyFromArray($this->centrarTexto);
        $this->libro->getActiveSheet()->getStyle("A3")->applyFromArray($this->labelBold);

        $arrExcel = array();
        $arrPercepciones = array();
        $arrDeducciones = array();
        foreach($listadoNomina as $lista){
            foreach($lista['percepciones'] as $percepcion){
                if(!in_array($percepcion['incidencia'],$arrPercepciones))
                    $arrPercepciones[] = $percepcion['incidencia'];
            }
            foreach($lista['deducciones'] as $deduccion){
                if(!in_array($deduccion['incidencia'],$arrDeducciones))
                    $arrDeducciones[] = $deduccion['incidencia'];
            }
        }
        $columns = array('H','I','J','K','L','M','N','O','P','Q','R','S','T','V','W','X','Y','Z','AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ','AK','AL','AM','AN','AO','AP','AQ','AR');
        //echo 'EOF 1';
        $this->libro->getActiveSheet()->mergeCells("A5:A6"); 
        $this->libro->getActiveSheet()->setCellValue("A5", "NIP"); 
        $this->libro->getActiveSheet()->mergeCells("B5:B6"); 
        $this->libro->getActiveSheet()->setCellValue("B5", "Sucursal"); 
        $this->libro->getActiveSheet()->mergeCells("C5:C6"); 
        $this->libro->getActiveSheet()->setCellValue("C5", "Departamento");
        $this->libro->getActiveSheet()->mergeCells("D5:D6"); 
        $this->libro->getActiveSheet()->setCellValue("D5", 'Puesto');
        $this->libro->getActiveSheet()->mergeCells("E5:E6"); 
        $this->libro->getActiveSheet()->setCellValue("E5", "Nombre");
        $this->libro->getActiveSheet()->mergeCells("F5:F6"); 
        $this->libro->getActiveSheet()->setCellValue("F5", "Cuenta");
        $this->libro->getActiveSheet()->mergeCells("G5:G6"); 
        $this->libro->getActiveSheet()->setCellValue("G5", "Banco");
        $cantPercepciones = count($arrPercepciones) - 1;
        $cantDeducciones = count($arrDeducciones) - 1;
        //echo $cantDeducciones;
        $this->libro->getActiveSheet()->mergeCells("H5:".$columns[$cantPercepciones]."5");        
        $this->libro->getActiveSheet()->setCellValue("H5", "Percepciones");
        //echo 'EOF 2';
        $a = 0;
        for($j=0;$j<=$cantPercepciones;$j++){
            $this->libro->getActiveSheet()->setCellValue($columns[$j]."6", $arrPercepciones[$a]); 
            $a++;
        }
        $nuevaColumna = $j;
        if(count($arrDeducciones)>0){
            $this->libro->getActiveSheet()->mergeCells($columns[$nuevaColumna]."5:".$columns[$cantDeducciones+$nuevaColumna]."5");  
            $this->libro->getActiveSheet()->setCellValue($columns[$nuevaColumna]."5", "Deducciones");
            //echo 'EOF 3';
            $a = 0;
            for($k=0;$k<=$cantDeducciones;$k++){
                $this->libro->getActiveSheet()->setCellValue($columns[$nuevaColumna+$k]."6", $arrDeducciones[$a]); 
                $a++;
            }
            //echo 'EOF 4';
            $nuevaColumna = $nuevaColumna+$k;      
        } 
        $this->libro->getActiveSheet()->mergeCells($columns[$nuevaColumna]."5:".$columns[$nuevaColumna]."6"); 
        $this->libro->getActiveSheet()->setCellValue($columns[$nuevaColumna]."5", "Pago en Banco");  
        $this->libro->getActiveSheet()->mergeCells($columns[$nuevaColumna+1]."5:".$columns[$nuevaColumna+1]."6"); 
        $this->libro->getActiveSheet()->setCellValue($columns[$nuevaColumna+1]."5", "Pago en Efectivo");
        $this->libro->getActiveSheet()->mergeCells($columns[$nuevaColumna+2]."5:".$columns[$nuevaColumna+2]."6"); 
        $this->libro->getActiveSheet()->setCellValue($columns[$nuevaColumna+2]."5", "Pago en Vales");
        $this->libro->getActiveSheet()->mergeCells($columns[$nuevaColumna+3]."5:".$columns[$nuevaColumna+3]."6"); 
        $this->libro->getActiveSheet()->setCellValue($columns[$nuevaColumna+3]."5", "Pago en Otros");
        $this->libro->getActiveSheet()->mergeCells($columns[$nuevaColumna+4]."5:".$columns[$nuevaColumna+4]."6"); 
        $this->libro->getActiveSheet()->setCellValue($columns[$nuevaColumna+4]."5", "Total");

        $this->libro->getActiveSheet()->getStyle("A5:".$columns[$nuevaColumna+4]."6")->applyFromArray($this->centrarTexto);
        $this->libro->getActiveSheet()->getStyle("A5:".$columns[$nuevaColumna+4]."6")->applyFromArray($this->labelBold);
        $this->libro->getActiveSheet()->getStyle("A5:".$columns[$nuevaColumna+4]."6")->applyFromArray($this->setColorText('000000',11));
        $this->libro->getActiveSheet()->getStyle("A5:".$columns[$nuevaColumna+4]."6")->getFill()->applyFromArray( $this->setColorFill("dddddd")  );
        $this->libro->getActiveSheet()->setAutoFilter("A5:G5");
        $this->libro->getActiveSheet()->setAutoFilter("H6:".$columns[$nuevaColumna-1]."6");
        $this->libro->getActiveSheet()->setAutoFilter($columns[$nuevaColumna]."5:".$columns[$nuevaColumna+4]."5");
        
        
        
        //echo 'EOF 5';
        foreach($listadoNomina as $row){
            $this->libro->setActiveSheetIndex(1);
            $this->libro->getActiveSheet()->setCellValue("A$i", $row['nip']);
            $this->libro->getActiveSheet()->setCellValue("B$i", $row['udn']);
            $this->libro->getActiveSheet()->setCellValue("C$i", $row['departamento']);
            $this->libro->getActiveSheet()->setCellValue("D$i", $row['puesto']);
            $this->libro->getActiveSheet()->setCellValue("E$i", $row['empleado']);
            $this->libro->getActiveSheet()->setCellValue("F$i", " ".$row['cuenta']);
            $this->libro->getActiveSheet()->setCellValue("G$i", $row['banco']);
            $ai = 0;
            foreach($arrPercepciones as $percep){
                foreach($row['percepciones'] as $empPer){
                    if($percep==$empPer['incidencia']){
                        $this->libro->getActiveSheet()->setCellValue($columns[$ai].$i, $empPer['monto']);
                        $this->libro->getActiveSheet()->getStyle($columns[$ai].$i)->getNumberFormat()->setFormatCode('#,##0.00');
                    }
                }
                $ai++;
            }
            //echo $columns[$ai];
            if(count($arrDeducciones)>0){
                foreach($arrDeducciones as $deduc){
                    foreach($row['deducciones'] as $empDed){
                        if($deduc==$empDed['incidencia']){
                            $this->libro->getActiveSheet()->setCellValue($columns[$ai].$i, $empDed['monto']);
                            $this->libro->getActiveSheet()->getStyle($columns[$ai].$i)->getNumberFormat()->setFormatCode('#,##0.00');
                        }
                    }
                    $ai++;
                }
            }
            $this->libro->getActiveSheet()->setCellValue($columns[$ai].$i, $row['bancos']);            
            $this->libro->getActiveSheet()->getStyle($columns[$ai].$i)->getNumberFormat()->setFormatCode('#,##0.00');
            $this->libro->getActiveSheet()->setCellValue($columns[$ai+1].$i, $row['efectivo']);
            $this->libro->getActiveSheet()->getStyle($columns[$ai+1].$i)->getNumberFormat()->setFormatCode('#,##0.00');
            $this->libro->getActiveSheet()->setCellValue($columns[$ai+2].$i, $row['vales']);
            $this->libro->getActiveSheet()->getStyle($columns[$ai+2].$i)->getNumberFormat()->setFormatCode('#,##0.00');
            $this->libro->getActiveSheet()->setCellValue($columns[$ai+3].$i, $row['otros']);
            $this->libro->getActiveSheet()->getStyle($columns[$ai+3].$i)->getNumberFormat()->setFormatCode('#,##0.00');
            $this->libro->getActiveSheet()->setCellValue($columns[$ai+4].$i, $row['total']);
            $this->libro->getActiveSheet()->getStyle($columns[$ai+4].$i)->getNumberFormat()->setFormatCode('#,##0.00');
            $i++;
        }

        foreach(range('A',$columns[$ai-1]) as $columnID) {
            $this->libro->getActiveSheet()->getColumnDimension($columnID)->setAutoSize(true);         
        }
        foreach(range('A',$columns[$ai+4]) as $columnID) {        
            $this->libro->getActiveSheet()->getStyle($columnID."5")->applyFromArray($this->bordes);
            $this->libro->getActiveSheet()->getStyle($columnID."6")->applyFromArray($this->bordes);
            $this->libro->getActiveSheet()->getStyle($columnID."5")->applyFromArray($this->verticalCenter);
        }
        foreach(range($columns[$ai],$columns[$ai+4]) as $columnID) {        
            $this->libro->getActiveSheet()->getColumnDimension($columnID)->setWidth(20);
        }    

        $reporteTerminado = new PHPExcel_Writer_Excel2007( $this->libro);
        $reporteTerminado->save('Reporte de Nomina.xlsx');
        return 'Reporte de Nomina.xlsx';
    }

}

$reporte = new ReporteNomina;
echo $reporte->preparaReporte(json_decode($_POST['data'],true), array('fechaInicio' => $_POST['fechaInicio'],'fechaFin' => $_POST['fechaFin'] ) ); 
//$reporte->preparaReporte($reporte->generaFaltasRetardos($_GET['fechaInicio'],$_GET['fechaFin']), array('fechaInicio' => date('Y-m-1'),'fechaFin' => date('Y-m-15') ) ); 

    //$reporte->enviarReporte( $configCorreo);