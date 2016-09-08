var ruleset = null;
var requestCount = 0;
var modalElement = '.submit-request';
var requestForm = '#time-request-form';
var datepicker = '#date-picker';
var requestType = "#time-request-type";
var requestedDates = '#requested-dates';
var requestReason = '#time-request-reason';
var submitButton = 'input[data-time-request-submit]';
var alertElement = '.alert';

var NOTIFICATION_TYPES = {
  Success: 'success',
  Error: 'error'
};

function initializeModal() {
  $('[data-submit-request]').click(function(e) {
    $(modalElement).modal();

    return false;
  });

  $(document).bind('ajaxError', requestForm, function(event, xhr) {
    showNotification(NOTIFICATION_TYPES.Error, 
      "An error occurred: " + xhr.responseText);
  });

  $(document).bind('ajaxSuccess', requestForm, function(event, xhr, opts, data) {
    if (data.type && data.type === 'CancelPtoTimeRequest'){
      removeRequestRow(data.vacation_day_id);
    } else {
      showNotification(NOTIFICATION_TYPES.Success, "Request successfully submitted");
    }
    resetModal();
  });
}

function removeRequestRow(id) {
  var row = $('tr[data-vacation-day-id=' + id + ']');
  row.slideUp();
}

function showNotification(type, message) {
  var alert = $(alertElement);

  alert.addClass("alert-" + type);
  alert.find(".keyword").text(type.capitalize() + "!");
  alert.find('.message').text(message);
  alert.show();
}

function resetModal() {
  $(requestForm)[0].reset();
  $(requestedDates).html('');
  ruleset.applyRules($(modalElement))
  checkForWarnings();
  $(modalElement).modal('hide');
}

function setFormRules() {
  if ($.deps) {
    ruleset = $.deps.createRuleset();

    var reasonRule = ruleset.createRule(requestType, "any", ["RemoteTimeRequest", "EmergencyTimeRequest"]);
    reasonRule.include(requestReason);

    ruleset.install({
      show: elementShowHandler,
      hide: elementHideHandler
    }); 
  }

}

function elementShowHandler(element) {
  if (element.is($(requestReason))) 
    element.find('textarea').attr('required', true);

  element.show();
}

function elementHideHandler(element) {
  if (element.is($(requestReason))) 
    element.find('textarea').attr('required', false);

  element.hide();
}

function setDateHandlers() {
  $('body').on('change', datepicker, function () {
    if ($(datepicker).val() != '') {
      addRequestedDate();    
    }
  });

  $('body').on('change', requestType, checkForWarnings);

  $('body').on('click', '.delete-request', function(event) {
    removeRequestDate(event.target.closest('li'));
  });
}

function inputNameForField(field) {
  return "requested_days[" + requestCount + "][" + field + "]";
}

function formatDate(date) {
  return moment(date).format("ddd, MMM Do, YYYY");
}

function requestIsType(type) {
  return $(requestType).val() == (type + "TimeRequest")
}

function checkForWarnings() {
  checkForSickWarning();
  checkForEmergencyWarning();
  checkForPtoWarning();
}

function checkForPtoWarning() {
  if (requestIsType("Pto") && requestedWithinTwoWeeks()) {
    $('#pto-warning').show();
  } else {
    $('#pto-warning').hide();
  }
}

function checkForSickWarning() {
  if ((requestIsType("Sick") ||
       requestIsType("Remote")) &&
       todayRequested() &&
       new Date().getHours() > 8) {
    $('#sick-warning').show();
  } else {
    $('#sick-warning').hide();
  }
}

function checkForEmergencyWarning() {
  if (requestIsType("Emergency")) {
    if (emergencyRequestsTaken + $('#requested-dates li').length > emergencyRequestsAllowed) {
      $('#emergency-warning').show();
    } else {
      $('#emergency-warning').hide();
    }
  }
}

function todayRequested() {
  var requestedDates = $('#requested-dates li [data-date-requested]');
  for (var i=0;i<requestedDates.length;i++) {
    if (requestedDates[i].value == moment().format("YYYY-MM-DD")) {
      return true;
    }
  }
  return false;
}

function requestedWithinTwoWeeks() {
  var requestedDates = $('#requested-dates li [data-date-requested]');
  for (var i=0;i<requestedDates.length;i++) {
    if (moment(requestedDates[i].value).diff(moment(), 'days') < 13) {
      return true;
    }
  }
  return false;
}

function addRequestedDate() {
  var dateElement = 
    '<li>' +
      '<a href="#" class="delete-request">x</a>' +
      '<span class="requested-date">' + formatDate($(datepicker).val()) + '</span>' +
      '<input type="radio" name="' + inputNameForField("hours_requested") + '" value="8" checked="checked">8 hours' +
      '<input type="radio" name="' + inputNameForField("hours_requested") + '" value="4">4 hours' +
      '<input type="hidden" data-date-requested name="' + inputNameForField("date_requested") + '" value="' + $(datepicker).val() + '">'
    '</li>'
  $(requestedDates).append(dateElement);
  $(datepicker).val('');
  $(submitButton).attr('disabled', false);
  requestCount++;
  checkForWarnings();
}

function removeRequestDate(element) {
  element.remove();
  if ($(requestedDates).find("li").length == 0) {
    $(submitButton).attr('disabled', true);
  }
  checkForWarnings();
}

function confirmArchive(e) {
  var user = $(e.target).data("user");
  return confirm("Are you sure you want to archive " + user + "?");
}

$(function() {
  initializeModal();
  setFormRules();
  setDateHandlers();
  $('.archive-user-link').click(confirmArchive);
});
