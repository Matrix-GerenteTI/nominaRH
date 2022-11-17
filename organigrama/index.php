<?php
if(!isset($_SESSION))
  session_start();
$conexion = new mysqli('172.16.0.91','nuevo','M@tr1x2017','dbnomina');

?>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Organigrama</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/jquery.jOrgChart.css"/>
    <link href="css/prettify.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="prettify.js"></script>
    
    <!-- jQuery includes -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
    
    <script src="jquery.jOrgChart.js"></script>

    <script>
    jQuery(document).ready(function() {
        $("#org").jOrgChart({
            chartElement : '#chart',
            dragAndDrop  : true
        });
    });
    </script>
  </head>

  <body onload="prettyPrint();">
    <?php
    $arrOrg = array();
    $qOrg = "SELECT 	e.nip as nip,
                      o.idhijo as hijo,
                      o.idpadre as padre,
                      e.nombre as nombre,
                      p.descripcion as puesto 
            FROM 	porganigrama o 
            INNER JOIN pempleado e ON o.idhijo=e.nip
            INNER JOIN pcontrato c ON e.nip=c.nip
            INNER JOIN cpuesto p ON c.idpuesto=p.id
            WHERE 	o.status=1 
            AND 	e.status=1";
    $sOrg = $conexion->query($qOrg);
    while($rOrg = $sOrg->fetch_assoc()){
      // if(!in_array($rOrg['idpadre'],$arrOrg)){
      //   $arrOrg[$rOrg['idpadre']][$rOrg['hijo']] = $rOrg;
      // }else{      
        //Sacamos nombre y apellido
        $exp = explode(' ',$rOrg['nombre']);
        $apellido = $exp[count($exp)-2];
        $nombre = $exp[0].' '.$apellido;
        $arrOrg[$rOrg['padre']][$rOrg['hijo']]['nip'] = $rOrg['nip'];
        $arrOrg[$rOrg['padre']][$rOrg['hijo']]['hijo'] = $rOrg['hijo'];
        $arrOrg[$rOrg['padre']][$rOrg['hijo']]['padre'] = $rOrg['padre'];
        $arrOrg[$rOrg['padre']][$rOrg['hijo']]['nombre'] = $nombre;
        $arrOrg[$rOrg['padre']][$rOrg['hijo']]['puesto'] = $rOrg['puesto'];

      //}
    }
    foreach($arrOrg as $idx1 => $org1){
      if(!isset($org['nip'])){
        if(is_array($org1)){
          foreach($org1 as $idx2 => $org2){
            if(!isset($org['nip'])){
              if(isset( $arrOrg[$idx2]))
                $arrOrg[$idx1][$idx2]['hijos'] = $arrOrg[$idx2];
              if(is_array($org2)){
                foreach($org2 as $idx3 => $org3){
                  if(!isset($org3['nip'])){
                    if(isset( $arrOrg[$idx3]))
                      $arrOrg[$idx1][$idx2][$idx3]['hijos'] = $arrOrg[$idx3];
                    if(is_array($org3)){
                      foreach($org3 as $idx4 => $org4){
                        if(!isset($org4['nip'])){
                          if(isset( $arrOrg[$idx4]))
                            $arrOrg[$idx1][$idx2][$idx3][$idx4]['hijos'] = $arrOrg[$idx4];
                          if(is_array($org4)){
                            foreach($org4 as $idx5 => $org5){
                              if(!isset($org5['nip'])){
                                if(isset( $arrOrg[$idx5]))
                                  $arrOrg[$idx1][$idx2][$idx3][$idx4][$idx5]['hijos'] = $arrOrg[$idx5];
                                if(is_array($org5)){
                                  foreach($org5 as $idx6 => $org6){
                                    if(!isset($org6['nip'])){
                                      if(isset( $arrOrg[$idx6]))
                                        $arrOrg[$idx1][$idx2][$idx3][$idx4][$idx5][$idx6]['hijos'] = $arrOrg[$idx6];
                                      if(is_array($org6)){
                                        foreach($org6 as $idx7 => $org7){
                                          if(!isset($org7['nip'])){
                                            if(isset( $arrOrg[$idx7]))
                                              $arrOrg[$idx1][$idx2][$idx3][$idx4][$idx5][$idx6][$idx7]['hijos'] = $arrOrg[$idx7];
                                            if(is_array($org7)){
                                              foreach($org7 as $idx8 => $org8){
                                                if(!isset($org8['nip'])){
                                                  if(isset( $arrOrg[$idx8]))
                                                    $arrOrg[$idx1][$idx2][$idx3][$idx4][$idx5][$idx6][$idx7][$idx8]['hijos'] = $arrOrg[$idx8];
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    // echo json_encode($arrOrg);
    // die();
    $formatos = ['jpg','jpeg'];

    foreach($arrOrg as $index => $rows){
      if($index!=-1)
        unset($arrOrg[$index]);
    }
    ?>
    <div class="container" style="margin-top: 20px" >
    <ul id="org" style="display:none">
    <?php
    foreach($arrOrg as $indice => $nodo){
    ?>
      <li>
            <div style="background-image: url(http://nominamatrix.ddns.net:8080/nomina/assets/images/logoOrg.png);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
            <div style="margin-top:5px">EMPRESA</div>   
            <div style="margin-top:3px; color:yellow"><b><?=$_SESSION['titulo']?></b></div> 
      <?php if(is_array($nodo)){ ?>
        <ul>
          <?php 
          foreach($nodo as $nodo2){ 
            foreach ($formatos as $i => $formato) {
              $image_type_check = @exif_imagetype("http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo2['nip'].".".$formato);
              if (strpos($http_response_header[0], "200")) {
                $foto = "http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo2['nip'].".".$formato;
                break;
              }else{
                $foto = "http://nominamatrix.ddns.net:8080/intranet/assets/images/person.png";
              }
            }
            ?>
         <li>
            <div style="background-image: url(<?=$foto?>);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
            <div style="margin-top:5px"><?=$nodo2['nombre']?></div>   
            <div style="margin-top:3px; color:yellow"><b><?=$nodo2['puesto']?></b></div> 
            
          <?php if(isset($nodo2['hijos'])){ ?>
           <ul>
            <?php 
            foreach($nodo2['hijos'] as $nodo3){ 
              foreach ($formatos as $i => $formato) {
                $image_type_check = @exif_imagetype("http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo3['nip'].".".$formato);
                if (strpos($http_response_header[0], "200")) {
                  $foto = "http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo3['nip'].".".$formato;
                  break;
                }else{
                  $foto = "http://nominamatrix.ddns.net:8080/intranet/assets/images/person.png";
                }
              }
              ?>
             <li>
              <div style="background-image: url(<?=$foto?>);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
              <div style="margin-top:5px"><?=$nodo3['nombre']?></div>   
              <div style="margin-top:3px; color:yellow"><b><?=$nodo3['puesto']?></b></div>  
              <?php if(isset($nodo3['hijos'])){ ?>
                <ul>
                  <?php 
                  foreach($nodo3['hijos'] as $nodo4){ 
                    foreach ($formatos as $i => $formato) {
                      $image_type_check = @exif_imagetype("http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo4['nip'].".".$formato);
                      if (strpos($http_response_header[0], "200")) {
                        $foto = "http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo4['nip'].".".$formato;
                      break;
                      }else{
                        $foto = "http://nominamatrix.ddns.net:8080/intranet/assets/images/person.png";
                      }
                    }
                    
                    ?>
                  <li>
                    <div style="background-image: url(<?=$foto?>);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
                    <div style="margin-top:5px"><?=$nodo4['nombre']?></div>   
                    <div style="margin-top:3px; color:yellow"><b><?=$nodo4['puesto']?></b></div>  
                    <?php if(isset($nodo4['hijos'])){ ?>
                      <ul>
                        <?php 
                        foreach($nodo4['hijos'] as $nodo5){ 
                          foreach ($formatos as $i => $formato) {
                            $image_type_check = @exif_imagetype("http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo5['nip'].".".$formato);
                            if (strpos($http_response_header[0], "200")) {
                              $foto = "http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo5['nip'].".".$formato;
                            break;
                            }else{
                              $foto = "http://nominamatrix.ddns.net:8080/intranet/assets/images/person.png";
                            }
                          }
                        
                        ?>
                        <li>
                          <div style="background-image: url(http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/<?=$nodo5['nip']?>.jpeg);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
                          <div style="margin-top:5px"><?=$nodo5['nombre']?></div>   
                          <div style="margin-top:3px; color:yellow"><b><?=$nodo5['puesto']?></b></div>  
                          <?php if(isset($nodo5['hijos'])){ ?>
                            <ul>
                              <?php 
                              foreach($nodo5['hijos'] as $nodo6){ 
                                foreach ($formatos as $i => $formato) {
                                  $image_type_check = @exif_imagetype("http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo6['nip'].".".$formato);
                                  if (strpos($http_response_header[0], "200")) {
                                    $foto = "http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo6['nip'].".".$formato;
                                  break;
                                  }else{
                                    $foto = "http://nominamatrix.ddns.net:8080/intranet/assets/images/person.png";
                                  }
                                }
                              
                              ?>
                              <li>
                                <div style="background-image: url(http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/<?=$nodo6['nip']?>.jpeg);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
                                <div style="margin-top:5px"><?=$nodo6['nombre']?></div>   
                                <div style="margin-top:3px; color:yellow"><b><?=$nodo6['puesto']?></b></div>  
                                <?php if(isset($nodo6['hijos'])){ ?>
                                  <ul>
                                    <?php 
                                    foreach($nodo6['hijos'] as $nodo7){ 
                                      foreach ($formatos as $i => $formato) {
                                        $image_type_check = @exif_imagetype("http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo7['nip'].".".$formato);
                                        if (strpos($http_response_header[0], "200")) {
                                          $foto = "http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo7['nip'].".".$formato;
                                        break;
                                        }else{
                                          $foto = "http://nominamatrix.ddns.net:8080/intranet/assets/images/person.png";
                                        }
                                      }
                                    
                                    ?>
                                    <li>
                                      <div style="background-image: url(http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/<?=$nodo7['nip']?>.jpeg);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
                                      <div style="margin-top:5px"><?=$nodo7['nombre']?></div>   
                                      <div style="margin-top:3px; color:yellow"><b><?=$nodo7['puesto']?></b></div>  
                                      <?php if(isset($nodo7['hijos'])){ ?>
                                        <ul>
                                          <?php 
                                          foreach($nodo7['hijos'] as $nodo8){ 
                                            foreach ($formatos as $i => $formato) {
                                              $image_type_check = @exif_imagetype("http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo8['nip'].".".$formato);
                                              if (strpos($http_response_header[0], "200")) {
                                                $foto = "http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/".$nodo8['nip'].".".$formato;
                                              break;
                                              }else{
                                                $foto = "http://nominamatrix.ddns.net:8080/intranet/assets/images/person.png";
                                              }
                                            }
                                          
                                          ?>
                                          <li>
                                            <div style="background-image: url(http://nominamatrix.ddns.net:8080/intranet/Empresa/foto_empleado/<?=$nodo8['nip']?>.jpeg);width:96px; height: 100px; background-size: cover; background-position: center; background-repeat: no-repeat;"></div>
                                            <div style="margin-top:5px"><?=$nodo8['nombre']?></div>   
                                            <div style="margin-top:3px; color:yellow"><b><?=$nodo8['puesto']?></b></div>  
                                          </li>
                                          <?php } ?>
                                        </ul>
                                      <?php } ?>
                                    </li>
                                    <?php } ?>
                                  </ul>
                                <?php } ?>
                              </li>
                              <?php } ?>
                            </ul>
                          <?php } ?>
                        </li>
                        <?php } ?>
                      </ul>
                    <?php } ?>
                  </li>
                  <?php } ?>
                </ul>
              <?php } ?>
             </li>
            <?php } ?>
            </ul>
          <?php } ?>
         </li>
         <?php } ?>
       </ul>
       <?php } ?>
     </li>
    <?php } ?>
   </ul>            
    
    <div id="chart" class="orgChart"></div>
    </div>
    
    
    <script>
        jQuery(document).ready(function() {
            
            /* Custom jQuery for the example */
            $("#show-list").click(function(e){
                e.preventDefault();
                
                $('#list-html').toggle('fast', function(){
                    if($(this).is(':visible')){
                        $('#show-list').text('Hide underlying list.');
                        $(".topbar").fadeTo('fast',0.9);
                    }else{
                        $('#show-list').text('Show underlying list.');
                        $(".topbar").fadeTo('fast',1);                  
                    }
                });
            });
            
            $('#list-html').text($('#org').html());
            
            $("#org").bind("DOMSubtreeModified", function() {
                $('#list-html').text('');
                
                $('#list-html').text($('#org').html());
                
                prettyPrint();                
            });
        });
    </script>

</body>
</html>