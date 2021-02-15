view: quote {
  sql_table_name: `leafy-habitat-174801.looker.quote`
    ;;

  dimension: applied_rule_ids {
    type: string
    sql: ${TABLE}.applied_rule_ids ;;
  }

  dimension: base_currency_code {
    type: string
    sql: ${TABLE}.base_currency_code ;;
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

  dimension: base_subtotal {
    type: number
    sql: ${TABLE}.base_subtotal ;;
  }

  dimension: base_subtotal_with_discount {
    type: number
    sql: ${TABLE}.base_subtotal_with_discount ;;
  }

  dimension: base_to_global_rate {
    type: number
    sql: ${TABLE}.base_to_global_rate ;;
  }

  dimension: base_to_quote_rate {
    type: number
    sql: ${TABLE}.base_to_quote_rate ;;
  }

  dimension: checkout_method {
    type: string
    sql: ${TABLE}.checkout_method ;;
  }

  dimension: coupon_code {
    type: string
    sql: ${TABLE}.coupon_code ;;
  }

  dimension_group: created {
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
    type: string
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

  dimension: customer_tax_class_id {
    type: number
    sql: ${TABLE}.customer_tax_class_id ;;
  }

  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
    primary_key: yes
  }

  dimension: global_currency_code {
    type: string
    sql: ${TABLE}.global_currency_code ;;
  }

  dimension: grand_total {
    type: number
    sql: ${TABLE}.grand_total ;;
  }

  dimension: is_active {
    type: number
    sql: ${TABLE}.is_active ;;
  }

  dimension: is_changed {
    type: number
    sql: ${TABLE}.is_changed ;;
  }

  dimension: is_multi_shipping {
    type: number
    sql: ${TABLE}.is_multi_shipping ;;
  }

  dimension: is_persistent {
    type: number
    sql: ${TABLE}.is_persistent ;;
  }

  dimension: is_subscription {
    type: number
    sql: ${TABLE}.is_subscription ;;
  }

  dimension: is_virtual {
    type: number
    sql: ${TABLE}.is_virtual ;;
  }

  dimension: items_count {
    type: number
    sql: ${TABLE}.items_count ;;
  }

  dimension: items_qty {
    type: number
    sql: ${TABLE}.items_qty ;;
  }

  dimension: msp_cod_amount {
    type: number
    sql: ${TABLE}.msp_cod_amount ;;
  }

  dimension: msp_cod_tax_amount {
    type: number
    sql: ${TABLE}.msp_cod_tax_amount ;;
  }

  dimension: orig_order_id {
    type: number
    sql: ${TABLE}.orig_order_id ;;
  }

  dimension: quote_currency_code {
    type: string
    sql: ${TABLE}.quote_currency_code ;;
  }

  dimension: remote_ip {
    type: string
    sql: ${TABLE}.remote_ip ;;
  }

  dimension: reserved_order_id {
    type: string
    sql: ${TABLE}.reserved_order_id ;;
  }

  dimension: stamps {
    type: number
    sql: ${TABLE}.stamps ;;
  }

  dimension: store_currency_code {
    type: string
    sql: ${TABLE}.store_currency_code ;;
  }

  dimension: store_id {
    type: number
    sql: ${TABLE}.store_id ;;
  }

  dimension: store_to_base_rate {
    type: number
    sql: ${TABLE}.store_to_base_rate ;;
  }

  dimension: store_to_quote_rate {
    type: number
    sql: ${TABLE}.store_to_quote_rate ;;
  }

  dimension: subtotal {
    type: number
    sql: ${TABLE}.subtotal ;;
  }

  dimension: subtotal_with_discount {
    type: number
    sql: ${TABLE}.subtotal_with_discount ;;
  }

  dimension: trigger_recollect {
    type: number
    sql: ${TABLE}.trigger_recollect ;;
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

  measure: count {
    type: count
    drill_fields: [customer_firstname, customer_lastname, entity_id]
  }

  measure: total_sales {
    label: "Sales Total"
    type: sum
    sql: ${base_grand_total} ;;
    drill_fields: [entity_id, created_date]
  }

  measure: avg_sales {
    label: "Sales Average"
    type: average
    sql: ${base_grand_total} ;;
    value_format: "0"
  }

  measure: total_qty {
    description: "Total quantity of product sold."
    type: sum
    sql: ${items_qty} ;;
  }
}
