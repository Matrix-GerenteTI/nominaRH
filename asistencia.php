<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
    <link rel="stylesheet" href="assets/vendors/datatables.net-bs5/dataTables.bootstrap5.css">
</head>
<body class="sidebar-<?=$_SESSION['template']?>">


<div class="modal fade" id="modalControlAsistencia" tabindex="-1" aria-labelledby="modalControlAsistenciaLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalControlAsistenciaLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
      </div>
        <div class="modal-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-striped table-bordered" style="width:50%; margin: 0 auto;">
                                <tr>
                                    <th>Foto</th>
                                    <th>Ubicacion</th>
                                    <th>Fecha</th>
                                    <th>Hora</th>	
                                    <th>Tipo</th>						
                                    <th style="display:none" id="headerEliminaIncidencia">Modificar</th>							
                                </tr>
                                <tbody id="logAsistencia">
                                    
                                </tbody>
                        </table>
                        <hr/>
                        <div class="container-fluid" style="display:none" id="displaySetIngresoXFalta">
                            <div class="row">
                                <div class="col-sm-10 col-offset-1">
                                    <b>*Nota: </b>
                                    <p>Se requiere de una hora y ubicacion para sustituir la actual.</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 col-offset-1">
                                    <input type="time" class="form-control"  placeholder="Ingresa una hora" id="horaIngresoxFalta">			
                                    <input type="hidden"  id="nipIngresoXFalta">					
                                </div>
                                <div class="col-sm-6 col-offset-1">
                                    <select class="form-control"  id="updsucursal"></select>
                                </div>
                            </div>		
                            <div class="row">
                                <div class="col-sm-10 col-offset-1">
                                    <button class="btn btn-success" id="btnSetAsistenciaDeFalta">Confirmar</button>
                                </div>
                            </div>					
                        </div>

                    </div>
                </div>					
            </div>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" id="btnAplicaCambiosMontos" style="display:none">Confirmar</button>
      </div>
    </div>
  </div>
</div>
<!-- 
    <div class="modal" tabindex="-1" role="dialog" id="modalControlAsistencia"> 
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="tituloControl"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<table class="table table-striped table-bordered" style="width:50%; margin: 0 auto;">
									<tr>
										<th>Fecha</th>
										<th>Hora</th>
										<th style="display:none" id="headerMontoIncidencia" >Descuento</th>							
										<th style="display:none" id="headerEliminaIncidencia">Quitar</th>							
									</tr>
									<tbody id="logAsistencia">
										
									</tbody>
							</table>
							<div class="container-fluid" style="display:none" id="displaySetIngresoXFalta">
								<div class="row">
									<div class="col-sm-10 col-offset-1">
										<b>*Nota: </b>
										<p>Se requiere de una hora de ingreso estimada para proceder a cancelar la falta del empleado, si se elige una hora superior a la hora de ingreso del trabajador se le aplicará la sanción correspondiente</p>
										<div class="input-group clockpicker" data-placement="left" data-align="top" data-autoclose="true">
											<input type="text" class="form-control"  placeholder="Ingresa una hora" id="horaIngresoxFalta">
											<span class="input-group-addon">
												<span class="icon-clock"></span>
											</span>
										</div>			
										<input type="hidden"  id="nipIngresoXFalta">					
									</div>
								</div>		
								<div class="row">
									<div class="col-sm-10 col-offset-1">
										<button class="btn btn-success" id="btnSetAsistenciaDeFalta">Confirmar</button>
									</div>
								</div>					
							</div>

						</div>
					</div>					
				</div>
			</div>
			<div class="modal-footer">
					
					<button class="btn btn-primary" id="btnAplicaCambiosMontos" style="float: right">Actualizar Deducciones</button>
					<button class="btn btn-default"  id="btnCerrarControl" data-dismiss="modal" style="float: right">Cerrar</button>
			</div>
			</div>
		</div>
	</div> -->
	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
		<?php require_once('partials/sidebar.php') ?>
    
		<!-- partial -->
	
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->
		<div class="page-content">
			<div class="row">
                <div class="col-12">
                    <div class="card">
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            Sucursal<br/>
                                            <select id="bussucursal" class="form-control"></select>
                                        </div>
                                        <div class="col-lg-4">
                                            Departamento<br/>
                                            <select id="busdepartamento" class="form-control"></select>
                                        </div>
                                        <div class="col-lg-4">
                                            Puesto<br/>
                                            <select id="buspuesto" class="form-control"></select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4">
                                            Empleado<br/>
                                            <input type="text" id="busempleado" class="form-control" />
                                        </div>
                                        <div class="col-lg-4">
                                            De<br/>
                                            <div class="input-group" data-target-input="nearest">
                                                <input type="text" id="fecIni" class="form-control" data-target="#fecIni" autocomplete="off"  value="<?php echo date("d/m/Y"); ?>"/>
                                                <button class="input-group-text" data-target="#fecIni"><i class="link-icon" data-feather="calendar"></i></button>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            Al<br/>
                                            <div class="input-group" data-target-input="nearest">
                                                <input type="text" id="fecFin" class="form-control" data-target="#fecFin" autocomplete="off"  value="<?php echo date("d/m/Y"); ?>"/>
                                                <button class="input-group-text" data-target="#fecFin"><i class="link-icon" data-feather="calendar"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">        
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][9]['ver']==1){ ?>
                                                <button type="button" class="btn btn-inverse-dark" onclick="lista(0,15)"><i data-feather="eye"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][9]['imprimir']==1 || $_SESSION['permisos'][9]['ver']==1){ ?>
                                                <button type="button" class="btn btn-inverse-info" onclick="descargar()"><i data-feather="download"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][9]['guardar']==1){ ?>
                                                <button type="button" class="btn btn-inverse-primary" onclick="aplicar()"><i data-feather="save"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                        <!-- <div class="col-6">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <button type="button" class="btn btn-inverse-success" onclick="prenomina()"><i data-feather="book-open"></i></button>
                                            </div>
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <div class="table-responsive">
                                <table id="tableData" class="table">
                                    <thead>
                                    <tr>
                                        <th> Sucursal </th>
                                        <th> Depto. </th>
                                        <th> Puesto </th>
                                        <th> Empleado </th>
                                        <th> Asistencias </th>
                                        <th> Retardos </th>
                                        <th> Faltas </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    
                                    </tbody>
                                </table>
                            </div>
                            <table class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    
                                </tr>
                                </thead>
                                <tr id="cargandoSVG" style="display: none">
                                    <td colspan="7">
                                                        
                                    </td>
                                </tr>				
                                <tbody id="tbody">
                                </tbody>
                            </table>
                            <div id="paginacion" style="text-align:right"></div>
                        </div>
                    </div>
                    <!-- /widget -->
                </div>
            </div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
    <script src="assets/vendors/datatables.net/jquery.dataTables.js"></script>
    <script src="assets/vendors/datatables.net-bs5/dataTables.bootstrap5.js"></script>
	<!-- End custom js for this page -->
    <script src="assets/js/data-table.js"></script>
	<script type="text/javascript" src="js/asistencia.js"></script>
</body>
</html>    