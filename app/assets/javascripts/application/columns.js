$(document).ready(function() {
  $(".learning-object-columns").each(function() {
    var html = '',
        i = 1;

    $("> div", this).each(function () {
      if (i == 2) {
        html = '<div class="col-md-6"><div class="row"><div class="col-md-3">&nbsp;</div><div class="col-md-6">';
        // TODO: find a way to not remove wrapper div
        html += $(this).clone().wrap('<div>').parent().html();
        html += '</div><div class="col-md-3">&nbsp;</div></div></div>';
        $(this).replaceWith(html);

        i = 0;
      }
      else {
        $(this).wrap('<div class="col-md-3"></div>');

        i += 1;
      }
    });
  });

});
