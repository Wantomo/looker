view: quote_item {
  sql_table_name: `leafy-habitat-174801.looker.quote_item`
    ;;

  dimension: applied_rule_ids {
    type: string
    sql: ${TABLE}.applied_rule_ids ;;
  }

  dimension: base_discount_amount {
    type: number
    sql: ${TABLE}.base_discount_amount ;;
  }

  dimension: base_discount_tax_compensation_amount {
    type: number
    sql: ${TABLE}.base_discount_tax_compensation_amount ;;
  }

  dimension: base_price {
    type: number
    sql: ${TABLE}.base_price ;;
  }

  dimension: base_price_incl_tax {
    type: number
    sql: ${TABLE}.base_price_incl_tax ;;
  }

  dimension: base_row_total {
    type: number
    sql: ${TABLE}.base_row_total ;;
  }

  dimension: base_row_total_incl_tax {
    type: number
    sql: ${TABLE}.base_row_total_incl_tax ;;
  }

  dimension: base_tax_amount {
    type: number
    sql: ${TABLE}.base_tax_amount ;;
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
    convert_tz: no
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: discount_percent {
    type: number
    sql: ${TABLE}.discount_percent ;;
  }

  dimension: discount_tax_compensation_amount {
    type: number
    sql: ${TABLE}.discount_tax_compensation_amount ;;
  }

  dimension: food_days {
    type: string
    sql: ${TABLE}.food_days ;;
  }

  dimension: free_shipping {
    type: number
    sql: ${TABLE}.free_shipping ;;
  }

  dimension: is_excluded_product {
    type: number
    sql: ${TABLE}.is_excluded_product ;;
  }

  dimension: is_qty_decimal {
    type: number
    sql: ${TABLE}.is_qty_decimal ;;
  }

  dimension: is_virtual {
    type: number
    sql: ${TABLE}.is_virtual ;;
  }

  dimension: item_id {
    type: number
    sql: ${TABLE}.item_id ;;
    primary_key: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: no_discount {
    type: number
    sql: ${TABLE}.no_discount ;;
  }

  dimension: parent_item_id {
    type: number
    sql: ${TABLE}.parent_item_id ;;
  }

  dimension: pet_id {
    type: number
    sql: ${TABLE}.pet_id ;;
  }

  dimension: pre_order {
    type: number
    sql: ${TABLE}.pre_order ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: price_incl_tax {
    type: number
    sql: ${TABLE}.price_incl_tax ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: qty {
    type: number
    sql: ${TABLE}.qty ;;
  }

  dimension: quote_id {
    type: number
    sql: ${TABLE}.quote_id ;;
  }

  dimension: recipe {
    type: string
    sql: ${TABLE}.recipe ;;
  }

  dimension: row_total {
    type: number
    sql: ${TABLE}.row_total ;;
  }

  dimension: row_total_incl_tax {
    type: number
    sql: ${TABLE}.row_total_incl_tax ;;
  }

  dimension: row_total_with_discount {
    type: number
    sql: ${TABLE}.row_total_with_discount ;;
  }

  dimension: row_weight {
    type: number
    sql: ${TABLE}.row_weight ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: store_id {
    type: number
    sql: ${TABLE}.store_id ;;
  }

  dimension: subscription_mode {
    type: number
    sql: ${TABLE}.subscription_mode ;;
  }

  dimension: tax_amount {
    type: number
    sql: ${TABLE}.tax_amount ;;
  }

  dimension: tax_percent {
    type: number
    sql: ${TABLE}.tax_percent ;;
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

  measure: count {
    type: count
    drill_fields: [name]
  }

  measure: total_sales {
    description: "Total is calculated at the product level, no discount applied."
    type: sum
    sql: ${base_row_total_incl_tax} ;;
    drill_fields: [sku, pet_id]
  }

  measure: total_qty {
    description: "Total quantity of product sold."
    type: sum
    sql: ${qty} ;;
  }

  measure: unique_quote_count {
    type: count_distinct
    sql: ${quote_id} ;;
    drill_fields: [quote_id, item_id]
  }
}
