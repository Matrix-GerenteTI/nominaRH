<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>

	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
		<?php require_once('partials/sidebar.php') ?>
    
		<!-- partial -->
		<style>
			.borderojo{
				border: red 1px solid;
			}
		</style>
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->
		<div class="page-content">
            <div class="row">
            <div class="col-12">
				<div class="card">
					<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
						<i class="icon-edit"></i> <span>Parametros de Asistencia</span>
					</div>
					<!-- /widget-header -->
					<div class="card-body" style="padding:10px">
						<div class="row">
							<div class="col-6 col-xl-3">
								Sucursal<br/>
								<select id="psucursal" class="form-control" onChange="carga()"></select>
							</div>
							<div class="col-6 col-xl-3">
								Departamento<br/>
								<select id="pdepartamento" class="form-control" onChange="comboPuesto()"></select>
							</div>
							<div class="col-6 col-xl-3">
								Puesto<br/>
								<select id="ppuesto" class="form-control" onChange="comboEmpleado()"></select>
							</div>
							<div class="col-6 col-xl-3">
								Trabajador<br/>
								<select id="pempleado" class="form-control" onChange="carga()"></select>
							</div>
						</div>
						<hr/>
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">
										<p class="text-muted mb-3">Configure por cada día de la semana los horarios de entrada y salida. Los horarios de comida se consideran como entradas y salidas intermedias. El órden de configuración es: [Hora de Entrada] [Hora salida intermedia] [Hora entrada intermedia] [Hora de Salida] </p>
										<div class="row">
											<div class="col-12 col-lg-2">
												<br/>
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="check1">
													<label class="form-check-label" for="checkChecked">Lunes</label>
												</div>
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="e1">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="si1">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="ei1">
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="s1">
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-12 col-lg-2">
												<br/>
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="check2">
													<label class="form-check-label" for="checkChecked">Martes</label>
												</div>
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="e2">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="si2">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="ei2">
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="s2">
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-12 col-lg-2">
												<br/>
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="check3">
													<label class="form-check-label" for="checkChecked">Miércoles</label>
												</div>
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="e3">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="si3">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="ei3">
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="s3">
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-12 col-lg-2">
												<br/>
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="check4">
													<label class="form-check-label" for="checkChecked">Jueves</label>
												</div>
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="e4">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="si4">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="ei4">
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="s4">
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-12 col-lg-2">
												<br/>
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="check5">
													<label class="form-check-label" for="checkChecked">Viernes</label>
												</div>
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="e5">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="si5">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="ei5">
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="s5">
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-12 col-lg-2">
												<br/>
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="check6">
													<label class="form-check-label" for="checkChecked">Sábado</label>
												</div>
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="e6">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="si6">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="ei6">
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="s6">
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-12 col-lg-2">
												<br/>
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="check0">
													<label class="form-check-label" for="checkChecked">Domingo</label>
												</div>
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="e0">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="si0">
											</div>
											<div class="col-6 col-lg-2">
												<input type="time" class="form-control" id="ei0">
											</div>
											<div class="col-6 col-lg-3">
												<input type="time" class="form-control" id="s0">
											</div>
										</div>
									</div>
								</div>
								<br/>
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-6 col-lg-3">
												Minutos de tolerancia<br/>
												<input type="number" min="0" id="ptolerancia" class="form-control" />
											</div>
											<div class="col-6 col-lg-3">
												Retardos para falta<br/>
												<input type="number" min="0" id="pretardospfalta" class="form-control" />
											</div>
											<div class="col-6 col-lg-3">
												Faltas para descuento<br/>
												<input type="number" min="0" id="pfaltaspdescuento" class="form-control" />
											</div>
											<div class="col-6 col-lg-3">
												Monto de descuento<br/>
												<input type="number" min="0" id="pmontodescuento" class="form-control" />
											</div>
										</div>
									</div>
								</div>
								<br/>
								<div class="d-flex flex-row-reverse">
									<?php if($_SESSION['permisos'][6]['guardar']==1){ ?>
									<button class="btn btn-success" onclick="guardar()"><i class="mdi mdi-content-save"></i> Guardar</button>
									<?php } ?>
								</div>
							</div>
						</div>
                    </div>
                </div>
                
                
                <!-- <div class="widget widget-nopad">   
                    <div class="widget-header"> <i class="icon-edit"></i>
                    <h3> Trabajadoes Programados </h3>
                    </div>
					
                    <div class="widget-content" style="padding:10px;">
                            <div class="container-buscador">
                                <input id="searchBar" class="searchbar" type="text" placeholder="Buscar Nombre...">
                                <a id="btnSearch" class="btn-search"><i class="icon-search"></i></a>
                            </div>
                        <section class="container-lista">
                            <div class="items" >
                                <div class="wrapper">
            
                                    <div class="table"  id="empleadosBaja">                                
                                    </div>  
                                </div>

                            </div>
                        </section>
                        
                </div> -->
                

                <!-- /widget -->
                </div>
            <!-- /span6 -->
            </div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
	<script type="text/javascript" src="js/parametros.js"></script>
</body>
</html>    