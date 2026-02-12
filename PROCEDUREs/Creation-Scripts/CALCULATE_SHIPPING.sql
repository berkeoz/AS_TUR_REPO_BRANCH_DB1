CREATE OR REPLACE EDITIONABLE PROCEDURE "CALCULATE_SHIPPING" (
    p_weight IN NUMBER,
    p_distance IN NUMBER,
    p_is_express IN VARCHAR2,
    p_shipping_cost OUT NUMBER
)
IS
    v_base_rate NUMBER := 5.00;
    v_weight_charge NUMBER;
    v_distance_charge NUMBER;
    v_express_fee NUMBER := 0;
BEGIN
    -- Calculate weight-based charge
    IF p_weight > 50 THEN
        v_weight_charge := p_weight * 0.50;
    ELSIF p_weight > 20 THEN
        v_weight_charge := p_weight * 0.30;
    ELSIF p_weight > 5 THEN
        v_weight_charge := p_weight * 0.20;
    ELSE
        v_weight_charge := p_weight * 0.10;
    END IF;

    -- Calculate distance-based charge
    IF p_distance > 1000 THEN
        v_distance_charge := p_distance * 0.15;
    ELSIF p_distance > 500 THEN
        v_distance_charge := p_distance * 0.10;
    ELSE
        v_distance_charge := p_distance * 0.05;
    END IF;

    -- Add express shipping fee
    IF p_is_express = 'Y' THEN
        v_express_fee := 25.00;
    END IF;

    -- Calculate total
    p_shipping_cost := v_base_rate + v_weight_charge + v_distance_charge + v_express_fee;

    DBMS_OUTPUT.PUT_LINE('Shipping cost: $' || p_shipping_cost);
END calculate_shipping;
/

