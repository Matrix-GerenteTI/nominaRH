<?php
if(!isset($_SESSION)){
    session_start(); 
}
require_once("mysql.php");
class ThumbImage { 
    private $source; 
    
    public function __construct($sourceImagePath) { 
        $this->source = $sourceImagePath; 
    } 
    
    public function createThumb($destImagePath, $thumbWidth=100) { 
        $sourceImage = imagecreatefromjpeg($this->source);   
        $orgWidth = imagesx($sourceImage); 
        $orgHeight = imagesy($sourceImage); 
        $thumbHeight = floor($orgHeight * ($thumbWidth / $orgWidth)); 
        $destImage = imagecreatetruecolor($thumbWidth, $thumbHeight);   
        imagecopyresampled($destImage, $sourceImage, 0, 0, 0, 0, $thumbWidth, $thumbHeight, $orgWidth, $orgHeight); 
        
        //$rotate = imagerotate($destImage, 270, 0);
        $res = imagejpeg($destImage, $destImagePath); 
        imagedestroy($sourceImage); 
        imagedestroy($destImage); 
        return $res;
    } 
}
if(!isset($_SESSION)){
    session_start();
}
$foto = $_FILES['foto'];
$nip = $_POST['nip'];
$file_name = $foto["name"];
$extension = pathinfo($_FILES['foto']['tmp_name']);
$objThumbImage = new ThumbImage($foto["tmp_name"]); 
//$guardado = $objThumbImage->createThumb($_SERVER['DOCUMENT_ROOT']."/intranet/Empresa/foto_empleado/".$_SESSION['rfc']."_".$nip.".jpg", 300);
// $source = $_FILES['foto']['tmp_name'];
// $imgInfo = getimagesize($source); 
// $mime = $imgInfo['mime']; 
    
// // Creamos una imagen
// switch($mime){ 
//     case 'image/jpeg': 
//         $image = imagecreatefromjpeg($source); 
//         break; 
//     case 'image/png': 
//         $image = imagecreatefrompng($source); 
//         break; 
//     case 'image/gif': 
//         $image = imagecreatefromgif($source); 
//         break; 
//     default: 
//         $image = imagecreatefromjpeg($source); 
// } 
    
// // Guardamos la imagen
// $rotate = imagerotate($image, 270, 0);
// $guardado = imagejpeg($rotate, $_SERVER['DOCUMENT_ROOT']."/intranet/Empresa/foto_empleado/". $nip.".jpg", 100);
$guardado = move_uploaded_file($_FILES['foto']['tmp_name'], $_SERVER['DOCUMENT_ROOT']."/intranet/Empresa/foto_empleado/".$nip.".jpg");
if ( $guardado) {
	$conexion->query("INSERT INTO pbitacora (usuario,movimiento,modulo,query,fecha,hora,importancia) VALUES ('".$_SESSION['userid']."','SUBIR FOTO','EMPLEADOS','".$nip.".jpg',NOW(),NOW(),2)");
    echo 1;

}else{
    echo 0;
}


?>