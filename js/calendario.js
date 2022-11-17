
var Draggable = FullCalendar.Draggable;
var calendarEl = document.getElementById('fullcalendar');
var containerEl = document.getElementById('external-events');

var curYear = moment().format('YYYY');
var curMonth = moment().format('MM');

$(document).ready(function(e) {
    showCalendario();
});

function showCalendario(){
    $("#idEvento").val('');
    $.post("ajax/ajaxempresa.php?op=getCalendario", "", function(resp){
        console.log(resp)
        var diasEventos = eval('('+resp+')');
        // initialize the calendar
        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: "prev,today,next",
                center: 'title',
                right: ""
            },
            locale: 'es',
            editable: true,
            droppable: true, // this allows things to be dropped onto the calendar
            fixedWeekCount: true,
            // height: 300,
            initialView: 'dayGridMonth',
            timeZone: 'America/Mexico_City',
            hiddenDays:[],
            navLinks: 'true',
            // weekNumbers: true,
            // weekNumberFormat: {
            //   week:'numeric',
            // },
            dayMaxEvents: 3,
            events: [],
            eventSources: [diasEventos.inhabil,diasEventos.especial,diasEventos.otro],
            drop: function(info) {
                // remove the element from the "Draggable Events" list
                // info.draggedEl.parentNode.removeChild(info.draggedEl);
            },
            eventClick: function(info) {
                var eventObj = info.event;
                console.log(eventObj.id);
                $('#modalTitle1').html(eventObj.title);
                $('#modalBody1').html(eventObj._def.extendedProps.description);
                $('#eventUrl').attr('href',eventObj.url);
                $("#idEvento").val(eventObj.id);
                $('#fullCalModal').modal("show");
            },
            dateClick: function(info) {                
                let fechaSelected = info.dateStr;
                $("#tipo").val(1);
                $("#salida").val('');
                $("#entrada").val('');
                $("#evento").val('');
                $("#descripcion").val('');
                $("#fecha").val('');
                $("#fechaHidden").val('');
                $("#createEventModal").modal("show");
                $("#idEvento").val('');
                $("#fechaHidden").val(fechaSelected);
                let fechaSlash = fechaSelected.split('-');
                $("#fecha").val(fechaSlash[2]+'/'+fechaSlash[1]+'/'+fechaSlash[0]);
                console.log(info.dateStr);
            }
        });

        calendar.render();
        const bookedDates = document.querySelectorAll('.fc-daygrid-day-number');

        bookedDates.forEach(function (bookedDate) {
            bookedDate.classList.add('bookedDate');
        });
    });
}

function eliminarEvento(){
    let id = $("#idEvento").val();
    confirmy('Eliminar Evento','question','¿Desea realmente eliminar el evento?','Si','No','delEvento',id);
    
}

function delEvento(id){
    $.post("ajax/ajaxempresa.php?op=eliminaEvento", "id="+id, function(resp){  
        if(resp>0){
            okMsg('Listo!',"El evento se eliminó exitosamente!");
            $("#idEvento").val('');
            $('#fullCalModal').modal("hide");	
            showCalendario();				
        }else
            errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");      
    });
}

function agregaEvento(){
    let tipo = $("#tipo").val();
    let entrada = $("#entrada").val();
    let salida = $("#salida").val();
    let evento = $("#evento").val();
    let descripcion = $("#descripcion").val();
    let fecha = $("#fechaHidden").val();
    let params = "tipo="+tipo;
    params+= "&entrada="+entrada;
    params+= "&salida="+salida;
    params+= "&evento="+evento;
    params+= "&descripcion="+descripcion;
    params+= "&fecha="+fecha;
    $.post("ajax/ajaxempresa.php?op=agregaEvento", params, function(resp){  
        if(resp>0){
            if(resp==1){
                okMsg('Listo!',"El evento se agregó correctamente!");
                $("#tipo").val(1);
                $("#salida").val('');
                $("#entrada").val('');
                $("#evento").val('');
                $("#descripcion").val('');
                $("#fechaHidden").val('');
                $("#fecha").val('');
                $('#createEventModal').modal("hide");	
                showCalendario();
            }else{
                errorMsg('Ups!',"Ya hay un evento del mismo tipo creado en esa fecha");
            }
        }else
            errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");      
    });
}

function activaHorarios(){
    let tipo = $("#tipo").val();
    if(tipo==2){
        $(".horarios").show();
    }else{
        $(".horarios").hide();
    }
}
