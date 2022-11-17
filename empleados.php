<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
    <style>
        .bordeRojo{
            border:#F00 1px solid;
        }
    </style>
    </head>
<body class="sidebar-<?=$_SESSION['template']?>">
<!--  Modal para baja con registro de fecha del empleado -->
<div class="modal fade" id="modBajaPersonal" tabindex="-1" aria-labelledby="modBajaPersonalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modBajaPersonalLabel">Bajas de empleados</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
      </div>
      <div class="modal-body">
		  	<div class="row">
				<div class="col-12">
					<div class="form-group">
						<label for="">Fecha de Baja</label>
						<input type="text" id="dateBajaPersonal" class="form-control">
					</div>
				</div>
				<div class="col-12">
					<div class="form-group">
						<label for="">Observaciones</label>
						<textarea id="txtBajaPersonal" class="form-control"></textarea>
					</div>
				</div>
		  	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" id="btnBajaPersonal">Confirmar</button>
      </div>
    </div>
  </div>
</div>
<!--  Fin modal de baja con registo de fecha del empleado -->


<!--  Modal para el cambio de adscripcion del personal     -->
<div class="modal fade" id="modCambioAdscripcion" tabindex="-1" aria-labelledby="modCambioAdscripcionLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modCambioAdscripcionLabel">Cambio de Adscripción</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
      </div>
      <div class="modal-body">
			<div class="row">
				<div class="col-12">
					<div class="form-group">
						<label for="">Fecha de cambio</label>
						<input type="text" id="dateCambioAds" class="form-control">
					</div>
				</div>				
		  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary">Confirmar</button>
      </div>
    </div>
  </div>
</div>
<!-- Fin modal para cambio de adscripción del personal -->

<!-- Modal BUSLIST -->

<div class="modal fade" id="busquedaEmpleados" tabindex="-1" aria-labelledby="busquedaEmpleadosLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="busquedaEmpleadosLabel">B&uacute;squeda de Empleado</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
      </div>
      <div class="modal-body">
	  	<div class="row">
			<div class="col-4">
				<div class="form-group">
					<select id="busestado" class="form-control">
						<option value="1">Activo</option>
						<option value="99">Inactivo</option>
					</select>
					<select id="busdepartamento" style="display:none"></select>
				</div>
			</div>
			<div class="col-5">
				<div class="form-group">
					<input type="text" id="busnombre" placeholder="Nombre" class="form-control" />
				</div>
			</div>
			<div class="col-3">
				<button class="btn btn-secondary btn-large" onclick="buslista()"><i class="mdi mdi-account-search"></i></button>
			</div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-12">
                <div class="table-responsive pt-3" style="max-height:600px">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th> Departamento </th>
                                <th> Nombre </th>
                            </tr>
                        </thead>
                        <tbody id="bustbody">
                        </tbody>
                    </table>
                </div>
			</div>
		</div>		
      </div>
      <!-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div> -->
    </div>
  </div>
