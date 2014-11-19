$(function() {
    var $body = $('body.preferences-controller');

    if($body.length > 0) {
        var $steps            = $body.find('section#steps'),
            $food_preferences = $body.find('section#food-preferences'),
            $area_preferences = $body.find('section#area-preferences'),
            $day_preferences  = $body.find('section#day-preferences');

        $food_preferences.on('click', '.food-track .track-image', function(e) {
            var $food_track      = $(this).parents('.food-track:first'),
                track_id         = $food_track.data('track-id'),
                $overlay_content = $food_track.find('.overlay-content'),
                not_done         = true;

            $food_track.addClass('active');
            setTimeout(function() {
                if(not_done) {
                    $overlay_content.html('<i class="fa fa-circle-o-notch fa-3x fa-spin">');
                }
            }, 1500);

            $.ajax({
                url: $food_track.data('update-url'),
                method: 'post',
                data: {
                    track_preferences: {
                        track_ids: [track_id]
                    }
                },
                success: function(data) {
                    not_done = false;

                    if(data.type == 'success') {
                        $overlay_content.html('<i class="fa fa-check fa-3x">');

                        $food_preferences.slideUp(function() { $food_preferences.removeClass('active');  });
                        $steps.find('.step.food-preferences').removeClass('active');
                        $area_preferences.addClass('active');
                        $area_preferences.slideDown();
                        $steps.find('.step.area-preferences').addClass('active');
                    } else {
                        $food_track.removeClass('active');
                        $overlay_content.html('<i class="fa fa-plus fa-3x">');
                    }
                },
                error: function() {
                    not_done = false;

                    $food_track.removeClass('active');
                    $overlay_content.html('<i class="fa fa-plus fa-3x">');
                }
            });
        });

        $area_preferences.on('click', 'form .btn-submit', function(e) {
            var $submit_button = $(this),
                $form = $submit_button.parents('form:first'),
                data = {
                    area_preferences: {
                        zipcode: $form.find('#area_preferences_form_zipcode').val(),
                        email: $form.find('#area_preferences_form_email').val(),
                        phone: $form.find('#area_preferences_form_phone').val()
                    }
                },
                not_done = true;

            if($submit_button.attr('disabled')) return;

            $form.find('input,.btn-submit').attr('disabled', true);

            setTimeout(function() {
                if(not_done) {
                    $submit_button.html('<i class="fa fa-circle-o-notch fa-spin">');
                }
            }, 1500);

            $.ajax({
                url: $form.attr('action'),
                method: 'post',
                data: data,
                success: function(data) {
                    not_done = false;

                    $form.find('div.has-error span.help-block').remove();
                    $form.find('div.has-error').removeClass('has-error');

                    if(data.type == 'success') {
                        $submit_button.html('<i class="fa fa-check">');

                        $area_preferences.slideUp(function() { $area_preferences.removeClass('active');  });
                        $steps.find('.step.area-preferences').removeClass('active');
                        $day_preferences.addClass('active');
                        $day_preferences.slideDown();
                        $steps.find('.step.day-preferences').addClass('active');
                    } else {
                        $form.find('input,.btn-submit').attr('disabled', false);
                        $submit_button.html('Next');

                        $.each(data.errors, function(field, errors) {
                            var $field = $form.find('#area_preferences_form_' + field),
                                wrapped_errors = $.map(errors, function(error) { return "<li>" + error + "</li>"; });

                            $('<span class="help-block"><ul' + wrapped_errors + '</ul></span>').insertAfter($field);

                            $field.parents('.form-group:first').addClass('has-error');
                        });
                    }
                },
                error: function() {
                    not_done = false;

                    $form.find('input,.btn-submit').attr('disabled', false);
                    $submit_button.html('Next');
                }
            })

            e.preventDefault();
        });

        function are_days_checked() {
            if($day_preferences.find('.lunch-day-selection .delivery-day.selected').length == 1 &&
               $day_preferences.find('.dinner-day-selection .delivery-day.selected').length == 1) {
                return true;
            } else {
                return false;
            }
        }

        $day_preferences.on('click', 'form .lunch-day-selection .delivery-day:not(.selected)', function(e) {
            var $day = $(this);

            $day.siblings('.delivery-day.selected').removeClass('selected');
            $day.addClass('selected');

            if(are_days_checked()) {
                $day_preferences.find('form .btn-submit').attr('disabled', false);
            }
        });

        $day_preferences.on('click', 'form .dinner-day-selection .delivery-day:not(.selected)', function(e) {
            var $day = $(this);

            $day.siblings('.delivery-day.selected').removeClass('selected');
            $day.addClass('selected');

            if(are_days_checked()) {
                $day_preferences.find('form .btn-submit').attr('disabled', false);
            }
        });

        $day_preferences.on('click', 'form .btn-submit', function(e) {
            var $submit_button = $(this),
                $form = $submit_button.parents('form:first'),
                data = {
                    day_preferences: {
                        lunch_days:  $.map($('form .dinner-day-selection .delivery-day.selected'), function(element) { return $(element).data('day-name'); }),
                        dinner_days: $.map($('form .dinner-day-selection .delivery-day.selected'), function(element) { return $(element).data('day-name'); })
                    }
                }
                not_done = true;

            if($submit_button.attr('disabled')) return;

            $form.find('.delivery-day,.btn-submit').attr('disabled', true);

            setTimeout(function() {
                if(not_done) {
                    $submit_button.html('<i class="fa fa-circle-o-notch fa-spin">');
                }
            }, 1500);

            $.ajax({
                url: $form.attr('action'),
                method: 'post',
                data: data,
                success: function(data) {
                    not_done = false;

                    if(data.type == 'success') {
                        $submit_button.html('<i class="fa fa-check">');

                        window.location = data.message.redirect;
                    } else {
                        not_done = false;

                        $form.find('.delivery-day,.btn-submit').attr('disabled', false);
                        $submit_button.html('Next');
                    }
                },
                error: function() {
                    not_done = false;

                    $form.find('.delivery-day,.btn-submit').attr('disabled', false);
                    $submit_button.html('Next');
                }
            });
        });
    }
});
