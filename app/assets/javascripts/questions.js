$(document).on('turbolinks:load', function () {
  var $question = $('#question');
  $question.on('click', '#edit-question-button', function (e) {
    e.preventDefault();
    $(this).hide();
    $('.edit_question').show();
  });
});
