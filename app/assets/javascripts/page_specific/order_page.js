if (window.location.pathname === '/orders') {
    $(document).ready(function () {

        var pickup_information = [
            'order_billing_name',
            'order_billing_company',
            'order_billing_org_nr',
            'order_billing_address',
            'order_billing_postal_code',
            'order_billing_city',
            'order_billing_phone',
            'order_billing_email',
            'order_allergies',
            'order_delivery_date'
        ];
        var delivery_information = [
            'order_delivery_name',
            'order_delivery_address',
            'order_delivery_postal_code',
            'order_delivery_city',
            'order_delivery_floor',
            'order_delivery_door_code',
            'order_delivery_contact_name',
            'order_delivery_contact_phone_number'
        ];

        function delivery_required(status) {
            delivery_information.forEach(function (obj) {
                document.getElementById(obj).required = status;
            })
        }

        function setStorage(obj) {
            var element_value = document.getElementById(obj).value;
            sessionStorage.setItem(obj, element_value);
        }

        function saveData() {
            pickup_information.forEach(function (obj) {
                setStorage(obj);
            });
            if (document.getElementById('delivery_address_fields')) {
                delivery_information.forEach(function (obj) {
                    setStorage(obj);
                })
            }
        }

        function loadData() {
            pickup_information.forEach(function (obj) {
                document.getElementById(obj).value = sessionStorage.getItem(obj)
            });
            if (document.getElementById('delivery_address_fields')) {
                delivery_information.forEach(function (obj) {
                    document.getElementById(obj).value = sessionStorage.getItem(obj)
                })
            }
        }

        if (sessionStorage.getItem('order_billing_name') !== null) {
            loadData();
        }

        if (sessionStorage.getItem('radio_button') === 'order_delivery_method_delivery'
            || sessionStorage.getItem('radio_button') === 'order_delivery_method_pickup') {
            document.getElementById(sessionStorage.getItem('radio_button')).checked = true;
            delivery_required(false);
            if (sessionStorage.getItem('radio_button') === 'order_delivery_method_pickup') {
                document.getElementById('delivery_address_fields').hidden = true;
            }
        } else {
            document.getElementById('order_delivery_method_delivery').checked = true;
            sessionStorage.setItem('radio_button', 'order_delivery_method_delivery');
            delivery_required(true);
        }

        var add_cutlery = document.getElementById('add_cutlery');
        var submit_order = document.getElementById('submit_order');
        var remove_cutlery = document.getElementById('remove_cutlery');

        submit_order.onclick = saveData;
        add_cutlery.onclick = saveData;
        if (remove_cutlery) {
            remove_cutlery.onclick = saveData;
        }

        var delivery_radio_button = document.getElementById('order_delivery_method_delivery');
        var pickup_radio_button = document.getElementById('order_delivery_method_pickup');

        delivery_radio_button.onclick = function () {
            document.getElementById('delivery_address_fields').hidden = false;
            sessionStorage.setItem('radio_button', 'order_delivery_method_deliver');
            delivery_required(true);
        };
        pickup_radio_button.onclick = function () {
            document.getElementById('delivery_address_fields').hidden = true;
            sessionStorage.setItem('radio_button', 'order_delivery_method_pickup');
            delivery_required(false);
        };
    })
}