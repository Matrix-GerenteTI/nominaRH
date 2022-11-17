<?
session_start();

// Include the random string file for captcha
require 'includes/rand.php';

// Set the session contents
$_SESSION['captcha_id'] = $str;

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sing in SUVEPV</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
<script type="text/javascript" src="js/validate.js"></script>
<script type="text/javascript" src="js/captcha.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
        
  });
  
 	function validate(){
		var cliente = $("#cliente").val();
	  	var password = $("#password").val();
	  	var captcha = $("#captcha").val();
	  	band = 0;
	  	
		
		
		
		
		
		if(cliente.length>0){
			if(password.length>0){
				if(captcha.length>0){
					$.post("includes/process.php", "captcha="+captcha, function(resp){
						if(resp>0){
							
							$.post("ajax.php?opc=validaCliente", "cliente="+cliente+"&password="+password, function(resp2){
								if(resp2>0){
									document.location="../login.php";
									$("#txtCaptcha").html("");
								}
								else
									$("#txtCaptcha").html("Usuario y/o contrase&ntilde;a no existe");
							});
						}
						else
							$("#txtCaptcha").html("C&oacute;digo err&oacute;neo. Haga click en la imagen para generar una nueva");
					});
				}
				else
					$("#txtCaptcha").html("C&oacute;digo err&oacute;neo. Haga click en la imagen para generar una nueva");
			}
			else
				$("#txtCaptcha").html("Escriba su contraseña");
		}
		else
			$("#txtCaptcha").html("Escriba su nombre de cliente");
  	}
</script>
<style type="text/css">
	html, body{
		height:100%;
		width: 100%;
		margin: 0px;
		padding: 0px;
		background:#CACAD9;
	}
</style>
</head>

<body>
	<table width="100%" height="100%">
    	<tr>
        	<td align="center">
            	<table width="967px" height="527px" align="center" style="background:url(bg.png) no-repeat">
                	<tr>
                    	<td>
                        	<table align="center">
                            	<tr>
                                	<td colspan="2" align="center">
                        				<!--<img src="logoSUVEPV.png" width="300px" />-->
                                   	</td>
                              	</tr>
                                <tr>
                                	<td colspan="2" align="center">
                        				<div style="height:80px"></div>
                                   	</td>
                              	</tr>
                                <tr>
                                	<td align="left" style="font-size:14px; font-family:Verdana, Geneva, sans-serif"><b>Cliente:</b></td>
                                    <td align="right"><input type="text" id="cliente" style="width:150px; border: #900 1px solid" /></td>
                                </tr>
                                <tr>
                                	<td align="left" style="font-size:14px; font-family:Verdana, Geneva, sans-serif"><b>Contrase&ntilde;a:</b></td>
                                    <td align="right"><input type="password" id="password" style="width:150px; border: #900 1px solid" /></td>
                                </tr>
                                <tr>
                                	<td>
                                    	<div id="captchaimage"><a href="" id="refreshimg" onClick="refreshimg(); return false;" title="Click to refresh image"><img src="captcha/image.php?<?php echo time(); ?>" alt="Captcha image" width="132" height="46" align="left" border="0" /></a></div>
                                    </td>
                                    <td align="right">
                                    	<input type="text" maxlength="6" name="captcha" id="captcha"  value="Ingrese aqui el codigo" onFocus="if(this.value=='Ingrese aqui el codigo'){this.value=''}" onBlur="if(this.value==''){this.value='Ingrese aqui el codigo'}" style="width:150px; border: #900 1px solid" />
                                    </td>
                                </tr>
                                <tr>
                                	<td colspan="2"><div id="txtCaptcha" style="text-align:right; color:#F00; font-size:10px">&nbsp;</div></td>
                                </tr>
                                <tr>
                                	<td>
                                    	<a href="#" style="color:#036; font-family:Arial">Recuperar mi contrase&ntilde;a</a>
                                    </td>
                                	<td align="right">
                                        <input type="button" value="" onclick="validate()" style="background:url(buttonIniciar.gif) no-repeat; width:102px; height:30px; border:none; cursor:pointer">
                                   	</td>
                              	</tr>
                           	</table>
                        </td>
                    </tr>
                </table>
                <div style="font-family:Verdana, Geneva, sans-serif; text-align:right; color:#666; font-size:12px; width:967px">XION Tecnolog&iacute;as 2014. Todos los derechos reservados&nbsp;&nbsp;</div>
            </td>
        </tr>
    </table>
</body>
</html>