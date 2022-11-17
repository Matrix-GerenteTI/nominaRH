<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	

	<?php require_once('partials/header.php') ?>
	
	<link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
	<style>
		.bookedDate {
			pointer-events: none !important;
		}
	</style>
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
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
				<div class="col-md-12">
					<div class="row">
						<!-- <div class="col-md-3 d-none d-md-block">
							<div class="card">
								<div class="card-body">
									<h6 class="card-title mb-4">Full calendar</h6>
									<div id='external-events' class='external-events'>
										<h6 class="mb-2 text-muted">Draggable Events</h6>
										<div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
											<div class='fc-event-main'>Birth Day</div>
										</div>
										<div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
											<div class='fc-event-main'>New Project</div>
										</div>
										<div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
											<div class='fc-event-main'>Anniversary</div>
										</div>
										<div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
											<div class='fc-event-main'>Clent Meeting</div>
										</div>
										<div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event hii'>
											<div class='fc-event-main'>Office Trip</div>
										</div>
									</div>
								</div>
							</div>
						</div> -->
						<div class="col-12 col-md-12">
							<div class="card">
								<div class="card-body">
									<div id='fullcalendar'></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div id="fullCalModal" class="modal fade">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h4 id="modalTitle1" class="modal-title"></h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"><span class="visually-hidden">close</span></button>
							<input type="text" id="idEvento" style="display:none">
						</div>
						<div id="modalBody1" class="modal-body">

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cerrar</button>
							<?php if($_SESSION['permisos'][7]['borrar']==1){ ?>
							<button class="btn btn-danger" onclick="eliminarEvento()">Eliminar Evento</button>
							<?php } ?>
						</div>
					</div>
				</div>
			</div>

			<div id="createEventModal" class="modal fade">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h4 id="modalTitle2" class="modal-title">Agregar evento</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"><span class="visually-hidden">close</span></button>
						</div>
						<div id="modalBody2" class="modal-body">
							<form>
								<div class="mb-3">
									<label for="entrada" class="form-label">Fecha</label>
									<input type="text" class="form-control" id="fecha" disabled />
									<input type="text" id="fechaHidden" style="display:none"/>
								</div>
								<div class="mb-3">
									<label for="tipo" class="form-label">Tipo de Evento</label>
									<select class="form-control" id="tipo" onchange="activaHorarios()">
										<option value="1">Suspensión de labores</option>
										<option value="2">Horario especial</option>
										<option value="3">Otro</option>
									</select>
								</div>
								<div class="mb-3 horarios" style="display:none">
									<label for="entrada" class="form-label">Hora de Entrada</label>
									<input type="time" class="form-control" id="entrada" />
								</div>
								<div class="mb-3 horarios" style="display:none">
									<label for="entrada" class="form-label">Hora de Salida</label>
									<input type="time" class="form-control" id="salida" />
								</div>
								<div class="mb-3">
									<label for="evento" class="form-label">Etiqueta del evento</label>
									<input type="text" class="form-control" id="evento" placeholder="Ej. Independencia de México">
								</div>
								<div class="mb-3">
									<label for="evento" class="form-label">Descripción</label>
									<textarea class="form-control" id="descripcion"></textarea>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
							<?php if($_SESSION['permisos'][7]['guardar']==1){ ?>
							<button class="btn btn-success" onclick="agregaEvento()">Agregar</button>
							<?php } ?>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
  	<script src="js/calendario.js"></script>
</body>
</html>    