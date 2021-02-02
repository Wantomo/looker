view: sales {
  sql_table_name: `leafy-habitat-174801.looker.sales`
    ;;

  dimension_group: _sdc_batched {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension_group: _sdc_extracted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension_group: _sdc_received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension: adjustment_negative {
    type: number
    sql: ${TABLE}.adjustment_negative ;;
  }

  dimension: adjustment_positive {
    type: number
    sql: ${TABLE}.adjustment_positive ;;
  }

  dimension: applied_rule_ids {
    type: string
    sql: ${TABLE}.applied_rule_ids ;;
  }

  dimension: base_adjustment_negative {
    type: number
    sql: ${TABLE}.base_adjustment_negative ;;
  }

  dimension: base_adjustment_positive {
    type: number
    sql: ${TABLE}.base_adjustment_positive ;;
  }

  dimension: base_currency_code {
    type: string
    sql: ${TABLE}.base_currency_code ;;
  }

  dimension: base_discount_amount {
    type: number
    sql: ${TABLE}.base_discount_amount ;;
  }

  dimension: base_discount_canceled {
    type: number
    sql: ${TABLE}.base_discount_canceled ;;
  }

  dimension: base_discount_invoiced {
    type: number
    sql: ${TABLE}.base_discount_invoiced ;;
  }

  dimension: base_discount_refunded {
    type: number
    sql: ${TABLE}.base_discount_refunded ;;
  }

  dimension: base_discount_tax_compensation_amount {
    type: number
    sql: ${TABLE}.base_discount_tax_compensation_amount ;;
  }

  dimension: base_discount_tax_compensation_invoiced {
    type: number
    sql: ${TABLE}.base_discount_tax_compensation_invoiced ;;
  }

  dimension: base_discount_tax_compensation_refunded {
    type: number
    sql: ${TABLE}.base_discount_tax_compensation_refunded ;;
  }

  dimension: base_grand_total {
    type: number
    sql: ${TABLE}.base_grand_total ;;
  }

  dimension: base_msp_cod_amount {
    type: number
    sql: ${TABLE}.base_msp_cod_amount ;;
  }

  dimension: base_msp_cod_tax_amount {
    type: number
    sql: ${TABLE}.base_msp_cod_tax_amount ;;
  }

  dimension: base_shipping_amount {
    type: number
    sql: ${TABLE}.base_shipping_amount ;;
  }

  dimension: base_shipping_canceled {
    type: number
    sql: ${TABLE}.base_shipping_canceled ;;
  }

  dimension: base_shipping_discount_amount {
    type: number
    sql: ${TABLE}.base_shipping_discount_amount ;;
  }

  dimension: base_shipping_discount_tax_compensation_amnt {
    type: number
    sql: ${TABLE}.base_shipping_discount_tax_compensation_amnt ;;
  }

  dimension: base_shipping_incl_tax {
    type: number
    sql: ${TABLE}.base_shipping_incl_tax ;;
  }

  dimension: base_shipping_invoiced {
    type: number
    sql: ${TABLE}.base_shipping_invoiced ;;
  }

  dimension: base_shipping_refunded {
    type: number
    sql: ${TABLE}.base_shipping_refunded ;;
  }

  dimension: base_shipping_tax_amount {
    type: number
    sql: ${TABLE}.base_shipping_tax_amount ;;
  }

  dimension: base_shipping_tax_refunded {
    type: number
    sql: ${TABLE}.base_shipping_tax_refunded ;;
  }

  dimension: base_subtotal {
    type: number
    sql: ${TABLE}.base_subtotal ;;
  }

  dimension: base_subtotal_canceled {
    type: number
    sql: ${TABLE}.base_subtotal_canceled ;;
  }

  dimension: base_subtotal_incl_tax {
    type: number
    sql: ${TABLE}.base_subtotal_incl_tax ;;
  }

  dimension: base_subtotal_invoiced {
    type: number
    sql: ${TABLE}.base_subtotal_invoiced ;;
  }

  dimension: base_subtotal_refunded {
    type: number
    sql: ${TABLE}.base_subtotal_refunded ;;
  }

  dimension: base_tax_amount {
    type: number
    sql: ${TABLE}.base_tax_amount ;;
  }

  dimension: base_tax_canceled {
    type: number
    sql: ${TABLE}.base_tax_canceled ;;
  }

  dimension: base_tax_invoiced {
    type: number
    sql: ${TABLE}.base_tax_invoiced ;;
  }

  dimension: base_tax_refunded {
    type: number
    sql: ${TABLE}.base_tax_refunded ;;
  }

  dimension: base_to_global_rate {
    type: number
    sql: ${TABLE}.base_to_global_rate ;;
  }

  dimension: base_to_order_rate {
    type: number
    sql: ${TABLE}.base_to_order_rate ;;
  }

  dimension: base_total_canceled {
    type: number
    sql: ${TABLE}.base_total_canceled ;;
  }

  dimension: base_total_due {
    type: number
    sql: ${TABLE}.base_total_due ;;
  }

  dimension: base_total_invoiced {
    type: number
    sql: ${TABLE}.base_total_invoiced ;;
  }

  dimension: base_total_invoiced_cost {
    type: number
    sql: ${TABLE}.base_total_invoiced_cost ;;
  }

  dimension: base_total_offline_refunded {
    type: number
    sql: ${TABLE}.base_total_offline_refunded ;;
  }

  dimension: base_total_online_refunded {
    type: number
    sql: ${TABLE}.base_total_online_refunded ;;
  }

  dimension: base_total_paid {
    type: number
    value_format_name: id
    sql: ${TABLE}.base_total_paid ;;
  }

  dimension: base_total_refunded {
    type: number
    sql: ${TABLE}.base_total_refunded ;;
  }

  dimension: billing_address_id {
    type: number
    sql: ${TABLE}.billing_address_id ;;
  }

  dimension: coupon_code {
    type: string
    sql: ${TABLE}.coupon_code ;;
  }

  dimension: coupon_rule_name {
    type: string
    sql: ${TABLE}.coupon_rule_name ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: customer_dob {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.customer_dob ;;
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customer_email ;;
  }

  dimension: customer_firstname {
    type: string
    sql: ${TABLE}.customer_firstname ;;
  }

  dimension: customer_firstnamekana {
    type: string
    sql: ${TABLE}.customer_firstnamekana ;;
  }

  dimension: customer_gender {
    type: number
    sql: ${TABLE}.customer_gender ;;
  }

  dimension: customer_group_id {
    type: number
    sql: ${TABLE}.customer_group_id ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_is_guest {
    type: number
    sql: ${TABLE}.customer_is_guest ;;
  }

  dimension: customer_lastname {
    type: string
    sql: ${TABLE}.customer_lastname ;;
  }

  dimension: customer_lastnamekana {
    type: string
    sql: ${TABLE}.customer_lastnamekana ;;
  }

  dimension: customer_note_notify {
    type: number
    sql: ${TABLE}.customer_note_notify ;;
  }

  dimension_group: delivery {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivery_date ;;
  }

  dimension: delivery_time_range {
    type: number
    sql: ${TABLE}.delivery_time ;;
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: discount_canceled {
    type: number
    sql: ${TABLE}.discount_canceled ;;
  }

  dimension: discount_description {
    type: string
    sql: ${TABLE}.discount_description ;;
  }

  dimension: discount_invoiced {
    type: number
    sql: ${TABLE}.discount_invoiced ;;
  }

  dimension: discount_refunded {
    type: number
    sql: ${TABLE}.discount_refunded ;;
  }

  dimension: discount_tax_compensation_amount {
    type: number
    sql: ${TABLE}.discount_tax_compensation_amount ;;
  }

  dimension: discount_tax_compensation_invoiced {
    type: number
    sql: ${TABLE}.discount_tax_compensation_invoiced ;;
  }

  dimension: discount_tax_compensation_refunded {
    type: number
    sql: ${TABLE}.discount_tax_compensation_refunded ;;
  }

  dimension: email_sent {
    type: number
    sql: ${TABLE}.email_sent ;;
  }

  dimension: entity_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.entity_id ;;
  }

  dimension: global_currency_code {
    type: string
    sql: ${TABLE}.global_currency_code ;;
  }

  dimension: grand_total {
    type: number
    sql: ${TABLE}.grand_total ;;
  }

  dimension: increment_id {
    type: string
    sql: ${TABLE}.increment_id ;;
  }

  dimension: is_subscription {
    type: number
    sql: ${TABLE}.is_subscription ;;
  }

  dimension: is_virtual {
    type: number
    sql: ${TABLE}.is_virtual ;;
  }

  dimension: msp_cod_amount {
    type: number
    sql: ${TABLE}.msp_cod_amount ;;
  }

  dimension: msp_cod_tax_amount {
    type: number
    sql: ${TABLE}.msp_cod_tax_amount ;;
  }

  dimension: order_currency_code {
    type: string
    sql: ${TABLE}.order_currency_code ;;
  }

  dimension: paypal_ipn_customer_notified {
    type: number
    sql: ${TABLE}.paypal_ipn_customer_notified ;;
  }

  dimension: protect_code {
    type: string
    sql: ${TABLE}.protect_code ;;
  }

  dimension: quote_id {
    type: number
    sql: ${TABLE}.quote_id ;;
  }

  dimension: remote_ip {
    type: string
    sql: ${TABLE}.remote_ip ;;
  }

  dimension: send_email {
    type: number
    sql: ${TABLE}.send_email ;;
  }

  dimension: shipping_address_id {
    type: number
    sql: ${TABLE}.shipping_address_id ;;
  }

  dimension: shipping_amount {
    type: number
    sql: ${TABLE}.shipping_amount ;;
  }

  dimension: shipping_canceled {
    type: number
    sql: ${TABLE}.shipping_canceled ;;
  }

  dimension: shipping_description {
    type: string
    sql: ${TABLE}.shipping_description ;;
  }

  dimension: shipping_discount_amount {
    type: number
    sql: ${TABLE}.shipping_discount_amount ;;
  }

  dimension: shipping_discount_tax_compensation_amount {
    type: number
    sql: ${TABLE}.shipping_discount_tax_compensation_amount ;;
  }

  dimension: shipping_incl_tax {
    type: number
    sql: ${TABLE}.shipping_incl_tax ;;
  }

  dimension: shipping_invoiced {
    type: number
    sql: ${TABLE}.shipping_invoiced ;;
  }

  dimension: shipping_method {
    type: string
    sql: ${TABLE}.shipping_method ;;
  }

  dimension: shipping_refunded {
    type: number
    sql: ${TABLE}.shipping_refunded ;;
  }

  dimension: shipping_tax_amount {
    type: number
    sql: ${TABLE}.shipping_tax_amount ;;
  }

  dimension: shipping_tax_refunded {
    type: number
    sql: ${TABLE}.shipping_tax_refunded ;;
  }

  dimension: stamps {
    type: number
    sql: ${TABLE}.stamps ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: store_currency_code {
    type: string
    sql: ${TABLE}.store_currency_code ;;
  }

  dimension: store_id {
    type: number
    sql: ${TABLE}.store_id ;;
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}.store_name ;;
  }

  dimension: store_to_base_rate {
    type: number
    sql: ${TABLE}.store_to_base_rate ;;
  }

  dimension: store_to_order_rate {
    type: number
    sql: ${TABLE}.store_to_order_rate ;;
  }

  dimension: subtotal {
    type: number
    sql: ${TABLE}.subtotal ;;
  }

  dimension: subtotal_canceled {
    type: number
    sql: ${TABLE}.subtotal_canceled ;;
  }

  dimension: subtotal_incl_tax {
    type: number
    sql: ${TABLE}.subtotal_incl_tax ;;
  }

  dimension: subtotal_invoiced {
    type: number
    sql: ${TABLE}.subtotal_invoiced ;;
  }

  dimension: subtotal_refunded {
    type: number
    sql: ${TABLE}.subtotal_refunded ;;
  }

  dimension: tax_amount {
    type: number
    sql: ${TABLE}.tax_amount ;;
  }

  dimension: tax_canceled {
    type: number
    sql: ${TABLE}.tax_canceled ;;
  }

  dimension: tax_invoiced {
    type: number
    sql: ${TABLE}.tax_invoiced ;;
  }

  dimension: tax_refunded {
    type: number
    sql: ${TABLE}.tax_refunded ;;
  }

  dimension: total_canceled {
    type: number
    sql: ${TABLE}.total_canceled ;;
  }

  dimension: total_due {
    type: number
    sql: ${TABLE}.total_due ;;
  }

  dimension: total_invoiced {
    type: number
    sql: ${TABLE}.total_invoiced ;;
  }

  dimension: total_item_count {
    type: number
    sql: ${TABLE}.total_item_count ;;
  }

  dimension: total_offline_refunded {
    type: number
    sql: ${TABLE}.total_offline_refunded ;;
  }

  dimension: total_online_refunded {
    type: number
    sql: ${TABLE}.total_online_refunded ;;
  }

  dimension: total_paid {
    type: number
    value_format_name: id
    sql: ${TABLE}.total_paid ;;
  }

  dimension: total_qty_ordered {
    type: number
    sql: ${TABLE}.total_qty_ordered ;;
  }

  dimension: total_refunded {
    type: number
    sql: ${TABLE}.total_refunded ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: welcome_stamps {
    type: number
    sql: ${TABLE}.welcome_stamps ;;
  }

  dimension: x_forwarded_for {
    type: string
    sql: ${TABLE}.x_forwarded_for ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_firstname, coupon_rule_name, customer_lastname, store_name]
  }

  measure: total_sales {
    label: "Sales Total"
    description: "this is the total sales for.."
    type: sum
    sql: ${base_grand_total} ;;
    # sql: ${TABLE}.base_grand_total ;;

  }


}
