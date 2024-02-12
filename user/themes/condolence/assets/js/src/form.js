(function() {
    const form = document.querySelector( 'form' );
    if ( !form ) {
        return false;
    }
    form.action = document.location.href;
    if ( document.location.pathname == '/' )
    {
        form.action = '/home';
    }

    const result = document.createElement( 'div' );
    result.classList.add( 'form__results' );
    form.after( result );

    form.addEventListener('submit', function(event) {
        event.preventDefault();

        const action = form.getAttribute('action') + '.json';
        const method = form.getAttribute('method');

        fetch(action, {
            method: method,
            body: new FormData(form)
        })
            .then(function(response) {
                if (response.ok) {
                    return response.text();
                } else {
                    return response.json();
                }
            })
            .then(function(output) {
                if (result) {
                    // result.innerHTML = output;
                    output = JSON.parse( output );
                    let markup = '<p class="notice notice--' + output.status + '">';
                    markup += output.message;
                    markup += '</p>';
                    result.innerHTML = markup;

                    if (output.status == 'success') {
                        form.classList.add('submitted');
                        form.querySelector( '.button[type=submit]' ).remove();
                    }
                }
            })
            .catch(function(error) {
                if (result) {
                    result.innerHTML = 'Error: ' + error;
                }

                throw new Error(error);
            });
    });
})();