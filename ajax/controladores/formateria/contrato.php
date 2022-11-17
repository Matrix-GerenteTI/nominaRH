<?php
error_reporting(0);
if(!isset($_SESSION)){
    session_start();
}
require_once $_SERVER['DOCUMENT_ROOT']."/intranet/lib/tcpdf/tcpdf.php";
require_once $_SERVER['DOCUMENT_ROOT']."/intranet/lib/tcpdf/tcpdi.php";
require_once $_SERVER['DOCUMENT_ROOT'].'/nomina/ajax/controladores/empleados.php';


class Contrato    
{
    protected $documento;
    protected $controllerTrabajador;

    public function __construct()
    {
        $this->documento  = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

        $this->documento->SetCreator(PDF_CREATOR);
        $this->documento->SetAuthor('XION Tecnologias');
        $this->documento->SetTitle('Contrato laboral');
        $this->documento->SetSubject('');
        $this->documento->SetKeywords('');

        $this->controllerTrabajador = new EmpleadosController;
    }

    public function formatDateSlash($fecha){
        $exp = explode('/',$fecha);
        return $exp[2].'/'.$exp[1].'/'.$exp[0];
    }

    public function formatDate($fecha){
        $exp = explode('-',$fecha);
        return $exp[2].'/'.$exp[1].'/'.$exp[0];
    }

    public function generaContrato( $idEmpleado )
    {
        $this->documento->AddPage(); 
        $this->documento->setPrintHeader(false); 

        $htmlContrato = $this->controllerTrabajador->getContrato( $idEmpleado );
        //echo "::::>".$htmlContrato;
        $header = '              <div style="margin-top:50px;">
                                        <img src="/nomina/ajax/logos/'.$_SESSION['rfc'].'.jpg" style="width:100px;height:auto">                                        
                                </div>';        
        
        $this->documento->writeHTML( $header, true, false, false, false, '');
        $this->documento->writeHTML( $htmlContrato, true, false, false, false, '');

        $name = strtotime( date("Y-m-d H:i:s") );
        if (file_exists('Contrato'.$idEmpleado.'.pdf')) 
            unlink('Contrato'.$idEmpleado.'.pdf');
        
        $this->documento->Output($_SERVER['DOCUMENT_ROOT'].'/nomina/ajax/controladores/formateria/Contrato'.$idEmpleado.'.pdf', 'F');
        echo "/nomina/ajax/controladores/formateria/Contrato".$idEmpleado.".pdf";
    }
}

$contrato = new Contrato;
$contrato->generaContrato( $_GET['empleado'] );
 