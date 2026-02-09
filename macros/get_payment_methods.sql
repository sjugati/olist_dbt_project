{% macro get_payment_methods() %}
    {{ return(['credit_card','debit_card','voucher','boleto']) }}
{% endmacro %}