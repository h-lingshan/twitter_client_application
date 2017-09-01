$(document).ready(function() {
    $('#btn_new_tweet').hide();
    setInterval(refreshPartial, 60000); //linetimeはRate Limitedにひっかかるので20秒ごとにapiにアクセスすることに60秒に変える
    $('#btn_new_tweet').click(function() {
        $.ajax({
            url: "/time_line",
            dataType: 'script',
            type: "GET",
            data: { max_id: $('#new_max_id').val() },
        }).done(function(data, textStatus, jqXHR){
            $('#max_id').val(('#new_max_id').val());
        })
        $('#btn_new_tweet').hide();
    })
})

function refreshPartial() {
    $.ajax({
        url: "/time_line_max_id",
        dataType: 'json',
        success: function(data) {
            if (data.max_id != $('#max_id').val()) {
                $('#new_max_id').val(data.max_id);
                $('#btn_new_tweet').show();
            }
        }
    })
}