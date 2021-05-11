view: sales_item {
  sql_table_name: `leafy-habitat-174801.looker.sales_item`
    ;;

  dimension: base_price_incl_tax {
    type: number
    sql: ${TABLE}.base_price_incl_tax ;;
    label: "Unit Price"
  }

  dimension: base_row_total_incl_tax {
    type: number
    sql: ${TABLE}.base_row_total_incl_tax ;;
    label: "Price"
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

  dimension: food_days {
    type: string
    sql: ${TABLE}.food_days ;;
    label: "Days of Food Ordered"
  }

  dimension: item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.item_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    label: "Internal Order Id"
  }

  dimension: parent_item_id {
    type: number
    sql: ${TABLE}.parent_item_id ;;
  }

  dimension: pet_id {
    type: number
    sql: ${TABLE}.pet_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/33?Pet%20ID={{ value }}"
    }
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: qty_ordered {
    label: "Quantity"
    type: number
    sql: ${TABLE}.qty_ordered ;;
  }

  dimension: quote_item_id {
    type: number
    sql: ${TABLE}.quote_item_id ;;
  }

  dimension: is_food {
    type: yesno
    sql: ${sku} LIKE 'FP-%' ;;
  }

  dimension: is_food_sample {
    type: yesno
    sql: ${sku} LIKE '%-150' ;;
  }

  dimension: meat_type {
    type: string
    sql: CASE
          WHEN ${sku} LIKE 'FP-B-%'THEN 'Beef'
          WHEN ${sku} LIKE 'FP-C-%' THEN 'Chicken'
        END ;;
  }

  dimension: recipe {
    type: string
    sql: ${TABLE}.recipe ;;
  }

  dimension: row_weight {
    type: number
    sql: ${TABLE}.row_weight ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
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
    drill_fields: [sku, pet_id]
  }

  measure: total_sales {
    description: "Total is calculated at the product level, no discount applied"
    type: sum
    sql: ${base_row_total_incl_tax} ;;
    drill_fields: [sku, pet_id]
  }

  measure: total_qty {
    label: "Total Quantity"
    description: "Total quantity of product sold"
    type: sum
    sql: ${qty_ordered} ;;
    drill_fields: [sku, pet_id, order_id]
  }

  measure: unique_order_count {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: unique_pet_count {
    type: count_distinct
    sql: ${pet_id} ;;
    drill_fields: [sku, pet_id, order_id]
  }
}
