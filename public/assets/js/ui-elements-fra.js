var UIElements = function () {
    //function to initiate bootstrap-paginator


    //function to initiate jquery.gritter
    var runGritterNotification = function () {
        $.extend($.gritter.options, {
            class_name: 'gritter-light', // for light notifications (can be added directly to $.gritter.add too)
            position: 'top-right', // possibilities: bottom-left, bottom-right, top-left, top-right
            fade_in_speed: 100, // how fast notifications fade in (string or int)
            fade_out_speed: 100, // how fast the notices fade out
            time: 3000 // hang on the screen for...
        });

        $('#add-regular').click(function () {
            $.gritter.add({
                // (string | mandatory) the heading of the notification
                title: 'This is a regular notice!',
                // (string | mandatory) the text inside the notification
                text: 'This will fade out after a certain amount of time. Vivamus eget tincidunt velit. Cum sociis natoque penatibus et <a href="#" style="color:#ccc">magnis dis parturient</a> montes, nascetur ridiculus mus.',
                // (string | optional) the image to display on the left
                image: 'assets/images/avatar-2.jpg',
                // (bool | optional) if you want it to fade out on its own or just sit there
                sticky: false,
                // (int | optional) the time you want it to be alive for before fading out
                time: ''
            });
            return false;
        });


    };
    return {
        //main function to initiate template pages
        init: function () {
            //runPaginator();
            //runPulsate();
            runGritterNotification();
        }
    };
}();