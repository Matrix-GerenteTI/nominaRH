<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RR.HH <?=$_SESSION['titulo']?></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600"
        rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/pages/dashboard.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
<body>
<?php require_once('header.php'); ?>
<!-- /navbar -->
<?php require_once('menu.php'); ?>
<!-- /subnavbar -->
<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <div class="span12">
          <div class="widget widget-nopad">
          	<div class="form-actions" style="text-align:right; margin-top:0px; margin-bottom:0px; padding:5px">
            	<table align="right" cellpadding="0" cellspacing="0">
                	<tr>
                    	<td align="right">
                            <div class="shortcuts"> 
                                <a href="javascript:nuevo();" class="shortcut"><i class="shortcut-icon icon-file-alt"></i><span class="shortcut-label">Nuevo</span></a>&nbsp;
                                <a href="javascript:guardar();" class="shortcut"><i class="shortcut-icon icon-save"></i><span class="shortcut-label">Guardar</span></a>&nbsp;
                                <a href="javascript:eliminar();" class="shortcut"><i class="shortcut-icon icon-remove"></i><span class="shortcut-label">Eliminar</span></a>
                            </div>
                      	</td>
                   	</tr>
              	</table>
            </div>
            <div class="widget-header"> <i class="icon-edit"></i>
              <h3> Datos de usuario</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content" style="padding:10px">
                <table width="100%">
                    <tr>
                        <td>
                        	Usuario<br/>
                            <input type="text" id="usuario" style="width:92%" />
                       	</td>
                        <td>
                        	Contrase&ntilde;a<br/>
                            <input type="password" style="width:92%" id="password1" />
                       	</td>
                        <td>
                        	Confirma contrase&ntilde;a<br/>
                            <input type="password" style="width:92%" id="password2" onKeyUp="validaPass()" />
                       	</td>
                        <td>
                        	Grupo<br/>
                            <select id="grupo" style="width:92%"></select>
                       	</td>
                    </tr>
                </table>
              	<table width="100%">
                    <tr>
                        <td>
                        	Nombre personal<br/>
                            <input type="text" id="nombre" style="width:97%" />
                       	</td>
                        <td>
                        	Email<br/>
                            <input type="text" id="email" style="width:97%" />
                       	</td>
                        <td>
                        	Empresa<br/>
                            <select id="empresa" style="width:97%" >
                              <option value="1">7 LEGUAS</option>
                              <option value="2">CM RESORTS</option>
                            </select>
                       	</td>
                    </tr>
                </table>
                <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th> Usuario </th>
                    <th> Nombre </th>
                    <th> Grupo </th>
                    <th> Empresa </th>
                  </tr>
                </thead>
                <tbody id="tbody">
                </tbody>
                </table>
           	</div>
          </div>
        </div>
        <!-- /span6 -->
      </div>
      <!-- /row --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /main-inner --> 
</div>
<!-- /main 
<div class="extra">
  <div class="extra-inner">
    <div class="container">
      <div class="row">
                    <div class="span3">
                        <h4>
                            About Free Admin Template</h4>
                        <ul>
                            <li><a href="javascript:;">EGrappler.com</a></li>
                            <li><a href="javascript:;">Web Development Resources</a></li>
                            <li><a href="javascript:;">Responsive HTML5 Portfolio Templates</a></li>
                            <li><a href="javascript:;">Free Resources and Scripts</a></li>
                        </ul>
                    </div>
                    <!-- /span3 
                    <div class="span3">
                        <h4>
                            Support</h4>
                        <ul>
                            <li><a href="javascript:;">Frequently Asked Questions</a></li>
                            <li><a href="javascript:;">Ask a Question</a></li>
                            <li><a href="javascript:;">Video Tutorial</a></li>
                            <li><a href="javascript:;">Feedback</a></li>
                        </ul>
                    </div>
                    <!-- /span3
                    <div class="span3">
                        <h4>
                            Something Legal</h4>
                        <ul>
                            <li><a href="javascript:;">Read License</a></li>
                            <li><a href="javascript:;">Terms of Use</a></li>
                            <li><a href="javascript:;">Privacy Policy</a></li>
                        </ul>
                    </div>
                    <!-- /span3
                    <div class="span3">
                        <h4>
                            Open Source jQuery Plugins</h4>
                        <ul>
                            <li><a href="http://www.egrappler.com">Open Source jQuery Plugins</a></li>
                            <li><a href="http://www.egrappler.com;">HTML5 Responsive Tempaltes</a></li>
                            <li><a href="http://www.egrappler.com;">Free Contact Form Plugin</a></li>
                            <li><a href="http://www.egrappler.com;">Flat UI PSD</a></li>
                        </ul>
                    </div>
                    <!-- /span3
                </div>
      <!-- /row
    </div>
    <!-- /container
  </div>
  <!-- /extra-inner
