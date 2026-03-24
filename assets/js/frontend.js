jQuery(document).ready(function ($) {
    $('.posttoai-link').on('click', function (e) {
        var aiName = $(this).find('.posttoai-name').text() || $(this).attr('title');

        if (typeof gtag !== 'undefined') {
            gtag('event', 'ai_summary_click', {
                'ai_service': aiName,
                'page_url': window.location.href
            });
        }
    });
});