</div>
<!-- MODAL BUSLISTA -->

	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
	<?php require_once('partials/sidebar.php') ?>
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
		<!-- partial -->
	
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->
	<div class="page-content">
        <div class="col-12">
                
            <div class="row">
                <div class="col-6" style="text-align:left; padding:1em">
                    <button type="button" class="btn btn-dark btn-icon" onclick="buscar()"><i data-feather="zoom-in"></i></button>
                </div>
                <div class="col-6" style="text-align:right; padding:1em" id="btnshtml">
                    <button type="button" class="btn btn-secondary btn-icon" onclick="nuevo()"><i class="mdi mdi-file-outline"></i></button>
                    <?php if($_SESSION['permisos'][4]['guardar']==1){ ?>
                    <button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button>
                    <?php } ?>
                </div>
            </div>	
        
            <div class="card">
                <div class="card-header" style="font-size:1.2em; font-weight:bold"> 
                    <i class="icon-edit"></i> <span>Datos Personales</span>
                </div>
                <!-- /widget-header -->
                <div class="card-body" style="padding:10px">
                    <div style="text-align:center">
                        
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-sm-4 col-lg-3" style="display:table-cell; vertical-align:middle; text-align:center">
                                <img src="assets/images/person-icon.png"  class="img-fluid" style="max-height:178px" id="previewfoto"/>
                                <?php if($_SESSION['permisos'][4]['guardar']==1){ ?><input type="file" style="display: none" id="takePhoto" accept="image/*;capture=camera" /><?php } ?>
                            </div>
                            <div class="col-sm-8 col-lg-9">
                                <div class="row">
                                    <div class="col-sm-6 col-lg-3">
                                        <b>NIP</b><br/>
                                        <input type="text" id="pnip" class="form-control" readonly />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4 col-lg-2">
                                        <label>RFC</label>
                                        <input type="text" id="prfc" class="form-control" />
                                    </div>
                                    <div class="col-8 col-lg-5">
                                        <label>Nombre</label>
                                        <input type="text" id="pnombre" class="form-control" />
                                    </div>
                                    <div class="col-6 col-lg-3">
                                        <label>CURP</label>
                                        <input type="text" id="pcurp" class="form-control" />
                                    </div>
                                    <div class="col-6 col-lg-2">
                                        <label>NSS</label>
                                        <input type="text" id="pnss" class="form-control" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-6 col-lg-3">
                                        Fecha de nacimiento<br/>
                                        <input type="text" id="pfecnac" class="form-control" onChange="calculaTiempo('pfecnac','pedad','edad')" placeholder="dd/mm/aaaa"  autocomplete="off"/>
                                    </div>
                                    <div class="col-6 col-lg-3">
                                        Edad<br/>
                                        <input type="text" id="pedad" class="form-control" readonly />
                                    </div>
                                    <div class="col-6 col-lg-3">
                                        Estado civil<br/>
                                        <select id="pedocivil" class="form-control">
                                            <option value="SOLTERA(O)">SOLTERA(O)</option>
                                            <option value="CASADA(O)">CASADA(O)</option>
                                            <option value="DIVORCIADA(O)">DIVORCIADA(O)</option>
                                            <option value="VIUDA(O)">VIUDA(O)</option>
                                            <option value="UNION LIBRE">UNION LIBRE</option>
                                        </select>
                                    </div>
                                    <div class="col-6 col-lg-3">
                                        Sexo<br/>
                                        <select id="psexo" class="form-control">
                                            <option value="MUJER">MUJER</option>
                                            <option value="HOMBRE">HOMBRE</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>                         
                        <div class="row">
                            <div class="col-12 col-lg-3">
                                Calle<br/>
                                <input type="text" id="pcalle" class="form-control" />
                            </div>
                            <div class="col-6 col-lg-2">
                                Numero Ext.<br/>
                                <input type="text" id="pnumext" class="form-control" />
                            </div>
                            <div class="col-6 col-lg-2">
                                Numero Int.<br/>
                                <input type="text" id="pnumint" class="form-control" />
                            </div>
                            <div class="col-8 col-lg-3">
                                Colonia<br/>
                                <input type="text" id="pcolonia" class="form-control" />
                            </div>
                            <div class="col-4 col-lg-2">
                                C.P.<br/>
                                <input type="text" id="pcp" class="form-control" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6 col-lg-2">
                                Estado<br/>
                                <select id="pestado" class="form-control"></select>
                            </div>
                            <div class="col-6 col-lg-3">
                                Municipio<br/>
                                <input type="text" id="pmunicipio" class="form-control" />
                            </div>
                            <div class="col-12 col-lg-3">
                                Correo electr&oacute;nico<br/>
                                <input type="text" id="pemail" class="form-control" />
                            </div>
                            <div class="col-6 col-lg-2">
                                Tel&eacute;fono particular<br/>
                                <input type="text" id="ptelefono" class="form-control" />
                            </div>
                            <div class="col-6 col-lg-2">
                                Celular<br/>
                                <input type="text" id="pcelular" class="form-control" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6 col-lg-2">
                                Religión<br/>
                                <input type="text" id="religion" class="form-control">
                            </div>
                            <div class="col-6 col-lg-2">
                                Tipo de Sangre<br>
                                <input type="text"  id="tipoSangre" placeholder="Ej. A POSITIVO" class="form-control">                        
                            </div>
                            <div class="col-5 col-lg-3">
                                Escolaridad<br>
                                <select  id="selEscolaridad" class="form-control">
                                    <option value="NINGUNO">NINGUNO</option>
                                    <option value="PRIMARIA">PRIMARIA</option>
                                    <option value="SECUNDARIA">SECUNDARIA</option>
                                    <option value="PREPARATORIA">PREPARATORIA</option>
                                    <option value="LICENCIATURA">LICENCIATURA</option>
                                    <option value="MAESTRIA">MAESTRÍA</option>
                                    <option value="DOCTORADO">DOCTORADO</option>
                                    <option value="POSGRADO">POSGRADO</option>
                                    <option value="OTRO">OTRO</option>
                                </select>
                                <!-- <td id="otrosEstudios" style="display:none">
                                    Especifique<br>
                                    <input type="text" name="" id="txtescolaridad" class="form-control">
                                </td> -->
                            </div>
                            <div class="col-7 col-lg-5">
                                Alergias Medicas
                                <input type="text" id="alergiaMedica" class="form-control">
                            </div>
                        </div>  
                        <!-- <div class="row">
                            <div class="col-2">
                                ¿Asegurado?<br>
                                <div class="form-check">
                                    <input type="radio" name="hasSeguro"  class="hasSeguro form-check-input" value="0" checked>
                                    <label class="form-check-label" for="radioDefault">No</label>
                                </div>
                                <div class="form-check">
                                    <input type="radio" name="hasSeguro"  class="hasSeguro form-check-input" value="1">
                                    <label class="form-check-label" for="radioDefault">Si</label>
                                </div>
                            </div>
                            <div class="col-2">
                                ¿Tiene hijos?<br>
                                <div class="form-check">
                                    <input type="radio" name="hasChild" class="hasChild form-check-input" value="0" checked>
                                    <label class="form-check-label" for="hasChild">No</label>
                                </div>
                                <div class="form-check">
                                    <input type="radio" name="hasChild" class="hasChild form-check-input" value="1">
                                    <label class="form-check-label" for="hasChild">Si</label>
                                </div>
                                <div  id="formHijos" style="display:none">
                                    <table>
                                        <tr>
                                            <td >
                                                # Hijas<br>
                                                <input type="number"  id="nHijas" class="form-control">
                                            </td>
                                            
                                            <td>
                                                # Hijos<br>
                                                <input type="number"  id="nHijos" class="form-control">
                                            </td>
                                        </tr>
                                    </table>
                                </div>                        
                            </div>
                        </div> -->             
                    </div>    
                </div>
            </div>
            <br/>
            <div class="card">
                <div class="card-header" style="font-size:1.2em; font-weight:bold"> 
                    <i class="icon-edit"></i> <span>Datos de Acceso</span>
                </div>
                <!-- /widget-header -->
                <div class="card-body" style="padding:10px">
                    <div class="row">
                        <div class="col-6 col-lg-3">
                            Usuario<br/>
                            <input type="text" id="pusuario" class="form-control" />
                        </div>
                        <div class="col-6 col-lg-3">
                            Tipo<br/>
                            <select id="ptipo" class="form-control">
                                <option value="3">USUARIO</option>
                                <option value="1">ADMINISTRADOR</option>
                            </select>
                        </div>
                        <div class="col-6 col-lg-2">
                            Contrase&ntilde;a<br/>
                            <input type="password" id="ppassword" class="form-control" />
                        </div>
                        <div class="col-6 col-lg-2">
                            Repetir Contrase&ntilde;a<br/>
                            <input type="password" id="ppasswordr" class="form-control" />
                        </div>
                    </div> 
                </div>
            </div>
            <br/>
            <div class="card">
                <div class="card-header" style="font-size:1.2em; font-weight:bold"> 
                    <i class="icon-file"></i> <span>Datos del Contrato</span>
                </div>
                <!-- /widget-header -->
                <div class="card-body" style="padding:10px">
                    <div class="row">
                        <div class="col-12 col-lg-3">
                            UDN<br/>
                            <div class="input-group" data-target-input="nearest">
                                <select id="psucursal" class="form-control" data-target="#sucursalempleado"></select>
                                <button class="input-group-text" data-target="#sucursalempleado" id="actAdscripcion"><i class="link-icon" data-feather="shuffle"></i></button>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3">
                            Departamento<br/>
                            <select id="pdepartamento" class="form-control" onChange="comboCatalogo('p','departamento',2,'puesto')"></select>
                        </div>
                        <div class="col-6 col-lg-2">
                            Puesto<br/>
                            <select id="ppuesto" class="form-control"></select>
                        </div>
                        <div class="col-6 col-lg-2">
                            Tipo de contrato<br/>
                            <select id="ptipocontrato" class="form-control"></select>
                        </div>
                        <div class="col-6 col-lg-2">
                            Tiempo de contrato<br/>
                            <select id="ptiempocontrato" class="form-control"></select>
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-4 col-lg-3">
                            Tipo de jornada<br/>
                            <select id="ptipojornada" class="form-control"></select>
                        </div>
                        <div class="col-4 col-lg-3">
                            Fecha de Inicio Laboral<br/>
                            <input type="text" id="piniciolaboral" class="form-control" onChange="calculaTiempo('piniciolaboral','pantiguedad','antiguedadSAT')" placeholder="dd/mm/aaaa" autocomplete="off" />
                        </div>
                        <div class="col-4 col-lg-2">
                            Antigüedad<br/>
                            <input type="text" id="pantiguedadinterna" class="form-control" readonly/>
                        </div>
                        <div class="col-4 col-lg-2">
                            Antigüedad SAT<br/>
                            <input type="text" id="pantiguedad" class="form-control" readonly/>
                        </div>
                        <div class="col-4 col-lg-2">
                            Sindicalizado<br/>
                            <select id="psindicalizado" class="form-control">
                                <option value='No'>No</option>
                                <option value='Sí'>Si</option>
                            </select>
                        </div>
                    </div>   
                    <div class="row">
                        <div class="col-8 col-lg-3">
                            Tipo de r&eacute;gimen<br/>
                            <select id="ptiporegimen" class="form-control"></select>
                        </div>
                        <div class="col-6 col-lg-3">
                            Riesgo del puesto<br/>
                            <select id="priesgopuesto" class="form-control"></select>
                        </div>
                        <div class="col-6 col-lg-3">
                            Periodicidad de pago<br/>
                            <select id="pperiodicidadpago" class="form-control"></select>
                        </div>
                        <div class="col-6 col-lg-3">
                            <b>Salario diario bruto</b><br/>
                            <input type="number" id="psueldobruto" min="1" class="form-control"  />
                        </div>
                    </div>   
                    <div class="row">
                        <div class="col-12 col-lg-4">
                            Banco<br/>
                            <select id="pbanco" class="form-control"></select>
                        </div>
                        <div class="col-6 col-lg-4">
                            Cuenta bancaria<br/>
                            <input type="text" id="pcuentabancaria" class="form-control"  />
                        </div>
                        <div class="col-6 col-lg-2">
                            Salario base<br/>
                            <input type="number" id="psalariobase" class="form-control" readonly />
                        </div>
                        <div class="col-6 col-lg-2">
                            Salario diario integrado<br/>
                            <input type="number" id="psalariodiario" class="form-control" readonly/>
                        </div>
                    </div>    
                    <div class="row">
                        <div class="col-6 col-lg-4">
                            RFC (Subcontrataci&oacute;n)<br/>
                            <input type="text" id="psubrfc" class="form-control"  />
                        </div>
                        <div class="col-6 col-lg-4">
                            % de tiempo (Subcontrataci&oacute;n)<br/>
                            <input type="number" id="psubporcentaje" class="form-control"  />
                        </div>
                        <div class="col-12 col-lg-4">
                            &nbsp;<br/>
                            <?php if($_SESSION['permisos'][2]['imprimir']==1){ ?>
                            <button type="button" class="btn btn-warning btn-icon-text" onclick="printContrato()">
                                <i class="btn-icon-prepend" data-feather="printer"></i>
                                Imprimir Contrato
                            </button>
                            <?php } ?>
                        </div>
                    </div>   
                </div>
            </div>
            <br/>
            <div class="card">
                <div class="card-header" style="font-size:1.2em; font-weight:bold"> 
                    <span>Documentos digitales</span>
                </div>
                <!-- /widget-header -->
                <div class="card-body" style="padding:10px">
                    <div class="row">
                        <div class="col-12 col-md-4">
                            Archivo<br/>
                            <input type="file" id="parchivo" name="parchivo" class="form-control"  />
                        </div>
                        <div class="col-12 col-md-4">
                            Tipo de documento<br/>
                            <select id="ptipodoc" class="form-control" ></select>
                        </div>
                        <div class="col-12 col-md-4">
                            &nbsp;<br/>
                            <button type="button" class="btn btn-primary btn-icon-text" <?php if($_SESSION['permisos'][4]['guardar']==1){ ?> onClick="subirDoc()"<?php } ?>>
                                <i class="btn-icon-prepend" data-feather="upload"></i>
                                Subir documento
                            </button>
                        </div>
                    </div>
                    <div class="row" id="documentos" style="padding:10px">
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12" style="text-align:right; padding:1em" id="btnshtmlbottom">
                        <button type="button" class="btn btn-secondary btn-icon" onclick="nuevo()"><i class="mdi mdi-file-outline"></i></button>
						<?php if($_SESSION['permisos'][4]['guardar']==1){ ?>
                        <button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <!-- /widget -->
        </div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
	<script type="text/javascript" src="js/empleados.js"></script>
</body>
</html>    