</div>
<!-- /extra -
<div class="footer">
  <div class="footer-inner">
    <div class="container">
      <div class="row">
        <div class="span12"> &copy; 2017 Timbrado de N&oacute;mina. <a href="http://www.xiontecnologias.com/">Creado por XION Tecnologias</a></div>
        <!-- /span12 --
      </div>
      <!-- /row --
    </div>
    <!-- /container --
  </div>
  <!-- /footer-inner --
</div>
<!-- /footer --> 
<!-- Le javascript
================================================== --> 
<!-- Placed at the end of the document so the pages load faster --> 
<script src="js/jquery-1.7.2.min.js"></script> 
<script src="js/excanvas.min.js"></script> 
<script src="js/chart.min.js" type="text/javascript"></script> 
<script src="js/bootstrap.js"></script>
<script language="javascript" type="text/javascript" src="js/full-calendar/fullcalendar.min.js"></script>
 
<script src="js/base.js"></script> 
<script> 
	  
	$(document).ready(function(e) {
		nuevo();	    
    });
	  
	function lista(){
		$.post("ajax/ajaxusuarios.php?op=lista", "", function(resp){
	  		var row = eval('('+resp+')');
			var echo = "";
			for(i in row){
				echo+= "<tr style='cursor:pointer' onClick='cargar(\""+row[i].username+"\")'>";
        if(row[i].idempresa==1)
				  echo+= "	<td>"+row[i].username+"</td><td>"+row[i].nombre+"</td><td>"+row[i].grupo+"</td><td>7 LEGUAS</td>";
        else
          echo+= "	<td>"+row[i].username+"</td><td>"+row[i].nombre+"</td><td>"+row[i].grupo+"</td><td>CM RESORTS</td>";
				echo+= "<tr>";
			}
			$("#tbody").html(echo);
		});
	}
	
  function cmbTipo(){
    $.post("ajax/ajaxusuarios.php?op=cmbTipo", "", function(resp){
			$("#grupo").html(resp);
		});
  }

	function nuevo(){
		$("#usuario").val('');
		$("#password1").val('');
		$("#password2").val('');
		$("#nombre").val('');	
		$("#email").val('');
    cmbTipo();
		lista();
	}
	
	function cargar(id){
		$.post("ajax/ajaxusuarios.php?op=cargar", "id="+id, function(resp){
			var row = eval('('+resp+')');
			$("#usuario").val(row.username);
			$("#password1").val(row.password);
			$("#password2").val(row.password);
			$("#grupo").val(row.tipo);
			$("#empresa").val(row.idempresa);
			$("#nombre").val(row.nombre);	
			$("#email").val(row.email);
		});
	}
	
	function guardar(){
		var campos = new Array('usuario_txt','password1_txt','password2_txt','nombre_txt');
		var validacion = validar(campos);
						
		if(validacion == true){
			if(validaPass()){
				var params = "username="+$("#usuario").val();
				params+= "&password="+$("#password1").val();
				params+= "&tipo="+$("#grupo").val();
				params+= "&nombre="+$("#nombre").val();
				params+= "&email="+$("#email").val();
				params+= "&idempresa="+$("#empresa").val();
				$.post("ajax/ajaxusuarios.php?op=guardar", params, function(resp){
					if(resp>0){
						alert("El registro se guardo exitosamente!");
						nuevo();
					}else
						alert("Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
				});
			}else
				alert("No coinciden las contraseñas");
		}else{
			if(validaPass())
				alert("Llene los campos requeridos");
			else
				alert("No coinciden las contraseñas");
		}
	}
	
	function eliminar(){
		var username = $("#usuario").val();
		var params = "username="+username;
		$.post("ajax/ajaxusuarios.php?op=eliminar", params, function(resp){
			if(resp<2){
				if(resp==1)
					alert("Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
			}else{
				alert("El usuario se elimino exitosamente!");
				nuevo();
			}
		});	
	}
	
	function validaPass(){
		var pass1 = $("#password1").val();
		var pass2 = $("#password2").val();
		if(pass1!=pass2){
			$("#password2").addClass('bordeRojo');
			return false;
		}else{
			$("#password2").removeClass('bordeRojo');
			return true;
		}
	}
	
	function validar(campos){
		var res = true;
		for(a in campos){
			var arr = campos[a].split("_");
			//alert(arr[1]);
			if(arr[1] == "txt"){
				var campo = $("#"+arr[0]).val();
				if(campo==""){
					 $("#"+arr[0]).addClass('bordeRojo');
					 res = false;
				}else{
					 $("#"+arr[0]).removeClass('bordeRojo');
				}
			}
		}
		return res;
	}

</script><!-- /Calendar -->
</body>
</html>
