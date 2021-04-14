view: sales {
  sql_table_name: `leafy-habitat-174801.looker.sales`;;
  drill_fields: [order_detail*]

  dimension: applied_rule_ids {
    type: string
    sql: ${TABLE}.applied_rule_ids ;;
  }

  dimension: base_currency_code {
    type: string
    sql: ${TABLE}.base_currency_code ;;
  }

  dimension: base_discount_amount {
    type: number
    sql: ${TABLE}.base_discount_amount ;;
  }

  dimension: base_discount_tax_compensation_amount {
    type: number
    sql: ${TABLE}.base_discount_tax_compensation_amount ;;
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

  dimension: base_shipping_discount_amount {
    type: number
    sql: ${TABLE}.base_shipping_discount_amount ;;
  }

  dimension: base_shipping_incl_tax {
    type: number
    sql: ${TABLE}.base_shipping_incl_tax ;;
  }

  dimension: base_shipping_tax_amount {
    type: number
    sql: ${TABLE}.base_shipping_tax_amount ;;
  }

  dimension: base_subtotal {
    type: number
    sql: ${TABLE}.base_subtotal ;;
  }

  dimension: base_subtotal_incl_tax {
    type: number
    sql: ${TABLE}.base_subtotal_incl_tax ;;
  }

  dimension: base_tax_amount {
    type: number
    sql: ${TABLE}.base_tax_amount ;;
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
    label: "Date of Order"
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
    convert_tz: no
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
    convert_tz: no
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customer_email ;;
  }

  dimension: customer_firstname {
    type: string
    sql: ${TABLE}.customer_firstname ;;
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
    convert_tz: no
  }

  dimension: delivery_time_range {
    type: number
    sql: ${TABLE}.delivery_time ;;
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: discount_description {
    type: string
    sql: ${TABLE}.discount_description ;;
  }

  dimension: discount_tax_compensation_amount {
    type: number
    sql: ${TABLE}.discount_tax_compensation_amount ;;
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

  dimension: increment_id {
    type: string
    sql: ${TABLE}.increment_id ;;
  }

  dimension: is_subscription {
    type: yesno
    sql: ${TABLE}.is_subscription = 1 ;;
  }

  dimension: is_virtual {
    type: number
    sql: ${TABLE}.is_virtual ;;
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

  dimension: shipping_description {
    type: string
    sql: ${TABLE}.shipping_description ;;
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

  dimension: store_id {
    type: number
    sql: ${TABLE}.store_id ;;
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}.store_name ;;
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
    convert_tz: no
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
    label: "Count of Order"
    type: count
  }

  measure: unique_user_count {
    label: "Unique Count of Order By Customer"
    type: count_distinct
    sql: ${customer_id} ;;
  }

  measure: total_sales {
    label: "Sales Total"
    type: sum
    sql: ${base_grand_total} ;;
  }

  measure: avg_sales {
    label: "Sales Average"
    type: average
    sql: ${base_grand_total} ;;
    value_format: "0"
  }

  set: order_detail {
    fields: [customer_id, customer_email, customer_firstname, customer_lastname, entity_id, increment_id, created_date, status]
  }
}
